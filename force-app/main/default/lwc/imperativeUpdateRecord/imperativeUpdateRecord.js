import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/ImperativeUpdataRecordController.getAccounts';
import { refreshApex } from '@salesforce/apex';

export default class ImperativeUpdateRecord extends LightningElement {
    @track selectedRecordId = null;
    @track accounts = [];

    wiredAccountsResult; // Store wired result for refreshApex

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Rating', fieldName: 'Rating' },
        { label: 'Industry', fieldName: 'Industry' },
        {
            label: 'Action',
            type: 'button',
            typeAttributes: { label: 'Edit', name: 'edit', variant: 'brand' }
        }
    ];

    // Fetch Accounts from Apex
    @wire(getAccounts)
    wiredAccounts(result) {
        this.wiredAccountsResult = result; // Store the wired result for refresh
        if (result.data) {
            this.accounts = result.data;
        } else if (result.error) {
            console.error('Error fetching accounts:', result.error);
        }
    }

    handleRowAction(event) {
        console.log('handleRowAction : ', event);
        console.log('handleRowAction : ', JSON.stringify(event.detail));

        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'edit') {
            this.selectedRecordId = row.Id;
        }
    }

    handleCancel() {
        this.selectedRecordId = null;
    }

    async handleSuccess() {
        this.selectedRecordId = null;

        // ✅ Refresh DataTable with latest data
        await refreshApex(this.wiredAccountsResult);
    }
}

