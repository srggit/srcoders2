import { LightningElement } from 'lwc';

export default class NotifyChildCompST extends LightningElement {
    showChildNotification = false;

    // Step 2: This method will set the varaible as true which will show the notification box in child component.
    childHandler(){
        this.showChildNotification = true;
    }

    // Step 1: This Method will fire first on button click.
    showNotiyParentHandler(){
        const selectEvent = new CustomEvent('show', 
            { bubbles : true}   // bubbles: true means the event will bubble up to the parent component. (bottom to top approach)
        );
        this.dispatchEvent(selectEvent);
    }
}