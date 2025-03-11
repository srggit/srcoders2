({
    inputHandler: function (component, event, helper) {
        component.set('v.messageValue', event.target.value);
        console.log('messageValue', component.get('v.messageValue'));
    },

    publishMessage: function (component, event, helper) {

        let msg = component.get('v.messageValue');
        let message = {
            lmsData: {
                value: msg
            }
        };
        // SampleMessageChannel is the aura:id and we are publishing our message using pulblish()
        component.find('SampleMessageChannel').publish(message);
    },

    // Here we will receive message
    handleMessage: function (component, message, helper) {

        console.log('message : ', message);
        console.log('message val 1: ', message.getParam('lmsData'));
        console.log('message val 2: ', message.getParam('lmsData').value);

        if (message != null && message.getParam('lmsData') != null) {
            component.set('v.messageReceived', message.getParam('lmsData').value);
        }
    }

})