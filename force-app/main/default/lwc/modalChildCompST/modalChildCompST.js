import { LightningElement, api } from 'lwc';

export default class ModalChildCompST extends LightningElement {

    @api headerText;

    @api bodyText;


    // Dispatching Event From Child..
    closeModal(){
        const custEvent = new CustomEvent('closemodal');
        this.dispatchEvent(custEvent);

        //this.dispatchEvent(new CustomEvent('closemodal'));
    }
}