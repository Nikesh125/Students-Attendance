<%@ page import="com.attendance.dao.AttendanceDAO, com.attendance.model.Attendance, java.sql.Date" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"teacher".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String[] presentIds = request.getParameterValues("present");
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        Date today = new Date(System.currentTimeMillis());
        try {
            // Mark all as absent first, then present for checked
            // For simplicity, assume all students, mark present for selected
            if (presentIds != null) {
                for (String id : presentIds) {
                    Attendance att = new Attendance();
                    att.setStudentId(Integer.parseInt(id));
                    att.setDate(today);
                    att.setStatus("present");
                    att.setMarkedBy(user.getId());
                    attendanceDAO.markAttendance(att);
                }
            }
            response.sendRedirect("dashboard.jsp");
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>