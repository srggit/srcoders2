import { LightningElement } from 'lwc';

export default class StopWatch extends LightningElement {
    timer = '0 Seconds'; // Default timer display
    timerReference; // For the interval
    startTime; // To hold the start time
    elapsedTime = 0; // To store elapsed time

    // Load the start time from local storage on component load
    connectedCallback() {
        const storedTime = window.localStorage.getItem('getStartTimer');
        if (storedTime) {
            console.log('Resuming timer from stored time');
            this.startTime = new Date(storedTime).getTime(); // Parse stored time
            this.elapsedTime = new Date().getTime() - this.startTime; // Calculate elapsed time
            this.setTimer(); // Restart the timer
        }
    }

    actionHandler(event) {
        const { label } = event.target;

        if (label === 'Start') {
            if (!this.startTime) {
                // Set startTime only if not already set
                this.startTime = new Date().getTime(); // Start fresh
            } else {
                // Adjust startTime to resume correctly
                this.startTime = new Date().getTime() - this.elapsedTime;
            }
            this.setTimer(); // Start/resume the timer
        }

        if (label === 'Stop') {
            console.log('Stopping the timer');
            window.clearInterval(this.timerReference); // Stop the interval
        }

        if (label === 'Reset') {
            console.log('Resetting the timer');
            window.clearInterval(this.timerReference); // Stop the interval
            this.timer = '0 Seconds'; // Reset timer display
            this.startTime = null; // Clear start time
            this.elapsedTime = 0; // Reset elapsed time
            window.localStorage.removeItem('getStartTimer'); // Clear local storage
        }
    }

    setTimer() {
        console.log('Starting/Resuming the timer');

        this.timerReference = window.setInterval(() => {
            const now = new Date().getTime();
            console.log('now', now);
            this.elapsedTime = now - this.startTime; // Update elapsed time
            console.log('this.elapsedTime', this.elapsedTime);
            this.timer = this.secondsToHRS(Math.floor(this.elapsedTime / 1000)); // Update display
        }, 1000);
    }

    secondsToHRS(seconds) {
        seconds = Number(seconds);
        const h = Math.floor(seconds / 3600);
        const m = Math.floor((seconds % 3600) / 60);
        const s = Math.floor(seconds % 3600) % 60;

        const hDisplay = h > 0 ? h + (h === 1 ? ' Hour, ' : ' Hours, ') : '';
        const mDisplay = m > 0 ? m + (m === 1 ? ' Minute, ' : ' Minutes, ') : '';
        const sDisplay = s > 0 ? s + (s === 1 ? ' Second' : ' Seconds') : '';

        return hDisplay + mDisplay + sDisplay;
    }
}