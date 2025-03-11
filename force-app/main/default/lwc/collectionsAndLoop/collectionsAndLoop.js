import { LightningElement } from 'lwc';

export default class CollectionsAndLoop extends LightningElement {

    // Collection and Loops 

    cities = ['Ngp', 'Mum', 'Hyd', 'Chen', 'Bang'];

    // JSON Data

    empData = {
        "Name" : "Suraj",
        "Salary" : 90000,
        "Age" : 30,
        "Post" : "Senior Developer",
        "City" : "Hyd"
    }; 

    // Radio Button Options

    get options(){
        return [                            
            {label: 'Even', value: 'even'},
            {label: 'Odd', value: 'odd'}
        ];
    }

    radioBtnValue = 'even'; // By default even is selected

    connectedCallback(){
        console.log('Initital Value : ', this.value);
    }


    handleChange(event){
        this.radioBtnValue = event.target.value;
        console.log('Updated Value : ', this.radioBtnValue);
    }

    range; result = 0;

    handleRangeChange(event){
        this.range = parseInt(event.target.value);
        console.log('range : ', this.range);
    }

    calculateRangeTotal(event){
        console.log('---calculateRangeTotal---');

        if(this.radioBtnValue == 'even'){
            for(let i=2; i<=this.range; i+=2){
                this.result = this.result + i;
                console.log('even : ' + this.result);
            }
            console.log('Even Total : ' + this.result);
        }
        

        if(this.radioBtnValue == 'odd'){
            for(let i=1; i<=this.range; i+=2){
                this.result = this.result + i;
                console.log('Odd Total : ' + this.result);
            }
        }

        this.result = 0;    
    }
}