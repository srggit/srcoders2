import { LightningElement, wire } from 'lwc';
import { getRelatedListsInfo } from 'lightning/uiRelatedListApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class GetRelatedListsInfoApiST extends LightningElement {

    relatedListData = [];

    @wire(getRelatedListsInfo, {
        parentObjectApiName: ACCOUNT_OBJECT.objectApiName,
        //recordTypeId: '012000000000000AAA'// optional
    }) relatedListInfo({ data, error }) {
        if (data) {
            this.relatedListData = data.relatedLists;
        }
        if (error) {
            console.log('error ::: ', error);
        }
    }
}