import { LightningElement, track, api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import readCSV from '@salesforce/apex/LWCCouponController.readCSVFile';

const columns = [
    { label: 'Coupon Item ID', fieldName: 'Coupon_Item__c', type: 'Master-Detail' },
    { label: 'HK ID', fieldName: 'HK_Id__c' }
    ];

export default class readCouponCSVFile extends LightningElement {
    @api recordId;
    @track error;
    @track columns = columns;
    @track data;

    // accepted parameters
    get acceptedFormats() {
        return ['.csv'];
    }
    
    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;

        // calling apex class
        readCSV({idContentDocument : uploadedFiles[0].documentId})
        .then(result => {
            window.console.log('result ===> '+result);
            this.data = result;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!!',
                    message: 'Coupon Instance Created!!!',
                    variant: 'success',
                }),
            );
        })
        .catch(error => {
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error!!',
                    message: 'Iam error' + JSON.stringify(error),
                    variant: 'error',
                }),
            );     
        })

    }
}