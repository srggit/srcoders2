import { LightningElement } from 'lwc';

export default class Spinner_with_message extends LightningElement {
    showSpinner1 = false;
    showSpinner2 = false;
    showSpinner3 = false;

    spinnerBtnHandler(event) {

        // this[event.target.name] = true is a valid and more concise way to achieve the same functionality. This approach uses bracket notation to dynamically update the property on the this object based on the value of event.target.name
        //  this[event.target.name] = true

        // This approach is concise and commonly used for objects when you want to extract multiple properties (e.g., const { name, value } = event.target;).
        const { name } = event.target;
        this[name] = true;


        let timer = window.setTimeout(() => {
            this[name] = false;
            window.clearTimeout(timer);
        }, 4000);
        /*
        const spinnerName = event.target.name;

        if (spinnerName === 'showSpinner1') {
            this.showSpinner1 = true;
        }
        else if (spinnerName === 'showSpinner2') {
            this.showSpinner2 = true;
        }
        else if (spinnerName === 'showSpinner3') {
            this.showSpinner3 = true;
        }
        */
    }
}