import { LightningElement } from 'lwc';

export default class EventEmpDataParent extends LightningElement {

    empName; empSalary; empPhone;

    getEmpDataFromChild(event){

        this.empName = event.detail.eName;
        this.empSalary = event.detail.eSalary;
        this.empPhone = event.detail.ePhone;

        console.log('Parent log');
        console.log(this.empName);
        console.log(this.empSalary);
        console.log(this.empPhone);
    }
}