import { LightningElement, wire } from 'lwc';
import searchContacts from '@salesforce/apex/searchContactsUsingKeyword.searchContacts';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

import ID_FIELD from '@salesforce/schema/Contact.Id';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

const cols = [
    { label: "FirstName", fieldName: "FirstName", type: "text", editable: true },
    { label: "LastName", fieldName: "LastName", type: "text", editable: true },
    { label: "Phone", fieldName: "Phone", type: "phone", editable: true },
    { label: "Email", fieldName: "Email", type: "email", editable: true }
];

export default class imperationsMultipleRowsUpdate extends LightningElement {

    searchItem;
    columns = cols;

    getSearchKey(event) {
        this.searchItem = event.target.value;
        console.log('Search Key Received: ' + this.searchItem);
    }

    // Wire a Property
    @wire(searchContacts, { searchKey: '$searchItem' }) contacts; // contacts is a Property

    handleSave(event) {
        const draftValues = event.detail.draftValues; // Get all draft values

        // Create an array of update promises
        const updatePromises = draftValues.map(draft => {
            const fields = {
                [ID_FIELD.fieldApiName]: draft.Id,
                [FIRST_NAME_FIELD.fieldApiName]: draft.FirstName,
                [LAST_NAME_FIELD.fieldApiName]: draft.LastName,
                [PHONE_FIELD.fieldApiName]: draft.Phone,
                [EMAIL_FIELD.fieldApiName]: draft.Email
            };

            return updateRecord({ fields }); // Update each record
        });

        // Execute all update promises
        Promise.all(updatePromises)
            .then(() => {
                console.log('All records updated successfully');
                
                // Clear draft values in the datatable
                const datatable = this.template.querySelector('lightning-datatable');
                if (datatable) {
                    datatable.draftValues = []; // Reset the draft values in the datatable
                }

                // Refresh the wire with new data
                return refreshApex(this.contacts);
            })
            .catch(error => {
                console.error('Error Occurred:', error);
                alert('Some Error Occurred: ' + error.body.message);
            });
    }
}