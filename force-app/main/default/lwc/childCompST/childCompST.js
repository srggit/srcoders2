import { LightningElement, api } from 'lwc';

export default class ChildCompST extends LightningElement {
    @api message = 'Initial Val';
    @api className;

    @api userDetails;

    connectedCallback(){
        console.log('Message:' , this.message);
    }
    get alertClassName() {
        return this.className ? 'alert ' + this.className : 'alert';
    }
}