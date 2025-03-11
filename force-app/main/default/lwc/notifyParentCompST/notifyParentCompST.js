import { LightningElement } from 'lwc';

export default class NotifyParentCompST extends LightningElement {
    showNotification = false;

    showhandler(){
        this.showNotification = true;
    };
}