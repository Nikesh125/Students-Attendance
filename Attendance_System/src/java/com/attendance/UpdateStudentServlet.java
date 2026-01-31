package com.attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/updateStudent")
public class UpdateStudentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer teacherId = (Integer) session.getAttribute("teacherId");
        
        String sId = request.getParameter("student_id");
        String name = request.getParameter("name");
        String roll = request.getParameter("roll");

        if (teacherId == null) { response.sendRedirect("index.html"); return; }

        try (Connection conn = DBConnection.getConnection()) {
            // Update only if student belongs to this teacher
            String sql = "UPDATE students SET name=?, roll_number=? WHERE student_id=? AND teacher_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, roll);
            ps.setInt(3, Integer.parseInt(sId));
            ps.setInt(4, teacherId);
            
            ps.executeUpdate();
            response.sendRedirect("viewStudents.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}