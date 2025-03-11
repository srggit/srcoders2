import { LightningElement } from 'lwc';

export default class Practice_lwc_parent extends LightningElement {

    name; rating; industry;

    getValue(event){
        field = event.target.field;
        this.name = event.target.value;

        console.log('field : ' + field);
        console.log('value : ' + this.name);
    }
}