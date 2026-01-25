package com.attendance.dao;

import com.attendance.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    // Create new user (registration)
    public boolean createUser(User user) {
        String query = "INSERT INTO users (username, password, role, first_name, last_name, " +
                      "faculty, semester, phone, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword()); // In production, hash the password
            pstmt.setString(3, user.getRole());
            pstmt.setString(4, user.getFirstName());
            pstmt.setString(5, user.getLastName());
            pstmt.setString(6, user.getFaculty());
            pstmt.setInt(7, user.getSemester());
            pstmt.setString(8, user.getPhone());
            pstmt.setString(9, user.getEmail());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0 && user.getRole().equals("student")) {
                // If user is student, also insert into students table
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int userId = rs.getInt(1);
                    insertStudent(userId, user.getUsername());
                }
                rs.close();
            }
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private void insertStudent(int userId, String username) throws SQLException {
        String query = "INSERT INTO students (student_id, roll_number) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            // Generate roll number from username + ID
            pstmt.setString(2, "R" + userId);
            pstmt.executeUpdate();
        }
    }
    
    // Authenticate user (login)
    public User authenticate(String username, String password) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setFaculty(rs.getString("faculty"));
                user.setSemester(rs.getInt("semester"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                
                rs.close();
                return user;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Check if username exists
    public boolean usernameExists(String username) {
        String query = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                rs.close();
                return count > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Get all students for a teacher's faculty
    public List<User> getStudentsByFaculty(String faculty, int semester) {
        List<User> students = new ArrayList<>();
        String query = "SELECT u.*, s.roll_number FROM users u " +
                      "LEFT JOIN students s ON u.id = s.student_id " +
                      "WHERE u.role = 'student' AND u.faculty = ? AND u.semester = ? " +
                      "ORDER BY s.roll_number";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, faculty);
            pstmt.setInt(2, semester);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setFaculty(rs.getString("faculty"));
                user.setSemester(rs.getInt("semester"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                
                students.add(user);
            }
            
            rs.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return students;
    }
}