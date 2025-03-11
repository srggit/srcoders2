import { LightningElement, api } from 'lwc';

export default class ProgressBarChildComp extends LightningElement {
    @api percentage;

    get getStyle(){
        return `width: ${this.percentage}%;`;
    }
}