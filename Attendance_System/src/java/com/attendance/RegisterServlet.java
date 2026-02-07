package com.attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/registerTeacher")
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            // SQL query to add a new teacher
            String sql = "INSERT INTO teachers (username, password) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                // Success: Send back to login page
                response.sendRedirect("index.html?msg=success");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error during registration: " + e.getMessage());
        }
    }
}