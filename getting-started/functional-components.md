# Functional Components



### **Functional Components**

The **Course Enrollment and Monitoring System** consists of several core functional components that enable learners to register for courses and allow staff to monitor enrollments efficiently. These components are built using Salesforce Lightning Web Components (LWC) and are integrated with custom Salesforce objects (e.g., `Course__c`, `Learner__c`, and `Registration__c`).

This page will provide an in-depth explanation of the **Registration Form** and **Enrollment Monitor** components, including their features, how they work, and their associated files.

***

#### **1. Registration Form**

**Overview**

The **Registration Form** component allows learners to register for multiple courses at once. It collects the learner's name, registration date, and selected courses, and submits the registration data to the backend. The form also includes validation to ensure that all required fields are filled correctly.

**Key Features**

* **Learner Name Input**: A text input field for entering the learner's name.
* **Registration Date Input**: A date picker for selecting the registration date.
* **Course Selection**: A multi-select dual-listbox for choosing multiple courses from a list of available courses.
* **Validation**: Ensures that the learner's name, registration date, and selected courses are provided before allowing submission.
* **Dynamic Feedback**: Displays success or error messages based on the registration result.
* **Loading Spinner**: A spinner appears during the registration process, indicating that the system is processing the request.

**Associated Files**

* **File 1**: `newRegistrationWithMultipleCourses.html` — The HTML structure for the course registration form.
* **File 2**: `newRegistrationWithMultipleCourses.js` — The JavaScript logic for handling input, validation, and submitting registration data.

***

#### **2. Enrollment Monitor**

**Overview**

The **Enrollment Monitor** component provides staff with a real-time view of active courses, the number of enrolled learners, and detailed learner information for each course. It supports efficient decision-making by displaying critical enrollment data in an easy-to-read table format.

**Key Features**

* **Course List**: Displays a list of active courses with the number of learners enrolled in each course.
* **View Learners**: A button next to each course allows staff to view detailed information about the learners enrolled in the selected course.
* **Modal Dialog**: When a course is selected, a modal dialog appears showing the learners' names, emails, and registration dates.
* **Error Handling**: Displays error messages if the course data cannot be fetched.

**Associated Files**

* **File 1**: `course_Enrollment_Monitor.html` — The HTML structure for the enrollment monitoring table.
* **File 2**: `course_Enrollment_Monitor.js` — The JavaScript logic for fetching and displaying course enrollments and learner details.

