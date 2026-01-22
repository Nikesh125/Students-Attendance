package com.attendance.model;

public class Student {
    private int id;
    private int userId;
    private String studentClass;
    private String gender;
    private User user; // Optional: to hold user details

    // Constructors, getters, setters
    public Student() {}

    public Student(int id, int userId, String studentClass, String gender) {
        this.id = id;
        this.userId = userId;
        this.studentClass = studentClass;
        this.gender = gender;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getStudentClass() { return studentClass; }
    public void setStudentClass(String studentClass) { this.studentClass = studentClass; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}