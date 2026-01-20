<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mandalay.DBConnection, java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>History of Mandalay</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <style>

        .history-container {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .history-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            flex-direction: column;
        }
        
        .history-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }
        
        .history-content {
            padding: 25px;
        }
        
        .event-year {
            background-color: #8d6e63; 
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 10px;
            font-size: 14px;
        }
        
        .history-card h2 {
            margin: 10px 0;
            color: #3e2723;
        }
        
        .history-card p {
            line-height: 1.8;
            color: #555;
            text-align: justify;
        }


        .read-more-btn {
            display: inline-block;
            margin-top: 15px;
            color: #00796b;
            text-decoration: none;
            font-weight: bold;
            border-bottom: 2px solid #00796b;
        }

        @media (min-width: 768px) {
            .history-card {
                flex-direction: row;
            }
            .history-card img {
                width: 40%;
                height: auto;
            }
            .history-content {
                width: 60%;
            }
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
			    <a href="login.jsp" class="btn" style="background:#ffca28; color:#333; padding:8px 20px; border-radius:20px;">Login</a>
            <% } else { %>
            	<a href="home.jsp">Home</a>
            	<a href="attractions.jsp">Attractions</a>
            	<a href="hotels.jsp">Hotels</a>
            	<a href="history.jsp">History</a>
            	<a href="music.jsp">Music</a>
                <% if("admin".equals(role)) { %>
                    <a href="admin_dashboard.jsp" style="color:cyan;">Admin Panel</a>
                <% } else { %>
                    <a href="account.jsp">My Account</a>
                <% } %>
                <a href="logout.jsp" style="color: #ef5350;">Logout</a>
            <% } %>
        </div>

    <div style="background:linear-gradient(135deg,  #00537A 0%,   #6CA3A2 100%); color: white; padding: 40px; text-align: center;">
        <h1 style="margin:0;">The Royal History</h1>
        <p>Journey through time into the golden era of Mandalay.</p>
    </div>

    <div class="history-container">
        
        <%
        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM history ORDER BY event_date ASC");
            
            while(rs.next()) {
        %>
            <div class="history-card">
                <img src="<%= rs.getString("image_url") %>" alt="Historical Image">
                <div class="history-content">
                    <span class="event-year"><%= rs.getString("event_date") %></span>
                    <h2><%= rs.getString("title") %></h2>
                    
                    <% 
                        String content = rs.getString("content");
                        if(content.length() > 200) {
                            content = content.substring(0, 200) + "...";
                        }
                    %>
                    <p><%= content %></p>
                    
                    </div>
            </div>
        <%
            }
            con.close();
        } catch(Exception e) {
        %>
            <div style="text-align:center; padding:50px; color:red;">
                <h3>Connection Error!</h3>
                <p><%= e.getMessage() %></p>
            </div>
        <%
        }
        %>

    </div>

</body>
</html>
