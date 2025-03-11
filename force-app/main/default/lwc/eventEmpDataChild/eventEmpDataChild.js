import { LightningElement } from 'lwc';

export default class EventEmpDataChild extends LightningElement {

    name; salary; phone;

    handleEmpName(event){
        this.name = event.target.value;
    }

    handleEmpSalary(event){
        this.salary = event.target.value;
    }

    handleEmpPhone(event){
        this.phone = event.target.value;
    }

    handleSubmit(event){
        
        // Step 1: Create an Event
        const empEvent = new CustomEvent('emp_data_event', { // JS Object
                                                                detail : 
                                                                { 
                                                                    eName : this.name, 
                                                                    eSalary : this.salary, 
                                                                    ePhone : this.phone
                                                                } 
                                                            });

        this.dispatchEvent(empEvent);
        
        console.log('Child Log');
        console.log(this.name);
        console.log(this.salary);
        console.log(this.phone);
    }
}