<%@ page import="com.attendance.model.User, com.attendance.dao.StudentDAO, com.attendance.dao.AttendanceDAO, com.attendance.model.Student, java.util.List, java.sql.Date" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"teacher".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    StudentDAO studentDAO = new StudentDAO();
    AttendanceDAO attendanceDAO = new AttendanceDAO();
    List<Student> students = studentDAO.getAllStudents();
    Date today = new Date(System.currentTimeMillis());
    int totalStudents = students.size();
    int present = attendanceDAO.getPresentCount(today, "BCA"); // Example
    int absent = totalStudents - present;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students' Attendance System - Dashboard</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <div class="header">
        <h1>Attendance System</h1>
        <div class="header-right">
            <span>Welcome, <%= user.getFirstName() %></span>
            <a href="logout.jsp" class="logout-link">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="sidebar">
            <ul class="nav-menu">
                <li class="active" onclick="setActive('dashboard')"><a href="#">Dashboard</a></li>
                <li onclick="setActive('attendance')"><a href="#">Mark Attendance</a></li>
            </ul>
        </div>

        <div class="main-content" id="dashboardContent">
            <h2>Today's Attendance</h2>
            
            <div class="filters">
                <label>Select Class:
                    <select id="classSelect">
                        <option>All Classes</option>
                        <option>BCA</option>
                        <option>BIT</option>
                        <option>BE</option>
                    </select>
                </label>
                <label>Select Date:
                    <input type="date" id="dateSelect" value="<%= today %>">
                </label>
                <button onclick="loadAttendance()">Search</button>
                <button class="add-student-btn" onclick="openModal()">+ Add Student</button>
            </div>

            <table class="attendance-table">
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Class</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="studentsTableBody">
                    <% for (Student s : students) { %>
                        <tr>
                            <td><%= s.getId() %></td>
                            <td><%= s.getUser().getFirstName() %> <%= s.getUser().getLastName() %></td>
                            <td><%= s.getStudentClass() %></td>
                            <td>Present</td>
                            <td><button>Edit</button></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="stats">
                <div class="stat-box">
                    <p>Total Students: <strong><%= totalStudents %></strong></p>
                </div>
                <div class="stat-box">
                    <p>Present: <strong><%= present %></strong></p>
                </div>
                <div class="stat-box">
                    <p>Absent: <strong><%= absent %></strong></p>
                </div>
                <div class="stat-box">
                    <p>Attendance Rate: <strong><%= totalStudents > 0 ? (present * 100 / totalStudents) : 0 %>%</strong></p>
                </div>
            </div>

            <button class="export-btn">Export Report</button>
        </div>

        <div class="main-content" id="attendanceContent" style="display: none;">
            <h2>Mark Today's Attendance</h2>
            <form action="markAttendance.jsp" method="post">
                <!-- Add dynamic student list with checkboxes -->
                <% for (Student s : students) { %>
                    <input type="checkbox" name="present" value="<%= s.getId() %>"> <%= s.getUser().getFirstName() %> <%= s.getUser().getLastName() %><br>
                <% } %>
                <button type="submit">Submit Attendance</button>
            </form>
        </div>
    </div>

    <script>
        function setActive(section) {
            document.getElementById('dashboardContent').style.display = section === 'dashboard' ? 'block' : 'none';
            document.getElementById('attendanceContent').style.display = section === 'attendance' ? 'block' : 'none';
        }
    </script>
</body>
</html>