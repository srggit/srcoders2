import { LightningElement } from 'lwc';
import LightningConfirm from 'lightning/confirm';

export default class LightningConfirmST extends LightningElement {

    async confirmHandler() {
        const result = await LightningConfirm.open({
            label: 'Confirm Reload ?',
            message: 'Are you sure you want to refresh the page ?',
            theme: 'warning'
        });
        console.log('result : ', result);

        if (result) {    // If OK is clicked, it return true
            location.reload();  // It reloads the current webpage
        }
    }
}