import { LightningElement, wire } from 'lwc';
import searchContacts from '@salesforce/apex/searchContactsUsingKeyword.searchContacts';

const cols1 = [
    {label: "FirstName", fieldName: "FirstName", type: "text"},
    {label: "LastName", fieldName: "LastName", type: "text"},
    {label: "Phone", fieldName: "Phone", type: "phone"},
    {label: "Email", fieldName: "Email", type: "email"}
];

const cols2 = [
    {label: "FirstName", fieldName: "FirstName", type: "text"},
    {label: "LastName", fieldName: "LastName", type: "text"},
    {label: "Phone", fieldName: "Phone", type: "phone"},
    {label: "Email", fieldName: "Email", type: "email"},
    {label: "AccountName", fieldName: "AccountName", type: "text"}
];


export default class WireAPropertyFunction extends LightningElement {
    columns1 = cols1;
    columns2 = cols2;

    searchKeyword = '';   // Initialize with an empty string
    mappedContacts = [];  // Separate variable for transformed data

    getSearchText(event){
        console.log('Search text : ' + event.target.value);
        this.searchKeyword = event.target.value;
    }

    // Wire a Property
    @wire(searchContacts, {searchKey:'$searchKeyword'}) contacts; // contacts is a Property

    searchContacts(event){
        console.log('-----searchContacts() is Triggered.');
    }

    // Wire a Function
    @wire(searchContacts, { searchKey:'$searchKeyword' }) 
    lstContacts({ data, error }){   // lstContacts is a function    
        if(data){
            // Map the data to flatten Account Name into AccountName field
            this.mappedContacts = data.map(contact => ({
                ...contact,
                AccountName: contact.Account ? contact.Account.Name : ''
            }));
        }
        if(error){
            console.log(error);
        }
    }
}