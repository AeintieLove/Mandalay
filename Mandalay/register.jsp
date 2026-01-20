<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mandalay</title>
 <style>
       body { font-family: 'Segoe UI', sans-serif; background-color: #C8EEF7;; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .register-box { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 350px; text-align: center; }
        h2 { color: #572805; margin-bottom: 20px; }
        input { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background-color: linear-gradient(45deg, #00537A, #00695c); color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; }
        button:hover { background-color: #572805; }
        .error { color: red; font-size: 14px; margin-bottom: 10px; }
        a { text-decoration: none; color: #572805; font-weight: bold; }
    </style>
</head>
<body>
	
    <div class="register-box">
        <h2>Mandalay Travel</h2>
        <p>Register to your account</p>
	<form action="RegisterServlet" method="post">
    <input type="text" name="username" placeholder="Username" required><br>
    <input type="email" name="email" placeholder="Email" required><br>
    <input type="password" name="password" placeholder="Password" required><br>
    <button type="submit">Sign Up</button>
     <p><a href="index.jsp">ပင်မစာမျက်နှာသို့ ပြန်သွားမည်</a></p>
    </div>
</form>
	
</body>
</html>