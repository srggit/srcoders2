import { LightningElement, api } from 'lwc';

export default class PaginationHandler extends LightningElement {

    totalRecords = [];
    recordSize = 5;
    visibleRecords;
    totalPages;
    currentPage = 1;
    /*
    previousVisibilility = true;
    nextVisibility = false;
    */
    get records() {
        return this.visibleRecords;
    }

    // Setter Method at the time of page load
    @api set records(data) {

        if (data) {
            this.totalRecords = data;
            this.totalPages = Math.ceil(data.length / this.recordSize);
            this.updateRecords();
        }
    }

    get disablePreviousButtont() {
        return this.currentPage === 1;   // true
    }

    get disableNextButtont() {
        return this.currentPage === this.totalPages;    // true
    }


    nextHandler(event) {
        // 1
        if (this.currentPage < this.totalPages) {   // 1<5, 2<5, 3<5, 4<5, 5<5
            this.currentPage++;     // 2
        }

        /*
        if (this.currentPage == this.totalPages) {
            this.nextVisibility = true;
        }
        */
        this.updateRecords();
        //      this.previousVisibilility = false;
    }


    previousHandler(event) {
        // 2
        if (this.currentPage > 1) {
            this.currentPage--;
        }
        /*
        if (this.currentPage == 1) {
            this.previousVisibilility = true;
        }
        */

        this.updateRecords();
    }

    updateRecords(event) {

        // 2-1 * 5 = 5
        const start = (this.currentPage - 1) * this.recordSize;    // 0-5 // 1*5 = 5  // 10
        const end = this.currentPage * this.recordSize;                        // 2*5 = 10  // 15
        //const end = Math.min(this.currentPage * this.recordSize, this.totalRecords.length);

        console.log(`Page: ${this.currentPage}, Start: ${start}, End: ${end}`);

        this.visibleRecords = this.totalRecords.slice(start, end);
        console.log('visibleRecords : ' + this.visibleRecords.length);

        // Creating and Dispactching the Event..
        this.dispatchEvent(new CustomEvent('update_records_on_page', {
            detail: {
                records: this.visibleRecords
            }
        }
        ));
    }
}