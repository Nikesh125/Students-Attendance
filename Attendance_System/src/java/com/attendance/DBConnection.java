package com.attendance; // Make sure this matches your package name
import java.sql.*;

public class DBConnection {
    // It MUST be "public static"
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/attendance", "root", "@Nikesh125");
    }
}