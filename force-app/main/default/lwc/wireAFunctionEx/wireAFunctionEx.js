import { LightningElement, wire } from 'lwc';
import fetchAllCases from '@salesforce/apex/GetAllcases.fetchAllCases';

const cols = [
    {label:'Case Number', fieldName:'CaseNumber', type:'text'},
    {label:'Priority', fieldName:'Priority', type:'text'},
    {label:'Type', fieldName:'Type', type:'text'},
    {label:'Reason', fieldName:'Reason', type:'text'}
];

export default class WireAFunctionEx extends LightningElement {
    columns = cols;
    allCases = [];
    highPCases = [];
    mediumPCases = [];
    lowPCases = [];
    error;

    
    @wire(fetchAllCases) 
    getAllCases({data, error}){
        if(data){

            this.highPCases = []; // Ensure it's cleared before pushing new data
            this.mediumPCases = []; 
            this.lowPCases = []; 

            this.allCases = data;
            console.log('length : ' + this.allCases.length);

            for(let i=0; i<this.allCases.length; i++){
                let caseRecord = this.allCases[i];

                if(caseRecord.Priority === 'High'){
                    this.highPCases.push(caseRecord);
                }
                else if(caseRecord.Priority === 'Medium'){
                    this.mediumPCases.push(caseRecord);
                }
                else if(caseRecord.Priority === 'Low'){
                    this.lowPCases.push(caseRecord);
                }
            }
            console.log('HPC :' + this.highPCases.length);
            console.log('MPC :' + this.mediumPCases.length);
            console.log('LPC :' + this.lowPCases.length);
        }
        if(error){
            this.error = error;
        }
    }
}