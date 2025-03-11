import { LightningElement } from 'lwc';

export default class StandardBaseCompDesign extends LightningElement {

    get options() {
        return [
            { label: 'Male', value: 'male' },
            { label: 'Female', value: 'female' }
        ];
    }
}