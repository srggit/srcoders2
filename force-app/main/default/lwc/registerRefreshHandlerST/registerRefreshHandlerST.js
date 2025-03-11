import { LightningElement, api } from 'lwc';

export default class RegisterRefreshHandlerST extends LightningElement {
    @api recordId;
    ratingValue;

    connectedCallback() {
        console.log('record id : ', this.recordId);
        // this.fetchAccount();
    }
}