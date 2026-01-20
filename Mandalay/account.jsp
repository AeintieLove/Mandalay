<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mandalay.DBConnection, java.sql.*" %>
<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role"); 
    int userId = (Integer) session.getAttribute("userId");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Account</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        
        
        .profile-header {
			background:linear-gradient(135deg, #00537A 0%,   #6CA3A2 100%);
            color: white;
            padding: 40px 20px;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .avatar-circle {
            width: 80px; height: 80px;
            background: white; color: #c0a062;
            border-radius: 50%;
            display: inline-flex; justify-content: center; align-items: center;
            font-size: 35px; font-weight: bold;
            margin-bottom: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .container {
        	 max-width: 1000px;
        	 margin: 0 auto;
        	 padding: 20px;
       	}
 
        .admin-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        .admin-card {
            background: white; padding: 25px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            text-decoration: none; color: #333;
        }
        .admin-card:hover { transform: translateY(-5px); background: #e0f2f1; }
        .admin-card i { font-size: 30px; color: #004d40; margin-bottom: 10px; }

        .booking-table {
            width: 100%; border-collapse: collapse;
            background: white; border-radius: 10px; overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .booking-table th, .booking-table td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        .booking-table th { background: #013C58; color: white; }
        .status-pending { color: orange; font-weight: bold; }
        .status-confirmed { color: green; font-weight: bold; }

    </style>
</head>
<body>

    <div class="navbar">
        <div style="font-size:24px; font-weight:bold;">Mandalay Travel</div>
        <div class="nav-links">
            <a href="home.jsp">Home</a>
            <a href="logout.jsp" style="color:yellow;">Logout <i class="fas fa-sign-out-alt"></i></a>
        </div>
    </div>

    <div class="profile-header">
        <div class="avatar-circle">
            <%= username.charAt(0) %> </div>
        <h2><%= username %></h2>
        <p style="opacity: 0.8; text-transform: uppercase; letter-spacing: 1px;">
            <%= role %> account
        </p>
    </div>

    <div class="container">

        <% if("admin".equals(role)) { %>
            
            <h2 style="color: #004d40; border-bottom: 2px solid #ddd; padding-bottom: 10px;">
                <i class="fas fa-cogs"></i> Admin Control Panel
            </h2>
            <br>

            <div class="admin-grid">
                <a href="add_attraction.jsp" class="admin-card">
                    <i class="fas fa-map-marked-alt"></i>
                    <h3>Add Attraction</h3>
                    <p>နေရာအသစ်များ ထည့်သွင်းရန်</p>
                </a>

                <a href="add_hotel.jsp" class="admin-card">
                    <i class="fas fa-hotel"></i>
                    <h3>Add Hotel</h3>
                    <p>ဟိုတယ်အသစ် ထည့်သွင်းရန်</p>
                </a>

                <a href="add_history.jsp" class="admin-card">
                    <i class="fas fa-history"></i>
                    <h3>Add History</h3>
                    <p>သမိုင်းကြောင်းများ တင်ရန်</p>
                </a>

                <div class="admin-card" style="cursor: default;">
                    <i class="fas fa-users"></i>
                    <h3>User Manager</h3>
                    <p>အသုံးပြုသူများကို စစ်ဆေးရန်</p>
                </div>
            </div>

        <% } else { %>

            <h2 style="color:#572805; border-bottom: 2px solid #ddd; padding-bottom: 10px;">
                <i class="fas fa-suitcase-rolling"></i> My Booking History
            </h2>
            <br>
            
            <table class="booking-table">
                <thead>
                    <tr>
                        <th>Hotel Name</th>
                        <th>Date</th>
                        <th>Rooms</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    boolean hasBookings = false;
                    try {
                        Connection con = DBConnection.getConnection();
                        String sql = "SELECT b.*, h.name as hotel_name FROM hotel_bookings b " +
                                     "JOIN hotels h ON b.hotel_id = h.id " +
                                     "WHERE b.user_id = ? ORDER BY b.booking_date DESC";
                        
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setInt(1, userId);
                        ResultSet rs = ps.executeQuery();
                        
                        while(rs.next()) {
                            hasBookings = true;
                            String status = rs.getString("status");
                            String statusClass = "Pending".equals(status) ? "status-pending" : "status-confirmed";
                    %>
                        <tr>
                            <td><%= rs.getString("hotel_name") %></td>
                            <td>
                                <%= rs.getString("check_in") %> <br>
                                <small style="color:gray;">to <%= rs.getString("check_out") %></small>
                            </td>
                            <td><%= rs.getInt("rooms") %></td>
                            <td class="<%= statusClass %>"><%= status %></td>
                        </tr>
                    <%
                        }
                        if(!hasBookings) {
                    %>
                        <tr>
                            <td colspan="4" style="text-align:center; padding: 30px; color: gray;">
                                Booking လုပ်ထားခြင်း မရှိသေးပါ။ <a href="hotels.jsp">ဟိုတယ်ကြည့်ရန်</a>
                            </td>
                        </tr>
                    <%
                        }
                    } catch(Exception e) { e.printStackTrace(); }
                    %>
                </tbody>
            </table>

        <% } %> </div>

</body>
</html>
