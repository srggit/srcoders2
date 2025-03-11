import { LightningElement, wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';

export default class GetRelatedListRecordsST extends LightningElement {

    relatedContactRecords = [];
    modifiedContacts = [];

    @wire(getRelatedListRecords, {
        parentRecordId: '001NS00000YKFfPYAX', // AccountId
        relatedListId: 'Contacts',  // Api Name of the Related List Object
        fields: ['Contact.FirstName', 'Contact.Id'],
        sortBy: ['Contact.Name']
    }) contactsRecords({ data, error }) {
        if (data) {
            this.relatedContactRecords = data.records;
        }
        if (error) {
            console.log(error);
        }

        this.modifiedContacts = this.relatedContactRecords.map(contact => ({
            contactId: contact.fields.Id.value,
            contactName: contact.fields.FirstName.value,
        }));
    }
}