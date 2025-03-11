import { LightningElement, api, wire } from 'lwc';
import showAcc from '@salesforce/apex/GetAllAccountsLWC.showAcc';
import getContacts from '@salesforce/apex/GetContactsLWC.getContacts';
import searchContacts from '@salesforce/apex/searchContactsUsingKeyword.searchContacts';
import { createRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

const COLS = [
    {label: "First Name", fieldName: "FirstName", type: "text"},
    {label: "Last Name", fieldName: "LastName", type: "text"},
    {label: "Phone", fieldName: "Phone", type: "phone"},
    {label: "Email", fieldName: "Email", type: "email"},
    {label: "Account", fieldName: "AccountName", type: "text"}
];

import ID from '@salesforce/schema/Contact.Id';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import PHONE from '@salesforce/schema/Contact.Phone';
import EMAIL from '@salesforce/schema/Contact.Email';
import ACCOUNT_ID from '@salesforce/schema/Contact.AccountId';
import ACCOUNT_NAME from '@salesforce/schema/Contact.AccountId';
import { updateRecord } from 'lightning/uiRecordApi';

const CONTACT_COLS = [
    {label: "First Name", fieldName: "FirstName", type: "text", editable: true},
    {label: "Last Name", fieldName: "LastName", type: "text", editable: true},
    {label: "Phone", fieldName: "Phone", type: "phone", editable: true},
    {label: "Email", fieldName: "Email", type: "email", editable: true},
    {label: "Account Id", fieldName: "AccountId", type: "text"},
    {label: "Account Name", fieldName: "AccountName", type: "text", editable: true}
];

export default class Practice_lwc extends LightningElement {
    
    privateVar = 'This is Private Variable Value';  

    @api publicVar = 'This is Public Variable Value';

    name; rating; industry;

    getValue(event){
        const field = event.target.fieldName;
        const value = event.target.value;

        console.log('field : ' + field);
        console.log('value : ' + value);

        if(field == 'Name'){
            this.name = event.target.value;
        }
        else if(field == 'Rating'){
            this.rating = event.target.value;
        }
        else if(field == 'Industry'){
            this.industry = event.target.value;
        }
    }

    columns = COLS;

    // Get Account Records using Wire as Property
    @wire(showAcc) accountsData;

    // Get Accounts Records using Wire as Function
    conResultData; conResultError; conMappedData;

    // This syntax is called the "spread operator." It takes all properties of the contact object and includes them in the new object being created.
    // For instance, if contact has properties like Id, Name, Email, etc., these properties are spread into the new object, so it retains all original fields of contact.
    
    @wire(getContacts) conData({data, error}){
        if(data){
            this.conResultData = data;                      // Original Data
            this.conMappedData = data.map(contact => ({     // New Array which contains Account Name
                ...contact,
                AccountName : contact.Account ? contact.Account.Name : ''
            }));
        }
        else if(error){
            this.conResultData = error;
        }
    }

    // createRecord Imperation
    accName; accRating; accIndustry; accOwnership;

    getAccData(event){
        const field = event.target.name;
        const value = event.target.value;

        console.log(`field : ${field} & value : ${value}`);

        if(field == 'accName'){
            this.accName = event.target.value;
        }
        else if(field == 'accRating'){
            this.accRating = event.target.value;
        }
        else if(field == 'accIndustry'){
            this.accIndustry = event.target.value;
        }
        else if(field == 'accOwnership'){
            this.accOwnership = event.target.value;
        }
    }

    resetValues(event){
        const allValues = this.template.querySelectorAll('lightning-input');
        console.log('allValues : ' + allValues); 

        for(let i=0; i<allValues.length; i++){
            allValues[i].value = '';
        }
    }

    saveRecord(event){
        console.log('saveRecord is Clicked');

        const fields = {
            'Name' : this.accName,
            'Rating' : this.accRating,
            'Industry' : this.accIndustry,
            'Ownership' : this.accOwnership
        };

        const accRecordDataToInsert = {apiName : 'Account', fields};

        createRecord(accRecordDataToInsert)
        .then(response =>{
                alert('Record Created Successfully !!!');
            }
        ).catch(error=>{
            alert('Record Creation Failed !!!');
        });
    }

    // Editable DataTable
    contactCols = CONTACT_COLS;
    key = '';
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