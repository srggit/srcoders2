import { LightningElement, track } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';

import getContacts from '@salesforce/apex/ContactController.getContacts';

const COLUMNS = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name' },
    { label: 'First Name', fieldName: 'FirstName', editable: true },
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Status', fieldName: 'Status__c' }
];

export default class ContactStatusUpdateUsingPlatformEvent extends LightningElement {

    columns = COLUMNS;
    @track contacts = [];
    subscription = null;

    connectedCallback() {
        this.loadContacts();
        this.subscribeToPlatformEvent();
    }

    loadContacts() {
        getContacts()
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                console.error('Error fetching contacts:', error);
            });
    }

    subscribeToPlatformEvent() {

        if (this.subscription) {
            console.warn('Already subscribed to Platform Event, skipping duplicate subscription.');
            return;
        }

        const channel = '/event/Contact_Status_Update__e';
        subscribe(channel, -1, (event) => {
            console.log('Received event:', JSON.stringify(event, null, 2));

            const updatedContactId = event.data.payload.ContactId__c;
            const updatedStatus = event.data.payload.Status__c;

            this.contacts = this.contacts.map(contact =>
                contact.Id === updatedContactId ? { ...contact, Status__c: updatedStatus } : contact
            );
        }).then(response => {
            this.subscription = response;
        }).catch(error => {
            console.log('Error Occured : ', error);
        })

        /* onError(error => {
            console.error('Error in Platform Event subscription:', error);
        }); */
    }

    disconnectedCallback() {
        if (this.subscription) {
            unsubscribe(this.subscription, response => {
                console.log('Unsubscribed from event:', response);
            });
        }
    }
}