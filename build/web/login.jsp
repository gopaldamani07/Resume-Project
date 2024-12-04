<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
</head>
<body>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean validUser = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/UserDB", "root", "silver");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Users WHERE username = ? AND password = ?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                validUser = true;
            }

            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }

        if (validUser) {
            response.sendRedirect("resume.jsp?username=" + username);
        } else {
    %>
        <h3 style="color: red;">Invalid username or password. Please try again.</h3>
        <a href="index.jsp">Go Back</a>
    <%
        }
    %>
</body>
</html>
