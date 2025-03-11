import { LightningElement, api} from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation'; // Import NavigationMixin



export default class Create_con_from_acc extends NavigationMixin(LightningElement) {

    @api recordId;
    contactId;

    fName; lName; phone; fax; email; title; department;

    getFirstName(event){
        this.fName = event.target.value;
    }

    getLastName(event){
        this.lName = event.target.value;
    }

    getPhone(event){
        this.phone = event.target.value;
    }

    getFax(event){
        this.fax = event.target.value;
    }

    getEmail(event){
        this.email = event.target.value;
    }

    getTitle(event){
        this.title = event.target.value;
    }

    getDepartment(event){
        this.department = event.target.value;
    }

    handleSave(event){
        console.log('handleSave Triggered');

        const fields = {
            'FirstName' : this.fName,
            'LastName' : this.lName,
            'Phone' : this.phone,
            'Fax' : this.fax,
            'Email' : this.email,
            'Title' : this.title,
            'Department' : this.department,
            'AccountId' : this.recordId
        };

        const recordData = { apiName : 'Contact', fields};

        createRecord(recordData)
        .then( response => {
            this.contactId = response.id;
            console.log('conId : ' + this.contactId);
            console.log('response : ' + JSON.stringify(response));
           
            this.showToast('Success', 'Contact Created Successfully !!', 'success');
            this.navigateToRecord();
        })
        .catch(error => {
            console.log('Error : ' + error);
            console.log(error.body.message);
            console.log(JSON.stringify(error));

            this.showToast('Error', 'Contact Creation Failed !!', 'error');
        });
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(toastEvent);
    }

    navigateToRecord() {
        // Use the NavigationMixin to navigate to the Account record
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.contactId,
                objectApiName: 'Contact', // API name of the object
                actionName: 'view' // Action name to view the record
            }
        });
    }
}