package com.attendance.servlet;

import com.attendance.dao.StudentDAO;
import com.attendance.dao.UserDAO;
import com.attendance.model.Student;
import com.attendance.model.User;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // Hash in production
        user.setRole(role);
        user.setFirstName(fname);
        user.setLastName(lname);

        UserDAO userDAO = new UserDAO();
        StudentDAO studentDAO = new StudentDAO();
        try {
            userDAO.register(user);
            if ("student".equals(role)) {
                // Assume class and gender from form or default
                String studentClass = request.getParameter("class"); // Add to form if needed
                String gender = request.getParameter("gender"); // Add to form
                Student student = new Student();
                student.setUserId(user.getId());
                student.setStudentClass(studentClass != null ? studentClass : "BCA");
                student.setGender(gender != null ? gender : "male");
                studentDAO.addStudent(student);
            }
            response.sendRedirect("index.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}