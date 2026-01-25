package com.attendance.dao;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestConnection {
    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("DATABASE CONNECTION TEST");
        System.out.println("========================================");
        System.out.println("MySQL Version: 8.0.42");
        System.out.println("Connector/J: 9.3.0");
        System.out.println("========================================");
        
        Connection conn = null;
        try {
            // 1. Test Driver Loading
            System.out.println("1. Testing JDBC Driver...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("   ✅ JDBC Driver loaded successfully");
            
            // 2. Test Connection
            System.out.println("2. Testing Database Connection...");
            conn = DatabaseConnection.getConnection();
            
            if (conn != null && !conn.isClosed()) {
                System.out.println("   ✅ Connection established");
                
                // 3. Get Database Info
                DatabaseMetaData meta = conn.getMetaData();
                System.out.println("   Database: " + conn.getCatalog());
                System.out.println("   URL: " + meta.getURL());
                System.out.println("   Driver: " + meta.getDriverName() + " v" + meta.getDriverVersion());
                System.out.println("   MySQL Server: " + meta.getDatabaseProductVersion());
                
                // 4. Test Simple Query
                System.out.println("3. Testing SQL Query...");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT 'Hello MySQL' as test_message");
                if (rs.next()) {
                    System.out.println("   ✅ Query successful: " + rs.getString("test_message"));
                }
                rs.close();
                stmt.close();
                
                // 5. Check if our database exists
                System.out.println("4. Checking database structure...");
                ResultSet databases = meta.getCatalogs();
                boolean dbExists = false;
                while (databases.next()) {
                    if ("attendance_system".equalsIgnoreCase(databases.getString(1))) {
                        dbExists = true;
                        break;
                    }
                }
                databases.close();
                
                if (dbExists) {
                    System.out.println("   ✅ Database 'attendance_system' exists");
                    
                    // Check tables
                    String[] types = {"TABLE"};
                    ResultSet tables = meta.getTables("attendance_system", null, "%", types);
                    int tableCount = 0;
                    System.out.println("   Tables found:");
                    while (tables.next()) {
                        tableCount++;
                        System.out.println("     - " + tables.getString("TABLE_NAME"));
                    }
                    tables.close();
                    
                    if (tableCount == 0) {
                        System.out.println("   ⚠️  No tables found. Need to run SQL script.");
                    }
                } else {
                    System.out.println("   ❌ Database 'attendance_system' NOT FOUND");
                    System.out.println("   ⚠️  Need to create database first");
                }
                
                System.out.println("========================================");
                System.out.println("✅ ALL TESTS PASSED!");
                System.out.println("Database connection is working correctly.");
                
            } else {
                System.out.println("   ❌ Connection failed - connection is null or closed");
            }
            
        } catch (ClassNotFoundException e) {
            System.out.println("❌ JDBC Driver not found: " + e.getMessage());
            System.out.println("⚠️  Make sure mysql-connector-j-9.3.0.jar is added to project");
        } catch (Exception e) {
            System.out.println("❌ ERROR: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    DatabaseConnection.closeConnection();
                    System.out.println("Connection closed.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        System.out.println("========================================");
    }
}