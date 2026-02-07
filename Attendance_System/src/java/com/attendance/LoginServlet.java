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
import java.sql.ResultSet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get data from the form
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        try {
            // 2. Connect to Database using your DBConnection class
            Connection conn = DBConnection.getConnection();
            
            // 3. SQL query to check if teacher exists
            String sql = "SELECT * FROM teachers WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("teacherId", rs.getInt("id")); // Store the unique ID
                session.setAttribute("teacherUser", user);
                response.sendRedirect("viewStudents.jsp");
            }
            else {
                // FAIL: Redirect back to login with a simple error flag
                response.sendRedirect("index.html?error=1");
            }
            
            conn.close();
        } catch (Exception e) {
            // This will print the error in the Apache Tomcat log console in NetBeans
            e.printStackTrace();
            // This will show the error on the webpage to help you debug
            response.getWriter().println("<h1>Database Error</h1>");
            response.getWriter().println("<p>" + e.getMessage() + "</p>");
        }
    }
}