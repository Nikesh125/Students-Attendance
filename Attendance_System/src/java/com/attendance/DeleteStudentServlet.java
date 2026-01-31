package com.attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/deleteStudent")
public class DeleteStudentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the ID from the URL (e.g., deleteStudent?id=5)
        String id = request.getParameter("id");

        try (Connection conn = DBConnection.getConnection()) {
            // 2. SQL to delete the student
            String sql = "DELETE FROM students WHERE student_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ps.executeUpdate();
            
            // 3. Go back to the dashboard to see the updated list
            response.sendRedirect("viewStudents.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting student: " + e.getMessage());
        }
    }
}