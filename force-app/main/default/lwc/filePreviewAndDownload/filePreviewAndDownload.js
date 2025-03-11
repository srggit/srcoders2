import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from "lightning/navigation";

import getRelatedFilesByRecordId from '@salesforce/apex/filePreviewAndDownloadController.getRelatedFilesByRecordId';
import deleteFilesById from '@salesforce/apex/filePreviewAndDownloadController.deleteFilesById'

export default class FilePreviewAndDownload extends NavigationMixin(LightningElement) {
    @api recordId;
    wiredFilesResult;
    filesList = [];

    @wire(getRelatedFilesByRecordId, { recordId: '$recordId' })
    wiredData(result) {

        // Storing and accessing the data this way to refreshApex
        this.wiredFilesResult = result;
        const { data, error } = result;

        if (result.data) {  // if(data)
            this.filesList = Object.keys(data).map(key =>
            ({
                "label": data[key],
                "value": key,
                "url": `/sfc/servlet.shepherd/document/download/${key}`
            }));
            console.log(this.filesList);
            console.log('this.filesList - :' + JSON.stringify(this.filesList));
        }
        if (result.error) { // if(error)
            console.log('error', error);
        }
    }

    handleFileUpload(event) {
        console.log('File uploaded successfully!');
        refreshApex(this.wiredFilesResult); // Refresh data
    }

    // https://www.sfdcpoint.com/salesforce/navigation-service-in-lwc/
    handlePreview(event) {
        // We use the dataset property in JavaScript to access custom data-* attributes on an HTML element.
        console.log(event.target.dataset.id);

        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'filePreview',
            },
            state: {
                selectedRecordId: event.target.dataset.id
            }
        });
    }

    handleDelete(event) {
        console.log('Delete file');
        console.log(event.target.dataset.id);

        deleteFilesById({ fileToDelete: event.target.dataset.id })
            .then(result => {
                console.log('result: ' + JSON.stringify(result));
                refreshApex(this.wiredFilesResult); // Refresh data
            })
            .catch(error => {
                console.log('error: ' + JSON.stringify(error));
            })
    }
}