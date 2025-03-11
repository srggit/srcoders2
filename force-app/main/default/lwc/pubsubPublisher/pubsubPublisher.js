import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class PubsubPublisher extends LightningElement {

    name; age; msg;

    getName(event){
        this.name = event.target.value;
    }

    getAge(event){
        this.age = event.target.value;
    }

    getMessage(event){
        this.msg = event.target.value;
    }

    handleSubmit(event){
        // let will maintain the pretty format, where as var will not
        let message = {
                        'Sender\'s Name'    : this.name,
                        'Sender\'s Age'     : this.age,
                        'Sender\'s Message' : this.msg
                      };
        
        console.log('Publisher message : ' + JSON.stringify(message, null, '\t'));

        // Fire pubsub
        pubsub.fire('publisherNotification', message);
    }
}