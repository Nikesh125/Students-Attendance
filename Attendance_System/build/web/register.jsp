<!DOCTYPE html>
<html>
<head>
    <title>Teacher Registration</title>
    <link href="style_css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4 card p-4 shadow">
            <h3>Teacher Sign Up</h3>
            <form action="registerTeacher" method="POST">
                <div class="mb-3">
                    <label>Create Username</label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Create Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-info w-100 text-white">Register</button>
            </form>
        </div>
    </div>
</body>
</html>