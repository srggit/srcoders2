import { LightningElement, track } from 'lwc';

import getAllUsers from '@salesforce/apex/ChangeAccountOwner_Class.getAllUsers';
import changeOwner from '@salesforce/apex/ChangeAccountOwner_Class.changeOwner';

export default class Change_account_owner_lwc extends LightningElement {
    
    @track userOptions = [];
    selectedUserId;

    openOpportunityFlag = false;
    allOpportunityFlag  = false;
    allContactsFlag     = false;
    allAccountsFlag     = false;

    @track isToastVisible      = false;

    async connectedCallback(){

        // Calling the Apex Class to get all the Users
        getAllUsers()
        .then(response => {

            const usersList = JSON.parse(response); 

            // Using => ( {} ), let us return value directly
            this.userOptions = usersList.map(user => ({
                label: user.Name,
                value: user.Id  
            }));

            /* Here we are manually returning the values
            this.userOptions = usersList.map(user => {
                return { label: user.Name, value: user.Id };
            });
            */
            console.log('userOptions:', JSON.stringify(this.userOptions));  
        })
        .catch(error => {
            console.error('Error fetching users:', JSON.stringify(error));
        });

    }   

    handleChange(event){
        console.log('Get User Id : ' + event.target.value);
        this.selectedUserId = event.target.value; 

        /* To get the Label of the User which we selected
        // Get the selected user ID
        const selectedUserId = event.detail.value; // Get the value from the combobox

        // Find the corresponding user object from userOptions
        const selectedUser = this.userOptions.find(user => user.value === selectedUserId);

        if (selectedUser) {
            // Now you can access the label (user name) and value (user ID)
            console.log('Get User Name:', selectedUser.label); // User Name
            console.log('Get User Id:', selectedUser.value);   // User Id
        } else {
            console.log('No user found for the selected ID.');
        }
        */
    }

    handleCheck(event) {
        // Handle the change event
        console.log('Checkbox is checked:', event.target.checked);

        const inputName = event.target.name;

        if(inputName == 'openOpps'){
            this.openOpportunityFlag = ! this.openOpportunityFlag;      // set true, default value is false and vise versa
        }
        else if(inputName == 'allOpps'){
            this.allOpportunityFlag = ! this.allOpportunityFlag;
        }
        else if(inputName == 'allConts'){
            this.allContactsFlag = ! this.allContactsFlag;
        }
        else if(inputName == 'allAccs'){
            this.allAccountsFlag = ! this.allAccountsFlag;
        }
    }

    // Calling Apex to Transfer Opp / Acc / Con to Selected User.
    handleProceed(event){

        changeOwner({
            openOpps : this.openOpportunityFlag,
            allOpps  : this.allOpportunityFlag,
            allConts : this.allContactsFlag,
            allAccs  : this.allAccountsFlag,
            userId   : this.selectedUserId
        })
        .then(response => {
            console.log('response : ' + response);
            this.isToastVisible = true;

            setTimeout( () =>{
                history.back();
            }, 2000);

            console.log('After Timeout');
        })
        .catch(error => {
            console.log('Error : ' + error.body.message);
        });
    }

    

}