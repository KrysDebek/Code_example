({
    getOpportunityRecord: function(component) {
        let helper = this;

        let action = component.get('c.fetchOpportunityData');
        action.setParams({
            opportunityId: component.get('v.recordId')
        });

        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let opp = response.getReturnValue();
                component.set('v.opportunityRecord', opp);
                console.log(component.get('v.opportunityRecord'));
            } else {
                let errors = response.getError();
                let message = 'Unknow_Error';
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    confirmOpportunity: function(component) {
        let helper = this;

        let action = component.get('c.confirmAndUpdateOpportunity');
        action.setParams({
            serializedOpportunity: JSON.stringify(component.get('v.opportunityRecord'))
        });

        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            $A.get('e.force:closeQuickAction').fire();

            let state = response.getState();
            if (state == 'SUCCESS') {
                helper.showSuccessToast($A.get('$Label.c.Opportunity_Confirmed'));
                $A.get('e.force:refreshView').fire();
                window.location.reload();
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                console.log(message);
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },


    loadReasonsOfWonOptions: function(component) {
        let helper = this;

        let action = component.get('c.getReasonsOfWonOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.reasonsOfWon', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },


    loadRODOAgreementOptions: function(component) {
        let helper = this;

        let action = component.get('c.getRODOAgreementOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.RODOAgreement', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadRODOMarketingITPOptions: function(component) {
        let helper = this;

        let action = component.get('c.getRODOMarketingITPOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.RODOMarketingITP', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    getRODOMarketingNeauviaOptions: function(component) {
        let helper = this;

        let action = component.get('c.getRODOMarketingNeauviaOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.RODOMarketingNEAUVIA', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadLouisVuittonArticleNumberOptions: function(component) {
        let helper = this;

        let action = component.get('c.getLouisVuittonArticleNumberOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.louisVuittonArtNumbers', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },


    loadFreeChargeItemsAddedOptions: function(component) {
        let helper = this;

        let action = component.get('c.getFreeChargeItemsAddedOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.freeOfChargeItemsAdded', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadFOCTypeOptions: function(component) {
        let helper = this;

        let action = component.get('c.getFOCTypeOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.focTypes', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadDownPaymentsOptions: function(component) {
        let helper = this;

        let action = component.get('c.getDownPaymentsOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.downPayments', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },


    loadProductDownPaymentsOptions: function(component) {
        let helper = this;

        let action = component.get('c.getProductDownPaymentsOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.productDownPayments', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadCountryOptions: function(component) {
        let helper = this;

        let action = component.get('c.getCountryOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.countries', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadInstallmentsOptions: function(component) {
        let helper = this;

        let action = component.get('c.getInstallmentsOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.installments', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadTeamMemberRolesOptions: function(component) {
        let helper = this;

        let action = component.get('c.getTeamMemberRolesOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.teamMemberRoles', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadTeamMemberAccessOptions: function(component) {
        let helper = this;

        let action = component.get('c.getTeamMemberAccessOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.teamMemberAccess', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadMarketingServiceTypesOptions: function(component) {
        let helper = this;

        let action = component.get('c.getMarketingServiceTypesOptions');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let options = response.getReturnValue();
                component.set('v.marketingServiceTypes', options);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    loadLabels: function(component) {
        let helper = this;

        let action = component.get('c.getLabelsMap');
        action.setCallback(this, function(response) {
            component.set('v.showSpinner', false);

            let state = response.getState();
            if (state == 'SUCCESS') {
                let returnedValue = response.getReturnValue();
                component.set('v.labelsMap', returnedValue);
            } else {
                let errors = response.getError();
                let message = $A.get('$Label.c.Unknow_Error');
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;

                }
                helper.showErrorToast(message);
            }
        });

        component.set('v.showSpinner', true);
        $A.enqueueAction(action);
    },

    showToast: function(message, type, icon) {
        let toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({
            'message': message,
            'type': type,
            'key': icon,
            'duration': 5000,
            'mode': type === 'success' ? 'dismissible' : 'sticky'
        });
        toastEvent.fire();
    },

    showErrorToast: function(message) {
        this.showToast(message, 'error', 'error');
    },

    showSuccessToast: function(message) {
        this.showToast(message, 'success', 'success');
    }
})