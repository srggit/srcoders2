import { LightningElement } from 'lwc';

export default class BarParentCompST extends LightningElement {

    // Calling child method from parent
    changeColor(){
        this.template.querySelector('c-bar-child-comp-s-t').changeBarColor();
    }
}