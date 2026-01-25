<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Attendance System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            text-align: center;
            color: white;
            max-width: 800px;
        }
        
        h1 {
            font-size: 48px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        p {
            font-size: 20px;
            margin-bottom: 40px;
            opacity: 0.9;
        }
        
        .buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-top: 50px;
        }
        
        .btn {
            padding: 18px 40px;
            font-size: 18px;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary {
            background: white;
            color: #667eea;
        }
        
        .btn-outline {
            background: transparent;
            color: white;
            border: 2px solid white;
        }
        
        .btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        
        .features {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin-top: 60px;
            flex-wrap: wrap;
        }
        
        .feature {
            background: rgba(255,255,255,0.1);
            padding: 25px;
            border-radius: 10px;
            width: 200px;
            backdrop-filter: blur(10px);
        }
        
        .feature-icon {
            font-size: 40px;
            margin-bottom: 15px;
        }
        
        .feature h3 {
            margin-bottom: 10px;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Student Attendance System</h1>
        <p>Efficient attendance tracking for educational institutions</p>
        
        <div class="buttons">
            <a href="${pageContext.request.contextPath}/pages/login.jsp" class="btn btn-primary">Login</a>
            <a href="${pageContext.request.contextPath}/pages/register.jsp" class="btn btn-outline">Register</a>
        </div>
        
        <div class="features">
            <div class="feature">
                <div class="feature-icon">📊</div>
                <h3>Attendance Tracking</h3>
                <p>Real-time monitoring</p>
            </div>
            <div class="feature">
                <div class="feature-icon">🎓</div>
                <h3>Board Eligibility</h3>
                <p>80% requirement check</p>
            </div>
            <div class="feature">
                <div class="feature-icon">🔒</div>
                <h3>Secure Access</h3>
                <p>Role-based permissions</p>
            </div>
        </div>
    </div>
</body>
</html>