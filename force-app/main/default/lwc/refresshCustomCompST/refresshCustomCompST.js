import { LightningElement, api } from 'lwc';
import { registerRefreshHandler, unregisterRefreshHandler } from 'lightning/refresh';
import getCurrentAccount from '@salesforce/apex/GetCurrentAccST.getCurrentAccount';

export default class RefresshCustomCompST extends LightningElement {
    @api recordId;
    ratingValue;
    refreshHandlerId;

    connectedCallback() {
        console.log('ConnectedCallback invoked, registering refresh handler.');
        this.refreshHandlerId = registerRefreshHandler(this, this.refreshHandler);
        this.fetchAccount();
    }

    disconnectedCallback() {
        if (this.refreshHandlerId) {
            unregisterRefreshHandler(this.refreshHandlerId);
            console.log('Refresh handler unregistered.');
        }
    }

    refreshHandler() {
        console.log('Something has Changed !!');
        return new Promise(resolve => {
            this.fetchAccount();
            resolve(true)
        })
    }
    /*
    refreshHandler() {
        console.log('Something has changed !!');
        return new Promise((resolve, reject) => {
            this.fetchAccount()
                .then(() => resolve(true))
                .catch(error => {
                    console.error('Error in refreshHandler:', error);
                    reject(error);
                });
        });
    }
    */

    fetchAccount() {
        if (!this.recordId) {
            console.warn('Record ID is undefined. Cannot fetch account.');
            return Promise.resolve(); // Graceful exit
        }
        return getCurrentAccount({ accId: this.recordId })
            .then(data => {
                console.log('fetchAccount data:', data);
                this.ratingValue = data.Rating; // Ensure case sensitivity matches Apex
            })
            .catch(error => {
                console.error('fetchAccount error:', JSON.stringify(error));
            });
    }
}