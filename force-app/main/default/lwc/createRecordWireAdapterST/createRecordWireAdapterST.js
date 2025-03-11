import { LightningElement } from 'lwc';

import { createRecord } from 'lightning/uiRecordApi';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACC_NAME from '@salesforce/schema/Account.Name';
import ACC_RATING from '@salesforce/schema/Account.Rating';
import ACC_INDUSTRY from '@salesforce/schema/Account.Industry';
import ACC_PHONE from '@salesforce/schema/Account.Phone';

export default class CreateRecordWireAdapterST extends LightningElement {

    fieldsData = {};

    changeHandler(event) {
        const fieldName = event.target.name;
        const value = event.target.value;

        this.fieldsData[fieldName] = value;
        console.log('this.fieldsData', JSON.stringify(this.fieldsData));
    }

    handleSave() {

        const fields = {
            'Name' : this.fieldsData['name'],
            'Rating' : this.fieldsData['rating'],
            'Industry' : this.fieldsData['industry'],
            'Phone' : this.fieldsData[' phone']
        };

        const recordData = { apiName: ACCOUNT_OBJECT.objectApiName, fields};

        createRecord(recordData)
            .then(result => {
                console.log('result : ', result);
                console.log('Acc Record Created Successfully : ', result.id);
                console.log('Industry : ', result.fields.Industry.value);
            })
            .catch(error => {
                console.log('error : ', JSON.stringify(error));
            });
    }
}







// Working Code
/*
formFields = {
        name : '',
        rating : '',
        industry : '',
        phone : ''
    };

    changeHandler(event){

        // const fieldName = event.target.name;
        // const value = event.target.value;

        // this.formFields[fieldName] = value;

        // console.log('formfields : ', this.formFields[fieldName] );
        // console.log('formFields: ', JSON.stringify(this.formFields));


        const {name, value} = event.target;
        this.formFields = {...this.formFields, [name] : value};

        console.log('formFields: ', JSON.stringify(this.formFields));
    }

    handleSave(){

        const fields = {};

        fields[ACC_NAME.fieldApiName] = this.formFields.name;
        fields[ACC_RATING.fieldApiName] = this.formFields.rating;
        fields[ACC_INDUSTRY.fieldApiName] = this.formFields.industry;
        fields[ACC_PHONE.fieldApiName] = this.formFields.phone;

        const recordData = { apiName : ACCOUNT_OBJECT.objectApiName, fields};

        createRecord(recordData)
        .then(result => {
            console.log('result : ', result);
            this.formFields = {};
            console.log('Acc Record Created Successfully !! : ', result.id);
            console.log(result.fields.Industry.value);
        })
        .catch(error => {
            console.log('error : ', JSON.stringify(error));
        });

    }
*/
// create and get the record.
/*
createRecord(recordData)
.then((result) => {
    console.log('Account Record Created Successfully!! ID: ', result.id);

    // Fetch the full record details
    return getRecord({ recordId: result.id, fields: FIELDS });
})
.then((record) => {
    console.log('Full Record Details: ', record);

    // Access specific field values
    const industry = record.fields.Industry.value;
    console.log('Industry: ', industry);
})
.catch((error) => {
    console.error('Error: ', error);
});
*/