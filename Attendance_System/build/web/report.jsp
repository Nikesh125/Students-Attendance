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
    <title>Attendance Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-info text-white d-flex justify-content-between">
            <h4 class="mb-0">Report: <%= f %> - Sem <%= s %></h4>
            <a href="viewStudents.jsp?f=<%=f%>&s=<%=s%>" class="btn btn-sm btn-light">Back</a>
        </div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                    <tr><th>Symbol No</th><th>Name</th><th>Present</th><th>Absent</th><th>%</th></tr>
                </thead>
                <tbody>
                <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT s.name, s.roll_number, " +
                                 "COUNT(CASE WHEN a.status='Present' THEN 1 END) as p, " +
                                 "COUNT(CASE WHEN a.status='Absent' THEN 1 END) as a " +
                                 "FROM students s LEFT JOIN attendance a ON s.student_id = a.student_id " +
                                 "WHERE s.teacher_id=? AND s.faculty=? AND s.semester=? " +
                                 "GROUP BY s.student_id";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, tId);
                    ps.setString(2, f);
                    ps.setInt(3, Integer.parseInt(s));
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()){
                        int p = rs.getInt("p");
                        int a = rs.getInt("a");
                        int total = p + a;
                        double percent = (total > 0) ? (p * 100.0 / total) : 0;
                %>
                    <tr>
                        <td><%= rs.getString("roll_number") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td class="text-success"><%= p %></td>
                        <td class="text-danger"><%= a %></td>
                        <td><%= String.format("%.1f", percent) %>%</td>
                    </tr>
                <% } } catch(Exception e) { out.print(e.getMessage()); } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>