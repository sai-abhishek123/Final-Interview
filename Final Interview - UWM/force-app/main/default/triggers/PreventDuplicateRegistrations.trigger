trigger PreventDuplicateRegistrations on Registration__c (before insert) {
    // Map to hold Learner ID and a set of Course IDs they're already registered for
    Map<Id, Set<Id>> learnerCourseMap = new Map<Id, Set<Id>>();
    
    // Map to hold Course ID to Course Name
    Map<Id, String> courseIdToNameMap = new Map<Id, String>();
    
    // Collect Learner IDs from the new registrations
    Set<Id> learnerIds = new Set<Id>();
    for (Registration__c reg : Trigger.new) {
        if (reg.Learner__c != null && reg.Course__c != null) {
            learnerIds.add(reg.Learner__c);
        }
    }
    
    // Query existing registrations for the learners in the trigger
    if (!learnerIds.isEmpty()) {
        List<Registration__c> existingRegistrations = [SELECT Learner__c, Course__c, Course__r.Name FROM Registration__c WHERE Learner__c IN :learnerIds];
    
        // Populate the learnerCourseMap and courseIdToNameMap
        for (Registration__c reg : existingRegistrations) {
            if (!learnerCourseMap.containsKey(reg.Learner__c)) {
                learnerCourseMap.put(reg.Learner__c, new Set<Id>());
            }
            learnerCourseMap.get(reg.Learner__c).add(reg.Course__c);
            
            // Populate the courseIdToNameMap
            if (reg.Course__c != null && reg.Course__r != null) {
                courseIdToNameMap.put(reg.Course__c, reg.Course__r.Name);
            }
        }
    }
    
    // Map to hold Learner ID and list of duplicate Course Names
    Map<Id, List<String>> learnerDuplicateCoursesMap = new Map<Id, List<String>>();
    
    // Check for duplicates in the new registrations
    for (Registration__c reg : Trigger.new) {
        if (reg.Learner__c != null && reg.Course__c != null) {
            Set<Id> registeredCourses = learnerCourseMap.get(reg.Learner__c);
            if (registeredCourses != null && registeredCourses.contains(reg.Course__c)) {
                if (!learnerDuplicateCoursesMap.containsKey(reg.Learner__c)) {
                    learnerDuplicateCoursesMap.put(reg.Learner__c, new List<String>());
                }
                String courseName = courseIdToNameMap.get(reg.Course__c);
                if (courseName != null) {
                    learnerDuplicateCoursesMap.get(reg.Learner__c).add(courseName);
                } else {
                    // Fallback to Course ID if name is not found
                    learnerDuplicateCoursesMap.get(reg.Learner__c).add(reg.Course__c);
                }
            }
        }
    }
    
    // If duplicates are found, throw an error with course names
    if (!learnerDuplicateCoursesMap.isEmpty()) {
        String errorMessage = 'Duplicate course registration detected for the following courses:\n';
        for (Id learnerId : learnerDuplicateCoursesMap.keySet()) {
            errorMessage += 'Courses: ' + String.join(learnerDuplicateCoursesMap.get(learnerId), ', ') + '. Please register for another available course.';//+'\n';
        }
        for (Registration__c reg : Trigger.new) {
            reg.addError(errorMessage);
        }
    }
}