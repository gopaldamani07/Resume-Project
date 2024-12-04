<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Resume</title>
</head>
<body>
    <%
        String username = request.getParameter("username");
        String phoneNumber = request.getParameter("phone_number");
        String skills = request.getParameter("skills");
        String internship = request.getParameter("internship");
        String experience = request.getParameter("experience");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/UserDB", "root", "silver");
            PreparedStatement ps = conn.prepareStatement("UPDATE Users SET phone_number = ?, skills = ?, internship = ?, experience = ? WHERE username = ?");
            ps.setString(1, phoneNumber);
            ps.setString(2, skills);
            ps.setString(3, internship);
            ps.setString(4, experience);
            ps.setString(5, username);
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("resume.jsp?username=" + username);
            } else {
                out.println("Error updating resume.");
            }

            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
</body>
</html>
