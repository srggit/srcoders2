import { LightningElement, api, track } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation'; // Import NavigationMixin

export default class Edit_account_action_btn extends NavigationMixin(LightningElement) {
    @api recordId;

    handleSave() {
        console.log('Save method is triggered');

        // Retrieve field values directly from the component
        const name = this.template.querySelector('[data-id="name"]').value;
        const rating = this.template.querySelector('[data-id="rating"]').value;
        const industry = this.template.querySelector('[data-id="industry"]').value;
        const annualRevenue = this.template.querySelector('[data-id="annualRevenue"]').value;
        const parentAcc = this.template.querySelector('[data-id="parentAcc"]').value;
        const phone = this.template.querySelector('[data-id="phone"]').value;
        const accountNumber = this.template.querySelector('[data-id="accountNumber"]').value;

        const fax = this.template.querySelector('[data-id="fax"]').value;
        const website = this.template.querySelector('[data-id="website"]').value;
        const employees = this.template.querySelector('[data-id="employees"]').value;
        const type = this.template.querySelector('[data-id="type"]').value;
        const ownership = this.template.querySelector('[data-id="ownership"]').value;
        const pincode = this.template.querySelector('[data-id="pincode"]').value;
        const active = this.template.querySelector('[data-id="active"]').value;

        const fields = {
            Id: this.recordId,
            Name: name,
            Rating: rating,
            Industry: industry,
            AnnualRevenue: annualRevenue,
            ParentId: parentAcc,
            Phone: phone,
            AccountNumber: accountNumber,
            Type: type,
            Fax: fax,
            Website: website,
            NumberOfEmployees: employees,
            Ownership: ownership,
            Pincode__c: pincode,
            Active__c: active
        };

        updateRecord({ fields })
            .then(() => {
                console.log('Account Updated Successfully !!');
                this.showToast('Success', 'Record updated successfully!', 'success');
                this.navigateToRecord();
            })
            .catch(error => {
                console.log('Error : ' + error);
                console.log('Error : ' + error.body.message);
                this.showToast('Error updating record', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(toastEvent);
    }

        navigateToRecord() {
            // Use the NavigationMixin to navigate to the Account record
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.recordId,
                    objectApiName: 'Account', // API name of the object
                    actionName: 'view' // Action name to view the record
                }
            });
        }

    handleCancel() {
        this.navigateToRecord();
    }

}