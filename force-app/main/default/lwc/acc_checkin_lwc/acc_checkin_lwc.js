import { LightningElement, track, wire, api } from 'lwc';	
import FORM_FACTOR from '@salesforce/client/formFactor';
import LightningAlert from 'lightning/alert';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';
import LightningConfirm from 'lightning/confirm';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CurrentPageReference } from 'lightning/navigation';


export default class Acc_checkin_lwc extends LightningElement {


    @track files = [];
    @track fileUpload = [];
    
    handleFileChange(event)
    {
        this.files = [];
        this.fileUpload = [];

        const newFiles = Array.from(event.target.files);

        this.files = [...this.files, ...newFiles];
        this.fileUpload = this.files.map(file => ({
            name : file.name,
            size : file.size,
            type : file.type,
            icon : this.getFileIcon(file.type)
        }));
    }

    // Here the values are accessed and searched as fileTypeIcons[fileType] --- fileTypeIcons['image/jpeg']
    // It directly returns the values from searching in an object
    getFileIcon(fileType) {
        const fileTypeIcons = {
            'image/jpeg': 'doctype:image',
            'image/png': 'doctype:image',
            'application/pdf': 'doctype:pdf',
            'application/msword': 'doctype:word',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document': 'doctype:word',
            'application/vnd.ms-excel': 'doctype:excel',
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': 'doctype:excel',
            'application/vnd.ms-powerpoint': 'doctype:ppt',
            'application/vnd.openxmlformats-officedocument.presentationml.presentation': 'doctype:ppt',
            'text/plain': 'doctype:txt',
        };

        // Return the corresponding icon for the file type, or a default icon if not found
        return fileTypeIcons[fileType] || 'doctype:attachment';
    }   

    /*
    // getFileIcon() method can also be written like this
    getFileIcon(fileType){
        if (fileType === 'image/jpeg') {
            return 'doctype:image';
        } 
        else if (fileType === 'application/pdf') {
            return 'doctype:pdf';
        }
        // ...other conditions
        else {
            return 'doctype:unknown';
        }
    }
    */
}