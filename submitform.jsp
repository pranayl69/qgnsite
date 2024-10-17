<%@ page import="java.sql.*" %>
<%
    // Get form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    // Database connection variables
    String url = "jdbc:mysql://localhost:3306/qgn";
    String dbUsername = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load the MySQL driver
        Class.forName("com.mysql.jdbc.Driver");

        // Connect to the database
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        // SQL query to insert data into the database (no ID specified)
        String sql = "INSERT INTO contact1 (name, email, mobile, subject, message) VALUES (?, ?, ?, ?, ?)";

        // Prepare the SQL statement
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, mobile);
        stmt.setString(4, subject);
        stmt.setString(5, message);

        // Execute the query
        int rows = stmt.executeUpdate();
        
        if (rows > 0) {
            // Success: Display a JavaScript popup message
%>
            <script>
                alert("Thank you! Your message has been sent successfully.");
                window.location.href = "index.html"; // Redirect to another page if needed
            </script>
<%
        } else {
            // Failure: Display a JavaScript popup message
%>
            <script>
                alert("Sorry! There was a problem sending your message.");
                window.location.href = "index.html"; // Redirect to another page if needed
            </script>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("Error: <%= e.getMessage() %>");
            window.location.href = "index.html"; // Redirect to another page if needed
        </script>
<%
    } finally {
        // Close the database connection
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
