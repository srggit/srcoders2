import { LightningElement, wire } from 'lwc';

// These adapters names are fixed and should not be changed

// getObjectInfo: Returns the object metadata
// getPicklistValues: Returns the picklist values for a given picklist field
// getPicklistValuesByRecordType: Returns the picklist values for a given record type
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
export default class GetPicklistValuesST extends LightningElement {

    industryPicklistValues;
    picklistValue

    @wire(getObjectInfo, {objectApiName:ACCOUNT_OBJECT})
    objectInfo

    // $ means reactive property, it is automatically updated when the value of objectInfo changes
    @wire(getPicklistValues , { recordTypeId:'$objectInfo.data.defaultRecordTypeId', fieldApiName:INDUSTRY_FIELD})
    industryPicklistValues( {data, error}){
        if(data){
            console.log('GetPicklistValuesST : ', data);
            this.industryPicklistValues = data.values;
        }
        else if(error){
            console.log('GetPicklistValuesST : ', error);
        }
    }

    /*
    @wire(getPicklistValues , { recordTypeId:'$objectInfo.data.defaultRecordTypeId', fieldApiName:INDUSTRY_FIELD})
    industryPicklistValues
    */

    handleIndustryChange(event){
        this.picklistValue = event.target.value;
        console.log('GetPicklistValuesST : ', this.picklistValue);
    }
}