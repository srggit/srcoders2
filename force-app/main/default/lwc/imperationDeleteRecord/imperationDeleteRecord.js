import { LightningElement, api } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ImperationDeleteRecord extends LightningElement {
    @api recordId; // Public property to receive the record ID

    handleDelete() {
        // Check if recordId is provided
        if (!this.recordId) {
            this.showToast('Error', 'No record ID provided for deletion', 'error');
            return;
        }

        // Delete the record using the deleteRecord method
        deleteRecord(this.recordId)
            .then(() => {
                console.log('Record deleted successfully!');
                // Show success toast message
                this.showToast('Success', 'Record deleted successfully!', 'success');
            })
            .catch((error) => {
                console.error('Error while deleting record:', error);
                // Show error toast message
                this.showToast('Error', error.body ? error.body.message : 'Unknown error occurred', 'error');
            });
    }

    // Function to show toast message
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }
}