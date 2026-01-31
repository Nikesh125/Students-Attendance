<!DOCTYPE html>
<html>
<head>
    <title>Add Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <div class="col-md-6 offset-md-3 card shadow p-4">
        <h3 class="mb-4">Register New Student</h3>
        <form action="addStudent" method="POST">
            <div class="mb-3">
                <label class="form-label fw-bold">Full Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Symbol Number</label>
                <input type="text" name="roll" class="form-control" required>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Faculty</label>
                    <select name="faculty" class="form-select">
                        <option value="BIT">BIT</option>
                        <option value="BCA">BCA</option>
                        <option value="BE">BE</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Semester</label>
                    <select name="semester" class="form-select">
                        <% for(int i=1; i<=8; i++) { %>
                            <option value="<%= i %>">Semester <%= i %></option>
                        <% } %>
                    </select>
                </div>
            </div>
            <hr>
            <button type="submit" class="btn btn-primary w-100">Save Student</button>
            <a href="viewStudents.jsp" class="btn btn-link w-100 mt-2 text-secondary text-decoration-none">Back to Dashboard</a>
        </form>
    </div>
</body>
</html>