<%@ page import="com.attendance.dao.UserDAO, com.attendance.model.User" %>
<%
    String error = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.authenticate(username, password);
            if (user != null) {
                session.setAttribute("user", user);
                if ("teacher".equals(user.getRole())) {
                    response.sendRedirect("dashboard.jsp");
                } else {
                    response.sendRedirect("student.jsp");
                }
                return;
            } else {
                error = "Invalid credentials";
            }
        } catch (Exception e) {
            error = "Database error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students' Attendance System - Login</title>
    <link rel="stylesheet" href="login.css">
</head> 
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>📚 Attendance System</h1>
        </div>

        <div class="login-box">
            <div class="form-header">
                <h2>Welcome Back!</h2>
                <p>Login to your account</p>
            </div>

            <form id="loginForm" action="index.jsp" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>

                <button type="submit" class="login-btn">Login</button>
            </form>

            <% if (error != null) { %>
                <p style="color: red;"><%= error %></p>
            <% } %>

            <div class="login-footer">
                <p>Don't have an account? <a href="register.jsp">Register Now</a></p>
            </div>
        </div>
    </div>
</body>
</html>