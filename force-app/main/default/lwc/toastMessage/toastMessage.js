import { LightningElement } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from 'lightning/navigation';

export default class ToastMessage extends NavigationMixin(LightningElement) {

    // Toast Message
    showMessage(event){
        const evt = new ShowToastEvent({
        title: 'Test',
        message: 'Toast Message is Working',
        variant: 'success',
        });
        this.dispatchEvent(evt);


        // Navigation
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'home',
            },
        });
    }
}