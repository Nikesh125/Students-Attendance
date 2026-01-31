<%@ page import="java.sql.*, com.attendance.DBConnection" %>
<%
    Integer tId = (Integer) session.getAttribute("teacherId");
    String sId = request.getParameter("id");
    if (tId == null || sId == null) { response.sendRedirect("viewStudents.jsp"); return; }
    
    String name = "";
    String roll = "";

    try (Connection conn = DBConnection.getConnection()) {
        // Only fetch if the student belongs to THIS teacher (Security!)
        String sql = "SELECT * FROM students WHERE student_id = ? AND teacher_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(sId));
        ps.setInt(2, tId);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            name = rs.getString("name");
            roll = rs.getString("roll_number");
        } else {
            response.sendRedirect("viewStudents.jsp"); return;
        }
    } catch(Exception e) { out.print(e.getMessage()); }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <div class="col-md-6 offset-md-3 card shadow p-4">
        <h3>Update Student Details</h3>
        <form action="updateStudent" method="POST">
            <input type="hidden" name="student_id" value="<%= sId %>">
            <div class="mb-3">
                <label class="form-label">Student Name</label>
                <input type="text" name="name" value="<%= name %>" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Roll Number</label>
                <input type="text" name="roll" value="<%= roll %>" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Student</button>
            <a href="viewStudents.jsp" class="btn btn-link text-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>