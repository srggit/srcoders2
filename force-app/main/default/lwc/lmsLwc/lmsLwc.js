import { LightningElement } from 'lwc';
import MC from '@salesforce/messageChannel/mediator__c';
import { publish, subscribe, unsubscribe, createMessageContext, releaseMessageContext } from 'lightning/messageService';

export default class LmsLwc extends LightningElement {
    
    receivedMessage = '';
    myMessage = '';
    subscription = null;
    context = createMessageContext();
    
    constructor(){
        super();    // super() is used to activate all the child/parent files/components before executing currecnt component.
                    // We have to activate/initialize MC as we are using in this component.
                    // Before touching 'this' activate all the required files.c/accConOppUsingImperation.
                    // Imperation doesen't require initialization.
    }

    handleMsg(event){
        this.myMessage = event.target.value;
    }

    publishMsgChannel(event){
        const message = {
                            // We have got this variables from mediator.xml file
                            messageToSend : this.myMessage,
                            sourceSystem : 'LWC', // From where the Message is Sent
                            PhoneNumber : '11111111111'
                        };

        publish(this.context, MC, message);     
    }

    /*
    subscribeMsgChannel(event){
        if(this.subscription){
            return;
        }   

        this.subscription = subscribe(this.context, MC, (message) => {  // nameless function
            this.displayMessage(message);
        });

    }
    */
    subscribeMsgChannel(event){
        if(! this.subscription){
            this.subscription = subscribe(this.context, MC, (message) => {  // nameless function
                this.displayMessage(message);
            });
        }   
    }

    displayMessage(message){
        this.receivedMessage = message ? JSON.stringify(message, null, '\t')  : 'no message payload';
    }

    unSubscribeMsgChannel(event){
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    disconnectedCallback(){
        releaseMessageContext(this.context);
    }
}