package com.attendance.dao;

import com.attendance.model.Attendance;
import com.attendance.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {
    public void markAttendance(Attendance attendance) throws SQLException {
        String sql = "INSERT INTO attendance (student_id, date, status, marked_by) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, attendance.getStudentId());
            stmt.setDate(2, attendance.getDate());
            stmt.setString(3, attendance.getStatus());
            stmt.setInt(4, attendance.getMarkedBy());
            stmt.setString(5, attendance.getStatus());
            stmt.executeUpdate();
        }
    }

    public List<Attendance> getAttendanceByDateAndClass(Date date, String studentClass) throws SQLException {
        List<Attendance> attendances = new ArrayList<>();
        String sql = "SELECT a.* FROM attendance a JOIN students s ON a.student_id = s.id WHERE a.date = ? AND s.class = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, date);
            stmt.setString(2, studentClass);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                attendances.add(new Attendance(rs.getInt("id"), rs.getInt("student_id"), rs.getDate("date"),
                                               rs.getString("status"), rs.getInt("marked_by")));
            }
        }
        return attendances;
    }

    public int getPresentCount(Date date, String studentClass) throws SQLException {
        String sql = "SELECT COUNT(*) FROM attendance a JOIN students s ON a.student_id = s.id WHERE a.date = ? AND s.class = ? AND a.status = 'present'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, date);
            stmt.setString(2, studentClass);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int getTotalStudents(String studentClass) throws SQLException {
        String sql = "SELECT COUNT(*) FROM students WHERE class = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentClass);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }
}