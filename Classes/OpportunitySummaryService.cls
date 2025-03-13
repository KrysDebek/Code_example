public without sharing class OpportunitySummaryService {

    public OpportunitySummaryService() {}

    public static Opportunity getOpportunityRecord(Id opportunityId) {
        Opportunity opp = null;

        List<Opportunity> opportunities = [
                SELECT
                        Id, Amount, CloseDate, Real_Close_Date__c, Planned_Delivery_Date__c, Opportunity_Summary_Completed__c, Reason_of_Won__c, OwnerId,
                        Owner.Name, Single_Order__c, Customer_NIP__c, Shipping_State_Province__c, Shipping_Zip_Postal_Code__c, Shipping_Street__c, Shipping_City__c,
                        Shipping_Country__c, Delivery_After_Full_Payment__c, Planned_Full_Payment_Date__c, Planned_Advance_Payment_Date__c, Advance_Payment_Amount__c,
                        E_Invoice__c, RODO_agreement_leasing__c, RODO_agreement_email__c, RODO_agreement_phone__c, RODO_agreement_statistics__c, RODO_agreement_marketing__c,
                        Free_of_charge_items__c, Payment_Method__c, Client_Representative_Last_Name__c, Client_Representative_First_Name__c, Company_Invoice_Name__c, StageName,
                        Billing_Country__c, Billing_City__c, Billing_Street__c, Billing_Zip_Postal_Code__c, Billing_State_Province__c, Customer_KRS__c, Customer_REGON__c, Down_payment__c,
                        Client_Representative_Title__c, Client_Representative_Phone__c, Client_Representative_Email__c, E_Invoice_e_mail__c, Reason_of_Won_From_Summary__c, Is_Approval_was_required__c,
                        toLabel(Shared_Sales__c), Sales_Representative__c, Additional_Sales_Representative__c, Sales_Representative__r.Name, Additional_Sales_Representative__r.Name, Free_of_Charge_Items_Added__c,
                        FOC_Type__c, Louis_Vuitton_article_number__c, RODO_Marketing_Agreement_ITP__c, RODO_Marketing_Agreement_Neauvia__c, RODO_Agreement__c, CurrencyIsoCode,
                        (
                                SELECT
                                        Id, Product2Id, Product2.Name, Product2.Product_Type__c, Product2.Bonus_Value__c, Asset__c,
                                        Quantity, UnitPrice, OpportunityId, Asset_for_Sale__c, Period_of_extended_warranty_months__c, Down_payment__c,
                                        Product2.Minimal_Stock_Value__c, Installments__c, Number_of_installments__c, Percentage_of_the_down_payment_amount__c,
                                        Delivery_After_Full_Payment__c, Planned_Delivery_Date__c, Planned_Full_Payment_Date__c, Advance_Payment_Amount__c, Planned_Advance_Payment_Date__c,
                                        CurrencyIsoCode
                                FROM
                                        OpportunityLineItems
                                WHERE
                                        Product2.Asset_for_Sale__c != true
                                ORDER BY
                                    Id ASC
                        ),
                        (
                                SELECT
                                        Id, UserId, User.Name, TeamMemberRole, OpportunityAccessLevel
                                FROM
                                        OpportunityTeamMembers
                                ORDER BY
                                        Id ASC
                        ),
                        (
                                SELECT
                                        Id, Name, Type__c, Description__c, Account__c, Account__r.Name
                                FROM
                                        Marketing_Services__r
                                ORDER BY
                                        Id ASC
                        )
                FROM
                        Opportunity
                WHERE
                        Id = :opportunityId
        ];

        if (opportunities.size() == 1) {
            opp = opportunities.get(0);
        }

        return opp;
    }

    public static void confirmAndWinOpportunity(Opportunity opportunity) {
        opportunity.Opportunity_Summary_Completed__c = true;
        opportunity.StageName = opportunity.Is_Approval_was_required__c ? 'Final Approval' : 'Closed Won';
        update opportunity;
    }

    public static void processOpportunityLineItems(List<OpportunityLineItem> lineItemsToUpdate, List<OpportunityLineItem> lineItemsToDelete) {
        update lineItemsToUpdate;
        delete lineItemsToDelete;
    }

    public static void processOpportunityTeamMembers(List<OpportunityTeamMember> opportunityTeamMembersToUpdate, List<OpportunityTeamMember> opportunityTeamMembersToDelete) {
        update opportunityTeamMembersToUpdate;
        delete opportunityTeamMembersToDelete;
    }

    public static void processMarketingServices(List<Marketing_Service__c> marketingServicesToUpdate, List<Marketing_Service__c> marketingServicesToDelete) {
        update marketingServicesToUpdate;
        delete marketingServicesToDelete;
    }

}