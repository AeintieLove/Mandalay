<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mandalay.DBConnection, java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mandalay Travel Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        .hero-section {
            background:linear-gradient(135deg,  #00537A 0%,   #6CA3A2 100%);
            background-size: cover;
            background-position: center;
            height: 500px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        .hero-title { font-size: 48px; font-weight: bold; text-shadow: 0 0 10px rgba(255, 202, 40, 0.5); margin-bottom: 10px; }
        .hero-subtitle { font-size: 20px; margin-bottom: 30px; opacity: 0.9; }
     
        .btn-hero {
            padding: 15px 35px;
            background-color: #7f5e1e; 
            color: #333;
            font-weight: bold;
            text-decoration: none;
            border-radius: 30px;
            font-size: 18px;
            transition: transform 0.3s, background 0.3s;
        }
        .btn-hero:hover { transform: scale(1.05); background-color: #d5b4b4; }
        .category-section {
            padding: 40px 20px;
            background: white;
            text-align: center;
            transform: translateY(-50px); 
            max-width: 900px;
            margin: 0 auto;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }
        .cat-item { text-decoration: none; color: #333; text-align: center; width: 120px; margin: 10px; transition: color 0.3s; }
        .cat-item:hover { color: #004d40; }
        .cat-icon {
            width: 60px; height: 60px;
            background:#f5f5f5;
            color: #333;
            border-radius: 50%;
            display: flex; justify-content: center; align-items: center;
            font-size: 24px;
            margin: 0 auto 10px;
            transition: background 0.3s, transform 0.3s;
        }
        .cat-item:hover .cat-icon { background: #c0a062; color: white; transform: rotate(10deg); }

        .section-title { text-align: center; margin: 40px 0 20px; color: #572805 ; }
        .grid-3 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto 50px;
            padding: 0 20px;
        }
        
     
        footer {
            background: #12212E;
            color: #cfd8dc;
            padding: 40px 20px;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <div style="font-size:24px; font-weight:bold; display:flex; align-items:center; gap:10px;">
            <i class="fas fa-pagelines"></i> Mandalay Travel
        </div>
        <div class="nav-links">

            <% if(user == null) { %>
                <a href="login.jsp" class="btn" style="background:#ffca28; color:#333; padding:5px 15px; border-radius:20px;">Login</a>
            <% } else { %>
                <% if("admin".equals(role)) { %>
                    <a href="admin_dashboard.jsp" style="color:cyan;">Admin Panel</a>
                <% } else { %>
                    <a href="account.jsp">My Account</a>
                <% } %>
                <a href="logout.jsp" style="color: #ef5350;">Logout</a>
            <% } %>
        </div>
    </div>

       <div class="hero-section">
        <div class="hero-title">Welcome to Mandalay</div>
        <div class="hero-subtitle">မြန်မာ့ယဉ်ကျေးမှု၏ မြို့တော် ရတနာပုံ</div>
        
        <%
            if (session.getAttribute("user") != null) {
        %>
            <a href="home.jsp" class="btn-hero">
                Start Exploring <i class="fas fa-arrow-right"></i>
            </a>
        <%
            } else {
        %>
            <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');" class="btn-hero" style="background-color:  #572805; color: #999;">
                🔒Start Exploring <i class="fas fa-lock"></i>
            </a>
        <%
            }
        %>
    </div>
     <div class="card">
                <img src="images/mandalay.jpeg" alt="Place" style="height:500px; width:100%; object-fit:cover;">
                <div class="card-content">
                   
                    <h3 style="margin:10px 0; text-align: center; "> မြန်မာ့ယဉ်ကျေးမှု၏ အသည်းနှလုံး မန္တလေးမြို့မှ ကြိုဆိုပါသည် </h3> 
                    <p style="color:#666; font-size:14px;">
							မြန်မာနိုင်ငံ၏ နောက်ဆုံးမင်းနေပြည်တော်ဖြစ်ခဲ့သည့် မန္တလေးမြို့သည် သမိုင်းတန်ဖိုးကြီးမားသော အနုပညာလက်ရာများ စုဝေးရာဒေသတစ်ခု ဖြစ်ပါသည်။ ရွှေချည်ထိုး၊ ပန်းပု နှင့် ကျောက်ဆစ်လုပ်ငန်း စသည့် ရိုးရာလက်မှုပညာရပ်များကို ယနေ့တိုင် ထိန်းသိမ်းထားပြီး၊ ဗုဒ္ဓဘာသာဆိုင်ရာ အထင်ကရနေရာများစွာလည်း တည်ရှိပါသည်။ ရှေးဟောင်းအငွေ့အသက်များနှင့် ဒေသခံတို့၏ ဖော်ရွေသော အပြုံးများဖြင့် ပြည့်နှက်နေသည့် မန္တလေးမြို့အလှကို ကိုယ်တိုင်ခံစားကြည့်ရှုဖို့ ဖိတ်ခေါ်လိုက်ပါသည်။
                    </p>
                    
                </div>
            </div>
 
    <h2 class="section-title">Popular Destinations <br><small style="font-size:16px; color:#111; font-weight:normal;">လူကြိုက်အများဆုံး နေရာများ</small></h2>
    
   <div class="grid-3">
        <%
        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM attractions ORDER BY id DESC LIMIT 3");
            while(rs.next()) {
        %>
            <div class="card" style="background:white; border-radius:10px; overflow:hidden; box-shadow:0 5px 15px rgba(0,0,0,0.1);">
                <img src="<%= rs.getString("image_url") %>" alt="Place" style="height:200px; width:100%; object-fit:cover;">
                <div class="card-content" style="padding:20px;">
                    <span style="background:#e0f2f1; color:#00695c; padding:3px 8px; border-radius:4px; font-size:12px; font-weight:bold;">
                        <%= rs.getString("category") %>
                    </span>
                    <h3 style="margin:10px 0;"><%= rs.getString("name") %></h3>
                    <p style="color:#666; font-size:14px;">
                        <%= rs.getString("location") %>
                    </p>
                     <%
            		if (session.getAttribute("user") != null) {
        			%>
            		<a href="attraction-detail.jsp?id=<%= rs.getInt("id") %>" class="btn" style=" font-weight:bold; margin-top:10px; display:inline-block;">View Details</a>
        			<%
           			 } else {
       				 %>
           			<a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');" class="btn" style="display:block; text-align:center; margin-top:10px;">
                 		🔒View Details <i class="fas fa-lock"></i>
            		</a>
        			<%
           			 }
        			%>
                </div>
            </div>
        <%
            }
            con.close();
        } catch(Exception e) {
        }
        %>
    </div>

    <div style="background-color: #307082; color: white; padding: 40px; text-align: center; margin-top: 50px;">
        <h2>Ready to Visit?</h2>
        <p>Book the best hotels and plan your trip easily.</p>
        <%
            if (session.getAttribute("user") != null) {
        %>
            <a href="hotels.jsp" class="btn" style="background:white; color:#572805; padding:10px 25px; border-radius:5px; text-decoration:none; font-weight:bold; margin-top:10px; display:inline-block;">Find Hotels</a>
        <%
            } else {
        %>
           <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');" class="btn" style="display:block; text-align:center; margin-top:10px;">
                 		🔒Find hotels <i class="fas fa-lock"></i>
            </a>
        <%
            }
        %>

    </div>

    <footer>
        <p>&copy; 2026 Mandalay Travel Portal. All Rights Reserved.</p>
        <p>Developed by Aeint</p>
        
    </footer>

</body>
</html>
