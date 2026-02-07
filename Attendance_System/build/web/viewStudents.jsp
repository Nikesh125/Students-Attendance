<%@ page import="java.sql.*, com.attendance.DBConnection" %>
<%
    Integer tId = (Integer) session.getAttribute("teacherId");
    if (tId == null) { response.sendRedirect("index.html"); return; }
    
    String f = request.getParameter("f"); 
    String s = request.getParameter("s"); 
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link href="style_css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
    <div class="d-flex justify-content-between mb-4">
        <h3>Dashboard: <%= session.getAttribute("teacherUser") %></h3>
        <a href="index.html" class="btn btn-danger">Logout</a>
    </div>

    <div class="card p-3 mb-4 bg-light shadow-sm">
        <form action="viewStudents.jsp" method="GET" class="row g-2">
            <div class="col-md-4">
                <select name="f" class="form-select" required>
                    <option value="BIT" <%= "BIT".equals(f)?"selected":"" %>>BIT</option>
                    <option value="BCA" <%= "BCA".equals(f)?"selected":"" %>>BCA</option>
                    <option value="BE" <%= "BE".equals(f)?"selected":"" %>>BE</option>
                </select>
            </div>
            <div class="col-md-4">
                <select name="s" class="form-select" required>
                    <% for(int i=1; i<=8; i++) { %>
                        <option value="<%= i %>" <%= String.valueOf(i).equals(s)?"selected":"" %>>Semester <%= i %></option>
                    <% } %>
                </select>
            </div>
            <div class="col-md-4">
                <button type="submit" class="btn btn-dark w-100">Load Class</button>
            </div>
        </form>
    </div>

    <% if (f != null && s != null) { %>
    <div class="card shadow">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0 text-uppercase"><%= f %> - Semester <%= s %></h5>
            <div>
                <a href="addStudent.jsp?f=<%=f%>&s=<%=s%>" class="btn btn-sm btn-light">Add Student</a>
                <a href="markAttendance.jsp?f=<%=f%>&s=<%=s%>" class="btn btn-sm btn-success">Mark Attendance</a>
                <a href="report.jsp?f=<%=f%>&s=<%=s%>" class="btn btn-sm btn-info text-white">Report</a>
            </div>
        </div>
        <table class="table table-hover mb-0">
            <thead><tr><th>Roll No</th><th>Name</th><th>Action</th></tr></thead>
            <tbody>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT * FROM students WHERE teacher_id=? AND faculty=? AND semester=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, tId);
                    ps.setString(2, f);
                    ps.setInt(3, Integer.parseInt(s));
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()) {
                        int studentId = rs.getInt("student_id");
            %>
                <tr id="row_<%= studentId %>">
                    <td><%= rs.getString("roll_number") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td>
                        <button type="button" class="btn btn-danger btn-sm" 
                                onclick="deleteStudent(event, <%= studentId %>)">Delete</button>
                        
                        <a href="edit.jsp?id=<%= studentId %>" class="btn btn-warning btn-sm">Edit</a>
                    </td>
                </tr>
            <% } } catch(Exception e) { out.print("Error: " + e.getMessage()); } %>
            </tbody>
        </table>
    </div>
    <% } %>

    <script src="style_js/bootstrap.bundle.min.js"></script>
    <script>
    function deleteStudent(event, id) {
        event.preventDefault(); // Stop any default behavior
        
        if(!confirm("Are you sure you want to delete this student?")) return;

        // Background call to the servlet
        fetch('deleteStudent?id=' + id)
        .then(response => {
            if(response.ok) {
                // Remove the row visually without refreshing
                const element = document.getElementById('row_' + id);
                element.style.transition = "0.4s";
                element.style.opacity = "0";
                setTimeout(() => element.remove(), 400);
            } else {
                alert("Failed to delete student from server.");
            }
        })
        .catch(err => console.error("Error:", err));
    }
    </script>
</body>
</html>