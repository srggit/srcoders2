import { LightningElement } from 'lwc';

export default class EventsDeclarativeChild extends LightningElement {

    increaseVol(event){
        // Step 1: Create Event (CustomEvent() is a Constructor)
        const incEvent = new CustomEvent('increase_vol_event', {detail : 'Volume'});   
        // increaseVolEvent : Name of the Event and Uppercase is not supported, only underscores
        // {detail : 'Volume'} : Used to pass the values in an event
    
        // Step 2: Dispatch Event (dispatchEvent is a Function)
        this.dispatchEvent(incEvent);
    }


    decraseVol(event){

        // Step 1 and 2 Combined
        this.dispatchEvent(new CustomEvent('decrease_vol_event', {detail : 'Volume'}));
    }
}