import { LightningElement, track, wire } from 'lwc';
import getActiveCourses from '@salesforce/apex/RegistrationService.getActiveCourses';
import registerCourses from '@salesforce/apex/RegistrationService.registerCourses';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Newregistrationwithmultiplecourses extends LightningElement {
    @track learnerName = '';
    @track courseOptions = [];
    @track selectedCourses = [];
    @track error;
    @track message;
    @track isLoading = false;
    @track registrationResults = [];
    registrationDate = new Date().toLocaleDateString('en-CA'); // Set default date to today

    // Fetch active courses and prepare options for dual-listbox
    @wire(getActiveCourses)
    getActiveCourses({ error, data }) {
        if (data) {
            this.courseOptions = data.map(course => ({
                label: course.Name,
                value: course.Id
            }));
            this.error = undefined;
        } else if (error) {
            this.error = error.body ? error.body.message : error.message;
            this.courseOptions = [];
        }
    }

    // Handle changes in Learner Name input
    handleLearnerNameChange(event) {
        this.learnerName = event.target.value;
    }

    // Handle changes in Course Selection
    handleCoursesChange(event) {
        this.selectedCourses = event.detail.value;
    }

    // Handle Register button click
    handleRegisterClick() {
        // Reset messages
        this.error = '';
        this.message = '';
        this.registrationResults = [];

        // Input Validation
        if (!this.learnerName.trim()) {
            this.error = 'Please enter the learner\'s name.';
            this.showToast('Error', this.error, 'error');
            return;
        }

        this.isLoading = true;

        // Call registerCourses Apex method
        registerCourses({
            learnerName: this.learnerName.trim(),
            courseIds: this.selectedCourses,
            registrationDate: this.registrationDate // Use the default date
        })
            .then(results => {
                this.registrationResults = results;

                // Separate enrolled and waitlisted results
                const enrolledCourses = results.filter(r => r.Status === 'Enrolled');
                const waitlistedCourses = results.filter(r => r.Status === 'Waitlisted');

                // Prepare messages for enrolled and waitlisted courses
                let successMessage = '';
                let waitlistMessage = '';
                if (enrolledCourses.length > 0) {
                    const enrolledCourseNames = enrolledCourses.map(r => r.CourseName).join(', ');
                    successMessage += `Successfully enrolled for the following courses: ${enrolledCourseNames}. `;
                    this.showToast('Registration Results', successMessage, 'success');
                }
                if (waitlistedCourses.length > 0) {
                    const waitlistedCourseNames = waitlistedCourses.map(r => r.CourseName).join(', ');
                    waitlistMessage += `Waitlisted for the following courses: ${waitlistedCourseNames}.`;
                    this.showToast('Registration Results', waitlistMessage, 'info');
                }
                this.resetForm();
            })
            .catch(error => {
                // Handle inactive user or other errors
                if (error.body && error.body.message.includes('inactive')) {
                    this.showToast('Error', 'The selected user is inactive. Please check and try again.', 'error');
                } else {
                    this.error = error.body ? error.body.message : error.message;
                    this.showToast('Error', this.error, 'error');
                }
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    // Method to reset form fields
    resetForm() {
        this.learnerName = '';
        this.selectedCourses = [];
    }

    // Method to show toast messages
    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title,
            message,
            variant,
            // mode: 'sticky'
        });
        this.dispatchEvent(evt);
    }
}
