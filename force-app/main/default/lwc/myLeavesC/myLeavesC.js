import { LightningElement, wire } from 'lwc';
import getMyLeaves from '@salesforce/apex/LeaveRequstController.getMyLeaves';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

import USER_ID from '@salesforce/user/Id';

const COLUMNS = [
    {
        label: 'Request Id', fieldName: 'Name',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'User', fieldName: 'userName',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'From Date', fieldName: 'From_Date__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'To Date', fieldName: 'To_Date__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'Reason', fieldName: 'Reason__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'Status', fieldName: 'Status__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'Manager Comment', fieldName: 'Manager_Comment__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        type: 'button', typeAttributes: {
            label: 'Edit',
            name: 'Edit',
            title: 'Edit',
            value: 'edit',
            disabled: { fieldName: 'isEditDisabled' }
        },
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    }
];

export default class MyLeavesC extends LightningElement {

    columns = COLUMNS;

    myLeavesWireResult;
    myLeaves = [];
    showModalPopup = false;
    recordId = '';
    objectApiName = 'LeaveRequest__c';
    currentLoggedInUserId = USER_ID;

    @wire(getMyLeaves)
    getLeaveRecords(result) {
        this.myLeavesWireResult = result;

        if (result.data) {
            this.myLeaves = result.data.map(leave => ({
                ...leave,
                userName: leave.User__r && leave.User__r.Name ? leave.User__r.Name : leave.User__r,
                cellClass: leave.Status__c == 'Approved' ? 'slds-theme_success' : leave.Status__c == 'Rejected' ? 'slds-theme_warning' : '',
                isEditDisabled: leave.Status__c != 'Pending' ? true : false
            }));
        }
        if (result.error) {
            console.log('Error While fetching data : ', result.error);
        }
    }

    // Getter to check if the myLeaves array is empty
    get noRecordsFound() {
        return this.myLeaves.length == 0;
        //return this.myLeaves.length == 0 ? true : false;
    }

    // Open Modal For New Request
    newRequestClickHandler(event) {
        console.log('Making New Request');
        this.showModalPopup = true;
        this.recordId = '';
    }

    // Close Modal
    popUpCloseHandler(event) {
        this.showModalPopup = false;
    }

    rowActionHandler(event) {
        console.log('rowActionHandler : ', event);
        this.showModalPopup = true;
        this.recordId = event.detail.row.Id;
        console.log('recordId : ', this.recordId);
    }

    submitHandler(event) {
        event.preventDefault();
        console.log('submitHandler : ', event);
        console.log(event.detail);
        const fields = { ...event.detail.fields };

        fields.Status__c = 'Pending';

        if (new Date(fields.From_Date__c) > new Date(fields.To_Date__c)) {
            this.showNotification('Error', 'From Date should not be greater than To Date', 'error');
        }
        else if (new Date() > new Date(fields.From_Date__c)) {
            this.showNotification('Error', 'From Date should not be less than Today', 'error');
        }
        else {
            this.refs.leaveRequestForm.submit(fields);
        }
    }

    // Toast Message Functionality
    successHandler(event) {
        console.log('Success Handler Called', event);
        this.showModalPopup = false;

        try {
            this.showNotification('Success !!', 'Record Created Successfully !!', 'success');
            console.log('Refreshing Apex Data...');
            refreshApex(this.myLeavesWireResult);
        } catch (error) {
            console.error('Error in refreshApex:', error);
        }

        // Step 1: Creating and Dispatching the Event..
        try {
            console.log('Dispatching Custom Event...');
            const refreshEvent = new CustomEvent('refreshleaverequests');
            this.dispatchEvent(refreshEvent);
        } catch (error) {
            console.error('Error dispatching event:', error);
        }

        console.log('Event Successfully Dispatched !!');
    }


    showNotification(titleText, messageText, variant) {
        const evt = new ShowToastEvent({
            title: titleText,
            message: messageText,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}