import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/Interview.getAccounts';
import { refreshApex } from '@salesforce/apex';


const ACCOUNTS_COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue' },
    { label: 'Rating', fieldName: 'Rating' },
    { label: 'Industry', fieldName: 'Industry' },
];

export default class Interview extends LightningElement {

    accountsColumns = ACCOUNTS_COLUMNS;
    accountsToRefresh;
    accountsData = [];

    @wire(getAccounts)
    wiredAccounts(result) {
        this.accountsToRefresh = result;
        const { data, error } = result;

        if (data) {
            this.accountsData = data;
        }
        if (error) {
            console.log('error : ', error);
        }
    }

    handleRefreshAccounts(event) {
        console.log('handleRefreshAccounts triggered');

        return refreshApex(this.accountsToRefresh);
    }
}


/* 

const CONTACTS_COLUMNS = [
    { 'id': 1, 'firstName': 'Satish', 'salary': 23300, 'experience': 3, 'city': 'Hyderabad' },
    { 'id': 2, 'firstName': 'Prashant', 'salary': 53300, 'experience': 3, 'city': 'Delhi' },
    { 'id': 3, 'firstName': 'Sagar', 'salary': 43300, 'experience': 3, 'city': 'Delhi' },
    { 'id': 4, 'firstName': 'Sumit', 'salary': 43300, 'experience': 3, 'city': 'Haryana' },
];


contacts = CONTACTS_COLUMNS;

@track contacts = this.contacts.map((contact, index, arr) => ({
    ...contact,
    first: index === 0, // First item flag
    last: index === arr.length - 1, // Last item flag
    className: index === 0 ? 'first-item' : index === arr.length - 1 ? 'last-item' : ''
}));

 */