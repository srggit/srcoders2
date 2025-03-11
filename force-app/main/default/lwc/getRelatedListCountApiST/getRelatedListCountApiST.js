import { LightningElement, wire } from 'lwc';
import { getRelatedListCount } from 'lightning/uiRelatedListApi';

export default class GetRelatedListCountApiST extends LightningElement {

    relatedContactsCount;

    @wire(getRelatedListCount, {
        parentRecordId: '001NS00000YKFfPYAX',       // AccountId
        relatedListId: 'Contacts'                   // Api Name of the Related List Object
    }) relatedContactsCount({ data, error }) {
        if (data) {
            console.log(data);
            this.relatedContactsCount = data.count > 0 ? data.count : '0';
        }
        if (error) {
            console.log(error);
        }
    }
}