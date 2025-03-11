import { LightningElement } from 'lwc';

const BASE_IMAGE_URL = 'https://sfdc-demo.s3-us-west-1.amazonaws.com/ecars';
const COLORS = ['red', 'green', 'black', 'blue', 'white'];

export default class CarColorPickerST extends LightningElement {
    colors = COLORS;
    selectedColor = this.colors[0];   // set default color as red

    get getSelectedCarImage() {
        console.log(this.selectedColor);
        return `${BASE_IMAGE_URL}/car_${this.selectedColor}.jpg`;
        //https://sfdc-demo.s3-us-west-1.amazonaws.com/ecars/car_red.jpg
    }

    handleCarChange(event) {
        this.selectedColor = event.target.dataset.color;
    }
}