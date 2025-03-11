import { LightningElement, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

import getLeaveRequests from '@salesforce/apex/LeaveRequstController.getLeaveRequests';

const COLS = [
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

export default class LeaveRequestsC extends LightningElement {

    columns = COLS;

    leaveRequests = [];
    wiredLeaveRequests;
    showModalPopup = false;
    objectApiName = 'LeaveRequest__c';
    recordId = '';

    @wire(getLeaveRequests)
    getLeaveRequestRecords(result) {
        this.wiredLeaveRequests = result;

        if (result.data) {
            this.leaveRequests = result.data.map(leave => ({
                ...leave,
                userName: leave.User__r && leave.User__r.Name ? leave.User__r.Name : leave.User__r,
                cellClass: leave.Status__c == 'Approved' ? 'slds-theme_success' : leave.Status__c == 'Rejected' ? 'slds-theme_warning' : '',
                isEditDisabled: leave.Status__c != 'Pending' ? true : false
            }));
            console.log(this.leaveRequests);
        }

        if (result.error) {
            console.log('Error occured while fetching the records : ', result.error);
        }
    }

    // Getter to check if the leaveRequests array is empty
    get noRecordsFound() {
        return this.leaveRequests.length == 0;
        //return this.leaveRequests.length == 0 ? true : false;
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

    successHandler(event) {
        this.showModalPopup = false;
        this.showNotification('Success !!', 'Record Created Successfully !!', 'success');
        //refreshApex(this.wiredLeaveRequests);
        this.refreshGrid();
    }

    showNotification(titleText, messageText, variant) {
        const evt = new ShowToastEvent({
            title: titleText,
            message: messageText,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }

    // Step 3: Calling this method from Parent Component
    @api
    refreshGrid() {
        refreshApex(this.wiredLeaveRequests);
    }
}   