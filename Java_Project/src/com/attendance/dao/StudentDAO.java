package com.attendance.dao;

import com.attendance.model.Student;
import com.attendance.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    public void addStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (user_id, class, gender) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, student.getUserId());
            stmt.setString(2, student.getStudentClass());
            stmt.setString(3, student.getGender());
            stmt.executeUpdate();
        }
    }

    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT s.*, u.first_name, u.last_name FROM students s JOIN users u ON s.user_id = u.id";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Student student = new Student(rs.getInt("id"), rs.getInt("user_id"), rs.getString("class"), rs.getString("gender"));
                User user = new User();
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                student.setUser(user);
                students.add(student);
            }
        }
        return students;
    }

    public List<Student> getStudentsByClass(String studentClass) throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT s.*, u.first_name, u.last_name FROM students s JOIN users u ON s.user_id = u.id WHERE s.class = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentClass);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Student student = new Student(rs.getInt("id"), rs.getInt("user_id"), rs.getString("class"), rs.getString("gender"));
                User user = new User();
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                student.setUser(user);
                students.add(student);
            }
        }
        return students;
    }
}