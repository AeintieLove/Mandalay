<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head><title>Add Attraction</title> <link rel="stylesheet" href="style.css"></head>
<body>
    <div class="container" style="max-width: 500px; background: white; padding: 30px; margin-top: 30px;">
        <h2>ဟိုတယ်အသစ် ထည့်သွင်းရန်</h2>
        <form action="AddHotelsServlet" method="post">
            <label>အမည်:</label><br>
            <input type="text" name="name" required style="width:100%; padding:8px;"><br><br>
            
            <label>Rating:</label><br>
            <input type="text" name="rating" step="0.1" min="1" max="5" required placeholder="4.5" required style="width:100%; padding:8px;"><br><br>
            
            <label>ဈေးနှုန်း(Price Range):</label><br>
            <textarea type="text" name="price" required placeholder="ဥပမာ - ၅သောင်း- ၈သောင်း" style="width:100%;"></textarea><br><br>
            
            <label>ဆက်သွယ်ရန် ဖုန်းနံပါတ်(Phone Number):</label><br>
            <textarea type="text" name="contact" required placeholder="09-xxxxxxxxx" style="width:100%;"></textarea><br><br>
            
            <label>ဓာတ်ပုံ Link (Image URL):</label><br>
            <input type="file" name="image" required style="width:100%; padding:8px;"><br><br>
            
            <button type="submit" class="btn">Save Data</button>
           <a href="admin_dashboard.jsp" style="display:block; text-align:center; color:#572805;">Adminစာမျက်နှာသို့ ပြန်သွားရန်</a>
        </form>
    </div>
</body>
</html>
