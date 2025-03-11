import { LightningElement, wire } from 'lwc';
import getRecords from '@salesforce/apex/ObjectPicklistController.getRecords';
import getRecords2 from '@salesforce/apex/ObjectPicklistController.getRecords2';
import getRecords3 from '@salesforce/apex/ObjectPicklistController.getRecords3';


export default class ObjectPicklist extends LightningElement {
    value = '';
    records = [];
    stringRecords = '';
    records2 = [];
    records3 = [];


    get options() {
        return [
            { label: 'Account', value: 'Id, Name, Rating, Industry' },
            { label: 'Contact', value: 'Id, FirstName, LastName' },
            { label: 'Opportunity', value: 'Id, StageName, CloseDate' }
        ];
    }

    handleChange(event) {
        console.log(event);
        console.log(event.target.value);

        this.value = event.target.value;
        const selectedValue = event.target.value;
        console.log('label : ', event.target.label);
        const selectedLabel = this.options.find(option => option.value === selectedValue).label;
        console.log(JSON.stringify(selectedLabel));

        getRecords()
            .then(result => {
                this.records = result;
                console.log('getRecords -- 1 : ', this.records);
            })
            .catch(error => {
                console.log('error : ' + error);
                console.log(JSON.stringify(error));
            });

        getRecords2()
            .then(result => {
                this.stringRecords = result;
                this.records2 = JSON.parse(this.stringRecords);
                console.log('getRecords -- 2 : ', this.records2);
            })
            .catch(error => {
                console.log('error : ' + error);
                console.log(JSON.stringify(error));
            });

        getRecords3()
            .then(result => {
                this.records3 = result;
                console.log('getRecords -- 3 : ', this.records3);
            })
            .catch(error => {
                console.log('error : ' + error);
                console.log(JSON.stringify(error));
            });
    }
}