import { LightningElement } from 'lwc';
import LightningPrompt from 'lightning/prompt';
import LightningAlert from 'lightning/alert';

export default class LightningPromptST extends LightningElement {

    response;

    handlePrompt() {
        LightningPrompt.open({
            message: 'What is Your Age ?',
            label: 'Check Your Voting Eligibility',
            variant: 'header',
            theme: 'info'
        }).then(result => {
            console.log(result);

            if (result && Number(result) > 18) {
                this.response = 'You are Eligible for Voting !!'
                this.handlerAlert('You are Eligible for Voting !!', 'Success !!', 'success');
            }
            else if (result === null || result === '' || result === undefined) {
                this.response = 'Please, Enter Some Value..';
                this.handlerAlert('Please, Enter Some Value..', 'Warning !!', 'warning');
            } else {
                this.response = 'Sorry, You are Not Eligible for Voting !!';
                this.handlerAlert('Sorry, You are Not Eligible for Voting !!', 'Error !!', 'error');
            }
        })
    }

    // Shorthand method
    handlerAlert(message, label, theme) {
        LightningAlert.open({
            message,
            label,
            theme
        })
    }
}