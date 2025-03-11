import { LightningElement, api } from 'lwc';

import ACC_Name from '@salesforce/schema/Account.Name';

export default class Create_account_from_contact extends LightningElement {


    //@api recordId;

    fields =  [ACC_Name];
}