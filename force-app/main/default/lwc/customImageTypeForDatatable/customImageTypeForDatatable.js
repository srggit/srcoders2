import { LightningElement } from 'lwc';
import LightningDatatable from 'lightning/datatable';
import customImage from './customImage';

export default class CustomImageTypeForDatatable extends LightningDatatable {
    static customTypes = {  //fixed keyword
        customImage: {
            template: customImage, // Name of the Html File in which we defined image tag. // Links to the custom template
            typeAttributes: ['title', 'altText'] // Used to pass the extra data: title, name etc //  // Pass additional attributes like title or altText

        }
    }
}

// Note:
// This component is extending the LightningDatatable and also we are creating out additional type for datatable.