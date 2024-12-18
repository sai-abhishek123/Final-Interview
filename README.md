# Course Enrollment and Monitoring System Documentation

#### **Overview**

The **Course Enrollment and Monitoring System** is a Salesforce-based solution that simplifies the course registration process and offers real-time monitoring of course enrollments. This system provides a seamless and efficient way for academic staff to manage course registrations, view detailed enrollment metrics, and make informed decisions regarding course capacities, waitlists, and cancellations—all in a centralized, easy-to-use interface.

#### **Purpose and Benefits**

The system serves two primary functions:

1. **Course Registration**: It enables learners to register for multiple courses, ensuring smooth enrollment through a user-friendly interface that handles input validation and feedback.
2. **Enrollment Monitoring**: It allows academic program staff to monitor the number of enrolled learners across various active courses and view learner details dynamically. This feature is crucial for responding to real-time inquiries about course capacity, waitlists, and cancellations.

By streamlining these processes, the system:

* Reduces administrative burden by providing a unified view of course enrollments.
* Enhances decision-making with real-time data on learner registration.
* Increases operational efficiency by automating registration and monitoring tasks.

***

#### **Key Features**

1. **Course Registration Form**:
   * **Multi-course Registration**: Learners can register for multiple courses simultaneously using a dual-listbox.
   * **Input Validation**: Ensures that required fields like learner name, registration date, and selected courses are provided.
   * **Real-time Feedback**: The system provides success and error messages to guide the user through the process.
2. **Enrollment Monitoring**:
   * **Active Course List**: Displays a list of all active courses with the number of learners enrolled.
   * **Learner View**: Staff can click on a "View Learners" button next to a course to see detailed information about the learners enrolled in that course.
   * **Modal Display**: Shows learner details (name, email, and registration date) in a modal popup for easy access without navigating away from the page.
3. **Backend Integration**:
   * **Apex Classes**: The system uses Apex to handle course registration logic, ensure there are no duplicate registrations, and retrieve enrollment data.
   * **Trigger**: A trigger prevents duplicate registrations, maintaining data integrity.
   * **Real-time Data Fetching**: The system fetches the latest data dynamically, allowing academic staff to make immediate decisions.
4. **Dynamic User Interface**:
   * **Lightning Web Components (LWC)**: The system leverages Salesforce's LWC framework to create a responsive, interactive, and modern UI for both learners and staff.
   * **Efficient Handling of Data**: Designed to efficiently handle up to 3 active courses, with dynamic updates based on user interaction.

***

#### **Use Case**

Imagine an academic program staff member who needs to manage enrollments across multiple courses and respond quickly to queries about course capacity. Instead of navigating through multiple systems and reports, they can use this system to:

* Quickly view the number of enrolled learners in each active course.
* Click on a course to see detailed information about the learners enrolled.
* Make immediate decisions about course capacities, waitlists, or cancellations.

For example, if a staff member sees that a course is nearing capacity, they can take immediate action based on the information provided, whether by contacting the instructor or adjusting the course schedule.

***

#### **Target Audience**

* **Academic Staff**: For monitoring course enrollments and making real-time decisions based on current registration data.
* **Learners**: For registering for multiple courses in a streamlined, error-free process.
* **Administrators**: For ensuring smooth deployment and management of course registration and enrollment systems.

***

#### **System Architecture and Technologies**

* **Salesforce Platform**: The entire system is built on the Salesforce platform, utilizing Salesforce Lightning Web Components (LWC) and Apex to handle backend logic.
* **Lightning Web Components**: These components are used to build a modern, responsive, and interactive user interface for both learners and academic staff.
* **Apex**: Custom backend logic is written in Apex to manage course registration, enrollment monitoring, and ensure there are no duplicate registrations.

***

#### **Benefits for Academic Programs**

* **Real-time Enrollment Insights**: Staff can see current enrollment counts for courses at any moment, enabling them to take quick action in managing capacities and making scheduling decisions.
* **Enhanced Operational Efficiency**: By automating much of the registration and monitoring processes, the system reduces manual efforts and the potential for errors.
* **Improved User Experience**: The seamless interface, with dynamic updates and easy-to-use features, provides a smooth experience for both learners and staff.
