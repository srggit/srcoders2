import { LightningElement, wire } from 'lwc';

import { getListUi } from 'lightning/uiListApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class GetListViewUiDemoST extends LightningElement {

    accResult;

    @wire(getListUi, {
        objectApiName : ACCOUNT_OBJECT,
        listViewApiName : 'Few_Accounts'
        //listViewApiName : 'AllAccounts'
         // For Custom List View, Get List view name from Url
        //listViewId: '00B5g0000090tWPEAY' // Replace with your List View ID

    }) wiredListView({data, error}){
        if(data){
            console.log('data : ', data);
            this.accResult = data.records.records;
        }
    };
}