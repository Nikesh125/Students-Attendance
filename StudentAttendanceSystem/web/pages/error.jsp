<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body { font-family: Arial; padding: 50px; text-align: center; background: #f5f5f5; }
        .error-container { background: white; padding: 40px; border-radius: 10px; max-width: 600px; margin: 0 auto; }
        .error-icon { font-size: 60px; color: #e74c3c; margin-bottom: 20px; }
        .btn { background: #3498db; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 10px; }
        .btn:hover { background: #2980b9; }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <h1>Oops! Something went wrong</h1>
        
        <div style="margin: 30px 0; padding: 20px; background: #fee; border-radius: 5px; text-align: left;">
            <%
                String errorCode = request.getParameter("errorCode");
                if (errorCode != null) {
                    out.println("<strong>Error Code:</strong> " + errorCode + "<br><br>");
                }
                if (exception != null) {
                    out.println("<strong>Error Message:</strong> " + exception.getMessage());
                }
            %>
        </div>
        
        <p>Please try the following:</p>
        <div style="margin: 30px 0;">
            <a href="${pageContext.request.contextPath}/" class="btn">Go to Home Page</a>
            <a href="${pageContext.request.contextPath}/pages/login.jsp" class="btn">Go to Login</a>
            <a href="javascript:history.back()" class="btn" style="background: #95a5a6;">Go Back</a>
        </div>
        
        <p style="color: #666; margin-top: 30px; font-size: 14px;">
            If the problem persists, please contact the system administrator.
        </p>
    </div>
</body>
</html>
