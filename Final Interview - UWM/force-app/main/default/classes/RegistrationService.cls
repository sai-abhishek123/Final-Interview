public with sharing class RegistrationService {

    
    //  Retrieves a list of active courses.
    @AuraEnabled(cacheable=true)
    public static List<Course__c> getActiveCourses() {
        try {
            return [SELECT Id, Name, Start_Date__c, End_Date__c, Capacity__c FROM Course__c WHERE Status__c = 'Active' ORDER BY Name];
        } catch(Exception e) {
            throw new AuraHandledException('Error fetching courses: ' + e.getMessage());
        }
    }

    // Finds a Learner__c record by its name.
     
    @AuraEnabled(cacheable=true)
    public static Learner__c findLearnerByName(String learnerName) {
        try {
            List<Learner__c> learners = [SELECT Id, Name FROM Learner__c WHERE Name = :learnerName AND Enrollment_Status__c='Active' LIMIT 1];
            if (!learners.isEmpty()) {
                return learners[0];
            } else {
                return null;
            }
        } catch(Exception e) {
            throw new AuraHandledException('Error finding learner: ' + e.getMessage());
        }
    }

    //  * Registers multiple active courses for a learner identified by name.
    @AuraEnabled
    public static List<RegistrationResult> registerCourses(String learnerName, List<Id> courseIds, Date registrationDate) {
        // Validate inputs
        if (String.isBlank(learnerName) || courseIds == null || courseIds.isEmpty() || registrationDate == null) {
            throw new AuraHandledException('Learner name, courses, and registration date are required.');
        }

        // Find the learner by name
        Learner__c learner = findLearnerByName(learnerName);
        if (learner == null) {
            throw new AuraHandledException('Learner with the name \"' + learnerName + '\" does not exist or could be not in Active Status.');
        }

        // Fetch course details including capacity and date constraints
        List<Course__c> courses = [SELECT Id, Name, Start_Date__c, End_Date__c, Capacity__c, (SELECT Id FROM Registrations__r) FROM Course__c  WHERE Id IN :courseIds];
        Map<Id, Course__c> courseMap = new Map<Id, Course__c>(courses);

        // Prepare results and validate course constraints
        List<RegistrationResult> results = new List<RegistrationResult>();
        List<Registration__c> newRegistrations = new List<Registration__c>();
        List<Registration__c> waitlistRegistrations = new List<Registration__c>();

        for (Id courseId : courseIds) {
            Course__c course = courseMap.get(courseId);

            // Check course capacity
            if (course.Registrations__r.size() >= course.Capacity__c) {
                waitlistRegistrations.add(new Registration__c(
                    Learner__c = learner.Id,
                    Course__c = course.Id,
                    Status__c = 'Waitlisted',
                    Registration_Date__c = registrationDate
                ));
                results.add(new RegistrationResult(
                    course.Name,
                    'Waitlisted',
                    registrationDate
                ));
            } else {
                newRegistrations.add(new Registration__c(
                    Learner__c = learner.Id,
                    Course__c = course.Id,
                    Status__c = 'Enrolled',
                    Registration_Date__c = registrationDate
                ));
                results.add(new RegistrationResult(
                    course.Name,
                    'Enrolled',
                    registrationDate
                ));
            }
        }

        // Insert new registrations
        if (!newRegistrations.isEmpty()) {
            try {
                insert newRegistrations;
            } catch(DmlException e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        // Insert waitlist registrations
        if (!waitlistRegistrations.isEmpty()) {
            try {
                insert waitlistRegistrations;
            } catch(DmlException e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        return results;
    }

    //  * Wrapper class to encapsulate registration result details.
    public class RegistrationResult {
        @AuraEnabled public String CourseName { get; set; }
        @AuraEnabled public String Status { get; set; }
        @AuraEnabled public Date RegistrationDate { get; set; }

        // Constructor with parameters
        public RegistrationResult(String courseName, String status, Date registrationDate) {
            this.CourseName = courseName;
            this.Status = status;
            this.RegistrationDate = registrationDate;
        }
    }
}