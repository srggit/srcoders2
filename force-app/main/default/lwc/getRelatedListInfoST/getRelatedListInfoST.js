import { LightningElement, wire } from 'lwc';
import { getRelatedListInfo } from 'lightning/uiRelatedListApi';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class GetRelatedListInfoST extends LightningElement {

    relatedListInfo;
    displayColumns = [];

    @wire(getRelatedListInfo, {
        parentObjectApiName: ACCOUNT_OBJECT.objectApiName,
        relatedListId: 'Contacts',
        //recordTypeId: '001NS00000YKFfPYAX', //optional
        fields: ['Contact.Name', 'Contact.Id', 'Contact.Phone', 'Contact.Email'], //optional
        optionalFields: ['Contact.FirstName'], //optional
        //restrictColumnsToLayout: false //optional
    }) relatedContactInfo({ data, error }) {
        if (data) {
            console.log('data >>> ', data);
            this.relatedListInfo = data;
            this.displayColumns = data.displayColumns;
        }
        if (error) {
            console.log('error <<< ', error);
        }
    }









}