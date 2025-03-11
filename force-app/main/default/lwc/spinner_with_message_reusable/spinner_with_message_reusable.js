import { LightningElement, api } from 'lwc';

export default class Spinner_with_message_reusable extends LightningElement {

    @api spinnerText = '';
    @api spinnerSize = 'medium'; // small, medium, large
    @api variant = 'base'; // base, brand, inverse
    @api alternativeText = '';

    get helpText() {
        return this.spinnerText ? this.spinnerText : 'Loading';
    }

    get dynamicClass() {
        // return `loader ${this.variant === 'inverse' ? 'inverse' : ''}`;
        return 'loader' + (this.variant === 'inverse' ? ' inverse' : '');

    }
}