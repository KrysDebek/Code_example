@IsTest
private class OpportunitySummaryControllerTest {
    @TestSetup
    static void prepareTestData() {
        Account testAccount = new TestDataFactory.AccountBuilder().withName('Test Account').buildAndSave();

        Opportunity testOpportunity = new Opportunity(
                Name = 'Test Opportunity',
                AccountId = testAccount.Id,
            	Free_of_Charge_Items_Added__c  = 'No',
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

    static testMethod void fetchOpportunityData_shouldReturnWrapper_whenOpportunityFound() {
        // given
        Id opportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;

        // when
        OpportunitySummaryController.OpportunityWrapper wrapper = OpportunitySummaryController.fetchOpportunityData(opportunityId);

        // then
        System.assertEquals(100, wrapper.amount);
    }

    static testMethod void fetchOpportunityData_shouldReturnNull_whenOpportunityNotFound() {
        // given
        String opportunityPrefix = Opportunity.SObjectType.getDescribe().getKeyPrefix();
        String opportunityId = opportunityPrefix.rightPad(18, '0');

        // when
        OpportunitySummaryController.OpportunityWrapper wrapper = OpportunitySummaryController.fetchOpportunityData(opportunityId);

        // then
        System.assertEquals(null, wrapper);
    }

    static testMethod void fetchOpportunityData_shouldThrowException_whenServiceThrowsException() {
        // given
        String opportunityId = 'wrong_id';

        try {
            // when
            OpportunitySummaryController.OpportunityWrapper wrapper = OpportunitySummaryController.fetchOpportunityData(opportunityId);
        } catch (Exception ex) {
            // then
            System.assertEquals('Invalid id: wrong_id', ex.getMessage());
        }
    }

    static testMethod void confirmAndUpdateOpportunity_shouldUpdateOpportunity() {
        // given
        Id opportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        OpportunitySummaryController.OpportunityWrapper wrapper = OpportunitySummaryController.fetchOpportunityData(opportunityId);

        // when
        Test.startTest();
        wrapper.closeDate = Date.today().addDays(1);
        String serializedOpportunity = JSON.serialize(wrapper);
        OpportunitySummaryController.confirmAndUpdateOpportunity(serializedOpportunity);
        Test.stopTest();

        // then
        Opportunity updatedOpportunity = [SELECT Id, CloseDate, Opportunity_Summary_Completed__c, StageName FROM Opportunity WHERE Id = :opportunityId];
        System.assertEquals(Date.today().addDays(1), updatedOpportunity.CloseDate);
        System.assertEquals('Closed Won', updatedOpportunity.StageName);
        System.assertEquals(true, updatedOpportunity.Opportunity_Summary_Completed__c);
    }

    static testMethod void confirmAndUpdateOpportunity_shouldThrowException_whenInvalidInput() {
        // given
        String malformedSerialization = '{ dsdsd';

        try {
            // when
            OpportunitySummaryController.confirmAndUpdateOpportunity(malformedSerialization);
        } catch (Exception ex) {
            // then
            String exceptionMessage = ex.getMessage();
            System.assert(exceptionMessage.startsWith(Label.Opportunity_Confirmation_Error));
        }
    }

    static testMethod void getLabelsMap_shouldReturnLabelsMap() {
        // given
        String opportunityLabel = SObjectType.Opportunity.getLabel();

        // when
        Map<String, String> labelsMap = OpportunitySummaryController.getLabelsMap();

        // then
        System.assertEquals(opportunityLabel, labelsMap.get('OPPORTUNITY'));
    }

    static testMethod void getTeamMemberRolesOptions_shouldReturnPicklistOptions() {
        // given
        Schema.DescribeFieldResult fieldResult = OpportunityTeamMember.TeamMemberRole.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();

        // when
        List<OpportunitySummaryController.PicklistOption> picklistOptions = OpportunitySummaryController.getTeamMemberRolesOptions();

        // then
        System.assertEquals(picklistEntries.size(), picklistOptions.size());
    }

    static testMethod void getTeamMemberAccessOptions_shouldReturnPicklistOptions() {
        // given
        Schema.DescribeFieldResult fieldResult = OpportunityTeamMember.OpportunityAccessLevel.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();

        // when
        List<OpportunitySummaryController.PicklistOption> picklistOptions = OpportunitySummaryController.getTeamMemberAccessOptions();

        // then
        System.assertEquals(picklistEntries.size(), picklistOptions.size());
    }

    static testMethod void getMarketingServiceTypesOptions_shouldReturnPicklistOptions() {
        // given
        Schema.DescribeFieldResult fieldResult = Marketing_Service__c.Type__c.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();

        // when
        List<OpportunitySummaryController.PicklistOption> picklistOptions = OpportunitySummaryController.getMarketingServiceTypesOptions();

        // then
        System.assertEquals(picklistEntries.size(), picklistOptions.size());
    }

    static testMethod void getReasonsOfWonOptions_shouldReturnPicklistOptions() {
        // given
        Schema.DescribeFieldResult fieldResult = Opportunity.Reason_of_Won__c.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();

        // when
        List<OpportunitySummaryController.PicklistOption> picklistOptions = OpportunitySummaryController.getReasonsOfWonOptions();

        // then
        System.assertEquals(picklistEntries.size(), picklistOptions.size());
    }

    @IsTest
    static void getCountryOptions_shouldReturnPicklistOptions() {
        List<Schema.PicklistEntry> picklistEntries = Opportunity.Billing_Country__c.getDescribe().getPicklistValues();
        List<OpportunitySummaryController.PicklistOption> picklistOptions = OpportunitySummaryController.getCountryOptions();
        System.assertEquals(picklistEntries.size(), picklistOptions.size());
    }
}