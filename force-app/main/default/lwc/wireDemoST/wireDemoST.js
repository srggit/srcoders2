import { LightningElement, wire, track } from 'lwc';
import { getSObjectValue } from '@salesforce/apex';

import ACC_NAME from '@salesforce/schema/Account.Name';
import getAccountList from '@salesforce/apex/GetAccountsControllerST.getAccountList';
import getAccById from '@salesforce/apex/GetAccountsControllerST.getAccById';
import getContacts from '@salesforce/apex/paginationClass.getContacts';

export default class WireDemoST extends LightningElement {

    accResults;
    accountById = {};
    contacts;

    // 1. Wire as a Property
    @wire(getAccountList) wiredAccounts;

    get accName() {
        return this.wiredAccounts.data ? getSObjectValue(this.wiredAccounts.data[0], ACC_NAME) : 'No data in wiredAccounts';
    }

    // 2. Wire as a Function
    @wire(getAccountList) wiredAccountsAsFunction({ data, error }) {
        if (data) {
            this.accResults = data;
        }
        if (error) {
            console.log('error : ', error);
        }
    }

    // 3. Wire a Propert / Function by passing arguments
    @wire(getAccById, { accId: '001NS00000YKFfPYAX' })
    wiredAccsById({ data, error }) {
        if (data) {
            this.accountById = data;
            console.log(JSON.stringify(data));
        }
    };

    // 4. Calling an Apex Method Imperatively
    loadContacts() {
        console.log('loadContacts() called ');
        getContacts({ department: 'Procurement' })       // getContacts({id:878345})
            .then(data => {     //.then( result )
                this.contacts = data;
                console.log('this.contacts : ', this.contacts);
            })

            .catch(error => {
                console.log('error : ', error);
            });
    }
}