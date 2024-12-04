<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resume</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
        }
        h1, h2 {
            color: #333;
        }
        p {
            font-size: 16px;
            line-height: 1.5;
            color: #555;
        }
        .button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin: 10px 0;
            display: inline-block;
        }
        .button:hover {
            background-color: #0056b3;
        }
        .edit-form input {
            margin-bottom: 10px;
            padding: 8px;
            width: 100%;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .edit-form button {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Resume</h1>
        <%
            String username = request.getParameter("username");
            boolean isEditing = request.getParameter("edit") != null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/UserDB", "root", "silver");
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM Users WHERE username = ?");
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
        %>
                    <h2>Welcome, <%= rs.getString("first_name") %> <%= rs.getString("last_name") %>!</h2>
                    <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                    <p><strong>Phone Number:</strong> <%= rs.getString("phone_number") %></p>
                    <p><strong>Skills:</strong> <%= rs.getString("skills") %></p>
                    <p><strong>Internship:</strong> <%= rs.getString("internship") %></p>
                    <p><strong>Experience:</strong> <%= rs.getString("experience") %></p>

                    <!-- Edit Button -->
                    <a href="resume.jsp?username=<%= username %>&edit=true" class="button">Edit</a>

                    <!-- Logout Button -->
                    <form action="resume.jsp" method="post">
                        <button type="submit" name="logout" class="button">Logout</button>
                    </form>

                    <%
                    if (isEditing) {
                    %>
                        <!-- Edit Form -->
                        <h3>Edit Your Resume</h3>
                        <form class="edit-form" action="updateResume.jsp" method="post">
                            <input type="hidden" name="username" value="<%= rs.getString("username") %>">
                            <label for="phone_number">Phone Number:</label>
                            <input type="text" id="phone_number" name="phone_number" value="<%= rs.getString("phone_number") %>">
                            <label for="skills">Skills:</label>
                            <input type="text" id="skills" name="skills" value="<%= rs.getString("skills") %>">
                            <label for="internship">Internship:</label>
                            <input type="text" id="internship" name="internship" value="<%= rs.getString("internship") %>">
                            <label for="experience">Experience:</label>
                            <input type="text" id="experience" name="experience" value="<%= rs.getString("experience") %>">
                            <button type="submit">Update Resume</button>
                        </form>
                    <%
                    }
                } else {
        %>
                    <p>User data not found.</p>
        <%
                }
                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>

        <%
            // Check if the logout button was pressed
            if (request.getParameter("logout") != null) {
                session.invalidate();  // Invalidate the session
                response.sendRedirect("index.jsp");  // Redirect to the login page
            }
        %>
    </div>
</body>
</html>
