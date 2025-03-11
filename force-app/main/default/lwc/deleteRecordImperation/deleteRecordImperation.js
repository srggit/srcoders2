import { LightningElement,api } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class DeleteRecordImperation extends NavigationMixin(LightningElement) {
    
    @api recordId;      // @api : declares the variable as Public..
    title = 'Record Deleted';
    message = 'Sample Message Successfully';
    variant = 'success'

    handleDelete(event){
        console.log('Check 1 : ' + this.recordId);
        deleteRecord(this.recordId).then(response=>{
            //alert('Record Deleted Successfully &&&&');
            console.log('Check 2');
            console.log('Check 3');  

            const evt = new ShowToastEvent({
            title: 'Test',
            message: 'Toast Message is Working',
            variant: 'success',
            });
            this.dispatchEvent(evt);
            
        }).catch(error=>{
            alert('Record Deletion Failed : ' + error.body.message)
            console.log(JSON.stringify(error));
        });
    }
}