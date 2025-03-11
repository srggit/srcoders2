import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class Imperations extends LightningElement {

    aName; aRating; aIndustry; aPhone; aRevenue; // Class properties
    titleText; messageText; variant;   // Class properties for notification

    accName(event) {
        this.aName = event.target.value;
    }

    accRating(event) {
        this.aRating = event.target.value;
    }

    accIndustry(event) {
        this.aIndustry = event.target.value;
    }       

    accPhone(event) {
        this.aPhone = event.target.value;
    }

    accRevenue(event){
        this.aRevenue = event.target.value;
    }

    saveRecord(event) {

        // Step 1: Create the Field List, JS Object, Name, Rating, Industry are not valid identifiers that's why enclosed in single quotes
        const fields = {
            'Name': this.aName,
            'Rating': this.aRating,
            'Industry': this.aIndustry,
            'Phone': this.aPhone,
            'AnnualRevenue': this.aRevenue
        };

        // Step 2: Create API Object + fields
        const recordData = { apiName: 'Account', fields };

        // Step 3: Create Imperation and use the Variables
        createRecord(recordData)
            .then(result => {
                const accId = result.id;
                console.log('accId : ' + accId);
                
                console.log('Log 3');
                this.titleText = "Success";
                this.messageText = "Account Record Created Successfully, ID: " + result.id;
                this.variant = "success";

                this.showNotification();
            })
            .catch(error => {
                console.error('Error during account creation:', error);
                this.titleText = "Error";
                this.messageText = "Account creation failed: " + error.body.message;
                this.variant = "error";
                this.showNotification();
            });
    }

    // Method to show notification
    showNotification() {
        try {
            const evt = new ShowToastEvent({
                title: this.titleText,
                message: this.messageText,
                variant: this.variant
            });
            this.dispatchEvent(evt);
        } catch (error) {
            console.error('Error dispatching toast event:', error);
        }
    }
}