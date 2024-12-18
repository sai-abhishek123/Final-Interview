@IsTest
public class RegistrationServiceTest {
    @TestSetup
    static void setupTestData() {
        // Create test courses
        List<Course__c> courses = new List<Course__c>();
        for (Integer i = 1; i <= 3; i++) {
            courses.add(new Course__c(
                Name = 'Course ' + i,
                Status__c = 'Active',
                Start_Date__c = Date.today().addDays(5),
                End_Date__c = Date.today().addDays(30),
                Capacity__c = 2
            ));
        }
        insert courses;

        // Create test learner
        Learner__c learner = new Learner__c(
            Name = 'Test Learner',
            Enrollment_Status__c = 'Active'
        );
        insert learner;

        // Create registrations to fill course capacity for one course
        List<Registration__c> registrations = new List<Registration__c>();
        for (Integer i = 1; i <= 2; i++) {
            registrations.add(new Registration__c(
                Learner__c = learner.Id,
                Course__c = courses[0].Id,
                Status__c = 'Enrolled',
                Registration_Date__c = Date.today()
            ));
        }
        insert registrations;
    }

    @IsTest
    static void testGetActiveCourses() {
        Test.startTest();
        List<Course__c> activeCourses = RegistrationService.getActiveCourses();
        Test.stopTest();

        System.assertNotEquals(0, activeCourses.size(), 'There should be active courses');
        System.assertEquals(3, activeCourses.size(), 'Three active courses should be returned');
    }

    @IsTest
    static void testFindLearnerByName() {
        Test.startTest();
        Learner__c learner = RegistrationService.findLearnerByName('Test Learner');
        Test.stopTest();

        System.assertNotEquals(null, learner, 'Learner should be found');
        System.assertEquals('Test Learner', learner.Name, 'Learner name should match');
    }

    @IsTest
    static void testRegisterCourses() {
        // Fetch course IDs
        List<Course__c> courses = [SELECT Id FROM Course__c];
        Id courseWithCapacity = courses[1].Id;
        Id courseWaitlisted = courses[0].Id;

        Test.startTest();
        List<RegistrationService.RegistrationResult> results = RegistrationService.registerCourses(
            'Test Learner',
            new List<Id> { courseWithCapacity, courseWaitlisted },
            Date.today()
        );
        Test.stopTest();

        System.assertEquals(2, results.size(), 'Two registration results should be returned');

        RegistrationService.RegistrationResult enrolledResult = results[0];
        System.assertEquals('Enrolled', enrolledResult.Status, 'First course should be enrolled');
        System.assertEquals(courseWithCapacity, [SELECT Id FROM Course__c WHERE Name = :enrolledResult.CourseName LIMIT 1].Id);

        RegistrationService.RegistrationResult waitlistResult = results[1];
        System.assertEquals('Waitlisted', waitlistResult.Status, 'Second course should be waitlisted');
        System.assertEquals(courseWaitlisted, [SELECT Id FROM Course__c WHERE Name = :waitlistResult.CourseName LIMIT 1].Id);
    }

    @IsTest
    static void testRegisterCoursesInvalidLearner() {
        Test.startTest();
        try {
            RegistrationService.registerCourses('Invalid Learner', new List<Id>(), Date.today());
            System.assert(false, 'Exception should have been thrown for invalid learner');
        } catch (AuraHandledException e) {
            System.assertEquals('Learner with the name "Invalid Learner" does not exist.', e.getMessage());
        }
        Test.stopTest();
    }

    @IsTest
    static void testRegisterCoursesInvalidInputs() {
        Test.startTest();
        try {
            RegistrationService.registerCourses('', new List<Id>(), null);
            System.assert(false, 'Exception should have been thrown for invalid inputs');
        } catch (AuraHandledException e) {
            System.assertEquals('Script-thrown exception', e.getMessage());
        }
        Test.stopTest();
    }
}
