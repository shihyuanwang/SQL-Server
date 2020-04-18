# School Management System Database


***Please refer to the file "SCHOOL_ MANAGEMENT_ SYSTEM_IDEA" for more information.**\\

To design a database to maintain information about school staff and students satisfying the following properties: 

**A. Enrollment System**

•	Departments will have their names, buildings, budgets, and balances.

•	Instructors will have their names, genders, departments, and other basic information.

•	Students will have their names, roll numbers, genders, departments, and other basic information.

•	A table containing all the course information, including course names, units of credit, study fees, teach fees, and the       corresponding departments.

•	A table containing all the classroom information, including corresponding buildings and room numbers.

•	A table recording all section information, including courses, instructors, quarters, years, time, classrooms, and       capacities. Notice that no two sections could be arrange in the same time and classroom, no two sections could be arranged with the same instructor and time, and an instructor could only teach courses in his/her department.

•	A table recording the enrollment information, including students and sections they take, their grades of homework, midterms, projects, and so on. Notice that students could only take courses offered this year, they could only enroll when the capacity is not full, they cannot enroll in sections repeatedly, and there should not be time conflict of sections enrolled.

•	A table recording the dynamic enrollment process, including the sections, their capacities, and numbers of spots left currently.


**B. Financial System**

•	A table recording the tuition information, including students, their payment amounts, and time of payment.

•	An audit table recording all the changes of tuition table.

•	A table recording tuition status of students (deficit, equilibrium, or surplus). Tuition payable depends on the specific courses the student takes. Students will be warned and dropped if they haven’t paid enough money.

•	A table recording the salary payment information, including instructors and their paid salary amounts. An instructor’s salary is calculated by the courses he/she teaches this quarter, their titles (Professor, Associate Professor or Assistant Professor), and their years of service.

•	A table recording account balances of instructors. Current balance is calculated by the previous balance and the amount of money paid by the department or the amount withdrawn by the instructor him/herself.

