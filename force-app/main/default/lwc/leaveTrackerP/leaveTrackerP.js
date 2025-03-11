import { LightningElement } from 'lwc';

export default class LeaveTrackerP extends LightningElement {


    // Step 2: Handle Custom Event from myLeavesC Component and refresh Method in Child Comp (leaveRequestC)
    refreshLeaveRequestHandler(event) {
        this.refs.leaveRequestComp.refreshGrid();
    }

}