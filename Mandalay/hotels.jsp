<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mandalay.DBConnection, java.sql.*" %>
<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Luxury Stays in Mandalay</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
     <style>

        .hotel-header {
            background:linear-gradient(135deg,  #00537A 0%,   #6CA3A2 100%);
            background-size: cover;
            background-position: center;
            height: 350px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            margin-bottom: 40px;
        }
        .hotel-header h1 {
            font-size: 42px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
            margin-bottom: 10px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .hotel-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
        }

        .hotel-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            position: relative;
            display: flex;
            flex-direction: column;
        }

        .hotel-card:hover {
            transform: translateY(-10px); 
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        .hotel-img-box {
            position: relative;
            height: 220px;
        }
        
        .hotel-img-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: #ffc107;
            color: #333;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .hotel-info {
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .hotel-name {
            font-size: 20px;
            font-weight: 700;
            color: #2c3e50;
            margin: 0 0 10px;
        }

        .rating {
            color: #ffc107; 
            margin-bottom: 15px;
            font-size: 14px;
        }

        .contact-info {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .action-row {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #eee;
            padding-top: 15px;
        }

        .price-tag {
            font-size: 18px;
            font-weight: bold;
            color: #572805;
        }
        .price-tag small {
            font-size: 12px;
            font-weight: normal;
            color: #888;
        }

        .btn-book {
            background: linear-gradient(45deg, #572805, #00695c);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: opacity 0.3s;
        }
        .btn-book:hover {
            opacity: 0.9;
            box-shadow: 0 4px 10px rgba(0,77,64,0.3);
        }

    </style>
</head>
<body>

    <div class="navbar">
        <div style="font-size:24px; font-weight:bold;">Mandalay Travel</div>
        <div class="nav-links">
            <a href="home.jsp">Home</a>
            <a href="attractions.jsp">Attractions</a>
            <a href="history.jsp">History</a>
            <a href="hotels.jsp" style="color: #ffeb3b;">Hotels</a>
            <a href="music.jsp">Music</a>
            <% if(session.getAttribute("user") == null) { %>
                <a href="login.jsp" style="background:#ff9800; padding:5px 10px; border-radius:4px;">Login</a>
            <% } else { %>
                <a href="logout.jsp">Logout</a>
            <% } %>
        </div>
    </div>

    <div class="hotel-header">
        <div>
            <h1>Stay in Comfort</h1>
            <p>အကောင်းဆုံး ဝန်ဆောင်မှုပေးမည့် ဟိုတယ်များကို ရွေးချယ်ပါ</p>
        </div>
    </div>

    <div class="container">
        <div class="hotel-grid">
            
            <%
            try {
                Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
              
                ResultSet rs = stmt.executeQuery("SELECT * FROM hotels ORDER BY rating DESC");
                
                while(rs.next()) {
                    double rating = rs.getDouble("rating");
                   
                    boolean isTopRated = rating >= 4.5;
            %>
            
            <div class="hotel-card">
                <div class="hotel-img-box">
                    <img src="<%= rs.getString("image_url") %>" alt="Hotel Image">
                    <% if(isTopRated) { %>
                        <span class="badge">Top Rated</span>
                    <% } %>
                </div>
                
                <div class="hotel-info">
                    <h3 class="hotel-name"><%= rs.getString("name") %></h3>
                    
                    <div class="rating">
                        ★ <%= rating %> / 5.0 (Excellent)
                    </div>
                    
                    <div class="contact-info">
                        📞 <%= rs.getString("contact") %>
                    </div>
                    
                    <div class="action-row">
                        <div class="price-tag">
                            <%= rs.getString("price_range") %> 
                            </div>
                       <a href="hotel-booking.jsp?id=<%= rs.getInt("id") %>" class="btn-book">Book Now</a>
                    </div>
                </div>
            </div>

            <%
                }
                con.close();
            } catch(Exception e) {
            %>
                <div style="color:red; text-align:center; padding: 20px;">
                    <h3>Connection Error!</h3>
                    <p><%= e.getMessage() %></p>
                </div>
            <%
            }
            %>

        </div>
    </div>

</body>
</html>
