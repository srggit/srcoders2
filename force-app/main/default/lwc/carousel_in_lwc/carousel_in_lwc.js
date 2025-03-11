// Parent Component

import { LightningElement } from 'lwc';
import IMAGES from '@salesforce/resourceUrl/carousel';

export default class Carousel_in_lwc extends LightningElement {

    // Step 1: Importing Images from Static Resources
    // Step 2: Creating an array of objects with Images as data
    // Step 3: Sending the data to the child component
    slides = [
        {
            image: `${IMAGES}/carousel/Image1.jpg`,
            heading: 'Carousel Image 1',
            description: 'Image 1 Description'
        },
        {
            image: `${IMAGES}/carousel/Image2.jpg`,
            heading: 'Carousel Image 2',
            description: 'Image 2 Description'
        },
        {
            image: `${IMAGES}/carousel/Image3.jpg`,
            heading: 'Carousel Image 3',
            description: 'Image 3 Description'
        }
    ];

}