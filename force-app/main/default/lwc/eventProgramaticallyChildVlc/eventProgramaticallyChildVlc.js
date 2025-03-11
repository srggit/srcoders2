import { LightningElement } from 'lwc';

export default class EventProgramaticallyChildVlc extends LightningElement {

    increaseBrightness(event){
        // Create Event
        const bIncreaseEvt = new CustomEvent('brightness_inc_event', {  detail : 'Brightness Up', 
                                                                        bubbles : true,
                                                                        composed : true
                                                                     });

        // Dispatch Event + Data + Propogation
        this.dispatchEvent(bIncreaseEvt);

        console.log('Brightness Increased');

    }

    decreaseBrightness(event){

        // Create Event
        const bDecrease = new CustomEvent('brightness_dec_event', { detail: 'Brightness Down',
                                                                    bubbles : true,
                                                                    composed : true
                                                                  });

        // Dispatch + Data + Propogation
        this.dispatchEvent(bDecrease);
        
        console.log('Brightness Decreased');
    }
}