import { LightningElement } from 'lwc';

export default class EventProgramaticallyParentVlc extends LightningElement {

    label = 'Initializing ... ';
    bLevel = 0;
    
    constructor(){
        super();  // mandatory
        console.log('Parent Constructor');
        // Listen to the event
        this.template.addEventListener('brightness_inc_event', this.handleBrightnessIncrement.bind(this));
        this.template.addEventListener('brightness_dec_event', this.handleBrightnessDecrement.bind(this));
        
        console.log('Events are Listened');
    }

    handleBrightnessIncrement(event){
        console.log('P Brightness Increased');

        this.label = event.detail;

        if(this.bLevel >= 0 && this.bLevel < 100){
            this.bLevel = this.bLevel + 1;
        }
    }

    handleBrightnessDecrement(event){
        console.log('P Brightness Decreased');
        
        this.label = event.detail;

        if(this.bLevel > 0 && this.bLevel <= 100){
            this.bLevel = this.bLevel - 1;
        }
    }
}