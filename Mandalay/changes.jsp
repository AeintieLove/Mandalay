<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mandalay.DBConnection, java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mandalay: Then & Now</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
       
        .disaster-header {
            background: linear-gradient(135deg, #00537A 0%, #6CA3A2 100%);
            background-size: cover;
            min-height: 400px; 
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 40px 20px;
        }

        .hero-title h1 { 
            font-size: 36px; 
            font-weight: bold; 
            text-shadow: 0 2px 10px rgba(0,0,0,0.3); 
            margin-bottom: 20px; 
            line-height: 1.4;
            color: white;
        }
        
        .hero-subtitle { 
            font-size: 18px;
            max-width: 800px;
            margin-bottom: 30px; 
            text-align: center;
            line-height: 1.8;
            color: #f1f1f1; /* Changed to light color */
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding-bottom: 50px;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }
        .card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-content {
            padding: 20px;
        }

        .severity-badge {
            position: absolute; top: 10px; right: 10px;
            padding: 5px 12px; border-radius: 4px; color: white; font-size: 12px; font-weight: bold;
            z-index: 2;
        }
        .bg-high { background: #d32f2f; }
        .bg-medium { background: #f57c00; }
        
        .compare-btn {
            display: block; width: auto; text-align: center; padding: 12px;
            background: linear-gradient(45deg, #00537A, #00695c); 
            color: white; text-decoration: none;
            margin-top: 15px; border-radius: 5px; transition: 0.3s;
            font-weight: bold;
        }
        .compare-btn:hover { background: #37474f; opacity: 0.9; }
        
    </style>
</head>
<body>

    <div class="navbar">
        <div style="font-size:24px; font-weight:bold; display:flex; align-items:center; gap:10px; color:#999;">
            <i class="fas fa-pagelines" style="color:#999;"></i> Mandalay Travel
        </div>
        <div class="nav-links">
            <% if(user == null) { %>
                <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">Home</a>
                <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">Attractions</a>
                <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">Hotels</a>
                <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">History</a>
                <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');">Music</a>
                <a href="login.jsp" style="background:#ffca28; color:#333; padding:8px 20px; border-radius:20px;">Login</a>
            <% } else { %>
                <a href="home.jsp">Home</a>
                <a href="attractions.jsp">Attractions</a>
                <a href="hotels.jsp">Hotels</a>
                <a href="history.jsp">History</a>
                <a href="music.jsp">Music</a>

                <% if("admin".equals(role)) { %>
                    <a href="admin_dashboard.jsp" style="color:#00537A; font-weight:bold;">Admin Panel</a>
                <% } else { %>
                    <a href="account.jsp">My Account</a>
                <% } %>
                <a href="logout.jsp" style="color: #ef5350;">Logout</a>
            <% } %>
        </div>
    </div>

    <div class="disaster-header">
        <div class="hero-title"> 
            <h1>The Resilience of Mandalay (မန္တလေးမြို့၏ ကြံ့ခိုင်မှု)</h1>
        </div>
        
        <div class="hero-subtitle">  
            <p>
                ၂၀၂၅ ခုနှစ်၊ မတ်လ ၂၈ ရက်နေ့တွင် လှုပ်ခတ်ခဲ့သော ရစ်ခ်ျတာစကေး (၇.၇) အဆင့်ရှိ အင်အားပြင်းငလျင်ကြီးသည် မန္တလေးမြို့၏ သမိုင်းဝင်အမွေအနှစ်များကို စိန်ခေါ်ခဲ့သော်လည်း၊ မန္တလေးသူ/သားတို့၏ စိတ်ဓာတ်နှင့် မြို့၏ဂုဏ်ဒြပ်ကိုမူ မဖျက်ဆီးနိုင်ခဲ့ပါ။ ယခုအခါ မန္တလေးမြို့သည် အပျက်အစီးများကြားမှ ပြန်လည်ရုန်းထကာ ပိုမိုခိုင်ခံ့သော အနာဂတ်ဆီသို့ ဦးတည်လျှောက်လှမ်းနေပြီ ဖြစ်ပါသည်။
            </p>
        </div>
        
        <p style="font-size: 18px; max-width: 700px; color: #ffca28; font-weight: bold;">
            သဘာဝဘေးဒဏ်ကြောင့် ထိခိုက်ခဲ့ရသော မန္တလေး၏ အထင်ကရနေရာများနှင့် <br>
            ပြန်လည်ထူထောင်ရေး မှတ်တမ်းများ
        </p>
    </div>

      <div class="container" style="margin-top: 50px;">
        <div class="grid">
            <%
            try {
                Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM disaster_logs");
                while(rs.next()) {
                    String sev = rs.getString("severity");
                    String badgeClass = "bg-medium";
                    if("High".equals(sev)) badgeClass = "bg-high";
            %>
                <div class="card" style="position: relative;">
                    <span class="severity-badge <%= badgeClass %>"><%= sev %> Impact</span>
                    
                    <img src="<%= rs.getString("after_img") %>" style="height: 200px; width: 100%; object-fit: cover; filter: grayscale(30%);">
                    
                    <div class="card-content">
                        <h3><%= rs.getString("location_name") %></h3>
                        <p style="color: #666; font-size: 14px;"><i class="far fa-calendar-alt"></i> <%= rs.getString("event_date") %></p>
                        
                        <p>
                            <%= rs.getString("damage_desc").substring(0, Math.min(rs.getString("damage_desc").length(), 80)) %>...
                        </p>
                          <%
            			if (session.getAttribute("user") != null) {
        			%>
	                   <a href="change-detail.jsp?id=<%= rs.getInt("id") %>" class="compare-btn">
                            See Before & After <i class="fas fa-exchange-alt"></i>
                        </a>
	                 <%
           			 } else {
       				 %>
	                     <a href="login.jsp" onclick="return confirm('ဒီအပိုင်းကို ဝင်ကြည့်ဖို့ Login အရင်ဝင်ရန် လိုအပ်ပါသည်။ Login ဝင်မလား?');"  class="compare-btn">
                            See Before & After <i class="fas fa-exchange-alt"></i>
                        </a>
	                     <%
            			}
        				%>
                       
                    </div>
                </div>
            <%
                }
            } catch(Exception e) { e.printStackTrace(); }
            %>
        </div>
    </div>

</body>
</html>

