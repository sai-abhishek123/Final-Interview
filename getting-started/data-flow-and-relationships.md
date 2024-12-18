# Data Flow and Relationships

### **Data Flow and Relationships**

The **Course Enrollment and Monitoring System** is built upon a set of custom Salesforce objects that work together to handle course registrations and enrollment monitoring. This section provides a detailed explanation of the relationships between these objects, the data flow between frontend and backend components, and how data is processed and presented to users.

***

#### **1. Key Salesforce Objects**

The system relies on three main custom Salesforce objects:

**1.1. Course\_\_c**

* Represents a course offered to learners.
* **Key Fields**:
  * **Name**: The name of the course.
  * **Description**: Details about the course.
  * **Status**: Indicates whether the course is active or inactive.
* **Purpose**: Used to fetch and display available courses for registration and monitor enrollments.

**1.2. Learner\_\_c**

* Represents an individual learner who registers for courses.
* **Key Fields**:
  * **Name**: The name of the learner.
  * **Email**: The learner’s email address.
  * **Registration Details**: Linked through the `Registration__c` object.
* **Purpose**: Tracks the learners and their contact information.

**1.3. Registration\_\_c**

* Represents the registration of a learner for a specific course.
* **Key Fields**:
  * **Learner\_\_c (Lookup)**: Links to the learner who registered.
  * **Course\_\_c (Lookup)**: Links to the course the learner registered for.
  * **Registration Date**: The date the learner registered.
  * **Status**: Indicates the registration status (e.g., `Enrolled`, `Waitlisted`).
* **Purpose**: Serves as the central object connecting learners and courses.

***

#### **2. Relationships Between Objects**

The system’s data model establishes relationships between the custom objects as follows:

* **One-to-Many Relationship**:
  * A single `Course__c` record can have multiple related `Registration__c` records, representing multiple learners enrolled in the course.
  * A single `Learner__c` record can have multiple related `Registration__c` records, representing enrollment in multiple courses.

**Object Diagram**

```
Learner__c 1----* Registration__c *----1 Course__c
```

This relationship ensures flexibility, allowing learners to enroll in multiple courses while keeping the data structured and linked.

***

#### **3. Data Flow Overview**

The system processes data through the following key stages:

**3.1. Registration Process**

1. **Data Input**:
   * Learners interact with the **Registration Form** to provide their details and select courses.
   * The frontend sends learner details, selected course IDs, and the registration date to the backend.
2. **Backend Processing**:
   * The `registerCourses` method in `RegistrationService.cls` validates the data.
   * It ensures that the learner is not already registered for the selected courses by checking `Registration__c` records.
   * If valid, new `Registration__c` records are created, linking the `Learner__c` and `Course__c` objects.
3. **Database Update**:
   * The Salesforce database is updated with the new `Registration__c` records.
   * Duplicate prevention is enforced by the `PreventDuplicateRegistrations.trigger`.
4. **Feedback**:
   * The backend sends success or error responses back to the frontend, which are displayed to the user.

**3.2. Enrollment Monitoring Process**

1. **Course Summary Retrieval**:
   * The **Enrollment Monitor** fetches active courses and their enrollment counts using the `getActiveCoursesWithEnrollment` method in `CourseEnrollmentMonitorController.cls`.
   * The method aggregates the number of `Registration__c` records for each active course.
2. **Learner Details Retrieval**:
   * When staff clicks "View Learners," the `getLearnersByCourse` method fetches learner information for the selected course by querying `Registration__c` and related `Learner__c` records.
3. **Frontend Display**:
   * The frontend displays the course summary in a table and learner details in a modal popup.

***

#### **4. Data Flow Diagram**

Below is an example representation of the data flow in the system:

```
Learner                Registration Form (Frontend)
   |                                 |
   |  Enter Details and Select Courses  
   |-------------------------------->|
   |                                 |
   |        Backend Processing       |
   |<--------------------------------|
   |         Registration Success     |
   |                                 |
   |
Database:
+-----------------+       +-----------------+       +-----------------+
|   Learner__c    |       | Registration__c |       |   Course__c     |
+-----------------+       +-----------------+       +-----------------+
```

***

#### **5. Data Interactions**

**5.1. Registration Form to Backend**

* **Frontend Action**:
  * Learner inputs data and submits the registration form.
* **Backend Processing**:
  * Validates data and checks for duplicates using `RegistrationService.cls`.
  * Updates the database with new `Registration__c` records.

**5.2. Enrollment Monitor to Backend**

* **Frontend Action**:
  * Staff accesses the Enrollment Monitor to view active courses and learner details.
* **Backend Processing**:
  * Queries active courses and their enrollments using `CourseEnrollmentMonitorController.cls`.
  * Fetches learner details dynamically based on staff input.

***

#### **6. Key Features of Data Flow**

1. **Dynamic Data Retrieval**:
   * The system fetches data in real time, ensuring up-to-date information for users.
2. **Integrated Relationships**:
   * The links between `Course__c`, `Learner__c`, and `Registration__c` ensure consistency and traceability of data.
3. **Error Handling**:
   * Prevents duplicate records and provides detailed error messages for invalid operations.

***

#### **7. Summary**

The data flow and relationships in the **Course Enrollment and Monitoring System** are designed to ensure seamless interaction between learners, staff, and backend systems. By leveraging Salesforce’s object model and Apex logic, the system efficiently manages course registrations and enrollment monitoring, providing a robust and reliable solution for academic programs.

