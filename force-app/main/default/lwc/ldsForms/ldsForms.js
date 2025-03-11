import { LightningElement, api } from 'lwc';

// Import Selected fields
import AccName from '@salesforce/schema/Account.Name';    
import AccRating from '@salesforce/schema/Account.Rating';
import AccInd from '@salesforce/schema/Account.Industry';
import AccPhone from '@salesforce/schema/Account.Phone';
import AccRevenue from '@salesforce/schema/Account.AnnualRevenue';

export default class LdsForms extends LightningElement {

    @api recordId;      // Reserved Keyword

    accFields = [AccName, AccRating, AccInd, AccPhone, AccRevenue];

    resetFields(event){
        const inputFields = this.template.querySelectorAll('lightning-input-field');
        inputFields.forEach(field => {field.reset();});
    }
}