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
    <title>Mandalay Melodies</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body {
            background-size: cover;
            background-attachment: fixed;
            color: white;
            font-family: 'Segoe UI', sans-serif;
        }

        .music-header {
            text-align: center;
            padding: 50px 20px;
            color: #013C58; 
        }
        .music-header h1 { font-size: 40px; margin-bottom: 10px; text-shadow: 0 0 10px rgba(255, 202, 40, 0.5); }
        .music-header p { color: #013C58; font-size: 18px; }

        .music-container {
            max-width: 800px;
            margin: 0 auto 50px;
            padding: 0 20px;
        }

        .music-card {
            background: rgba(100, 100, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.3s;
        }

            transform: scale(1.02);
            background: rgba(255, 255, 255, 0.15);
            border-color: #ffca28;
        }

        .album-art {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 3px solid #ffca28;
            object-fit: cover;
            animation: spin 10s linear infinite;
            box-shadow: 0 0 15px rgba(0,0,0,0.5);
        }
        
        .music-card:hover .album-art {
            animation-duration: 3s;
        }

        @keyframes spin {
            100% { transform: rotate(360deg); }
        }

        .song-info {
            flex-grow: 1;
        }
        .song-title {
            font-size: 18px;
            font-weight: bold;
            color: #011B2F;
            margin: 0;
            display: block;
        }
        .artist-name {
            color: #572805;
            font-size: 14px;
            margin-top: 5px;
            display: block;
        }

        audio {
            height: 35px;
            width: 250px;
            border-radius: 20px;
        }
     
        .listen-btn {
            background: #ffca28;
            color: #333;
            padding: 8px 15px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .listen-btn:hover { background: #ffd54f; }

        @media (max-width: 600px) {
            .music-card { flex-direction: column; text-align: center; }
            audio { width: 100%; margin-top: 10px; }
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
            <a href="hotels.jsp">Hotels</a>
            <a href="music.jsp" style="color: #ffca28;">Music</a> <% if(session.getAttribute("user") == null) { %>
                <a href="login.jsp" style="background:#ff9800; padding:5px 10px; border-radius:4px;">Login</a>
            <% } else { %>
                <a href="logout.jsp">Logout</a>
            <% } %>
        </div>
    </div>

    <div class="music-header">
        <h1><i class="fas fa-music"></i> Melodies of Mandalay</h1>
        <p>ရွှေမန်းမြေ၏ အငွေ့အသက် တေးသံသာများ</p>
    </div>

    <div class="music-container">
        
        <%
        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM music");
            
            while(rs.next()) {
                String link = rs.getString("music_link");
                if(link == null) link = "#";
        %>
            
            <div class="music-card">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6A5q-JgvjR-KxT7qY4QJ8P4Zq_6o6-w&s" class="album-art" alt="Vinyl">
                
                <div class="song-info">
                    <span class="song-title"><%= rs.getString("title") %></span>
                    <span class="artist-name">
                        <i class="fas fa-microphone-alt"></i> <%= rs.getString("artist") %>
                    </span>
                </div>

                <% if(link.endsWith(".mp3")) { %>
                    <audio controls>
                        <source src="<%= link %>" type="audio/mpeg">
                        Your browser does not support the audio element.
                    </audio>
                <% } else { %>
                    <a href="<%= link %>" target="_blank" class="listen-btn">
                        <i class="fas fa-play"></i> Play Now
                    </a>
                <% } %>
            </div>

        <%
            }
            con.close();
        } catch(Exception e) {
        %>
            <div style="text-align:center; color: #ff6b6b;">
                <h3>Connection Error!</h3>
                <p><%= e.getMessage() %></p>
            </div>
        <%
        }
        %>

    </div>

</body>
</html>
