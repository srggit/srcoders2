import { LightningElement } from 'lwc';

export default class GetSet_Lwc extends LightningElement {

    get name(){
        return 'Rupom';
    }

    get courseDetails(){
        return 'LWC & Aura';
    }
}