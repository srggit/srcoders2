import { LightningElement } from 'lwc';
import LightningAlert from 'lightning/alert';

export default class LightningAlertST extends LightningElement {

    async handleAlert(event) {
        // window.alert() // Earlier we were using this.

        const name = event.target.name;
        //const {name} = event.target;

        const result = await LightningAlert.open({
            message: `${name.toUpperCase()} Alert`,
            theme: name,
            label: name.toUpperCase()
        });
        console.log('Alert result : ', result);
    }
}