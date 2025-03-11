import { LightningElement, api } from 'lwc';

export default class ProgressBarParentComp extends LightningElement {
    @api percentage = 10;

    changeHandler(event){
        this.percentage = event.target.value < 100 ? event.target.value : 100;
    }
}