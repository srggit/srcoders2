import { LightningElement, api, wire } from 'lwc';

import { getRecord, getFieldValue, getFieldDisplayValue } from 'lightning/uiRecordApi';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_RATING from '@salesforce/schema/Account.Rating';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
import ACCOUNT_ANNUAL_REVENUE from '@salesforce/schema/Account.AnnualRevenue';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';
import ACCOUNT_OWNER from '@salesforce/schema/Account.Owner.Name';

const FIELDS = ['Account.Name', 'Account.Rating', 'Account.Industry', 'Account.Phone'];

export default class GetRecordDemoST extends LightningElement {
    @api recordId;

    name; rating; industry; phone; owner; annualRevenue;
    accData = {};
    /*
    @wire(getRecord,
        {
            recordId: '$recordId',
            fields: [ACCOUNT_NAME, ACCOUNT_RATING],
            optionalFields: [ACCOUNT_INDUSTRY, ACCOUNT_PHONE, ACCOUNT_OWNER],
        }
    ) accountData
    */

    // Method 3:
    // Example of getFieldValue(record, field)
    // If fields has Viewing Permission Restrictions, it will throw error
    @wire(getRecord,
        {
            recordId: '001NS00000YKFfPYAX',
            fields: [ACCOUNT_NAME, ACCOUNT_RATING], // FIELDS
            optionalFields: [ACCOUNT_INDUSTRY, ACCOUNT_PHONE, ACCOUNT_OWNER, ACCOUNT_ANNUAL_REVENUE],
        }
    ) account;

    get accName() {
        return getFieldValue(this.account.data, ACCOUNT_NAME);
    }

    get accRating() {
        return getFieldValue(this.account.data, ACCOUNT_RATING);
    }

    get accIndustry() {
        return getFieldValue(this.account.data, ACCOUNT_INDUSTRY);
    }

    // Example of getFieldDisplayValue: It shows the value as in records
    get accAnnualRevenue1() {
        return getFieldValue(this.account.data, ACCOUNT_ANNUAL_REVENUE);
    }

    get accAnnualRevenue2() {
        return getFieldDisplayValue(this.account.data, ACCOUNT_ANNUAL_REVENUE);
    }

    get accPhone() {
        return getFieldValue(this.account.data, ACCOUNT_PHONE);
    }

    get accOwner() {
        return getFieldValue(this.account.data, ACCOUNT_OWNER);
    }




    // Method 1:
    // Example of getRecord
    @wire(getRecord,
        {
            recordId: '001NS00000YKFfPYAX',
            fields: [ACCOUNT_NAME, ACCOUNT_RATING, ACCOUNT_INDUSTRY], // FIELDS
            optionalFields: [ACCOUNT_ANNUAL_REVENUE, ACCOUNT_PHONE, ACCOUNT_OWNER, ACCOUNT_ANNUAL_REVENUE],
        }
    ) accountData({ data, error }) {
        if (data) {
            console.log('GetRecordDemoST data: ', JSON.stringify(data));

            const { fields } = data;

            // Get the fields data as key
            const keys = Object.keys(fields);   // return an Array of keys 
            console.log('keys : ', JSON.stringify(keys));

            Object.keys(fields).forEach(item => {
                let value = fields[item] && fields[item].displayValue ? fields[item].displayValue : fields[item].value;

                this.accData = { ...this.accData, [item]: value };

                //this.accData[item] = value
            });
            console.log('this.accData : ', JSON.stringify(this.accData));

            // Method 2:
            this.name = data.fields.Name.value;
            this.rating = data.fields.Rating.value;
            this.industry = data.fields.Industry.value;
            this.phone = data.fields.Phone.value;
            this.owner = data.fields.Owner.displayValue;
            this.annualRevenue = data.fields.AnnualRevenue.displayValue;

            //this.owner = data.fields.Owner.value.fields.Name.value;
        }
        if (error) {
            console.log('GetRecordDemoST error : ', error);
        }
    };

}