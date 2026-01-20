<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Mandalay Travel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color:#C8EEF7; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 350px; text-align: center; }
        h2 { color: #572805; margin-bottom: 20px; }
        input { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background-color:linear-gradient(45deg, #00537A, #00695c); color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; }
        button:hover { background-color: #572805; }
        .error { color: red; font-size: 14px; margin-bottom: 10px; }
        a { text-decoration: none; color: #572805; font-weight: bold; }
    </style>
</head>
<body>

    <div class="login-box">
        <h2>Mandalay Travel</h2>
        <p>Sign in to your account</p>
        
        <% if(request.getParameter("error") != null) { %>
            <div class="error">Email သို့မဟုတ် Password မှားယွင်းနေပါသည်။</div>
        <% } %>

        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        
        <br>
        <p>အကောင့်မရှိသေးဘူးလား? <a href="register.jsp">Register လုပ်ရန်</a></p>
        <p><a href="index.jsp">ပင်မစာမျက်နှာသို့ ပြန်သွားမည်</a></p>
    </div>

</body>
</html>
