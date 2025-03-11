import { LightningElement } from 'lwc';

export default class ModalParentCompST extends LightningElement {
    showModal = false;

    showHandler(){
        this.showModal = true;
    }

    handleModalCloseEvent(){
        this.showModal = false;
    }
}