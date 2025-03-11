import { LightningElement, wire, track } from 'lwc';
import searchContacts from '@salesforce/apex/searchContactsUsingKeyword.searchContacts';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

// JS Object
const COLS = [
    { label: 'First Name', fieldName: 'FirstName', type: 'text', editable: true },
    { label: 'Last Name', fieldName: 'LastName', type: 'text', editable: true },
    { label: 'Phone', fieldName: 'Phone', type: 'text', editable: true },
    { label: 'Email', fieldName: 'Email', type: 'text', editable: true }
];

import ID_FIELD from '@salesforce/schema/Contact.Id';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';

export default class Imperations2 extends LightningElement {
    searchItem;
    columns = COLS;
    contactList = [];
    draftValues = [];  // Track draft values for the data table
    wiredContactsResult;  // Store the wired result for refreshApex

    // Capture the search keyword
    getSearchKey(event) {
        this.searchItem = event.target.value;
        console.log('Search Item Is : ' + this.searchItem);
    }

    // Wire the apex method and store the result for refreshApex
    @wire(searchContacts, { searchKey: '$searchItem' }) 
    wiredContacts(result) {
        this.wiredContactsResult = result;
        if (result.data) {
            console.log('Data:', result.data);
            this.contactList = result.data;
            this.error = undefined;
        } else if (result.error) {
            console.log('Error:', result.error);
            this.error = result.error;
        }
    }

    // Handle the save action when the user clicks the "Save" button
    handleSave(event) {
 
        const draftValues = event.detail.draftValues;  // Handle only the first draft value for simplicity
        
        // Create an array of promises for each updateRecord call
        const updatePromises = draftValues.map( draftValue => {
            const fields = {};

            fields[ID_FIELD.fieldApiName] = draftValue.Id;
            fields[FIRST_NAME_FIELD.fieldApiName] = draftValue.FirstName;
            fields[LAST_NAME_FIELD.fieldApiName] = draftValue.LastName;

            // Create recordData for each record and update in Salesforce
            const recordData = { fields };

            // Update the record in Salesforce
            updateRecord(recordData)
            .then(response => {
                console.log('Record Updated Successfully:', response);
                this.draftValues = [];  // Clear the draft values

                // Refresh the data in the table
                return refreshApex(this.wiredContactsResult);  // Trigger the data refresh
            })
            .then(() => {
                console.log('Page refreshed!');
            })
            .catch(error => {
                console.error('Error while updating record:', error);
            });

        });
    }
}


/*

// Handle the save action when the user clicks the "Save" button
    handleSave(event) {
        const fields = {};
        const draftValues = event.detail.draftValues[0];  // Handle only the first draft value for simplicity
        
        fields[ID_FIELD.fieldApiName] = draftValues.Id;
        fields[FIRST_NAME_FIELD.fieldApiName] = draftValues.FirstName;
        fields[LAST_NAME_FIELD.fieldApiName] = draftValues.LastName;

        const recordData = { fields };

        // Update the record in Salesforce
        updateRecord(recordData)
            .then(response => {
                console.log('Record Updated Successfully:', response);
                this.draftValues = [];  // Clear the draft values

                // Refresh the data in the table
                return refreshApex(this.wiredContactsResult);  // Trigger the data refresh
            })
            .then(() => {
                console.log('Page refreshed!');
            })
            .catch(error => {
                console.error('Error while updating record:', error);
            });
    }

*/