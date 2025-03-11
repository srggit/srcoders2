import { LightningElement, wire } from 'lwc';


import ACCOUNT_OBJECT from '@salesforce/schema/Account';

// These adapters names are fixed and should not be changed
import { getObjectInfo } from 'lightning/uiObjectInfoApi';

// getPicklistValuesByRecordType: Returns the picklist values for a given record type
import { getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';

export default class GetPickListValuesByRecordTypeST extends LightningElement {

    accDefaultRecordTypeId;
    activePicklistValues;
    activeValue;

    @wire(getObjectInfo, {objectApiName:ACCOUNT_OBJECT})
    objectInfo ( {data, error}){
        if(data){
            console.log('GetPickListValuesByRecordTypeST Objects Data : ', data);
            this.accDefaultRecordTypeId = data.defaultRecordTypeId;
        }
    }

    // $ means reactive property, it is automatically updated when the value of objectInfo changes
    @wire(getPicklistValuesByRecordType,
        {objectApiName : ACCOUNT_OBJECT,
            recordTypeId : '$accDefaultRecordTypeId'
        }
    ) pickListValuesByRecordType({ data, error }){
        if(data){
            console.log('GetPickListValuesByRecordTypeST Data : ', data);
            this.activePicklistValues = data.picklistFieldValues.Active__c.values;
            console.log(this.activePicklistValues);
        }
        else if(error){
            console.log('GetPickListValuesByRecordTypeST Error : ', error);
        }
    }

    handleActiveChange(event){
        this.activeValue = event.target.value;
        console.log('active value', this.activeValue);
    }
}