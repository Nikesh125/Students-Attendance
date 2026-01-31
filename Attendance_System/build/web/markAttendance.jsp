<%@ page import="java.sql.*, com.attendance.DBConnection" %>
<%
    Integer tId = (Integer) session.getAttribute("teacherId");
    String f = request.getParameter("f");
    String s = request.getParameter("s");
    if (tId == null || f == null) { response.sendRedirect("viewStudents.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">Attendance: <%= f %> (Sem <%= s %>)</h4>
        </div>
        <div class="card-body">
            <form action="submitAttendance" method="POST">
                <input type="hidden" name="faculty" value="<%= f %>">
                <input type="hidden" name="semester" value="<%= s %>">
                <div class="mb-4" style="max-width: 250px;">
                    <label class="form-label fw-bold">Select Date</label>
                    <input type="date" name="attDate" id="dp" class="form-control" required>
                </div>
                <table class="table table-bordered">
                    <thead><tr><th>Symbol No</th><th>Name</th><th>Status</th></tr></thead>
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
                            int id = rs.getInt("student_id");
                    %>
                        <tr>
                            <td><%= rs.getString("roll_number") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td>
                                <input type="radio" name="status_<%=id%>" value="Present" checked> P
                                <input type="radio" name="status_<%=id%>" value="Absent" class="ms-3"> A
                            </td>
                        </tr>
                    <% } } catch(Exception e) { } %>
                    </tbody>
                </table>
                <button type="submit" class="btn btn-success">Save Attendance</button>
            </form>
        </div>
    </div>
    <script>document.getElementById('dp').valueAsDate = new Date();</script>
</body>
</html>