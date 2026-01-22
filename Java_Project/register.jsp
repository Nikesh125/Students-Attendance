<%@ page import="com.attendance.dao.UserDAO, com.attendance.dao.StudentDAO, com.attendance.model.User, com.attendance.model.Student" %>
<%
    String message = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");

        if (!password.equals(confirmPassword)) {
            message = "Passwords do not match";
        } else {
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setRole(role);
            user.setFirstName(fname);
            user.setLastName(lname);

            UserDAO userDAO = new UserDAO();
            StudentDAO studentDAO = new StudentDAO();
            try {
                userDAO.register(user);
                if ("student".equals(role)) {
                    String studentClass = request.getParameter("class");
                    String gender = request.getParameter("gender");
                    Student student = new Student();
                    student.setUserId(user.getId());
                    student.setStudentClass(studentClass != null ? studentClass : "BCA");
                    student.setGender(gender != null ? gender : "male");
                    studentDAO.addStudent(student);
                }
                message = "Registration successful!";
                response.sendRedirect("index.jsp");
                return;
            } catch (Exception e) {
                message = "Registration failed: " + e.getMessage();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students' Attendance System - Register</title>
    <link rel="stylesheet" href="register.css">
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h1>📚 Attendance System</h1>
        </div>

        <div class="register-box">
            <div class="form-header">
                <h2>Create Account</h2>
                <p>Join our attendance system</p>
            </div>

            <form id="registerForm" action="register.jsp" method="post">
                <div class="form-group">
                    <label for="fname">First Name</label>
                    <input type="text" id="fname" name="fname" placeholder="Enter your first name" required>
                </div>

                <div class="form-group">
                    <label for="lname">Last Name</label>
                    <input type="text" id="lname" name="lname" placeholder="Enter your last name" required>
                </div>

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Choose a username" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Create a password" required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                </div>

                <div class="form-group">
                    <label for="role">Role</label>
                    <select id="role" name="role" required>
                        <option value="">Select Role</option>
                        <option value="student">Student</option>
                        <option value="teacher">Teacher</option>
                    </select>
                </div>

                <div class="form-group" id="studentFields" style="display: none;">
                    <label for="class">Class</label>
                    <select id="class" name="class">
                        <option value="BCA">BCA</option>
                        <option value="BIT">BIT</option>
                        <option value="BE">BE</option>
                    </select>
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="other">Other</option>
                    </select>
                </div>

                <button type="submit" class="register-btn">Register</button>
            </form>

            <% if (message != null) { %>
                <p style="color: red;"><%= message %></p>
            <% } %>

            <div class="register-footer">
                <p>Already have an account? <a href="index.jsp">Login Here</a></p>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('role').addEventListener('change', function() {
            const studentFields = document.getElementById('studentFields');
            if (this.value === 'student') {
                studentFields.style.display = 'block';
            } else {
                studentFields.style.display = 'none';
            }
        });
    </script>
</body>
</html>