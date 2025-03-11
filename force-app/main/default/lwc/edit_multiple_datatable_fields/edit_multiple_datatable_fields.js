import { LightningElement, wire} from 'lwc';
import searchContacts from '@salesforce/apex/searchContactsUsingKeyword.searchContacts';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

import ID from '@salesforce/schema/Contact.Id';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import PHONE from '@salesforce/schema/Contact.Phone';
import EMAIL from '@salesforce/schema/Contact.Email';
import ACCOUNT_ID from '@salesforce/schema/Contact.AccountId';
import ACCOUNT_NAME from '@salesforce/schema/Contact.AccountId';

const CONTACT_COLS = [
    {label: "First Name", fieldName: "FirstName", type: "text", editable: true},
    {label: "Last Name", fieldName: "LastName", type: "text", editable: true},
    {label: "Phone", fieldName: "Phone", type: "phone", editable: true},
    {label: "Email", fieldName: "Email", type: "email", editable: true},
    {label: "Account Id", fieldName: "AccountId", type: "text"},
    {label: "Account Name", fieldName: "AccountName", type: "text", editable: true}
];

export default class Edit_multiple_datatable_fields extends LightningElement {
    
    contactCols = CONTACT_COLS;
    key;
    wiredContactsResult = [];
    contactList = [];
    mappedContacts = [];

    getContacts(event){
        this.key = event.target.value;
        console.log('this.key  : ' + this.key);
    }

    @wire(searchContacts, { searchKey : '$key'})
    wiredResult(result){
        this.wiredContactsResult = result;

        if(result.data){
            this.contactList = result.data;

            this.mappedContacts = result.data.map( contact => ({
                ...contact,
                AccountName : contact.Account ? contact.Account.Name : ''
            }));
        }

        if(result.error){
            console.log(JSON.stringify(result.error));
        }
    }

    handleSave(event) {
        const draftValues = event.detail.draftValues;
        console.log('draftValues : ' + JSON.stringify(draftValues));
    
        // Create an array of promises for each updateRecord call
        const updatePromises = draftValues.map(draftVal => {
            const fields = {};
    
            fields[ID.fieldApiName] = draftVal.Id;
            fields[FIRST_NAME.fieldApiName] = draftVal.FirstName;
            fields[LAST_NAME.fieldApiName] = draftVal.LastName;
            fields[PHONE.fieldApiName] = draftVal.Phone;
            fields[EMAIL.fieldApiName] = draftVal.Email;
    
            const recordData = { fields };
    
            // Return the updateRecord promise
            return updateRecord(recordData);
        });
    
        // Use Promise.all to wait until all updateRecord calls are completed
        Promise.all(updatePromises)
            .then(() => {
                // Clear draft values after successful update
                this.draftValues = [];
    
                alert('Records Updated');
                
                // Refresh the data in the table after all updates are complete
                return refreshApex(this.wiredContactsResult);  // Trigger the data refresh
            })
            .catch(error => {
                console.error('Error while updating records:', JSON.stringify(error));
                alert('Error updating records');
            });
    }  

}