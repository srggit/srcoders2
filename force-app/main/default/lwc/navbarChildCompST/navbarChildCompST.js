import { LightningElement, api } from 'lwc';

export default class NavbarChildCompST extends LightningElement {

    @api navList;

    handleNavSelection(event){
        console.log('Child ;', event.target.name);

        const selectedEvent = new CustomEvent('selected',
            { detail: event.target.name }
        );

        this.dispatchEvent(selectedEvent);
    }
}