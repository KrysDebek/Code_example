public with sharing class OpportunitySummaryController {

    private static Map<String, String> STANDARD_LABELS_MAP = new Map<String, String>{
            'OPPORTUNITY' => SObjectType.Opportunity.getLabel(),
            'PRODUCTS' => SObjectType.OpportunityLineItem.getLabelPlural(),
            'MEMBERS' => SObjectType.OpportunityTeamMember.getLabelPlural(),
            'SERVICES' => SObjectType.Marketing_Service__c.getLabelPlural(),
            'OPPORTUNITY_AMOUNT' => Opportunity.Amount.getDescribe().getLabel(),
            'OPPORTUNITY_CLOSEDATE' => Opportunity.CloseDate.getDescribe().getLabel(),
            'OPPORTUNITY_PLANNEDDELIVERYDATE' => Opportunity.Planned_Delivery_Date__c.getDescribe().getLabel(),
            'OPPORTUNITY_REALCLOSEDATE' => Opportunity.Real_Close_Date__c.getDescribe().getLabel(),
            'OPPORTUNITY_REASONWON' => Opportunity.Reason_of_Won__c.getDescribe().getLabel(),
            'OPPORTUNITY_SINGLEORDER' => Opportunity.Single_Order__c.getDescribe().getLabel(),
            'OPPORTUNITY_NIP' => Opportunity.Customer_NIP__c.getDescribe().getLabel(),
            'OPPORTUNITY_REGON' => Opportunity.Customer_REGON__c.getDescribe().getLabel(),
            'OPPORTUNITY_KRS' => Opportunity.Customer_KRS__c.getDescribe().getLabel(),
            'OPPORTUNITY_REPFIRSTNAME' => Opportunity.Client_Representative_First_Name__c.getDescribe().getLabel(),
            'OPPORTUNITY_REPLASTNAME' => Opportunity.Client_Representative_Last_Name__c.getDescribe().getLabel(),
            'OPPORTUNITY_REPTITLE' => Opportunity.Client_Representative_Title__c.getDescribe().getLabel(),
            'OPPORTUNITY_REPPHONE' => Opportunity.Client_Representative_Phone__c.getDescribe().getLabel(),
            'OPPORTUNITY_REPEMAIL' => Opportunity.Client_Representative_Email__c.getDescribe().getLabel(),
            'OPPORTUNITY_PAYMENTMETHOD' => Opportunity.Payment_Method__c.getDescribe().getLabel(),
            'OPPORTUNITY_FREEOFCHARGEITEMS' => Opportunity.Free_of_charge_items__c.getDescribe().getLabel(),
            'OPPORTUNITY_RODOMARKETING' => Opportunity.RODO_agreement_marketing__c.getDescribe().getLabel(),
            'OPPORTUNITY_RODOSTAT' => Opportunity.RODO_agreement_statistics__c.getDescribe().getLabel(),
            'OPPORTUNITY_RODOPHONE' => Opportunity.RODO_agreement_phone__c.getDescribe().getLabel(),
            'OPPORTUNITY_RODOEMAIL' => Opportunity.RODO_agreement_email__c.getDescribe().getLabel(),
            'OPPORTUNITY_RODOLEASING' => Opportunity.RODO_agreement_leasing__c.getDescribe().getLabel(),
            'OPPORTUNITY_RODOMARKETINGITP' => Opportunity.RODO_Marketing_Agreement_ITP__c.getDescribe().getLabel(),
            'OPPORTUNITY_RODOMARKETINGNEAUVIA' => Opportunity.RODO_Marketing_Agreement_Neauvia__c.getDescribe().getLabel(),
            'OPPORTUNITY_RODOAGREEMENT' => Opportunity.RODO_Agreement__c.getDescribe().getLabel(),
            'OPPORTUNITY_EINVOICE' => Opportunity.E_Invoice__c.getDescribe().getLabel(),
            'OPPORTUNITY_EINVOICE_EMAIL' => Opportunity.E_Invoice_e_mail__c.getDescribe().getLabel(),
            'OPPORTUNITY_PAYMENTDATE' => Opportunity.Planned_Full_Payment_Date__c.getDescribe().getLabel(),
            'OPPORTUNITY_DELIVERYAFTERFULLPAY' => Opportunity.Delivery_After_Full_Payment__c.getDescribe().getLabel(),
            'OPPORTUNITY_SHIPCOUNTRY' => Opportunity.Shipping_Country__c.getDescribe().getLabel(),
            'OPPORTUNITY_SHIPCITY' => Opportunity.Shipping_City__c.getDescribe().getLabel(),
            'OPPORTUNITY_SHIPSTREET' => Opportunity.Shipping_Street__c.getDescribe().getLabel(),
            'OPPORTUNITY_SHIPCODE' => Opportunity.Shipping_Zip_Postal_Code__c.getDescribe().getLabel(),
            'OPPORTUNITY_SHIPSTATE' => Opportunity.Shipping_State_Province__c.getDescribe().getLabel(),
            'OPPORTUNITY_BILLINGCOUNTRY' => Opportunity.Billing_Country__c.getDescribe().getLabel(),
            'OPPORTUNITY_BILLINGCITY' => Opportunity.Billing_City__c.getDescribe().getLabel(),
            'OPPORTUNITY_BILLINGSTREET' => Opportunity.Billing_Street__c.getDescribe().getLabel(),
            'OPPORTUNITY_BILLINGCODE' => Opportunity.Billing_Zip_Postal_Code__c.getDescribe().getLabel(),
            'OPPORTUNITY_BILLINGSTATE' => Opportunity.Billing_State_Province__c.getDescribe().getLabel(),
            'OPPORTUNITY_COMPANYINVNAME' => Opportunity.Company_Invoice_Name__c.getDescribe().getLabel(),
            'OPPORTUNITY_SHARED_SALES' => Opportunity.Shared_Sales__c.getDescribe().getLabel(),
            'OPPORTUNITY_SALES_REPRESENTATIVE' => Opportunity.Sales_Representative__c.getDescribe().getLabel(),
            'OPPORTUNITY_DOWN_PAYMENT' => Opportunity.Down_payment__c.getDescribe().getLabel(),
            'OPPORTUNITY_ADDITIONAL_SALES_REPRESENTATIVE' => Opportunity.Additional_Sales_Representative__c.getDescribe().getLabel(),
            'OPPORTUNITY_FOC_TYPE' => Opportunity.FOC_Type__c.getDescribe().getLabel(),
            'OPPORTUNITY_FREE_OF_CHARGE_ITEMS_ADDED' => Opportunity.Free_of_Charge_Items_Added__c.getDescribe().getLabel(),
            'OPPORTUNITY_FREE_OF_CHARGE_ITEMS' => Opportunity.Free_of_charge_items__c.getDescribe().getLabel(),
            'OPPORTUNITY_LOUIS_VUITTON_ART_NUMBER' => Opportunity.Louis_Vuitton_article_number__c.getDescribe().getLabel(),
            'PRODUCTS_PRODUCT' => OpportunityLineItem.Name.getDescribe().getLabel(),
            'PRODUCTS_QUANTITY' => OpportunityLineItem.Quantity.getDescribe().getLabel(),
            'PRODUCTS_PRICE' => OpportunityLineItem.UnitPrice.getDescribe().getLabel(),
            'PRODUCTS_PERIODOFEXTENDEDWARRANTY' => OpportunityLineItem.Period_of_extended_warranty_months__c.getDescribe().getLabel(),
            'PRODUCTS_PERIODOFEXTENDEDWARRANTY_HP' => OpportunityLineItem.Period_of_extended_warranty_months__c.getDescribe().getInlineHelpText(),
            'PRODUCTS_INSTALLMENTS' => OpportunityLineItem.Installments__c.getDescribe().getLabel(),
            'PRODUCTS_NUMBER_OF_INSTALLMENTS' => OpportunityLineItem.Number_of_installments__c.getDescribe().getLabel(),
            'PRODUCTS_PERCENTAGE_OF_DOWN_PAYMENT' => OpportunityLineItem.Percentage_of_the_down_payment_amount__c.getDescribe().getLabel(),
            'PRODUCTS_DOWN_PAYMENT' => OpportunityLineItem.Down_payment__c.getDescribe().getLabel(),
            'PRODUCTS_DELIVERYAFTERFULLPAY' => OpportunityLineItem.Delivery_After_Full_Payment__c.getDescribe().getLabel(),
            'PRODUCTS_PLANNEDDELIVERYDATE' => OpportunityLineItem.Planned_Delivery_Date__c.getDescribe().getLabel(),
            'PRODUCTS_PAYMENTDATE' => OpportunityLineItem.Planned_Full_Payment_Date__c.getDescribe().getLabel(),
            'MEMBERS_USER' => OpportunityTeamMember.Name.getDescribe().getLabel(),
            'MEMBERS_ROLE' => OpportunityTeamMember.TeamMemberRole.getDescribe().getLabel(),
            'MEMBERS_ACCESS' => OpportunityTeamMember.OpportunityAccessLevel.getDescribe().getLabel(),
            'SERVICES_NAME' => Marketing_Service__c.Name.getDescribe().getLabel(),
            'SERVICES_ACCOUNT' => Marketing_Service__c.Account__c.getDescribe().getLabel(),
            'SERVICES_TYPE' => Marketing_Service__c.Type__c.getDescribe().getLabel(),
            'SERVICES_DESCRIPTION' => Marketing_Service__c.Description__c.getDescribe().getLabel(),
            'ASSET_FOR_SALE' => SObjectType.Asset_for_Sale__c.getLabel(),
            'ASSET_NAME' => Asset.Name.getDescribe().getLabel(),
            'ASSET_SERIAL_NUMBER' => Asset.Serial_Number__c.getDescribe().getLabel(),
            'ASSET_PRICE' => Asset_for_Sale__c.Sales_Price__c.getDescribe().getLabel()
    };

    @AuraEnabled
    public static OpportunityWrapper fetchOpportunityData(Id opportunityId) {
        try {
            OpportunityWrapper wrapper = null;

            Opportunity opportunity = OpportunitySummaryService.getOpportunityRecord(opportunityId);
            if (opportunity != null) {
                wrapper = new OpportunityWrapper(opportunity);

                OpportunityResponsiblesService service = new OpportunityResponsiblesService();
                Map<String, OpportunityResponsiblesService.SettlementWrapper> settlementWrappers = service.wrapSettlementsForOpportunityAsMap(opportunityId);

                Map<String, List<Reservation_Asset__c>> reservationAssetToAssetId = new Map<String, List<Reservation_Asset__c>>();

                for (ProductWrapper productWrapper : wrapper.products) {
                    OpportunityResponsiblesService.SettlementWrapper settlement = settlementWrappers.get(productWrapper.id);
                    if (settlement != null) {
                        productWrapper.settlement = settlement;
                    }

                    if (String.isNotBlank(productWrapper.assetId) && reservationAssetToAssetId.containsKey(productWrapper.assetId) == false) {
                        reservationAssetToAssetId.put(productWrapper.assetId, new List<Reservation_Asset__c>());
                    }
                }

                for (Reservation_Asset__c reservationAsset : [
                        SELECT Id, Asset__c, Reservation__r.Start_Date__c, Reservation__r.Name
                        FROM Reservation_Asset__c
                        WHERE Asset__c IN :reservationAssetToAssetId.keySet()
                ]) {
                    String assetId = reservationAsset.Asset__c;
                    if (reservationAssetToAssetId.containsKey(assetId)) {
                        reservationAssetToAssetId.get(assetId).add(reservationAsset);
                    }
                }

                for (ProductWrapper productWrapper : wrapper.products) {
                    if (String.isNotBlank(productWrapper.assetId) && reservationAssetToAssetId.containsKey(productWrapper.assetId)) {
                        productWrapper.isPartrOfReservation = true;
                        for (Reservation_Asset__c resAsset : reservationAssetToAssetId.get(productWrapper.assetId)) {
                            productWrapper.reservationAssetWrapper.add(new ReservationAssetWrapper(resAsset));
                        }
                    }
                }
            }


            return wrapper;
        } catch (Exception ex) {
            AuraHandledException auraHandledException = new AuraHandledException(ex.getMessage());
            auraHandledException.setMessage(ex.getMessage());
            throw auraHandledException;
        }
    }

    @AuraEnabled
    public static void confirmAndUpdateOpportunity(String serializedOpportunity) {
        Savepoint sp = Database.setSavepoint();

        try {
            OpportunityWrapper wrapper = (OpportunityWrapper) JSON.deserialize(serializedOpportunity, OpportunityWrapper.class);

            Opportunity opportunity = wrapper.toSObject();
            opportunity.StageName = 'Final Approval';

            List<OpportunityResponsiblesService.SettlementWrapper> settlementWrappers = new List<OpportunityResponsiblesService.SettlementWrapper>();

            List<OpportunityLineItem> lineItemsToUpdate = new List<OpportunityLineItem>();
            List<OpportunityLineItem> lineItemsToDelete = new List<OpportunityLineItem>();
            for (ProductWrapper productWrapper : wrapper.products) {
                OpportunityLineItem lineItem = productWrapper.toSObject();
                if (productWrapper.isDeleted) {
                    lineItemsToDelete.add(lineItem);
                } else {
                    lineItem.Do_Not_Required_Approval_Process__c = true;
                    lineItemsToUpdate.add(lineItem);
                }
                settlementWrappers.add(productWrapper.settlement);
            }

            List<OpportunityTeamMember> opportunityTeamMembersToUpdate = new List<OpportunityTeamMember>();
            List<OpportunityTeamMember> opportunityTeamMembersToDelete = new List<OpportunityTeamMember>();
            for (TeamMemberWrapper teamMemberWrapper : wrapper.teamMembers) {
                OpportunityTeamMember teamMember = teamMemberWrapper.toSObject();
                if (teamMemberWrapper.isDeleted) {
                    opportunityTeamMembersToDelete.add(teamMember);
                } else {

                    opportunityTeamMembersToUpdate.add(teamMember);
                }
            }

            List<Marketing_Service__c> marketingServicesToUpdate = new List<Marketing_Service__c>();
            List<Marketing_Service__c> marketingServicesToDelete = new List<Marketing_Service__c>();
            for (MarketingServiceWrapper marketingServiceWrapper : wrapper.marketingServices) {
                Marketing_Service__c marketingService = marketingServiceWrapper.toSObject();
                if (marketingServiceWrapper.isDeleted) {
                    marketingServicesToDelete.add(marketingService);
                } else {
                    marketingServicesToUpdate.add(marketingService);
                }
            }

            OpportunityResponsiblesService service = new OpportunityResponsiblesService();
            service.setSettlementWrappers(settlementWrappers);
            service.process();
            OpportunitySummaryService.processMarketingServices(marketingServicesToUpdate, marketingServicesToDelete);
            OpportunitySummaryService.processOpportunityTeamMembers(opportunityTeamMembersToUpdate, opportunityTeamMembersToDelete);
            OpportunitySummaryService.confirmAndWinOpportunity(opportunity);
        } catch (Exception ex) {
            Database.rollback(sp);
            String message = Label.Opportunity_Confirmation_Error + ' ' + ex.getMessage();
            AuraHandledException auraHandledException = new AuraHandledException(message);
            auraHandledException.setMessage(message);
            throw auraHandledException;
        }
    }

    @AuraEnabled
    public static Map<String, String> getLabelsMap() {
        return STANDARD_LABELS_MAP;
    }

    @AuraEnabled
    public static List<PicklistOption> getTeamMemberRolesOptions() {
        List<PicklistOption> options = new List<PicklistOption>();
        Schema.DescribeFieldResult fieldResult = OpportunityTeamMember.TeamMemberRole.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getTeamMemberAccessOptions() {
        List<PicklistOption> options = new List<PicklistOption>();
        Schema.DescribeFieldResult fieldResult = OpportunityTeamMember.OpportunityAccessLevel.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getMarketingServiceTypesOptions() {
        Schema.DescribeFieldResult fieldResult = Marketing_Service__c.Type__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getRODOAgreementOptions() {
        Schema.DescribeFieldResult fieldResult = Opportunity.RODO_Agreement__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getRODOMarketingITPOptions() {
        Schema.DescribeFieldResult fieldResult = Opportunity.RODO_Marketing_Agreement_ITP__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getRODOMarketingNeauviaOptions() {
        Schema.DescribeFieldResult fieldResult = Opportunity.RODO_Marketing_Agreement_Neauvia__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getReasonsOfWonOptions() {
        Schema.DescribeFieldResult fieldResult = Opportunity.Reason_of_Won__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getCountryOptions(){
        Schema.DescribeFieldResult fieldResult = Opportunity.Shipping_Country__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getInstallmentsOptions(){
        Schema.DescribeFieldResult fieldResult = OpportunityLineItem.Installments__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getDownPaymentsOptions(){
        Schema.DescribeFieldResult fieldResult = Opportunity.Down_payment__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getProductDownPaymentsOptions(){
        Schema.DescribeFieldResult fieldResult = OpportunityLineItem.Down_payment__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getFreeChargeItemsAddedOptions(){
        Schema.DescribeFieldResult fieldResult = Opportunity.Free_of_Charge_Items_Added__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getFOCTypeOptions(){
        Schema.DescribeFieldResult fieldResult = Opportunity.FOC_Type__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    @AuraEnabled
    public static List<PicklistOption> getLouisVuittonArticleNumberOptions(){
        Schema.DescribeFieldResult fieldResult = Opportunity.Louis_Vuitton_article_number__c.getDescribe();
        return getPicklistOptionsForObjectAndField(fieldResult);
    }

    private static List<PicklistOption> getPicklistOptionsForObjectAndField(Schema.DescribeFieldResult fieldResult) {
        List<PicklistOption> options = new List<PicklistOption>();

        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry picklistEntry : picklistEntries) {
            options.add(new PicklistOption(picklistEntry.getLabel(), picklistEntry.getValue()));
        }

        return options;
    }

    public class PicklistOption {
        @AuraEnabled
        public String label { get; set; }

        @AuraEnabled
        public String value { get; set; }

        public PicklistOption(String label, String value) {
            this.label = label;
            this.value = value;
        }
    }

    public class OpportunityWrapper {
        @AuraEnabled public String id { get; set; }
        @AuraEnabled public Decimal amount { get; set; }
        @AuraEnabled public Date closeDate { get; set; }
        @AuraEnabled public Date realCloseDate { get; set; }
        @AuraEnabled public Date plannedDeliveryDate { get; set; }
        @AuraEnabled public String reasonOfWon { get; set; }
        @AuraEnabled public Boolean isConfirmed { get; set; }
        @AuraEnabled public Boolean isSingleOrder { get; set; }
        @AuraEnabled public String customerNip { get; set; }
        @AuraEnabled public String customerRegon { get; set; }
        @AuraEnabled public String customerKrs { get; set; }
        @AuraEnabled public String repFirstName { get; set; }
        @AuraEnabled public String repLastName { get; set; }
        @AuraEnabled public String repTitle { get; set; }
        @AuraEnabled public String repPhone { get; set; }
        @AuraEnabled public String repEmail { get; set; }
        @AuraEnabled public String paymentMethod { get; set; }
        @AuraEnabled public String freeOfChargeItems { get; set; }
        @AuraEnabled public Boolean rodoMarketing { get; set; }
        @AuraEnabled public Boolean rodoStat { get; set; }
        @AuraEnabled public Boolean rodoPhone { get; set; }
        @AuraEnabled public Boolean rodoEmail { get; set; }
        @AuraEnabled public Boolean rodoLeasing { get; set; }
        @AuraEnabled public String rodoMarketingITP { get; set; }
        @AuraEnabled public String rodoMarketingNeauvia { get; set; }
        @AuraEnabled public String rodoAgreement { get; set; }
        @AuraEnabled public Boolean eInvoice { get; set; }
        @AuraEnabled public String eInvoiceEmail { get; set; }
        @AuraEnabled public Date fullPayDate { get; set; }
        @AuraEnabled public Boolean deliveryAfterPayment { get; set; }
        @AuraEnabled public String shippingCountry { get; set; }
        @AuraEnabled public String shippingStreet { get; set; }
        @AuraEnabled public String shippingCode { get; set; }
        @AuraEnabled public String shippingCity { get; set; }
        @AuraEnabled public String shippingState { get; set; }
        @AuraEnabled public String billingCountry { get; set; }
        @AuraEnabled public String billingStreet { get; set; }
        @AuraEnabled public String billingCode { get; set; }
        @AuraEnabled public String billingCity { get; set; }
        @AuraEnabled public String billingState { get; set; }
        @AuraEnabled public String companyInvoiceName { get; set; }
        @AuraEnabled public String sharedSales { get; set; }
        @AuraEnabled public String salesRepresentative { get; set; }
        @AuraEnabled public String salesRepresentativeId { get; set; }
        @AuraEnabled public String additionalSalesRepresentative { get; set; }
        @AuraEnabled public String additionalSalesRepresentativeId { get; set; }
        @AuraEnabled public String reasonOfWonFromSummary { get; set; }
        @AuraEnabled public Boolean isApprovalWasRequired { get; set; }
        @AuraEnabled public String stageName { get; set; }
        @AuraEnabled public String downPayment { get; set; }
        @AuraEnabled public String focType { get; set; }
        @AuraEnabled public String louisVuittonArticleNumber { get; set; }
        @AuraEnabled public String freeOfChargeItemsAdded { get; set; }
        @AuraEnabled public String currencyIsoCode { get; set; }

        @AuraEnabled
        public List<ProductWrapper> products { get; set; }

        @AuraEnabled
        public List<TeamMemberWrapper> teamMembers { get; set; }

        @AuraEnabled
        public List<TeamMemberOptionWrapper> teamMemberOptions { get; set; }

        @AuraEnabled
        public List<MarketingServiceWrapper> marketingServices { get; set; }

        public OpportunityWrapper(Opportunity opportunity) {
            this.id = opportunity.Id;
            this.amount = opportunity.Amount;
            this.closeDate = opportunity.CloseDate;
            this.realCloseDate = opportunity.Real_Close_Date__c;
            this.plannedDeliveryDate = opportunity.Planned_Delivery_Date__c;
            this.reasonOfWon = opportunity.Reason_of_Won__c;
            this.isConfirmed = opportunity.Opportunity_Summary_Completed__c;
            this.isSingleOrder = opportunity.Single_Order__c;
            this.customerNip = opportunity.Customer_NIP__c;
            this.customerRegon = opportunity.Customer_REGON__c;
            this.customerKrs = opportunity.Customer_KRS__c;
            this.repFirstName = opportunity.Client_Representative_First_Name__c;
            this.repLastName = opportunity.Client_Representative_Last_Name__c;
            this.repTitle = opportunity.Client_Representative_Title__c;
            this.repPhone = opportunity.Client_Representative_Phone__c;
            this.repEmail = opportunity.Client_Representative_Email__c;
            this.paymentMethod = opportunity.Payment_Method__c;
            this.freeOfChargeItems = opportunity.Free_of_charge_items__c;
            this.rodoMarketing = opportunity.RODO_agreement_marketing__c;
            this.rodoStat = opportunity.RODO_agreement_statistics__c;
            this.rodoPhone = opportunity.RODO_agreement_phone__c;
            this.rodoEmail = opportunity.RODO_agreement_email__c;
            this.rodoLeasing = opportunity.RODO_agreement_leasing__c;
            this.eInvoice = opportunity.E_Invoice__c;
            this.eInvoiceEmail = opportunity.E_Invoice_e_mail__c;
            this.fullPayDate = opportunity.Planned_Full_Payment_Date__c;
            this.deliveryAfterPayment = opportunity.Delivery_After_Full_Payment__c;
            this.shippingCity = opportunity.Shipping_City__c;
            this.shippingCountry = opportunity.Shipping_Country__c;
            this.shippingState = opportunity.Shipping_State_Province__c;
            this.shippingStreet = opportunity.Shipping_Street__c;
            this.shippingCode = opportunity.Shipping_Zip_Postal_Code__c;
            this.shippingCity = opportunity.Shipping_City__c;
            this.billingCountry = opportunity.Billing_Country__c;
            this.billingState = opportunity.Billing_State_Province__c;
            this.billingStreet = opportunity.Billing_Street__c;
            this.billingCode = opportunity.Billing_Zip_Postal_Code__c;
            this.billingCity = opportunity.Billing_City__c;
            this.companyInvoiceName = opportunity.Company_Invoice_Name__c;
            this.sharedSales = opportunity.Shared_Sales__c;
            this.salesRepresentative = opportunity.Sales_Representative__r.Name;
            this.salesRepresentativeId = opportunity.Sales_Representative__c;
            this.additionalSalesRepresentative = opportunity.Additional_Sales_Representative__r.Name;
            this.additionalSalesRepresentativeId = opportunity.Additional_Sales_Representative__c;
            this.reasonOfWonFromSummary = opportunity.Reason_of_Won_From_Summary__c;
            this.isApprovalWasRequired = opportunity.Is_Approval_was_required__c;
            this.stageName = opportunity.StageName;
            this.downPayment = opportunity.Down_payment__c;
            this.freeOfChargeItemsAdded = opportunity.Free_of_Charge_Items_Added__c;
            this.louisVuittonArticleNumber = opportunity.Louis_Vuitton_article_number__c;
            this.focType = opportunity.FOC_Type__c;
            this.rodoMarketingITP = opportunity.RODO_Marketing_Agreement_ITP__c;
            this.rodoMarketingNeauvia = opportunity.RODO_Marketing_Agreement_Neauvia__c;
            this.rodoAgreement = opportunity.RODO_Agreement__c;
            this.currencyIsoCode = opportunity.CurrencyIsoCode;

            this.products = new List<ProductWrapper>();
            for (OpportunityLineItem lineItem : opportunity.OpportunityLineItems) {
                ProductWrapper productWrapper = new ProductWrapper(lineItem);
                productWrapper.isResponsiblesAllowed = lineItem.Product2.Bonus_Value__c != null;
                this.products.add(new ProductWrapper(lineItem));
            }

            this.teamMembers = new List<TeamMemberWrapper>();
            this.teamMemberOptions = new List<TeamMemberOptionWrapper>();
            this.teamMemberOptions.add(new TeamMemberOptionWrapper(opportunity));
            for (OpportunityTeamMember teamMember : opportunity.OpportunityTeamMembers) {
                this.teamMembers.add(new TeamMemberWrapper(teamMember));

               if(!isTeamMemberContainsMember(this.teamMemberOptions, teamMember)){
                   this.teamMemberOptions.add(new TeamMemberOptionWrapper(teamMember));
               }
            }

            this.marketingServices = new List<MarketingServiceWrapper>();
            for (Marketing_Service__c marketingService : opportunity.Marketing_Services__r) {
                this.marketingServices.add(new MarketingServiceWrapper(marketingService));
            }
        }

        public Opportunity toSObject() {
            return new Opportunity(
                    Id = this.id,
                    Amount = this.amount,
                    CloseDate = this.closeDate,
                    Real_Close_Date__c = this.realCloseDate,
                    Reason_of_Won__c = this.reasonOfWon,
                    Single_Order__c = this.isSingleOrder,
                    Planned_Delivery_Date__c = this.plannedDeliveryDate,
                    Customer_NIP__c = this.customerNip,
                    Client_Representative_First_Name__c = this.repFirstName,
                    Client_Representative_Last_Name__c = this.repLastName,
                    Payment_Method__c = this.paymentMethod,
                    Free_of_charge_items__c = this.freeOfChargeItems,
                    RODO_agreement_marketing__c = this.rodoMarketing,
                    RODO_agreement_statistics__c = this.rodoStat,
                    RODO_agreement_phone__c = this.rodoPhone,
                    RODO_agreement_email__c = this.rodoEmail,
                    RODO_agreement_leasing__c = this.rodoLeasing,
                    E_Invoice__c = this.eInvoice,
                    Planned_Full_Payment_Date__c = this.fullPayDate,
                    Delivery_After_Full_Payment__c = this.deliveryAfterPayment,
                    Shipping_City__c = this.shippingCity,
                    Shipping_Country__c = this.shippingCountry,
                    Shipping_State_Province__c = this.shippingState,
                    Shipping_Street__c = this.shippingStreet,
                    Shipping_Zip_Postal_Code__c = this.shippingCode,
                    Billing_City__c = this.BillingCity,
                    Billing_Country__c = this.BillingCountry,
                    Billing_State_Province__c = this.BillingState,
                    Billing_Street__c = this.BillingStreet,
                    Billing_Zip_Postal_Code__c = this.BillingCode,
                    Shared_Sales__c = this.sharedSales,
                    Sales_Representative__c = this.salesRepresentativeId,
                    Additional_Sales_Representative__c = this.additionalSalesRepresentativeId,
                    Company_Invoice_Name__c = this.companyInvoiceName,
                    Reason_of_Won_From_Summary__c = this.reasonOfWon == null ? this.reasonOfWonFromSummary : this.reasonOfWon,
                    Is_Approval_was_required__c = this.isApprovalWasRequired,
                    Down_payment__c = this.downPayment,
                    Free_of_Charge_Items_Added__c = this.freeOfChargeItemsAdded,
                    Louis_Vuitton_article_number__c = this.louisVuittonArticleNumber,
                    FOC_Type__c = this.focType,
                    RODO_Marketing_Agreement_ITP__c = this.rodoMarketingITP,
                    RODO_Marketing_Agreement_Neauvia__c = this.rodoMarketingNeauvia,
                    RODO_Agreement__c = this.rodoAgreement
            );
        }
    }

    public class ProductWrapper {
        @AuraEnabled
        public String id { get; set; }

        @AuraEnabled
        public String assetId { get; set; }

        @AuraEnabled
        public String productName { get; set; }

        @AuraEnabled
        public Decimal quantity { get; set; }

        @AuraEnabled
        public Decimal salesPrice { get; set; }

        @AuraEnabled
        public Decimal minimalStockValue { get; set; }

        @AuraEnabled
        public OpportunityResponsiblesService.SettlementWrapper settlement { get; set; }

        @AuraEnabled
        public Boolean isDeleted { get; set; }

        @AuraEnabled
        public Boolean isResponsiblesAllowed { get; set; }

        @AuraEnabled
        public Boolean isPartrOfReservation { get; set; }

        @AuraEnabled
        public Decimal periodOfExtendedWarranty {get;set;}

        @AuraEnabled
        public String installments {get;set;}

        @AuraEnabled
        public Decimal numberOfInstallments {get;set;}

        @AuraEnabled
        public Decimal percentageOfDownPayment {get;set;}

        @AuraEnabled
        public String downPayment { get; set; }

        @AuraEnabled
        public Decimal advancedPaymentAmount { get; set; }

        @AuraEnabled
        public Date plannedAdvancePaymentDate { get; set; }

        @AuraEnabled
        public Date plannedDeliveryDate { get; set; }

        @AuraEnabled
        public String currencyIsoCode { get; set; }

        @AuraEnabled
        public Boolean deliveryAfterPayment { get; set; }

        @AuraEnabled
        public List<ReservationAssetWrapper> reservationAssetWrapper { get; set; }

        public ProductWrapper(OpportunityLineItem lineItem) {
            this.id = lineItem.Id;
            this.assetId = lineItem.Asset__c;
            this.productName = lineItem.Product2.Name;
            this.quantity = lineItem.Quantity;
            this.salesPrice = lineItem.UnitPrice;
            this.periodOfExtendedWarranty = lineItem.Period_of_extended_warranty_months__c;
            this.settlement = new OpportunityResponsiblesService.SettlementWrapper(lineItem);
            this.isDeleted = false;
            this.isResponsiblesAllowed = lineItem.Product2.Bonus_Value__c != null;
            this.minimalStockValue = lineItem.Product2.Minimal_Stock_Value__c;
            this.installments = lineItem.Installments__c;
            this.numberOfInstallments = lineItem.Number_of_installments__c;
            this.percentageOfDownPayment = lineItem.Percentage_of_the_down_payment_amount__c;
            this.downPayment = lineItem.Down_payment__c;
            this.deliveryAfterPayment = lineItem.Delivery_After_Full_Payment__c;
            this.plannedDeliveryDate = lineItem.Planned_Delivery_Date__c;
            this.advancedPaymentAmount = lineItem.Advance_Payment_Amount__c;
            this.plannedAdvancePaymentDate = lineItem.Planned_Advance_Payment_Date__c;
            this.currencyIsoCode = lineItem.CurrencyIsoCode;
            this.reservationAssetWrapper = new List<ReservationAssetWrapper>();
        }

        public OpportunityLineItem toSObject() {
            return new OpportunityLineItem(
                    Id = this.id,
                    Quantity = this.quantity,
                    UnitPrice = this.salesPrice,
                    Period_of_extended_warranty_months__c = this.periodOfExtendedWarranty,
                    Installments__c = this.installments,
                    Number_of_installments__c = this.numberOfInstallments,
                    Percentage_of_the_down_payment_amount__c = this.percentageOfDownPayment,
                    Down_payment__c = this.downPayment,
                    Delivery_After_Full_Payment__c = this.deliveryAfterPayment,
                    Planned_Delivery_Date__c = this.plannedDeliveryDate,
                    Planned_Advance_Payment_Date__c = this.plannedAdvancePaymentDate
            );
        }
    }

    public class TeamMemberWrapper {
        @AuraEnabled
        public String id { get; set; }

        @AuraEnabled
        public String user { get; set; }

        @AuraEnabled
        public String role { get; set; }

        @AuraEnabled
        public String accessLevel { get; set; }

        @AuraEnabled
        public Boolean isDeleted { get; set; }

        public TeamMemberWrapper(OpportunityTeamMember teamMember) {
            this.id = teamMember.Id;
            this.user = teamMember.User.Name;
            this.role = teamMember.TeamMemberRole;
            this.accessLevel = teamMember.OpportunityAccessLevel;
            this.isDeleted = false;
        }

        public OpportunityTeamMember toSObject() {
            return new OpportunityTeamMember(
                    Id = this.id,
                    TeamMemberRole = this.role,
                    OpportunityAccessLevel = this.accessLevel
            );
        }
    }

    public class TeamMemberOptionWrapper {
        @AuraEnabled
        public String value { get; set; }

        @AuraEnabled
        public String label { get; set; }

        public TeamMemberOptionWrapper(OpportunityTeamMember teamMember) {
            this.value = teamMember.UserId;
            this.label = teamMember.User.Name;
        }

        public TeamMemberOptionWrapper(Opportunity opportunity) {
            this.value = opportunity.OwnerId;
            this.label = opportunity.Owner.Name;
        }
    }

    public class MarketingServiceWrapper {
        @AuraEnabled
        public String id { get; set; }

        @AuraEnabled
        public String name { get; set; }

        @AuraEnabled
        public String account { get; set; }

        @AuraEnabled
        public String type { get; set; }

        @AuraEnabled
        public String description { get; set; }

        @AuraEnabled
        public Boolean isDeleted { get; set; }

        public MarketingServiceWrapper(Marketing_Service__c service) {
            this.id = service.Id;
            this.name = service.Name;
            this.account = service.Account__r.Name;
            this.type = service.Type__c;
            this.description = service.Description__c;
            this.isDeleted = false;
        }

        public Marketing_Service__c toSObject() {
            return new Marketing_Service__c(
                    Id = this.id,
                    Type__c = this.type,
                    Description__c = this.description
            );
        }
    }

    public class ReservationAssetWrapper {
        @AuraEnabled
        public String id { get; set; }

        @AuraEnabled
        public String name { get; set; }

        @AuraEnabled
        public Date startDate { get; set; }

        public ReservationAssetWrapper(Reservation_Asset__c reservationAsset) {
            this.id = reservationAsset.Reservation__c;
            this.name = reservationAsset.Reservation__r.Name;
            this.startDate = Date.valueOf(reservationAsset.Reservation__r.Start_Date__c);
        }
    }

    private static Boolean isTeamMemberContainsMember(List<TeamMemberOptionWrapper> listOfTeamMemberOptionWrappers ,
                                                                OpportunityTeamMember opportunityTeamMember ){
        for(TeamMemberOptionWrapper teamMemberOption: listOfTeamMemberOptionWrappers){
            if(teamMemberOption.value == opportunityTeamMember.UserId){
                return true;
            }
        }
        return false;
    }

}