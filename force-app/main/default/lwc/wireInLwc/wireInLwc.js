import { LightningElement, wire } from 'lwc';
import showAcc from '@salesforce/apex/GetAllAccountsLWC.showAcc';

const COLS = [
                  {label: "Account Name",     fieldName: "Name",     type: "text"},
                  {label: "Account Rating",   fieldName: "Rating",   type: "text"},
                  {label: "Account Industry", fieldName: "Industry", type: "text"},
                  {label: "Account Phone",    fieldName: "Phone",    type: "phone"}
             ];

export default class WireInLwc extends LightningElement {

   @wire(showAcc) accounts;     // wire a property

   columns = COLS;


   /*  wire a function
   accounts;    // To store the account data
   error;       // To store any errors

   @wire(showAcc)
   wiredAccounts({ error, data }) {
      if (data) {
            this.accounts = data;
            console.log('Accounts Data: ', JSON.stringify(this.accounts));  // Log accounts
      } else if (error) {
            this.error = error;
            console.error('Error fetching accounts: ', this.error);
      }
   }
   */
}