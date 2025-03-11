import { LightningElement, track } from 'lwc';

export default class IfTrueIfFalseTemplate extends LightningElement {

    showText = false;
    hideText = false;
    objectText = {
        result: false
    };
    heading = 'This is the Power of Getter!!';
    switch = 'OFF';
    password = null;

    handleClick() {
        this.showText = !this.showText;
    }

    handleHide() {
        this.hideText = true;
    }

    handleObject() {
        // this.objectText.result = true;   // Use of @track is needed to make the object changeable
        this.objectText = { ...this.objectText, result: true };
    }

    get title() {
        return this.heading.toUpperCase();
    }

    handleSwitch(event) {
        console.log(this.switch);
        this.switch = event.target.label;
    }

    get boxStatus() {
        //return this.switch == 'ON' ? 'box green' : 'box red';
        return `box ${this.switch === 'ON' ? 'green' : 'red'}`;
    }

    passwordHandler(event) {
        this.password = event.target.value;
    }

    get checkPassword() {
        return this.password === 'Password@12345';
    }
}