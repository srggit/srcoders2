import { LightningElement } from 'lwc';

import { publish, subscribe, unsubscribe, createMessageContext, releaseMessageContext, APPLICATION_SCOPE } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleMessageChannel__c';


export default class LMSLWCST2 extends LightningElement {
    lwcMessage = '';
    subscriptionToMC;
    receivedMessage;

    context = createMessageContext();

    inputHandler(event) {
        this.lwcMessage = event.target.value;
        console.log('this.lwcMessage : ', this.lwcMessage);
    }

    publishMessage() {
        console.log('publishMessage() LWC');

        const message = {
            lmsData: {
                value: lwcMessage
            }
        };

        publish(this.context, SAMPLEMC, message);
    }

    subscribeMessage() {
        console.log('subscribeMessage() LWC');
        if (this.subscriptionToMC) {
            return;
        }
        this.subscriptionToMC = subscribe(this.context, SAMPLEMC, messageHandler, { scope: APPLICATION_SCOPE });
    }

    messageHandler(message) {
        this.receivedMessage = message && message.lmsData ? message.lmsData.value : 'No Payload sent';
    }

    unsubscribeMessage() {
        unsubscribe(this.subscriptionToMC);
        this.subscriptionToMC = null;
    }

    disconnectedCallback() {
        releaseMessageContext(this.context);
    }
}