import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/paginationClass.getContacts';

export default class Pagination extends LightningElement {

    totalContacts;
    visibleContacts;

    @wire(getContacts) wiredContacts({ data, error }) {
        if (data) {
            this.totalContacts = data;
            console.log('data', data);
            console.log('data length : ' + data.length);
        }
        if (error) {
            console.log('error', error);
        }
    }

    updateContactRecordsEvent(event) {

        let slicedContacts = event.detail.records;   // 5 Contacts

        this.visibleContacts = [...slicedContacts];  // Spread Operator to make copy of the array
        console.log('Parent Component : ' + this.visibleContacts.length);

    }
}