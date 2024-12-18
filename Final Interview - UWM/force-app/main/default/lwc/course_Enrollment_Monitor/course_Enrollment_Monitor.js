import { LightningElement, track, wire } from 'lwc';
import getActiveCoursesWithEnrollment from '@salesforce/apex/CourseEnrollmentMonitorController.getActiveCoursesWithEnrollment';
import getLearnersByCourse from '@salesforce/apex/CourseEnrollmentMonitorController.getLearnersByCourse';

export default class CourseEnrollmentMonitor extends LightningElement {
    @track courses = [];
    @track learners = [];
    @track selectedCourseId = '';
    @track selectedCourseName = '';
    @track showLearners = false;
    @track error;

    // Fetch active courses with enrollment counts from Apex
    @wire(getActiveCoursesWithEnrollment)
    getActiveCoursesWithEnrollment({ error, data }) {
        if (data) {
            this.courses = data;
        } else if (error) {
            this.error = error.body ? error.body.message : error.message;
        }
    }

    // Handle 'View Learners' button click to show learners for the selected course
    handleViewLearners(event) {
        this.selectedCourseId = event.target.dataset.id;
        this.selectedCourseName = event.target.dataset.name;

        // Call Apex method to fetch learners for the selected course
        getLearnersByCourse({ courseId: this.selectedCourseId })
            .then(result => {
                this.learners = result;
                this.showLearners = true;
            })
            .catch(error => {
                this.error = error.body ? error.body.message : error.message;
            });
    }

    // Close the learners list and reset the relevant properties
    handleCloseLearners() {
        this.showLearners = false;
        this.learners = [];
    }
}
