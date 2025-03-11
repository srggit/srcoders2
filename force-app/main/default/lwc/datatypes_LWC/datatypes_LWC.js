import { LightningElement } from 'lwc';

export default class Datatypes_LWC extends LightningElement {
    name = 'Saurabh';
    salary = 899999;
    empId = 11002;

    aVal; bVal; cVal;

    
    firstNum(event){
        this.aVal = parseInt(event.target.value);
    }

    secondNum(event){
        this.bVal = parseInt(event.target.value);
    }

    thirdNum(event){
        this.cVal = parseInt(event.target.value);
    }


    calculateGreater(event){
        if(this.aVal > this.bVal && this.aVal > this.cVal){
            alert('The Greater Number is ' + this.aVal);
        }
        else if(this.bVal > this.aVal && this.bVal > this.cVal){
            alert('The Greater Number is : ' + this.bVal);
        }
        else if(this.cVal > this.aVal && this.cVal > this.bVal){
            alert('The Greater Number is : ' + this.cVal);
        }
        else{
            alert('All Numbers are Same !!');
        }
    }
    
}