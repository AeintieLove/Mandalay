<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add History</title>
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div class="navbar">
        <div style="font-size:24px; font-weight:bold;">Mandalay Admin</div>
        <a href="admin_dashboard.jsp" style="color:white;">Back to Dashboard</a>
    </div>

    <div class="container" style="max-width: 600px; background: white; padding: 30px; margin-top: 30px; border-radius: 8px;">
        <h2 style="color: #004d40; text-align: center;">သမိုင်းကြောင်း အသစ်တင်ရန်</h2>
        
        <form action="AddHistoryServlet" method="post" enctype="multipart/form-data">
            
            <label>ခေါင်းစဉ် (Title):</label>
            <input type="text" name="title" required placeholder="ဥပမာ - မန္တလေးနန်းတွင်း တည်ဆောက်ခြင်း"> <br><br>
            
            <label>ဖြစ်ပျက်ခဲ့သည့် ခုနှစ်/ရက်စွဲ (Event Date):</label>
            <input type="text" name="event_date" required placeholder="ဥပမာ - ၁၈၅၇ ခုနှစ်"> <br><br>
            
            <label>အကြောင်းအရာ (Content):</label>
            <textarea name="content" rows="6" required placeholder="သမိုင်းကြောင်း အသေးစိတ် ရေးရန်..."></textarea> <br><br>

            <label>မှတ်တမ်းဓာတ်ပုံ (Image):</label>
            <input type="file" name="photo" required> <br><br>
            
            <button type="submit" class="btn" style="width: 100%;">Save History</button>
           <a href="admin_dashboard.jsp" style="display:block; text-align:center; color:#572805;">Adminစာမျက်နှာသို့ ပြန်သွားရန်</a>
        </form>
    </div>
</body>
</html>
