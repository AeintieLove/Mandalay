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
        <h2>နေရာအသစ် ထည့်သွင်းရန်</h2>
        <form action="AddAttractionServlet" method="post">
            <label>နေရာအမည်:</label><br>
            <input type="text" name="name" required style="width:100%; padding:8px;"><br><br>
            
            <label>အမျိုးအစား (Category):</label><br>
            <select name="category" style="width:100%; padding:8px;">
                <option value="ဘုရား">ဘုရား</option>
                <option value="အထင်ကရနေရာ">အထင်ကရနေရာ</option>
                <option value="ပန်းခြံ">ပန်းခြံ</option>
            </select><br><br>
            
            <label>တည်နေရာ (Location):</label><br>
            <input type="text" name="location" required style="width:100%; padding:8px;"><br><br>
            
            <label>ဓာတ်ပုံ Link (Image URL):</label><br>
            <input type="file" name="image" required style="width:100%; padding:8px;"><br><br>
            
            <label>အကြောင်းအရာ (Description):</label><br>
            <textarea name="desc" rows="5" style="width:100%;"></textarea><br><br>
            
            <button type="submit" class="btn">Save Data</button>
              <a href="admin_dashboard.jsp" style="display:block; text-align:center; color:#572805;">Adminစာမျက်နှာသို့ ပြန်သွားရန်</a>
        </form>
    </div>
</body>
</html>
