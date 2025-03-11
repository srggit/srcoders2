import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Opportunity.Name',
    'Opportunity.StageName',
    'Opportunity.Amount'
];

// JS Object, label, fieldName and type are valid identifiers in JS, that's not enclosed in Quotes
const COLS = [
    { label: 'Name', fieldName: 'name', type: 'text' },
    { label: 'Stage', fieldName: 'stageName', type: 'text' },
    { label: 'Amount', fieldName: 'amount', type: 'currency' }
];

export default class GetRecordImperation extends LightningElement {
    recordId = '006NS00000Mff2uYAB'; // Hardcoded record ID for testing
    oppRecord = []; // Initialize as an array for datatable
    columns = COLS;
    error;
    name;

    // Wire service to get the Opportunity data
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    opportunityRecord({ data, error }) {
        if (data) {
            // Format data for the datatable
            this.oppRecord = [{
                name: data.fields.Name.value,
                stageName: data.fields.StageName.value,
                amount: data.fields.Amount.value
            }];
            console.log('Formatted Data:', JSON.stringify(this.oppRecord, null, 2)); // Log formatted data
            this.error = undefined; // Reset error

            console.log('Data : ' + data);
            console.log('Data Fields : ' + data.fields);
            console.log('OppRecord : ' + this.oppRecord);
            
            this.name = data.fields.Name.value;
            this.stageName = data.fields.StageName.value;
            this.amount = data.fields.Amount.value;
        } 
        else if (error) {
            console.error('Error retrieving opportunity record:', error);
            this.error = error; // Store error for use in the template
            this.oppRecord = []; // Clear oppRecord on error
        }
    }
}