<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if(session.getAttribute("user") == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .admin-panel { max-width: 1000px; margin: 30px auto; padding: 20px; background: white; border-radius: 8px; }
        .admin-btn { display: block; width: 980px; padding: 15px; margin: 10px 0; background:linear-gradient(135deg,  #00537A 0%,   #6CA3A2 100%); color: white; text-align: center; border-radius: 5px; font-size: 18px; }
        .admin-btn:hover { background: #333333; }
        .logout { color: red; float: right; }
    </style>
</head>
<body>
    <div class="navbar">
        <div>Mandalay Admin Panel</div>
        <div>
            Welcome, <%= session.getAttribute("user") %>
            <a href="logout.jsp" style="margin-left: 20px; color: yellow;">Logout</a>
        </div>
    </div>

    <div class="admin-panel">
        <h2 style="text-align:center;">Admin Control Center</h2>
        <hr>
        
        <h3>Manage Content</h3>
        <a href="add_attraction.jsp" class="admin-btn">+ နေရာသစ်များ ထည့်ရန် (Add Attraction)</a>
        <a href="add_hotels.jsp" class="admin-btn">+ ဟိုတယ်အသစ် ထည့်ရန် (Add Hotel)</a>
        <a href="add_history.jsp" class="admin-btn">+ သမိုင်းကြောင်း ထည့်ရန် (Add History)</a>
        
        <br>
        <a href="home.jsp" style="display:block; text-align:center; color:#572805;">Website ပင်မစာမျက်နှာသို့ ပြန်သွားရန်</a>
    </div>

</body>
</html>
