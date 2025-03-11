import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {

    // One Way Data Binding
    firstName = 'John';     // Class Variable

    profession = 'Developer';

    getProfession(event) {
        this.profession = event.target.value;
    }

    // Note: 
    // @track operator is no longer required for 2 - way data binding.
    // As it renderes the whole component, whenever something is changed on the component. 
}