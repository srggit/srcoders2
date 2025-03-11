import { LightningElement } from 'lwc';

const COLUMNS = [
    { label: 'Title', fieldName: 'title', wrapText: true },
    { label: 'Description', fieldName: 'description', initialWidth: 500, wrapText: true },
    { label: 'Price', fieldName: 'price', type: 'currency', initialWidth: 200 },
    {
        label: 'Image',
        fieldName: 'image',
        type: 'customImage',
        typeAttributes: { title: 'Product Image', altText: 'Image of the Product' },
        initialWidth: 200
    }
];

export default class ProductsApiCall extends LightningElement {

    columns = COLUMNS;
    products = [];

    connectedCallback() {
        this.getProducts();
    }

    async getProducts() {
        try {
            const response = await fetch('https://fakestoreapi.com/products');

            if (response.ok) {
                this.products = await response.json();
                console.log(this.products);
            }
            else {
                console.error('Error in API response:', response.status);
            }
        }
        catch {
            console.log('Some Error Occured.')
        }

    }
}