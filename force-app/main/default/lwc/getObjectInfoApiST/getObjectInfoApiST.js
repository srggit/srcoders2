import { LightningElement, wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class GetObjectInfoApiST extends LightningElement {

    accDefaultRecordTypeId;

    @wire(getObjectInfo, { objectApiName : ACCOUNT_OBJECT}) 
    wiredObjectInfo({data, error}){
        if(data){
            console.log('getObjectInfo Data : ', data);
            this.accDefaultRecordTypeId = data.defaultRecordTypeId;
        }
        else if(error){
            console.log('error : ', error);
        }
    };
}