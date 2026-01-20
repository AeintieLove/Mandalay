<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mandalay.DBConnection, java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
%>

<%!
public String clean(String input) {
    if (input == null) return "";
    return input.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
}
%>
<%
response.setHeader(
  "Content-Security-Policy",
  "default-src 'self'; " +
  "img-src 'self' data:; " +
  "style-src 'self' 'unsafe-inline'; " +
  "script-src 'self'; " +
  "object-src 'none'; " +
  "base-uri 'self'; " +
  "frame-ancestors 'none';"
);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mandalay Attractions</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <style>
        .page-header {
            background:linear-gradient(135deg,  #00537A 0%,   #6CA3A2 100%);
            background-size: cover;
            background-position: center;
            color: white;
            padding: 60px 20px;
            text-align: center;
            margin-bottom: 30px;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .search-bar { text-align: center; margin-bottom: 30px; }
        .search-input { padding: 10px; width: 300px; border: 1px solid #ddd; border-radius: 5px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 25px; }
        .card { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: transform 0.3s ease; display: flex; flex-direction: column; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.15); }
        .card img { width: 100%; height: 200px; object-fit: cover; }
        .card-body { padding: 20px; flex-grow: 1; display: flex; flex-direction: column; }
        .category-tag { background-color: #e0f2f1; color: #00695c; padding: 4px 10px; border-radius: 15px; font-size: 12px; font-weight: bold; display: inline-block; margin-bottom: 10px; width: fit-content; }
        .card h3 { margin: 0 0 10px; color: #333; font-size: 20px; }
        .location { color: #777; font-size: 14px; margin-bottom: 10px; display: flex; align-items: center; gap: 5px; }
        .description { color: #555; font-size: 14px; line-height: 1.6; margin-bottom: 20px; }
        .btn-detail { margin-top: auto; display: block; text-align: center; background-color: #004d40; color: white; padding: 10px; border-radius: 5px; text-decoration: none; font-weight: bold; transition: background 0.3s; }
        .btn-detail:hover { background-color: #00796b; }
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
    </div>

<div class="page-header">
    <h1>Explore Mandalay</h1>
    <p>ရှေးဟောင်းယဉ်ကျေးမှု နယ်မြေများနှင့် အထင်ကရနေရာများ</p>
</div>

<div class="container">

<form action="attractions.jsp" method="GET" class="search-bar" style="display:flex; gap:10px; justify-content:center;">
<%
    String p = request.getParameter("search");
    p = clean(p);
%>
<input type="text" name="search" class="search-input" value="<%= p %>" placeholder="နေရာများ ရှာဖွေရန်......">
<button type="submit" class="btn" style="padding:10px 20px;">Search</button>
</form>

<%
String q = request.getParameter("search");
if (q != null && !q.trim().isEmpty()) {
%>
  <p style="text-align:center;">
      မင်းကအဲ့တာရှာတာလား <b><%= clean(q) %></b>
  </p>
<%
}
%>

<div class="grid">
<%
try {
    Connection con = DBConnection.getConnection();
    String searchQuery = request.getParameter("search");
    String sql;
    PreparedStatement ps;

    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        sql = "SELECT * FROM attractions WHERE name LIKE ? OR location LIKE ? ORDER BY id DESC";
        ps = con.prepareStatement(sql);
        ps.setString(1, "%" + searchQuery + "%");
        ps.setString(2, "%" + searchQuery + "%");
    } else {
        sql = "SELECT * FROM attractions ORDER BY id DESC";
        ps = con.prepareStatement(sql);
    }

    ResultSet rs = ps.executeQuery();
    boolean found = false;

    while(rs.next()) {
        found = true;
%>
    <div class="card">
        <img src="<%= clean(rs.getString("image_url")) %>" alt="Place" style="height:200px; width:100%; object-fit:cover;">
        <div class="card-content">
            <span style="background:#e0f2f1; color:#00695c; padding:3px 8px; border-radius:4px; font-size:12px; font-weight:bold;">
                <%= clean(rs.getString("category")) %>
            </span>
            <h3 style="margin:10px 0;"><%= clean(rs.getString("name")) %></h3>
            <p style="color:#666; font-size:14px;">
                <%= clean(rs.getString("location")) %>
            </p>

            <%
            if (session.getAttribute("user") != null) {
            %>
                <a href="attraction-detail.jsp?id=<%= rs.getInt("id") %>" class="btn" style="display:block; text-align:center; margin-top:10px;">
                    View Details
                </a>
            <%
            } else {
            %>
                <a href="login.jsp"
                   onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');"
                   class="btn" style="display:block; text-align:center; margin-top:10px;">
                    View Details
                </a>
            <%
            }
            %>
        </div>
    </div>
<%
    }

    if(!found) {
%>
    <p style="text-align:center; grid-column: 1/-1; color: red;">
        "<%= clean(searchQuery) %>" နှင့် ပတ်သက်သော အချက်အလက် မတွေ့ရှိပါ။
    </p>
<%
    }

    con.close();
} catch(Exception e) {
    e.printStackTrace();
}
%>
</div>
</div>

</body>
</html>