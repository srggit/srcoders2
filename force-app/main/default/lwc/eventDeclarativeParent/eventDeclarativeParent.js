import { LightningElement } from 'lwc';

export default class EventDeclarativeParent extends LightningElement {

    vol = 0;
    label = 'Initializing ..... ';

    callIncreaseVol(event){

        this.label = event.detail;   // Value passed while dispatching the event

        if(this.vol >= 0 && this.vol < 100){
            this.vol = this.vol + 1;
            console.log('Vol Increased');
        }
    }

    callDecreaseVol(event){
        
       this. label = event.detail;   // Value passed while dispatching the event

        if(this.vol > 0 && this.vol <= 100){
            this.vol = this.vol - 1;
            console.log('Vol Decreased');
        }
    }
}