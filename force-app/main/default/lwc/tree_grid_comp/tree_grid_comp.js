import { LightningElement, wire } from 'lwc';
import getAccountsAndContacts from '@salesforce/apex/AccountContactForTreeGrid.getAccountsAndContacts';

export default class Tree_grid_comp extends LightningElement {

    accountsAndContacts;
    wiredResult;
    gridData;

    // Imperative Call
    /*
    async connectedCallback() {
        this.accountsAndContacts = await getAccountsAndContacts();
        console.log(this.accounts); 
    }
    */

    /*    
    @wire(getAccountsAndContacts)
    wiredAccounts({ data, error }) {
        if (data) {
            this.accountsAndContacts = data;
            console.log(this.accountsAndContacts);
        }
        if (error) {
            console.log('Error : ' + error);
        }
    }
    */


    // Best way to use @wire if we need to use refreshApex()
    @wire(getAccountsAndContacts)
    accountsAndContacts(result) {

        this.wiredResult = result;  // Store the result for refreshApex()

        if (result.data) {
            this.accountsAndContacts = result.data;
            this.formatGridData(this.accountsAndContacts);    // Calling a function to format the data as Account and its related Contacts
            console.log(this.accountsAndContacts);
        }
        if (result.error) {
            console.log('Error : ' + result.error);
        }
    };

    // Columns //
    gridColumns = [
        {
            label: 'Acc Name',
            fieldName: 'Name',
            type: 'text',
        },
        {
            label: 'Rating',
            fieldName: 'Rating',
            type: 'text'
        },
        {
            label: 'Industry',
            fieldName: 'Industry',
            type: 'text'
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'phone'
        },
        {
            label: 'Website',
            fieldName: 'Website',
            type: 'url',
            typeAttribute: {
                target: '_blank'
            }
        }
    ];

    // Here we are making a Child of Contacts for Learning
    dummyData = [
        {
            Name: 'Salesforce Dummy Data 1',
            Email: 'salesforcedummy1@gmail.com',
            Website: 'salesforce.com',
            Phone: '34780-99999'
        },
        {
            Name: 'Salesforce Dummy Data 2',
            Email: 'salesforcedummy2@gmail.com',
            Website: 'salesforce.com',
            Phone: '34780-99090'

        }
    ];

    /* My Method 1:
    formatGridData(result) {
        let contChild;
        this.gridData = [];

        result.map(item => {
            contChild = item.Contacts != undefined || item.Contacts != null ? item.Contacts.map(contact => ({
                ...contact,
                _children: this.dummyData
            })) : []; // Default to an empty array if Contacts is undefined // // Contacts is the name in List which is returned from Apex

            this.gridData.push({
                ...item,
                _children: contChild
            });
        });
    }
    */
    /* My Method 2:
    formatGridData(result) {
        this.gridData = result.map(item => ({
            ...item,
            _children: item.Contacts != undefined ? item.Contacts.map(cont => ({
                ...cont,
                _children: this.dummyData
            })) : [] // Default to an empty array if Contacts is undefined // // Contacts is the name in List which is returned from Apex         
        }));
        console.log('this.gridData : ' + JSON.stringify(this.gridData));
    }
    */

    // Salesforce Troop Method
    formatGridData(result) {
        this.gridData = result.map(item => {
            const { Contacts, ...accounts } = item; // Contacts is the name in List which is returned from Apex
            const contChild = Contacts != undefined ? Contacts.map(contact => {
                return {
                    ...contact,
                    _children: this.dummyData
                }
            }) : [];

            return { ...accounts, _children: contChild };
        });

        console.log('this.gridData : ' + JSON.stringify(this.gridData));
    }

}