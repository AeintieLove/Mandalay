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
    <title>Book Hotel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <style>
        .booking-container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; }
        .hotel-title { color: #004d40; text-align: center; margin-bottom: 20px; }
        .btn-confirm { width: 100%; padding: 12px; background: #004d40; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .btn-confirm:hover { background: #00695c; }
    </style>
</head>
<body>

    <div class="navbar">
        <div style="font-size:24px; font-weight:bold;">Mandalay Travel</div>
        <div class="nav-links">
            <a href="home.jsp">Home</a>
            <a href="hotels.jsp">Back to Hotels</a>
        </div>
    </div>

    <div class="booking-container">
        
        <%
            String hotelId = request.getParameter("id");
            String hotelName = "";
            String price = "";
            
            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM hotels WHERE id=?");
                ps.setString(1, hotelId);
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    hotelName = rs.getString("name");
                    price = rs.getString("price_range");
                }
            } catch(Exception e) { e.printStackTrace(); }
        %>

        <h2 class="hotel-title">Booking for: <%= hotelName %></h2>
        <p style="text-align:center; color:#777;">Price Range: <%= price %></p>
        <hr><br>

        <form action="HotelBookingServlet" method="post">
            <input type="hidden" name="hotel_id" value="<%= hotelId %>">
            
            <div class="form-group">
                <label>Name (ဧည့်သည်အမည်):</label>
                <input type="text" name="guest_name" required placeholder="Enter your full name">
            </div>

            <div class="form-group">
                <label>Phone (ဖုန်းနံပါတ်):</label>
                <input type="text" name="phone" required placeholder="09-xxxxxxxxx">
            </div>

            <div style="display:flex; gap:10px;">
                <div class="form-group" style="flex:1;">
                    <label>Check-in Date:</label>
                    <input type="date" name="check_in" required>
                </div>
                <div class="form-group" style="flex:1;">
                    <label>Check-out Date:</label>
                    <input type="date" name="check_out" required>
                </div>
            </div>

            <div class="form-group">
                <label>No. of Rooms (အခန်းအရေအတွက်):</label>
                <input type="number" name="rooms" min="1" value="1" required>
            </div>

            <button type="submit" class="btn-confirm">Confirm Booking</button>
        </form>
    </div>

</body>
</html>
