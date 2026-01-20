<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mandalay.DBConnection, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attractions-Details</title> 
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
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
    </style>
</head>
<body>
    <div class="container" style="margin-top:50px;">
        <a href="attractions.jsp" class="btn" style="background:#555;">&larr; Back</a>
        <br><br>
        
        <%
            int id = 0;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                response.sendRedirect("attractions.jsp"); 
                return;
            }

            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM attractions WHERE id=?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if(rs.next()) {
        %>
            <div style="background:white; padding:30px; border-radius:10px;">
                <img src="<%= rs.getString("image_url") %>" style="width:100%; max-height:600px; object-fit:cover; border-radius:10px;">
                <h1><%= rs.getString("name") %></h1>
                <p><strong>Location:</strong> <%= rs.getString("location") %></p>
                <p><strong>Category:</strong> <%= rs.getString("category") %></p>
                <hr>
                <p style="line-height:1.8; font-size:18px;"><%= rs.getString("description") %></p>
            </div>
        <%
                }
            } catch(Exception e) { e.printStackTrace(); }
        %>
        
        <div style="margin-top: 20px; text-align: center;">
             <button onclick="toggleHistory()" class="btn" style="background: white; color: #333; border: 1px solid #ddd; padding: 12px 25px; border-radius: 30px; font-weight: bold; cursor: pointer; transition: 0.3s;">
                 <i class="fas fa-history"></i> View History
            </button>
        </div>

        <div id="history-section">
            <h2 style="text-align:center; color:#c0a062; margin-bottom: 30px;">
               History Timeline
            </h2>
           
            <%
            try {
                Connection con = DBConnection.getConnection();
                String sql = "SELECT * FROM attraction_history WHERE attraction_id = ? ORDER BY event_date ASC";
                PreparedStatement psHist = con.prepareStatement(sql);
                psHist.setInt(1, id); 
                
                ResultSet rsHist = psHist.executeQuery();
      
                boolean hasHistory = false;
                while(rsHist.next()) {
                    hasHistory = true;
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
                
                if(!hasHistory) {
                    out.println("<p style='text-align:center; color:#666;'>No history records found for this place.</p>");
                }
                
            } catch(Exception e) {
                e.printStackTrace();
            }
            %>
            
            <div style="text-align:center; margin-top:20px;">
                <button onclick="toggleHistory()" class="btn" style="background:#ddd; color:#333; padding: 10px 20px; border-radius: 5px; border:none; cursor: pointer;">Close History</button>
            </div>
        </div>
        
    </div>
    
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
