import { LightningElement, track, wire } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import getAccounts from '@salesforce/apex/Interview.getAccounts';
import { refreshApex } from '@salesforce/apex';


const COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Rating', fieldName: 'Rating' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue' },
    { label: 'Website', fieldName: 'Website' }
];

export default class PlatformEventAccountsEx extends LightningElement {
    @track accounts = [];
    wiredAccountsResult;
    columns = COLUMNS;
    subscription = null;

    connectedCallback() {
        this.subscribeToAccountPlatformEvent();
    }

    disconnectedCallback() {
        this.unsubscribeFromAccountPlatformEvent();
    }

    @wire(getAccounts)
    wiredAccounts(result) {
        this.wiredAccountsResult = result;

        if (result.data) {
            this.accounts = result.data;
            console.log('✅ Accounts Fetched:', this.accounts);
        }
        if (result.error) {
            console.log('Error while fetching the accounts');
        }
    }

    subscribeToAccountPlatformEvent() {
        console.log('📡 Subscribing to Platform Event...');
        const channel = '/event/Account_Event__e';

        subscribe(channel, -1, (event) => {
            console.log('🚀 Platform Event Received:', JSON.stringify(event, null, 2));

            // Use refreshApex instead of manually calling the method
            refreshApex(this.wiredAccountsResult);
        }).then(response => {
            this.subscription = response;
            console.log('✅ Successfully subscribed to:', response.channel);
        });

        // Handle errors
        /*
        onError(error => {
            console.error('⚠️ Platform Event Subscription Error:', JSON.stringify(error, null, 2));
        });
        */
    }

    unsubscribeFromAccountPlatformEvent() {
        if (this.subscription) {
            unsubscribe(this.subscription, response => {
                console.log('🛑 Unsubscribed from Platform Event:', response);
            });
        }
    }
}
