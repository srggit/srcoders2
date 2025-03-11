import { LightningElement, api } from 'lwc';

export default class PublicVariablesLwc extends LightningElement {
    privateVar = 'Rupom';

    @api publicVar = 'p';

}