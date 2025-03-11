import { LightningElement, api } from 'lwc';

export default class BarChildCompST extends LightningElement {
    
    className = 'greenBar';

    @api changeBarColor(){
        this.className = this.className === 'greenBar' ? 'redBar' : 'greenBar';
    }
}