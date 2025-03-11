import { LightningElement } from 'lwc';
import { RefreshEvent } from 'lightning/refresh';

import FIRSTNAME from '@salesforce/schema/Contact.FirstName';
import LASTNAME from '@salesforce/schema/Contact.LastName';
import PHONE from '@salesforce/schema/Contact.Phone';
import EMAIL from '@salesforce/schema/Contact.Email';
import ACC_ID from '@salesforce/schema/Contact.AccountId';

export default class RefreshViewST extends LightningElement {
    firstName = FIRSTNAME;
    lastName = LASTNAME;
    phone = PHONE;
    email = EMAIL;
    accId = ACC_ID;

    handleSucccess(event) {
        console.log('Contact Record Created Successully !! ', event.detail.id);

        this.dispatchEvent(new RefreshEvent());
    }
}