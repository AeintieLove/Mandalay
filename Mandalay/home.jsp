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
            background: linear-gradient(135deg, #00537A 0%, #6CA3A2 100%);
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
            position: relative;
            border-radius: 0 0 30px 30px; 
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
        
        .category-section {
            padding: 30px 20px;
            background: white;
            text-align: center;

            margin: -40px auto 30px; 
            position: relative;
            z-index: 10;
            max-width: 900px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }
        .cat-item { text-decoration: none; color: #333; text-align: center; width: 120px; margin: 10px; transition: 0.3s; }
        .cat-icon {
            width: 60px; height: 60px;
            background: #f5f5f5;
            color: #333;
            border-radius: 50%;
            display: flex; justify-content: center; align-items: center;
            font-size: 24px;
            margin: 0 auto 10px;
            transition: 0.3s;
        }
        .cat-item:hover .cat-icon { background: #c0a062; color: white; transform: translateY(-5px); }

        .section-title { text-align: center; margin: 40px 0 20px; color:rgb(132, 70, 24); font-size: 28px; }
        .grid-3 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto 50px;
            padding: 0 20px;
        }

        #history-section {
            display: none; 
            background-color: #fff8e1;
            padding: 40px 20px;
            margin: 30px auto;
            max-width: 1000px;
            border-radius: 15px;
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); } 
            to { opacity: 1; transform: translateY(0); }
        }

        .history-card {
            display: flex;
            gap: 20px;
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            align-items: center;
            border-left: 5px solid #c0a062;
        }
        
        @media( max-width: 700px){
            .history-card { flex-direction: column; text-align: center; }
            .history-card img { width: 100%; height: auto; }
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

    <div class="hero-section">
        <div class="hero-title">Welcome to Mandalay</div>
        <div class="hero-subtitle">မြန်မာ့ယဉ်ကျေးမှု၏ မြို့တော် ရတနာပုံ</div>
        
        <button onclick="toggleHistory()" class="btn" style="background: white; color: #333; border:none; padding: 12px 25px; border-radius: 30px; font-weight: bold; cursor: pointer; transition: 0.3s;">
             <i class="fas fa-history"></i> View History
        </button>
    </div>

    <div id="history-section">
        <h2 style="text-align:center; color:#c0a062; margin-bottom: 30px;">
            Mandalay History Timeline
        </h2>

        <%
        try {
            Connection con = DBConnection.getConnection();
            Statement stmtHist = con.createStatement();
            ResultSet rsHist = stmtHist.executeQuery("SELECT * FROM history WHERE id=1"); 
            
            while(rsHist.next()) {
        %>
            <div class="history-card">
                <img src="<%= rsHist.getString("image_url") %>" style="width: 200px; height: 140px; object-fit: cover; border-radius: 10px;">
                <div>
                    <span style="background:#c0a062; color:white; padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight:bold;">
                        <%= rsHist.getString("event_date") %>
                    </span>
                    <h3 style="margin: 10px 0; color: #333;"><%= rsHist.getString("title") %></h3>
                    <p style="color: #666; font-size: 14px;"><%= rsHist.getString("content") %></p>
                </div>
            </div>
        <%
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        %>
        
        <div style="text-align:center; margin-top:20px;">
            <button onclick="toggleHistory()" class="btn" style="background:#572805; color:#999; padding: 10px 20px; border-radius: 5px; border:none; cursor: pointer;">Close History</button>
        </div>
    </div>
    <div class="category-section">
       
   		 <%
            if (session.getAttribute("user") != null) {
        %>
           <a href="attractions.jsp" class="cat-item">
            <div class="cat-icon"><i class="fas fa-map-marked-alt"></i></div>
            <b>Attractions</b>
        </a>
        <a href="hotels.jsp" class="cat-item">
            <div class="cat-icon"><i class="fas fa-hotel"></i></div>
            <b>Hotels</b>
        </a>
        <a href="history.jsp" class="cat-item">
            <div class="cat-icon"><i class="fas fa-landmark"></i></div>
            <b>History</b>
        </a>
        <a href="music.jsp" class="cat-item">
            <div class="cat-icon"><i class="fas fa-music"></i></div>
            <b>Music</b>
        </a>
         <a href="changes.jsp" class="cat-item">
            <div class="cat-icon"><i class="fas fa-hands-helping"></i></div>
            <b>Resilience</b>
        </a>
        <%
            } else {
        %>
            <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');" class="cat-item">
            <div class="cat-icon"><i class="fas fa-map-marked-alt"></i></div>
            <b>Attractions</b>
        </a>
        <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');"class="cat-item">
            <div class="cat-icon"><i class="fas fa-hotel"></i></div>
            <b>Hotels</b>
        </a>
        <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');" class="cat-item">
            <div class="cat-icon"><i class="fas fa-landmark"></i></div>
            <b>History</b>
        </a>
        <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');" class="cat-item">
            <div class="cat-icon"><i class="fas fa-music"></i></div>
            <b>Music</b>
        </a>
         <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');" class="cat-item">
            <div class="cat-icon"><i class="fas fa-hands-helping"></i></div>
            <b>Resilience</b>
        </a>
        <%
            }
        %>
        
    </div>

    <h2 class="section-title">Popular Destinations <br><small style="font-size:16px; color:#666; font-weight:normal;">လူကြိုက်အများဆုံး နေရာများ</small></h2>
    
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
                    <a href="attraction-detail.jsp?id=<%= rs.getInt("id") %>" class="btn" style="display:block; text-align:center; margin-top:10px;">
                 		View Details 
            		</a>
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
        <a href="hotels.jsp" class="btn" style="background:white; color:#572805; padding:10px 25px; border-radius:5px; text-decoration:none; font-weight:bold; margin-top:10px; display:inline-block;">Find Hotels</a>
    </div>

    <footer>
        <p>&copy; 2026 Mandalay Travel Portal. All Rights Reserved.</p>
        <p>Developed by Aeint</p>
    </footer>

    <script>
    function toggleHistory() {
        var historyDiv = document.getElementById("history-section");
        
        if (historyDiv.style.display === "none" || historyDiv.style.display === "") {
            historyDiv.style.display = "block"; 
            historyDiv.scrollIntoView({behavior: "smooth", block: "start"});
        } else {
            historyDiv.style.display = "none"; 
        }
    }
    </script>
</body>
</html>
