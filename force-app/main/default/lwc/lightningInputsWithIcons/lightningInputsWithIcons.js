import { LightningElement } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import inputIconsStyles from '@salesforce/resourceUrl/inputIconsStyles';    // Name of the External Static Resource Css File

export default class LightningInputsWithIcons extends LightningElement {

    showPassword = false;
    changeParaColor = 'para-red'
    isParaColorRed = true;

    get passwordIcon() {
        return this.showPassword ? 'utility:hide' : 'utility:preview';
    }

    get passwordType() {
        return this.showPassword ? 'text' : 'password'
    }

    togglePasswordVisibility() {
        this.showPassword = !this.showPassword;
    }

    connectedCallback() {
        loadStyle(this, inputIconsStyles)
            .then(() => {
                console.log('Styles Loaded Successfully !!')
            })
            .catch(error => {
                console.log('Error Loading Styles !!')
            });
    }

    changeColor() {
        // this.changeParaColor = 'para-green';

        this.changeParaColor === 'para-red' ? this.changeParaColor = 'para-green' : this.changeParaColor = 'para-red';
    }

    toggleParaColor() {
        this.isParaColorRed = !this.isParaColorRed;
    }

    get getParaColor() {
        return this.isParaColorRed ? 'para-red' : 'para-green';
    }
}