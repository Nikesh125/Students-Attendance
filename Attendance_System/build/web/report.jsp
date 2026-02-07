<%@ page import="java.sql.*, com.attendance.DBConnection, java.util.Calendar" %>
<%
    Integer tId = (Integer) session.getAttribute("teacherId");
    String f = request.getParameter("f");
    String s = request.getParameter("s");
    
    // Get Month and Year from URL, default to current month/year if null
    Calendar now = Calendar.getInstance();
    String selectedMonth = request.getParameter("month");
    String selectedYear = request.getParameter("year");
    
    if (selectedMonth == null) selectedMonth = String.valueOf(now.get(Calendar.MONTH) + 1);
    if (selectedYear == null) selectedYear = String.valueOf(now.get(Calendar.YEAR));

    if (tId == null || f == null) { response.sendRedirect("viewStudents.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Attendance Report</title>
    <link href="style_css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h4 class="mb-0">Monthly Report: <%= f %> (Sem <%= s %>)</h4>
        </div>
        <div class="card-body">
            <form method="GET" class="row g-3 mb-4 bg-light p-3 rounded border">
                <input type="hidden" name="f" value="<%= f %>">
                <input type="hidden" name="s" value="<%= s %>">
                
                <div class="col-md-4">
                    <label class="form-label fw-bold">Select Month</label>
                    <select name="month" class="form-select">
                        <% 
                           String[] months = {"January", "February", "March", "April", "May", "June", 
                                             "July", "August", "September", "October", "November", "December"};
                           for(int i=0; i<12; i++) { 
                        %>
                            <option value="<%= i+1 %>" <%= selectedMonth.equals(String.valueOf(i+1)) ? "selected" : "" %>><%= months[i] %></option>
                        <% } %>
                    </select>
                </div>
                
                <div class="col-md-4">
                    <label class="form-label fw-bold">Select Year</label>
                    <select name="year" class="form-select">
                        <% for(int y=2024; y<=2030; y++) { %>
                            <option value="<%= y %>" <%= selectedYear.equals(String.valueOf(y)) ? "selected" : "" %>><%= y %></option>
                        <% } %>
                    </select>
                </div>
                
                <div class="col-md-4 mt-auto">
                    <button type="submit" class="btn btn-primary w-100">View Report</button>
                    <a href="viewStudents.jsp?f=<%=f%>&s=<%=s%>" class="btn btn-outline-secondary w-100 mt-2">Back</a>
                </div>
            </form>

            <table class="table table-bordered table-striped">
                <thead class="table-secondary">
                    <tr>
                        <th>Roll No</th>
                        <th>Student Name</th>
                        <th class="text-center">Present in <%= months[Integer.parseInt(selectedMonth)-1] %></th>
                        <th class="text-center">Absent</th>
                        <th class="text-center">%</th>
                    </tr>
                </thead>
                <tbody>
                <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT s.name, s.roll_number, " +
                                 "COUNT(CASE WHEN a.status='Present' AND MONTH(a.date)=? AND YEAR(a.date)=? THEN 1 END) as p, " +
                                 "COUNT(CASE WHEN a.status='Absent' AND MONTH(a.date)=? AND YEAR(a.date)=? THEN 1 END) as a " +
                                 "FROM students s LEFT JOIN attendance a ON s.student_id = a.student_id " +
                                 "WHERE s.teacher_id=? AND s.faculty=? AND s.semester=? " +
                                 "GROUP BY s.student_id, s.roll_number, s.name";
                    
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(selectedMonth));
                    ps.setInt(2, Integer.parseInt(selectedYear));
                    ps.setInt(3, Integer.parseInt(selectedMonth));
                    ps.setInt(4, Integer.parseInt(selectedYear));
                    ps.setInt(5, tId);
                    ps.setString(6, f);
                    ps.setInt(7, Integer.parseInt(s));
                    
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
                        <td class="text-center text-success fw-bold"><%= p %></td>
                        <td class="text-center text-danger fw-bold"><%= a %></td>
                        <td class="text-center"><%= String.format("%.1f", percent) %>%</td>
                    </tr>
                <% } } catch(Exception e) { out.print("Error: " + e.getMessage()); } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>