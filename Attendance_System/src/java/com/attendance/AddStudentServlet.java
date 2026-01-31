package com.attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/addStudent")
public class AddStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer teacherId = (Integer) session.getAttribute("teacherId");
        
        if (teacherId == null) {
            response.sendRedirect("index.html");
            return;
        }

        String name = request.getParameter("name");
        String roll = request.getParameter("roll");
        String faculty = request.getParameter("faculty");
        String semStr = request.getParameter("semester");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO students (name, roll_number, teacher_id, faculty, semester) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, roll);
            ps.setInt(3, teacherId);
            ps.setString(4, faculty);
            ps.setInt(5, Integer.parseInt(semStr));
            
            ps.executeUpdate();
            
            // Redirect back to dashboard showing the class you just added to
            response.sendRedirect("viewStudents.jsp?f=" + faculty + "&s=" + semStr);
            
        } catch (SQLIntegrityConstraintViolationException e) {
            // Specifically handles the "Roll Number already exists" error
            response.getWriter().println("<script>alert('Error: Roll number " + roll + " already exists in " + faculty + " Sem " + semStr + "'); window.history.back();</script>");
        } catch (Exception e) {
            response.getWriter().println("<h3>System Error: " + e.getMessage() + "</h3>");
        }
    }
}