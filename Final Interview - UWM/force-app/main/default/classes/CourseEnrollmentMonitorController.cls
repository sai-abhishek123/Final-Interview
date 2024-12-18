public with sharing class CourseEnrollmentMonitorController {

    // Fetch active courses with the enrollment count
    @AuraEnabled(cacheable=true)
    public static List<CourseWrapper> getActiveCoursesWithEnrollment() {
        List<CourseWrapper> results = new List<CourseWrapper>();

        // Query active courses and related registration counts, including Capacity__c
        List<Course__c> courses = [SELECT Id, Name, Capacity__c, 
        (SELECT Id FROM Registrations__r WHERE Status__c = 'Enrolled') 
        FROM Course__c WHERE Status__c = 'Active' LIMIT 3];

        // Iterate through courses to prepare enrollment count and other details
        for (Course__c course : courses) {
            Integer enrolledCount = course.Registrations__r.size();
            results.add(new CourseWrapper(course.Id, course.Name, 
            enrolledCount, course.Capacity__c));
        }
        
        return results;
    }

    // Fetch learners for a specific course based on Registration and junction object
    @AuraEnabled
    public static List<LearnerWrapper> getLearnersByCourse(Id courseId) {
        List<LearnerWrapper> learners = new List<LearnerWrapper>();

        // Query learners enrolled in the specific course
        List<Registration__c> registrations = [SELECT Learner__r.Name, 
        Learner__r.Email_Id__c, 
        Registration_Date__c FROM Registration__c WHERE 
        Course__c = :courseId AND Status__c = 'Enrolled'];

        // Populate the learners list
        for (Registration__c registration : registrations) {
            learners.add(new LearnerWrapper(registration.Learner__r.Name, 
            registration.Learner__r.Email_Id__c, registration.Registration_Date__c));
        }

        return learners;
    }

    // Wrapper class for course data
    public class CourseWrapper {
        @AuraEnabled public String courseId;
        @AuraEnabled public String courseName;
        @AuraEnabled public Integer enrolledCount;
        @AuraEnabled public Decimal capacity;

        // Constructor updated to match the field types
        public CourseWrapper(String courseId, String courseName, Integer enrolledCount, Decimal capacity) {
            this.courseId = courseId;
            this.courseName = courseName;
            this.enrolledCount = enrolledCount;
            this.capacity = capacity;
        }
    }

    // Wrapper class for learner data
    public class LearnerWrapper {
        @AuraEnabled public String learnerName;
        @AuraEnabled public String email;
        @AuraEnabled public Date registrationDate;

        public LearnerWrapper(String learnerName, String email, Date registrationDate) {
            this.learnerName = learnerName;
            this.email = email;
            this.registrationDate = registrationDate;
        }
    }
}