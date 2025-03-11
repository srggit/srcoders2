import { LightningElement } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';

import applyCustomCss from '@salesforce/resourceUrl/applyCustomCss';

export default class CustomBaseCompDesign extends LightningElement {

    get options() {
        return [
            { label: 'Male', value: 'male' },
            { label: "Female", value: 'female' }
        ];
    }

    connectedCallback() {
        loadStyle(this, applyCustomCss);
    }
    /*
    // Including CSS Styles inside JS: Not Recommended
    renderedCallback() {
        const style = document.createElement('style');

        style.innerText = `.custom-button-color .slds-input, custom-button-color .slds-button {
            border-radius: 25px;
        }
        
        .custom-button-color lightning-radio-group .slds-form-element__control{
            display: flex;
        }
        `;

        this.template.querySelector('.custom-button-color')?.appendChild(style);
    }
    */

}