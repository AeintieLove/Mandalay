<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mandalay.DBConnection, java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Damage Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <style>
        .detail-container { max-width: 1000px; margin: 40px auto; padding: 20px; }

        .comparison-wrapper {
            display: flex; gap: 20px; margin-bottom: 30px;
        }
        .image-box {
            flex: 1; position: relative; overflow: hidden; border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .image-box img {
            width: 100%; height: 350px; object-fit: cover; transition: transform 0.5s;
        }
        .image-box:hover img { transform: scale(1.05); }
        
        .label {
            position: absolute; top: 20px; left: 20px;
            padding: 8px 15px; color: white; font-weight: bold; border-radius: 5px;
            text-transform: uppercase; letter-spacing: 1px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.3);
        }
        .label-before { background: #2e7d32; }
        .label-after { background: #c62828;}

        .info-section {
            background: white; padding: 30px; border-radius: 10px;
            border-left: 5px solid #ffca28;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        @media (max-width: 768px) {
            .comparison-wrapper { flex-direction: column; }
        }
    </style>
</head>
<body>
<div class="navbar">
        <div style="font-size:24px; font-weight:bold; display:flex; align-items:center; gap:10px;">
            <i class="fas fa-pagelines" style="color:#ffca28;"></i> Mandalay Travel
        </div>
        <div class="nav-links">
        	<% if(user == null) { %>
            	<a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">Home</a>
            	<a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">Attractions</a>
            	<a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">Hotels</a>
            	<a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">History</a>
            	<a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">Music</a>
            	<a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">Back to Logs</a>
			    <a href="login.jsp" class="btn" style="background:#ffca28; color:#333; padding:8px 20px; border-radius:20px;">Login</a>
            <% } else { %>
            	<a href="home.jsp">Home</a>
            	<a href="attractions.jsp">Attractions</a>
            	<a href="hotels.jsp">Hotels</a>
            	<a href="history.jsp">History</a>
            	<a href="music.jsp">Music</a>
            	<a href="changes.jsp">Back to Logs</a>
                <% if("admin".equals(role)) { %>
                    <a href="admin_dashboard.jsp" style="color:cyan;">Admin Panel</a>
                <% } else { %>
                    <a href="account.jsp">My Account</a>
                <% } %>
                <a href="logout.jsp" style="color: #ef5350;">Logout</a>
            <% } %>
        </div>
    </div>


    <div class="detail-container">
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM disaster_logs WHERE id=?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if(rs.next()) {
        %>
            <h1 style="text-align:center; margin-bottom:30px; color:#111;"><%= rs.getString("location_name") %></h1>

            <div class="comparison-wrapper">
                <div class="image-box">
                    <span class="label label-before">Before (ယခင်)</span>
                    <img src="<%= rs.getString("before_img") %>" alt="Before">
                </div>

                <div class="image-box">
                    <span class="label label-after">After (ယခု)</span>
                    <img src="<%= rs.getString("after_img") %>" alt="After">
                </div>
            </div>

            <div class="info-section">
               <h3 style="color:#2e7d32;">ငလျင်မတိုင်မီ(Before Status)</h3>
                <p style="line-height:1.8; color:#555; margin-bottom:20px;">
                    <%= rs.getString("before_desc") %>
                </p>

                 <h3 style="color:#c62828;">⚠️ ငလျင်အပြီး ထိခိုက်ပျက်စီးမှု အခြေအနေ (Damage Report)</h3>
                <p style="line-height:1.8; color:#555;">
                    <%= rs.getString("damage_desc") %>
                </p>
                
                 <h3 style="color:#c62828;">🛠️️ ပြန်လည်ပြုပြင်ထိန်းသိမ်းမှု အခြေအနေ (Recovery Status)</h3>
                <p style="line-height:1.8; color:#555;">
                    <%= rs.getString("recovery_status") %>
                </p>
                
                <div style="margin-top:20px; font-size:14px; color:#777;">
                    <strong>Event Date:</strong> <%= rs.getString("event_date") %>
                </div>
            </div>

        <%
                }
            } catch(Exception e) { e.printStackTrace(); }
        %>
    </div>

</body>
</html>
