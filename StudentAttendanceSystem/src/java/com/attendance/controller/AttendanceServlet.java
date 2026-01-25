package com.attendance.controller;

import com.attendance.dao.UserDAO;
import com.attendance.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/attendance/*")
public class AttendanceServlet extends HttpServlet {
    private UserDAO userDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String action = request.getPathInfo();
        
        if (action == null) {
            // Show attendance page based on role
            if (user.getRole().equals("teacher")) {
                response.sendRedirect(request.getContextPath() + "/pages/mark-attendance.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/student-dashboard.jsp");
            }
            return;
        }
        
        switch (action) {
            case "/mark":
                // For now, just show a simple page
                request.getRequestDispatcher("/pages/mark-attendance.jsp").forward(request, response);
                break;
            case "/records":
                // Show attendance records
                response.sendRedirect(request.getContextPath() + "/pages/student-dashboard.jsp");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/dashboard");
                break;
        }
    }
}