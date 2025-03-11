import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class PubsubSubscriber extends LightningElement {

    message = 'No Message';

    connectedCallback(){
        //this.registerPubSub();
        pubsub.register('publisherNotification', this.handleEvent.bind(this));
    }

    /*
    registerPubSub(){
        pubsub.register('publisherNotification', this.handleEvent.bind(this));
    }
    */
   
    handleEvent(messageFromEvt){

        this.message = messageFromEvt ? JSON.stringify(messageFromEvt, null, '\t') : 'No message payload';
    }
}