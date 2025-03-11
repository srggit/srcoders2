/*
* slides-data: Its the data in the for of [ {image:'', heading:'', description:''}]
* enable-auto-scroll:  Enable or disable auto scroll
* slide-timer: for controlling the slider speed, default is 3 seconds
* show-full: show-full is 100%, else custom width, default is 700
* custom-width: used to controller the width of the slider
*/

import { LightningElement, api } from 'lwc';

const CARD_VISIBLE_CLASSES = 'slds-show fade';
const CARD_HIDDEN_CLASSES = 'slds-hide fade';

const DOT_VISIBLE_CLASSES = 'dot active';
const DOT_HIDDEN_CLASSES = 'dot';
const DEFAULT_SLIDER_TIMER = 3000;  // 3 seconds
const DEFAULT_SLIDER_WIDTH = 700;

export default class Custom_carousel_comp extends LightningElement {

    slides = [];
    slideNumber = 1;
    timer;

    @api slideTimer = DEFAULT_SLIDER_TIMER;
    @api enableAutoScroll = false;
    @api customWidth = DEFAULT_SLIDER_WIDTH;
    @api showFull = false;

    get maxWidth() {
        return this.showFull ? `width: 100%` : `width: ${Number(this.customWidth)}px`;
    }

    @api
    get slidesData() {
        return this.slides;
    }

    // Step 4: Receiving the data from the parent component as 'data'
    // Step 5: Adding some new properties to the data object
    // Step 6: HTML Renders the First Slide
    set slidesData(data) {

        this.slides = data.map((item, index) => {
            return index === 0 ? {
                ...item,
                slideIndex: index + 1,
                cardClasses: CARD_VISIBLE_CLASSES,
                dotClasses: DOT_VISIBLE_CLASSES
            } :
                {
                    ...item,
                    slideIndex: index + 1,
                    cardClasses: CARD_HIDDEN_CLASSES,
                    dotClasses: DOT_HIDDEN_CLASSES
                }
        });
    }

    // Step 7: connectedCallback Executes when the component is inserted into the DOM
    // Navigate slides automatically based on the timer, window is used to suppor all the browsers
    connectedCallback() {
        if (this.enableAutoScroll) {
            console.log('enableAutoScroll : ', this.enableAutoScroll);
            console.log('this.slideTimer : ', this.slideTimer);

            this.timer = window.setInterval(() => {
                this.slideNumberHandler(this.slideNumber + 1);
            }, Number(this.slideTimer));
        }
    }

    // After Moving from Component disconnect the timer
    disconnectedCallback() {
        if (this.enableAutoScroll) {
            window.clearInterval(this.timer);
        }
    }

    // Navigate slide through prev and next buttons
    prevSlide() {
        let slideNo = this.slideNumber - 1;
        this.slideNumberHandler(slideNo);
    }

    nextSlide() {
        console.log('nextSlide()');
        let slideNo = this.slideNumber + 1;
        this.slideNumberHandler(slideNo);
    }

    slideNumberHandler(slideNo) {

        if (slideNo > this.slides.length) {     // 4 > 3    --> Go to first slide
            console.log('Condition 1');
            console.log('this.slides.length : ', this.slides.length);
            console.log('slideNo : ', slideNo);
            this.slideNumber = 1;
            console.log('this.slideNumber : ', this.slideNumber);
        }
        else if (slideNo < 1) {        // 0 < 1 --> Go to last slide
            console.log('Condition 2');
            console.log('this.slides.length : ', this.slides.length);
            console.log('slideNo : ', slideNo);
            this.slideNumber = this.slides.length;
            console.log('this.slideNumber : ', this.slideNumber);
        }
        else {
            console.log('Condition 3');         // 3 == 3 --> Go to same slide
            console.log('slideNo : ', slideNo);
            this.slideNumber = slideNo;
            console.log('this.slideNumber : ', this.slideNumber);
        }

        this.slides = this.slides.map((item) => {
            return this.slideNumber === item.slideIndex ? {
                ...item,
                cardClasses: CARD_VISIBLE_CLASSES,
                dotClasses: DOT_VISIBLE_CLASSES
            } :
                {
                    ...item,
                    cardClasses: CARD_HIDDEN_CLASSES,
                    dotClasses: DOT_HIDDEN_CLASSES
                }
        });
    }

    // Navigate slides throw dots
    currentSlideHandler(event) {
        let selectedSlide = Number(event.target.dataset.id);
        this.slideNumberHandler(selectedSlide);
    }
}