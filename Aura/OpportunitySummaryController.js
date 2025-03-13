({
    initHandler: function(component, event, helper) {
        helper.loadLabels(component);
        helper.getOpportunityRecord(component);
        helper.loadReasonsOfWonOptions(component);
        helper.loadCountryOptions(component);
        helper.loadTeamMemberRolesOptions(component);
        helper.loadTeamMemberAccessOptions(component);
        helper.loadMarketingServiceTypesOptions(component);
        helper.loadInstallmentsOptions(component);
        helper.loadDownPaymentsOptions(component);
        helper.loadProductDownPaymentsOptions(component);
        helper.loadLouisVuittonArticleNumberOptions(component);
        helper.loadFreeChargeItemsAddedOptions(component);
        helper.loadFOCTypeOptions(component);
        helper.loadRODOAgreementOptions(component);
        helper.loadRODOMarketingITPOptions(component);
        helper.getRODOMarketingNeauviaOptions(component);
    },

    confirmOpportunityAction: function(component, event, helper) {
        let fieldsToValidate = component.find("fieldToValidate");
        let numberOfInvalidFields = 0;
        if(fieldsToValidate.length != undefined){
            let allValid = fieldsToValidate.reduce(function (validSoFar, inputCmp){
                inputCmp.showHelpMessageIfInvalid();
                return validSoFar && inputCmp.get('v.validity').valid;
            }, true);
            if (!allValid) {
                numberOfInvalidFields++;
            }
        } else {
            let allValid = fieldsToValidate;
            if (!allValid.get('v.validity').valid) {
                numberOfInvalidFields++;
            }
        }
        if(numberOfInvalidFields == 0){

            let confirmationDialog = component.find('opportunityConfirmationDialog'),
                opportunity = component.get('v.opportunityRecord'),
                assetForSaleReservations = [];

            opportunity.products.forEach(function(item) {
                if (!$A.util.isUndefinedOrNull(item.reservationAssetWrapper) && !item.isDeleted) {
                    item.reservationAssetWrapper.forEach(function(reservation) {
                        let reservationStartDate = new Date(reservation.startDate),
                            oppCloseDate = new Date(component.get('v.opportunityRecord').plannedDeliveryDate),
                            dateDiffInDays = parseInt((reservationStartDate-oppCloseDate)/(24*3600*1000));
                        if (dateDiffInDays >= -3) {
                            assetForSaleReservations.push(reservation);
                        }
                    });
                }
            });

            if (assetForSaleReservations.length > 0) {
                component.set('v.assetForSaleReservations', assetForSaleReservations);
                let message = $A.get('$Label.c.Opportunity_Summary_Reservation_colliding_message');
                helper.showErrorToast(message);
            } else {
                if (confirmationDialog) {
                    confirmationDialog.showDialog();
                }
            }
        } else {
            let message = $A.get('$Label.c.CheckAsset_ReviewErrors');
            helper.showErrorToast(message);
        }
    },

    navigateToRecord : function(component, event, helper) {
        let navService = component.find("navService"),
            recordId = event.getSource().get('v.value'),
            pageRef = {
                type: 'standard__recordPage',
                attributes: {
                    actionName: 'view',
                    objectApiName: 'Reservation__c',
                    recordId : recordId
                }
            };

        navService.generateUrl(pageRef)
            .then($A.getCallback(function(url) {
              window.open(url,'_blank');
            }),
            $A.getCallback(function(error) {
              console.log('error: ' + error);
        }));
    },

    handleProductDeleteAction: function(component, event, helper) {
        let value = event.getSource().get('v.value');

        let opportunity = component.get('v.opportunityRecord');
        opportunity.products.forEach(function(item) {
            if (item.id === value) {
                item.isDeleted = true;
            }
        });

        component.set('v.opportunityRecord', opportunity);
    },

    handleProductRestoreAction: function(component, event, helper) {
        let value = event.getSource().get('v.value');

        let opportunity = component.get('v.opportunityRecord');
        opportunity.products.forEach(function(item) {
            if (item.id === value) {
                item.isDeleted = false;
            }
        });

        component.set('v.opportunityRecord', opportunity);
    },

    handleTeamMemberDeleteAction: function(component, event, helper) {
        let value = event.getSource().get('v.value');

        let opportunity = component.get('v.opportunityRecord');
        opportunity.teamMembers.forEach(function(item) {
            if (item.id === value) {
                item.isDeleted = true;
            }
        });

        component.set('v.opportunityRecord', opportunity);
    },

    handleTeamMemberRestoreAction: function(component, event, helper) {
        let value = event.getSource().get('v.value');

        let opportunity = component.get('v.opportunityRecord');
        opportunity.teamMembers.forEach(function(item) {
            if (item.id === value) {
                item.isDeleted = false;
            }
        });

        component.set('v.opportunityRecord', opportunity);
    },

    handleMarketingServiceDeleteAction: function(component, event, helper) {
        let value = event.getSource().get('v.value');

        let opportunity = component.get('v.opportunityRecord');
        opportunity.marketingServices.forEach(function(item) {
            if (item.id === value) {
                item.isDeleted = true;
            }
        });

        component.set('v.opportunityRecord', opportunity);
    },

    handleMarketingServiceRestoreAction: function(component, event, helper) {
        let value = event.getSource().get('v.value');

        let opportunity = component.get('v.opportunityRecord');
        opportunity.marketingServices.forEach(function(item) {
            if (item.id === value) {
                item.isDeleted = false;
            }
        });

        component.set('v.opportunityRecord', opportunity);
    },

    handleAssetForSaleDeleteAction: function(component, event, helper) {
        let value = event.getSource().get('v.value');

        let opportunity = component.get('v.opportunityRecord');
        opportunity.assetForSales.forEach(function(item) {
            if (item.id === value) {
                item.isDeleted = true;
            }
        });

        component.set('v.opportunityRecord', opportunity);
    },

    handleAssetForSaleRestoreAction: function(component, event, helper) {
        let value = event.getSource().get('v.value');

        let opportunity = component.get('v.opportunityRecord');
        opportunity.assetForSales.forEach(function(item) {
            if (item.id === value) {
                item.isDeleted = false;
            }
        });

        component.set('v.opportunityRecord', opportunity);
    },

    handleNotificationEvent: function(component, event, helper) {
        let message = event.getParam('message');
        let name = event.getParam('name');

        if (name === 'opportunityConfirmation') {
            if (message === 'OK') {
                helper.confirmOpportunity(component);
            }
        }
    }
})