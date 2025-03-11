import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import createAccConOpp from '@salesforce/apex/Create_Acc_Con_Opp_Apex.createAccConOpp';

import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Lwc_navigation extends NavigationMixin(LightningElement) {

    account = {};
    contact = {};
    opportunity = {};
    
    handleAccFieldChange(event){
        console.log('---- handleAccFieldChange Triggered ----');

        const field = event.target.fieldName;
        const value = event.target.value;
        console.log( `Field: ${field}, Value: ${value}`);

        // Create A shallow copy :  which duplicates only the top-level properties of an object, rather than any nested objects or deeper properties within it.
        const acc = { ...this.account };     

        // Modify the values in shallow acc
        acc[field] = value;

        // Re-assign the values to real account
        this.account = acc;

        console.log('this.account : ' + this.account);
    }
    
    handleConFieldChange(event){
        console.log('---- handleConFieldChange Triggered ----');

        const field = event.target.fieldName;
        const value = event.target.value;

        const con = { ...this.contact };
        con[field] = value;

        this.contact = con;
    }

    handleOppFieldChange(event){
        console.log('---- handleOppFieldChange Triggered ----');

        const field = event.target.fieldName;
        const value = event.target.value;
        console.log(`Field : ${field}, Value : ${value}`);

        const opp = { ...this.opportunity };
        opp[field] = value;

        this.opportunity = opp;
    }

    handleSave(event){
        console.log('---- handleSave Triggered -----');

        const acc = { ...this.account };
        const con = { ...this.contact };
        const opp = { ...this.opportunity };

        if( !acc.Name ){
            this.handleAlertClick('Account Name is Mandatory', 'warning', 'Information');
            return;
        }

        if( !con.LastName ){
            this.handleAlertClick('Contact Last Name is Mandatory', 'warning', 'Information');
            return;
        }

        if( !opp.Name ){
            this.handleAlertClick('Opportunity Name is Mandatory', 'warning', 'Information');
            return;
        }

        if( !opp.StageName ){
            this.handleAlertClick('Opportunity Stage Name is Mandatory', 'warning', 'Information');
            return;
        }

        if( !opp.CloseDate ){
            this.handleAlertClick('Opportunity Close Date is Mandatory', 'warning', 'Information');
            return;
        }

        // Calling Apex Class
        createAccConOpp({
            accString : JSON.stringify(this.account),
            conString : JSON.stringify(this.contact),
            oppString : JSON.stringify(this.opportunity)
        })
        .then( response => {
            console.log(`response : ${response}`);
            this.showToast('Success', 'Account Contact Opportunity Created Successfully !!', 'success');
            this.navigateToObjectHome();
        })
        .catch( error => {
            console.log(`error : ${JSON.stringify(error)}`);

            /* Error Message Format
            error = {
                "status": 500,
                "body": {
                    "fieldErrors": {},
                    "pageErrors": [
                    {
                        "statusCode": "REQUIRED_FIELD_MISSING",
                        "message": "Required fields are missing: [Stage]"
                    }
                    ],
                    "index": null,
                    "duplicateResults": []
                },
                "headers": {},
                "ok": false,
                "statusText": "Server Error",
                "errorType": "fetchResponse"
            }
            */
            /*
            let errResponse = error.body && error.body.pageErrors;
            let statusCode = errResponse && errResponse[0] && errResponse[0].statusCode ? errResponse[0].statusCode : 'Unknown Error';
            let errMsg = errResponse && errResponse[0] && errResponse[0].message ? errResponse[0].message : 'Unknown Error';
            */
            let statusCode = error.body.pageErrors[0].statusCode;
            let errMsg = error.body.pageErrors[0].message;

            console.log(`statusCode : ${statusCode}`);
            console.log(`errMsg : ${errMsg}`);
        });

    }

    
    handleReset(event){
        console.log('---- handleReset Triggered -----');

        const allFields = this.template.querySelectorAll('lightning-input-field');
        /*
        if(allFields){
            for(let i=0; i<allFields.length; i++){
                allFields[i] = '';
            }
        }
        */
        if(allFields){
            allFields.forEach( element => {element.reset()});
        }
    }

    handleCancel(event){
        console.log('---- handleCancel Triggered -----');
        this.navigateToObjectHome();
        console.log('handleCancel Operation Done');
    }
   
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,  // Options: 'success', 'error', 'warning', 'info'
            mode: 'dismissable'  // Options: 'dismissable', 'pester', 'sticky'
        });
        this.dispatchEvent(event);
    }

    async handleAlertClick(message, theme, label) {
        await LightningAlert.open({
            message: message,
            theme: theme, 
            label: label, 
        });
        //Alert has been closed
    }

    navigateToObjectHome() {
        try {
            this[NavigationMixin.Navigate]({
                type: "standard__objectPage",
                attributes: {
                  objectApiName: "Account",
                  actionName: "list",
                },
                state: {
                  // 'filterName' is a property on the page 'state'
                  // and identifies the target list view.
                  // It may also be an 18 character list view id.
                  filterName: "__Recent", // or by 18 char '00BT0000002TONQMA4'
                },
            })
            .then(() => console.log('Navigation successful'))
            .catch(error => console.log('Navigation failed:', JSON.stringify(error)));
        } catch (error) {
            console.log('Error in navigation:', JSON.stringify(error));
        }
    }

}