import { LightningElement } from 'lwc';
import LightningAlert from 'lightning/alert';

export default class Lightning_alert_example extends LightningElement {

    async handleErrorClick() {
        await LightningAlert.open({
            message: 'This is ERROR alert message',
            theme: 'error', // a red theme intended for error states
            label: 'Error!', // this is the header text
        });
        //Alert has been closed
    }

    async handleSuccessClick() {
        await LightningAlert.open({
            message: 'This is SUCCESS alert message',
            theme: 'success', // a red theme intended for error states
            label: 'Success!', // this is the header text
        });
        //Alert has been closed
    }

}