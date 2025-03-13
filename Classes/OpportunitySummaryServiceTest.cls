@IsTest
private class OpportunitySummaryServiceTest {
    @TestSetup
    static void prepareTestData() {
        Account testAccount = new TestDataFactory.AccountBuilder().withName('Test Account').buildAndSave();

        Opportunity testOpportunity = new Opportunity(
                Name = 'Test Opportunity',
            	Free_of_Charge_Items_Added__c  = 'No',
                AccountId = testAccount.Id,
                StageName = 'Needs Analysis',
                CloseDate = Date.today(),
            	Real_Close_Date__c = Date.today(),
                Medical_Specialist_not_needed__c = true,
                Pricebook2Id = Test.getStandardPricebookId(),
                Client_Representative_First_Name__c = 'John',
                Client_Representative_Last_Name__c = 'Kowalski',
                Payment_Method__c = Opportunity.Payment_Method__c.getDescribe().getPicklistValues()[0].getValue(),
            	Shared_Sales__c = 'No'
        );
        insert testOpportunity;

        Marketing_Service__c testMarketingService = new Marketing_Service__c(
                Account__c = testAccount.Id,
                Opportunity__c = testOpportunity.Id,
                Type__c = 'Plakaty',
                Description__c = 'Jest ok'
        );
        insert testMarketingService;

        OpportunityTeamMember testOpportunityTeamMember = new OpportunityTeamMember(
                OpportunityId = testOpportunity.Id,
                UserId = UserInfo.getUserId(),
                TeamMemberRole = 'Sales Representative',
                OpportunityAccessLevel = 'Edit'
        );
        insert testOpportunityTeamMember;

        Product2 testProduct = new Product2(
                Name = 'Test Product'
        );
        insert testProduct;

        PricebookEntry testPricebookEntry = new PricebookEntry(
                Product2Id = testProduct.Id,
                Pricebook2Id = Test.getStandardPricebookId(),
                UnitPrice = 100,
                IsActive = true
        );
        insert testPricebookEntry;

        OpportunityLineItem testLineItem = new OpportunityLineItem(
                OpportunityId = testOpportunity.Id,
                Product2Id = testProduct.Id,
                PricebookEntryId = testPricebookEntry.Id,
                Quantity = 1,
                UnitPrice = 100
        );
        insert testLineItem;
    }

    static testMethod void getOpportunityRecord_shouldReturnOpportunity_whenFoundById() {
        // given
        Id opportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;

        // when
        Opportunity fetchedOpportunity = OpportunitySummaryService.getOpportunityRecord(opportunityId);

        // then
        System.assertEquals(100, fetchedOpportunity.Amount);
    }

    static testMethod void getOpportunityRecord_shouldReturnNull_whenNotFoundById() {
        // given
        String opportunityPrefix = Opportunity.SObjectType.getDescribe().getKeyPrefix();
        String opportunityId = opportunityPrefix.rightPad(18, '0');

        // when
        Opportunity fetchedOpportunity = OpportunitySummaryService.getOpportunityRecord(opportunityId);

        // then
        System.assertEquals(null, fetchedOpportunity);
    }

    static testMethod void confirmAndWinOpportunity_shouldChangeOpportunityConfirmationStatus() {
        // given
        Id opportunityId = [SELECT Id, StageName, Opportunity_Summary_Completed__c FROM Opportunity LIMIT 1].Id;
        Opportunity fetchedOpportunity = OpportunitySummaryService.getOpportunityRecord(opportunityId);

        // when
        Test.startTest();
        OpportunitySummaryService.confirmAndWinOpportunity(fetchedOpportunity);
        Test.stopTest();
        // then
        System.assertEquals(true, fetchedOpportunity.Opportunity_Summary_Completed__c);
        System.assertEquals('Closed Won', fetchedOpportunity.StageName);
    }

    static testMethod void processOpportunityLineItems_shouldExecuteDmlsWithoutErrors() {
        // given
        Id opportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        Opportunity fetchedOpportunity = OpportunitySummaryService.getOpportunityRecord(opportunityId);
        List<OpportunityLineItem> opportunityLineItems = fetchedOpportunity.OpportunityLineItems;

        // when
        for (OpportunityLineItem oli : opportunityLineItems) {
            oli.Quantity = 2;
        }

        OpportunitySummaryService.processOpportunityLineItems(opportunityLineItems, new List<OpportunityLineItem>());

        // then
        for (OpportunityLineItem oli : [SELECT Quantity FROM OpportunityLineItem WHERE OpportunityId = :opportunityId]) {
            System.assertEquals(2, oli.Quantity);
        }
    }

    static testMethod void processOpportunityTeamMembers_shouldExecuteDmlsWithoutErrors() {
        // given
        Id opportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        Opportunity fetchedOpportunity = OpportunitySummaryService.getOpportunityRecord(opportunityId);
        List<OpportunityTeamMember> opportunityTeamMembers = fetchedOpportunity.OpportunityTeamMembers;

        // when
        for (OpportunityTeamMember otm : opportunityTeamMembers) {
            otm.TeamMemberRole = 'Medical Specialist';
        }
        OpportunitySummaryService.processOpportunityTeamMembers(opportunityTeamMembers, new List<OpportunityTeamMember>());

        // then
        for (OpportunityTeamMember otm : [SELECT TeamMemberRole FROM OpportunityTeamMember WHERE OpportunityId = :opportunityId]) {
            System.assertEquals('Medical Specialist', otm.TeamMemberRole);
        }
    }

    static testMethod void processMarketingServices_shouldExecuteDmlsWithoutErrors() {
        // given
        Id opportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        Opportunity fetchedOpportunity = OpportunitySummaryService.getOpportunityRecord(opportunityId);
        List<Marketing_Service__c> marketingServices = fetchedOpportunity.Marketing_Services__r;

        // when
        for (Marketing_Service__c ms : marketingServices) {
            ms.Description__c = ms.Id + ' test description';
        }
        OpportunitySummaryService.processMarketingServices(marketingServices, new List<Marketing_Service__c>());

        // then
        for (Marketing_Service__c ms : marketingServices) {
            System.assertEquals(ms.Id + ' test description', ms.Description__c);
        }
    }
}