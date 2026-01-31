package com.attendance;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/submitAttendance")
public class AttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("attDate");
        String f = request.getParameter("faculty");
        String s = request.getParameter("semester");
        Integer teacherId = (Integer) request.getSession().getAttribute("teacherId");

        try (Connection conn = DBConnection.getConnection()) {
            String studentQuery = "SELECT student_id FROM students WHERE teacher_id = ? AND faculty = ? AND semester = ?";
            PreparedStatement getStudents = conn.prepareStatement(studentQuery);
            getStudents.setInt(1, teacherId); getStudents.setString(2, f); getStudents.setInt(3, Integer.parseInt(s));
            ResultSet rs = getStudents.executeQuery();

            String sql = "INSERT INTO attendance (student_id, status, date) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE status = VALUES(status)";
            PreparedStatement ps = conn.prepareStatement(sql);

            while (rs.next()) {
                int id = rs.getInt("student_id");
                String status = request.getParameter("status_" + id);
                if (status != null) {
                    ps.setInt(1, id); ps.setString(2, status); ps.setString(3, date);
                    ps.addBatch();
                }
            }
            ps.executeBatch();
            response.sendRedirect("report.jsp?f=" + f + "&s=" + s);
        } catch (Exception e) { e.printStackTrace(); }
    }
}