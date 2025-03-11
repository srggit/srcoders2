import { LightningElement, wire } from 'lwc';
import getAllAccounts from '@salesforce/apex/DatatableStylingController.getAllAccounts';

// For External CSS Styling
import { loadStyle } from 'lightning/platformResourceLoader';
import COLORS from '@salesforce/resourceUrl/datatable_color_file';

const COLS = [
    {
        label: 'Account Name', fieldName: 'Name', type: 'text', cellAttributes: {
            class: { fieldName: 'accountColor' }
        }
    },
    { label: 'Type', fieldName: 'Type', type: 'text' },
    {
        label: 'Industry', fieldName: 'Industry', type: 'text', cellAttributes: {
            class: { fieldName: 'industryColor' },
        }
    },
    { label: 'Rating', fieldName: 'Rating', type: 'text' },
    {
        label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency', cellAttributes: {
            class: { fieldName: 'amountColor' },
            iconName: { fieldName: 'iconName' },
            iconPosition: 'right',
        }
    },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Website', fieldName: 'Website', type: 'url' },
    { label: 'Ownership', fieldName: 'Ownership', type: 'text' }
];

export default class Datatable_styling extends LightningElement {

    accounts;
    columns = COLS;
    isCSSLoaded = false;

    @wire(getAllAccounts)
    wiredAccounts({ data, error }) {
        if (data) {
            this.accounts = data.map(acc => ({
                ...acc,
                amountColor: acc.AnnualRevenue > 50000000 ? 'slds-text-color_success' : 'slds-text-color_error',
                iconName: acc.AnnualRevenue > 50000000 ? 'utility:up' : 'utility:down',
                industryColor: 'slds-icon-custom-custom22 slds-text-color_default',
                accountColor: 'datatable-color'     // this is the name of the CSS class in Static Resource named as datatableColor
            }));
            /*
            this.accounts = data.map(item => {
                let amountColor = item.AnnualRevenue > 90000000 ? 'slds-text-color_success' : 'slds-text-color_error';
                return { ...item, amountColor: amountColor };
            });
            */
            //console.log('this.accounts : ' + this.accounts);
            //console.log(JSON.stringify(this.accounts));
        }
        else if (error) {
            this.error = error;
            this.accounts = undefined;
        }
    }

    renderedCallback() {

        if (this.isCSSLoaded)    // If the values is TRUE
            return;

        this.isCSSLoaded = true;  // we set the values to TRUE, so next time it should not execute, Only once the renderedCallback() should run

        // Used to load the style in this component, loadStyle returns a promise and we handle in then & catch block
        loadStyle(this, COLORS).then(() => {
            console.log('Style Applied');

        }).catch(error => {
            console.log('Error loading style');
        });

    }

}