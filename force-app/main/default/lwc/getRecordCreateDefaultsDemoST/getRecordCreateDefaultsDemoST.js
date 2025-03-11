import { LightningElement, wire } from 'lwc';

// Used to get the default info of the field
import { getRecordCreateDefaults } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class GetRecordCreateDefaultsDemoST extends LightningElement {

    tableHeader; tableData;

    @wire(getRecordCreateDefaults, { objectApiName: ACCOUNT_OBJECT.objectApiName })
    wiredRecordsDefault({ data, error }) {
        if (data) {
            //console.log(' GetRecordCreateDefaultsDemoST data : ', data);

            // This is used to fetch the data as it is, if we know the structure
            const fields = data.objectInfos.Account.fields;
            //console.log('GetRecordCreateDefaultsDemoST fields : ', fields);

            // In this situation i don't know the structure of the childRelationships, that's why i am using below structure: It is an Array, it will automatically detect the structure and store the data accordingly
            //const {childRelationships} = data.objectInfos.Account;

            // I can't use this, because the data is an Array and I am trying to store it in an object
            const { childRelationships } = data.objectInfos.Account.childRelationships;
            //console.log('GetRecordCreateDefaultsDemoST childRelationships : ', childRelationships);

            // fields is an Object
            // From fields object we are fetching all the keys, but we don't need all the keys
            // this.tableHeader = Object.keys(fields);
            this.tableHeader = ['ApiName', 'DataType', 'Label', 'Length', 'Required'];
            // this.tableHeader: AccountNumber, apiName, length, required etc
            //console.log('tableHeader : ', JSON.stringify(this.tableHeader));

            // Fetching all the values
            // item: AccountNumber, apiName, length, required etc
            this.tableData = Object.keys(fields).map(item => {
                // let values = fields['AccountNumber'];
                // AccountNumber is again an object.
                let values = fields[item];

                //let apiName = values.apiName;
                //let dataType = values.dataType;
                // values is an object, from which we are fetching the required data
                const { apiName, dataType, label, length, required } = values;
                return { apiName, dataType, label, length, required };
            });
            //console.log('tableData : ', JSON.stringify(this.tableData));
        }
        if (error) {
            console.log('error : ', error);
        }
    }
}