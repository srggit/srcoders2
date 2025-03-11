import { LightningElement, wire } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';

import getContactList from '@salesforce/apex/refreshApexControllerST.getContactList';

import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from '@salesforce/apex';

const COLS = [
    { label: 'First Name', fieldName: 'FirstName', type: 'text', editable: true },
    { label: 'Last Name', fieldName: 'LastName', type: 'text', editable: true },
    { label: 'Phone', fieldName: 'Phone', type: 'phone', editable: true },
    { label: 'Email', fieldName: 'Email', type: 'email', editable: true }
];

export default class RefreshCompST extends LightningElement {

    columns = COLS;
    draftValues = [];

    @wire(getContactList) contacts;

    handleSave(event) {
        console.log('event : ', event);
        console.log(event.detail.draftValues)

        const newValues = event.detail.draftValues;
        console.log('newValues : ', newValues);

        //const copiedArray = newValues.slice(0, newValues.length); 
        // slice(start, end): takes 2 args, if not mentioned anything it will simply create copy the existing data.

        // const recordInputs2 = newValues.slice().map(value => {
        //     const fields = Object.assign({}, value)
        //     return { fields }
        // });

        // recordInputs2.forEach(element => {
        //     console.log(JSON.stringify(element.fields));
        //     console.log(JSON.stringify(element));
        // });

        // The motive is to create Key Value pair to pass to updateRecord api
        const recordInputs = newValues.slice().map(value => ({
            fields: { ...value }
        }));
        console.log('recordInputs:', JSON.stringify(recordInputs));

        // recordInputs.forEach(element => {
        //     console.log(JSON.stringify(element.fields));
        //     console.log(JSON.stringify(element));
        // });

        // updateRecord api updates single record at a time
        // array.map(callback())
        const allPromises = recordInputs.map(recordInput => updateRecord(recordInput));

        console.log('allPromises : ', allPromises);

        Promise.all(allPromises)
            .then(result => {
                console.log('result : ', result);

                this.showNotification('Success', 'Records Updated Successfully !!', 'success');

                this.draftValues = [];
                return refreshApex(this.contacts);

            })
            .catch(error => {
                console.log('error : ', JSON.stringify(error));
                this.showNotification('Error', error.body, 'error');
            });
    }

    showNotification(title, messageText, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: messageText,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}