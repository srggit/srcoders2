import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccConOppUsingImperation extends LightningElement {
    
    // Account fields
    accountName;
    accountPhone;
    
    // Contact fields
    contactFirstName;
    contactLastName;
    contactEmail;

    // Opportunity fields
    opportunityName;
    opportunityCloseDate;
    opportunityStage;

    // Define options for the combobox
    get stageOptions() {
        return [
            { label: 'Prospecting', value: 'Prospecting' },
            { label: 'Qualification', value: 'Qualification' },
            { label: 'Needs Analysis', value: 'Needs Analysis' },
            { label: 'Closed Won', value: 'Closed Won' },
            { label: 'Closed Lost', value: 'Closed Lost' }
        ];
    }

    handleOpportunityStageChange(event) {
        this.opportunityStage = event.target.value; // Capture the selected value
    }

    handleAccountNameChange(event) {
        this.accountName = event.target.value;
    }
    handleAccountPhoneChange(event) {
        this.accountPhone = event.target.value;
    }
    handleContactFirstNameChange(event) {
        this.contactFirstName = event.target.value;
    }
    handleContactLastNameChange(event) {
        this.contactLastName = event.target.value;
    }
    handleContactEmailChange(event) {
        this.contactEmail = event.target.value;
    }
    handleOpportunityNameChange(event) {
        this.opportunityName = event.target.value;
    }
    handleOpportunityCloseDateChange(event) {
        this.opportunityCloseDate = event.target.value;
    }

    saveRecords() {
        // Step 1: Create Account Record
        const accountFields = {
            'Name': this.accountName,
            'Phone': this.accountPhone
        };
        const accountRecord = { apiName: 'Account', fields: accountFields };

        createRecord(accountRecord)
            .then(accountResult => {
                // Account created successfully
                const accountId = accountResult.id;

                // Step 2: Create Contact Record and link to Account
                const contactFields = {
                    'FirstName': this.contactFirstName,
                    'LastName': this.contactLastName,
                    'Email': this.contactEmail,
                    'AccountId': accountId  // Link Contact to Account
                };
                const contactRecord = { apiName: 'Contact', fields: contactFields };

                return createRecord(contactRecord).then(contactResult => {
                    const contactId = contactResult.id;

                    // Step 3: Create Opportunity Record and link to Account and Contact
                    const opportunityFields = {
                        'Name': this.opportunityName,
                        'CloseDate': this.opportunityCloseDate,
                        'StageName': this.opportunityStage,
                        'AccountId': accountId  // Link Opportunity to Account
                    };
                    const opportunityRecord = { apiName: 'Opportunity', fields: opportunityFields };

                    return createRecord(opportunityRecord).then(() => {
                        // Show Success Toast Message
                        this.showToast('Success', 'Records Created Successfully!', 'success');
                    });
                });
            })
            .catch(error => {
                // Show Error Toast Message
                this.showToast('Error', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}