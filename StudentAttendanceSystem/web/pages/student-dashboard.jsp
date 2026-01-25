<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.attendance.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"student".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial; background: #f5f5f5; }
        .header { background: #2ecc71; color: white; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .nav { background: white; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .nav a { margin-right: 20px; text-decoration: none; color: #2ecc71; }
        .card { background: white; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .stats { display: flex; gap: 20px; margin: 20px 0; }
        .stat-box { flex: 1; text-align: center; padding: 20px; border-radius: 5px; }
        .present { background: #d4ffd4; border-left: 4px solid #2ecc71; }
        .absent { background: #ffe6e6; border-left: 4px solid #e74c3c; }
        .total { background: #e6f3ff; border-left: 4px solid #3498db; }
        .percentage { background: #fff8e6; border-left: 4px solid #f39c12; }
        .btn { background: #2ecc71; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <h1>Student Dashboard</h1>
            <p>Welcome, <%= user.getFirstName() %> <%= user.getLastName() %> | Roll No: R<%= user.getId() %> | Faculty: <%= user.getFaculty() %> | Semester: <%= user.getSemester() %></p>
        </div>
    </div>
    
    <div class="container">
        <div class="nav">
            <a href="${pageContext.request.contextPath}/pages/student-dashboard.jsp">Dashboard</a>
            <a href="${pageContext.request.contextPath}/attendance/records">My Attendance</a>
            <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
        </div>
        
        <div class="card">
            <h2>Attendance Statistics</h2>
            <div class="stats">
                <div class="stat-box present">
                    <h3>24</h3>
                    <p>Present Days</p>
                </div>
                <div class="stat-box absent">
                    <h3>6</h3>
                    <p>Absent Days</p>
                </div>
                <div class="stat-box total">
                    <h3>30</h3>
                    <p>Working Days</p>
                </div>
                <div class="stat-box percentage">
                    <h3>80%</h3>
                    <p>Attendance %</p>
                </div>
            </div>
        </div>
        
        <div class="card">
            <h2>Board Exam Eligibility</h2>
            <div style="text-align: center; padding: 30px;">
                <div style="font-size: 60px; margin-bottom: 20px;">✅</div>
                <h3 style="color: #2ecc71; margin-bottom: 10px;">Eligible for Board Exams</h3>
                <p>Your current attendance meets the 80% requirement.</p>
                <p style="margin-top: 20px; color: #666;">Minimum required: 80% attendance</p>
            </div>
        </div>
        
        <div class="card">
            <h2>Recent Attendance</h2>
            <table style="width: 100%; border-collapse: collapse; margin-top: 15px;">
                <tr style="background: #f8f9fa;">
                    <th style="padding: 12px; text-align: left;">Date</th>
                    <th style="padding: 12px; text-align: left;">Status</th>
                </tr>
                <tr>
                    <td style="padding: 12px; border-bottom: 1px solid #eee;">2024-03-15</td>
                    <td style="padding: 12px; border-bottom: 1px solid #eee;">
                        <span style="color: #2ecc71; font-weight: bold;">Present</span>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 12px; border-bottom: 1px solid #eee;">2024-03-14</td>
                    <td style="padding: 12px; border-bottom: 1px solid #eee;">
                        <span style="color: #e74c3c; font-weight: bold;">Absent</span>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 12px; border-bottom: 1px solid #eee;">2024-03-13</td>
                    <td style="padding: 12px; border-bottom: 1px solid #eee;">
                        <span style="color: #2ecc71; font-weight: bold;">Present</span>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>