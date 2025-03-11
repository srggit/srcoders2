import { LightningElement } from 'lwc';

import signInTemplate from './signInTemplate.html';
import signUpTemplate from './signUpTemplate.html';
import defaultTemplate from './renderMultipleTemplateDemo.html';

export default class RenderMultipleTemplateDemo extends LightningElement {

    selected = null;

    render() {
        return this.selected === 'Sign Up' ? signUpTemplate :
            this.selected === 'Sign In' ? signInTemplate :
                defaultTemplate;
    }

    signInUpHandler(event) {
        this.selected = event.target.label;
    }

    submitHandler(event) {
        if (event.target.label === 'Sign In') {
            console.log('Sign In Button Clicked !!');
        }
        else if (event.target.label === 'Sign Up') {
            console.log('Sign Up Button Clicked !!');
        }
        else {
            console.log('Go Back Button Clicked !!');

            this.selected =  'Go Back';
        }
    }

}