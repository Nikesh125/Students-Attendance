<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.attendance.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"teacher".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial; background: #f5f5f5; }
        .header { background: #3498db; color: white; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .nav { background: white; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .nav a { margin-right: 20px; text-decoration: none; color: #3498db; }
        .card { background: white; padding: 25px; border-radius: 5px; margin-bottom: 20px; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }
        .btn-primary { background: #3498db; color: white; }
        .btn-success { background: #2ecc71; color: white; }
        .btn-danger { background: #e74c3c; color: white; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; }
        .form-control { padding: 10px; border: 1px solid #ddd; border-radius: 5px; width: 100%; }
        .status-toggle { padding: 5px 10px; border-radius: 3px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <h1>Mark Attendance</h1>
            <p>Welcome, <%= user.getFirstName() %> <%= user.getLastName() %> | Faculty: <%= user.getFaculty() %> | Semester: <%= user.getSemester() %></p>
        </div>
    </div>
    
    <div class="container">
        <div class="nav">
            <a href="${pageContext.request.contextPath}/pages/teacher-dashboard.jsp">Dashboard</a>
            <a href="${pageContext.request.contextPath}/attendance/mark" style="font-weight: bold;">Mark Attendance</a>
            <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
        </div>
        
        <div class="card">
            <h2>Mark Attendance for Today</h2>
            <p style="margin: 15px 0; color: #666;">
                Select date and mark attendance for your students.
            </p>
            
            <form>
                <div style="margin-bottom: 20px; max-width: 300px;">
                    <label style="display: block; margin-bottom: 8px; font-weight: bold;">Attendance Date</label>
                    <input type="date" class="form-control" value="2024-03-15">
                </div>
                
                <div style="margin-bottom: 20px;">
                    <button type="button" class="btn btn-success" onclick="markAllPresent()">Mark All Present</button>
                    <button type="button" class="btn btn-danger" onclick="markAllAbsent()">Mark All Absent</button>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>Roll No</th>
                            <th>Student Name</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody id="attendanceTable">
                        <!-- Students will be populated here -->
                        <tr>
                            <td>R1001</td>
                            <td>John Doe</td>
                            <td>
                                <button type="button" class="status-toggle" style="background: #2ecc71; color: white;" 
                                        onclick="toggleStatus(this)">Present</button>
                            </td>
                        </tr>
                        <tr>
                            <td>R1002</td>
                            <td>Jane Smith</td>
                            <td>
                                <button type="button" class="status-toggle" style="background: #e74c3c; color: white;" 
                                        onclick="toggleStatus(this)">Absent</button>
                            </td>
                        </tr>
                        <tr>
                            <td>R1003</td>
                            <td>Robert Johnson</td>
                            <td>
                                <button type="button" class="status-toggle" style="background: #2ecc71; color: white;" 
                                        onclick="toggleStatus(this)">Present</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                
                <div style="margin-top: 30px;">
                    <button type="submit" class="btn btn-primary" style="padding: 12px 30px;">Save Attendance</button>
                    <a href="${pageContext.request.contextPath}/pages/teacher-dashboard.jsp" class="btn" style="background: #95a5a6; color: white;">Cancel</a>
                </div>
            </form>
        </div>
        
        <div class="card">
            <h3>Instructions</h3>
            <ol style="margin: 15px 0 15px 20px;">
                <li>Select the date for attendance</li>
                <li>Click on status buttons to toggle between Present/Absent</li>
                <li>Use "Mark All" buttons for quick selection</li>
                <li>Click "Save Attendance" to save to database</li>
            </ol>
        </div>
    </div>
    
    <script>
        function toggleStatus(button) {
            if (button.textContent === 'Present') {
                button.textContent = 'Absent';
                button.style.background = '#e74c3c';
            } else {
                button.textContent = 'Present';
                button.style.background = '#2ecc71';
            }
        }
        
        function markAllPresent() {
            const buttons = document.querySelectorAll('.status-toggle');
            buttons.forEach(button => {
                button.textContent = 'Present';
                button.style.background = '#2ecc71';
            });
        }
        
        function markAllAbsent() {
            const buttons = document.querySelectorAll('.status-toggle');
            buttons.forEach(button => {
                button.textContent = 'Absent';
                button.style.background = '#e74c3c';
            });
        }
    </script>
</body>
</html>