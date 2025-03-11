import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class CompToCompNavigationParent extends NavigationMixin(LightningElement) {
    navigateToChildLwc() {
        // Access the input value
        const userName = this.refs.userName.value;

        // Define the component and its attributes
        const compDefinition = {
            componentDef: 'c:navigationChildComp',
            attributes: {
                userName: userName
            }
        };

        // Encode the component definition in Base64
        const compDefBase64 = btoa(JSON.stringify(compDefinition));

        // Navigate to the component
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/one/one.app#' + compDefBase64
            }
        });
    }
}