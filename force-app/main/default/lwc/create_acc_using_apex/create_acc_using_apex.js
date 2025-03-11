import { LightningElement } from 'lwc';
import createAccount from '@salesforce/apex/Create_Acc_Using_LWC.createAccount';

import { NavigationMixin } from 'lightning/navigation';
import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class Create_acc_using_apex extends NavigationMixin(LightningElement) {
    account = {};

    handleAccFieldChange(event){
        
        const field = event.target.name;
        const value = event.target.value;

        console.log('field : ' + field);
        console.log('value : ' + value);

        const acc = { ...this.account } // Create A shallow copy :  which duplicates only the top-level properties of an object, rather than any nested objects or deeper properties within it.
   
        acc[field] = value;     // Modity the values in shallow acc

        this.account = acc;     // Assign the changes in real account

        console.log('this.account : ' + this.account)
        console.log('this.account string : ' + JSON.stringify(this.account));
    }

    handleSave(event){
        console.log('---- handleSave triggered ----');

        createAccount({
            accString : JSON.stringify(this.account)
        })
        .then( response => {
            console.log('response :  ' + response);

            // After the 2-second delay, history.back() navigates the user to the previous page in their browser’s history, similar to pressing the back button.
            setTimeout(() => {
                history.back();
            }, 2000);
 
            this.showToast('Success', 'Account Created Successfully !!', 'success');

            //this.handleAlertClick('Account Created Successfully !!', 'success', 'Success');

            this.handleReset();
        })
        .catch( error => {
            console.log('error :  ' + JSON.stringify(error));

            /* Error Sample
            const errorResponse = {
                "status": 500,
                "body": {
                    "fieldErrors": {},
                    "pageErrors": [
                        {
                            "statusCode": "REQUIRED_FIELD_MISSING",
                            "message": "Required fields are missing: [Account Name]"
                        }
                    ],
                    "index": null,
                    "duplicateResults": []
                },
                "headers": {},
                "ok": false,
                "statusText": "Server Error",
                "errorType": "fetchResponse"
            };
            */
            const errorResponse = error.body  && error.body.pageErrors;
            const statusCode = errorResponse && errorResponse[0] && errorResponse[0].statusCode ? errorResponse[0].statusCode : 'Unknown Error';
            const errMsg = errorResponse && errorResponse[0] && errorResponse[0].message ? errorResponse[0].message : 'Unknown Error';
            console.log('statusCode : ' + statusCode);
            console.log('errMsg : ' + errMsg);
            
            if(statusCode != 'Unknown Error' && errMsg != 'Unknown Error'){         // If statusCode and errMsg contains Error Msg String
                this.handleAlertClick('Account Creation Failed !! ' + statusCode + ' - ' + errMsg, 'error', 'Error');
            }
            else if(statusCode != 'Unknown Error' &&  errMsg == 'Unknown Error'){   // If statusCode contains Error Msg String and errMsg is Unknown Error
                this.handleAlertClick('Account Creation Failed !! ' + statusCode, 'error', 'Error');
            }
            else if(statusCode == 'Unknown Error' && errMsg != 'Unknown Error'){    // If statusCode does not contain Error Msg String and errMsg contins Error String
                this.handleAlertClick('Account Creation Failed !! ' + errMsg, 'error', 'Error');
            }
            else if(statusCode == 'Unknown Error' ** errMsg == 'Unknown Error'){    // If statusCode and errMsg both doesen't contain Error Message String
                this.handleAlertClick('Account Creation Failed !! ', 'error', 'Error');
            }
            
        });
    }

    handleReset(event){
        console.log('---- resetButton Triggered ----');

        /*
        let inputFields = this.template.querySelectorAll('lightning-input-field');
        inputFields.forEach( element => { element.reset() });
        */

        let inputFields = this.template.querySelectorAll('lightning-input-field');
        if(inputFields){
            for(let i=0; i<inputFields.length; i++){
                inputFields[i].value = ''; 
            }
        }
    }

    handleCancel(event){
        this.navigateToListView();
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

    navigateToListView() {
        // Navigate to the Contact object's Recent list view.
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
        });
      }
}