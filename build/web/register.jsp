<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }
        h2 {
            color: #333;
            margin-bottom: 1rem;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }
        input[type="text"], input[type="password"], input[type="email"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        textarea {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <form action="register.jsp" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>
            
            <label for="first_name">First Name:</label>
            <input type="text" id="first_name" name="first_name" required><br>
            
            <label for="last_name">Last Name:</label>
            <input type="text" id="last_name" name="last_name" required><br>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br>
            
            <label for="phone_number">Phone Number:</label>
            <input type="text" id="phone_number" name="phone_number" required><br>
            
            <label for="skills">Skills:</label>
            <textarea id="skills" name="skills" required></textarea><br>
            
            <label for="internship">Internship:</label>
            <textarea id="internship" name="internship" required></textarea><br>
            
            <label for="experience">Experience:</label>
            <textarea id="experience" name="experience" required></textarea><br>
            
            <button type="submit">Register</button>
        </form>
    </div>

    <% 
        // Register user and insert into the database
        if(request.getMethod().equalsIgnoreCase("POST")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phone_number");
            String skills = request.getParameter("skills");
            String internship = request.getParameter("internship");
            String experience = request.getParameter("experience");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/UserDB", "root", "silver");

                // Insert user data into the Users table
                String insertQuery = "INSERT INTO Users (username, password, first_name, last_name, email, phone_number, skills, internship, experience) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(insertQuery);
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, firstName);
                ps.setString(4, lastName);
                ps.setString(5, email);
                ps.setString(6, phoneNumber);
                ps.setString(7, skills);
                ps.setString(8, internship);
                ps.setString(9, experience);

                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    // Redirect to resume page after successful registration
                    response.sendRedirect("resume.jsp?username=" + username);
                } else {
                    out.println("Error: Unable to register user.");
                }

                conn.close();
            } catch (SQLException e) {
                out.println("SQL Error: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println("Driver Class Not Found: " + e.getMessage());
            }
        }
    %>
</body>
</html>
