# Usage Instructions

### **Usage Instructions**

This section provides a step-by-step guide on how to use the **Course Enrollment and Monitoring System** for learners and staff. The system is designed to simplify course registration for learners and streamline enrollment monitoring for academic staff.

***

#### **1. For Learners: Registering for Courses**

Learners can use the **Registration Form** to register for multiple courses. Follow the steps below to complete the registration process:

**Steps**

1. **Access the Registration Form**:
   * Navigate to the learner registration page where the **Registration Form** component is deployed.
2. **Enter Personal Details**:
   * Fill in your name in the **Learner Name** field.
   * Select the **Registration Date** using the date picker.
3. **Select Courses**:
   * View the list of available courses in the **Available Courses** list on the left of the dual-listbox.
   * Move the courses you wish to register for to the **Selected Courses** list by selecting them and clicking the arrow button.
4. **Submit the Form**:
   * Click the **Register** button to submit your registration.
5. **View Feedback**:
   * If the registration is successful, a confirmation message will appear.
   * If there are errors (e.g., missing details or duplicate registration), an error message will guide you to resolve the issue.

**Key Features for Learners:**

* Real-time validation ensures you fill out all required fields.
* You can register for multiple courses in a single submission.
* Clear feedback messages provide immediate responses.

***

#### **2. For Staff: Monitoring Course Enrollments**

Staff can use the **Enrollment Monitor** to view and manage course enrollments dynamically. Follow the steps below to utilize this component effectively:

**Steps**

1. **Access the Enrollment Monitor**:
   * Navigate to the enrollment monitoring page or dashboard where the **Enrollment Monitor** component is deployed.
2. **View Course Summary**:
   * The system displays a table of active courses, including:
     * **Course Name**
     * **Number of Enrolled Learners**
3. **Drill Down into Learner Details**:
   * To view details for a specific course, click the **View Learners** button next to the course name.
   * A modal popup will appear, displaying a list of learners enrolled in that course, including:
     * Learner Name
     * Email
     * Registration Date
4. **Close the Modal**:
   * After reviewing the learner details, close the modal by clicking the **Close** button or the **X** icon.

**Key Features for Staff:**

* Real-time enrollment data provides up-to-date insights.
* The ability to view detailed learner information streamlines decision-making.
* A centralized interface eliminates the need to navigate multiple reports.

***

#### **3. Common Scenarios**

**Scenario 1: A Learner Registers for Multiple Courses**

* The learner accesses the registration form, enters their details, and selects two or more courses.
* The system validates the input, prevents duplicate registrations, and displays a confirmation message upon successful submission.

**Scenario 2: Staff Monitors Enrollment for a High-Demand Course**

* Staff accesses the enrollment monitor and notices that a course is nearing full capacity.
* They click the **View Learners** button to review the list of enrolled learners and their registration dates, helping them decide whether to open a waitlist or add additional sessions.

**Scenario 3: Error During Registration**

* A learner tries to submit the form without selecting any courses.
* The system displays an error message: "Please select at least one course."
* The learner corrects the issue and successfully registers.

***

#### **4. Tips for Efficient Usage**

**For Learners:**

* Always double-check the **Selected Courses** list to ensure you’ve added all the desired courses before submitting the form.
* If you encounter errors during registration, review the feedback message to resolve the issue.

**For Staff:**

* Use the **View Learners** feature to quickly address inquiries about specific courses.
* Regularly monitor enrollment counts to manage course capacity effectively.

***

#### **5. Troubleshooting**

**Common Issues for Learners**

1. **Error: "Please enter the learner’s name."**
   * Solution: Ensure the **Learner Name** field is not empty.
2. **Error: "Please select a registration date."**
   * Solution: Use the date picker to choose a valid registration date.
3. **Error: "Please select at least one course."**
   * Solution: Move courses from the **Available Courses** list to the **Selected Courses** list before submitting.

**Common Issues for Staff**

1. **No Courses Displayed in the Enrollment Monitor**:
   * Solution: Check that the **Course\_\_c** object has active courses.
2. **Learner Details Not Displayed**:
   * Solution: Ensure the selected course has enrolled learners. If the issue persists, check the backend for data retrieval errors.

***

#### **6. Summary**

The **Course Enrollment and Monitoring System** is designed to be intuitive and user-friendly. By following these instructions, learners can register seamlessly for multiple courses, and staff can efficiently monitor enrollments and access detailed learner information. Whether you’re a learner or a staff member, this system ensures a smooth and productive experience.

