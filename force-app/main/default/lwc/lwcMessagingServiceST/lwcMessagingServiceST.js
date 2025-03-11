import { LightningElement } from 'lwc';

import { publish, subscribe, unsubscribe, createMessageContext, releaseMessageContext, APPLICATION_SCOPE } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleMessageChannel__c';

export default class LwcMessagingServiceST extends LightningElement {
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
                value: this.lwcMessage
            }
        };
        console.log('lmsData : ', JSON.stringify(message));
        publish(this.context, SAMPLEMC, message);
    }

    subscribeMessage() {
        console.log('subscribeMessage() LWC');
        console.log('this.subscriptionToMC : ', this.subscriptionToMC);
        if (this.subscriptionToMC) {
            return;
        }
        this.subscriptionToMC = subscribe(this.context, SAMPLEMC, (message) => this.messageHandler(message), { scope: APPLICATION_SCOPE });
    }

    messageHandler(message) {
        this.receivedMessage = message && message.lmsData ? message.lmsData.value : 'No Payload sent';
        console.log('this.receivedMessage : ', this.receivedMessage);
    }

    unsubscribeMessage() {
        unsubscribe(this.subscriptionToMC);
        this.subscriptionToMC = null;
    }

    disconnectedCallback() {
        releaseMessageContext(this.context);
    }
}