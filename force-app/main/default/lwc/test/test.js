import { LightningElement, api } from 'lwc';

import ACC_NAME from '@salesforce/schema/Account.Name';

export default class Test extends LightningElement {
    @api recordId // Ensure this is a valid Account record ID
    accFields = [ACC_NAME];

    connectedCallback() {
        console.log('Component initialized with recordId:', this.recordId);
        console.log('Fields to display:', this.accFields);
    }
}