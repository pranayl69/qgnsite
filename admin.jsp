<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Nunito', sans-serif;
            background: #f8f9fa;
            color: #343a40;
        }
        .container {
            margin-top: 30px;
        }
        h1 {
            margin-bottom: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .table thead th {
            background: #6c757d;
            color: #ffffff;
        }
        .btn-custom {
            background: #6c757d;
            color: white;
        }
        .btn-custom:hover {
            background: #5a6268;
        }
        .footer {
            margin-top: 50px;
            text-align: center;
        }
        .logout-btn {
            float: right;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 class="text-center">Admin Dashboard</h1>
    
    <a href="adminpage.html" class="btn btn-custom logout-btn">Logout</a>

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h4>Contact Information</h4>
                </div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>ID</th> <!-- Added ID column -->
                            <th>Name</th>
                            <th>Email</th>
                            <th>Mobile</th>
                            <th>Subject</th>
                            <th>Message</th>
                            <th>Actions</th> <!-- Added Actions column for delete and reply -->
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            // Database connection details
                            String url = "jdbc:mysql://localhost:3306/qgn"; // Update with your database URL
                            String user = "root"; // Update with your database username
                            String password = "root"; // Update with your database password

                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;

                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                conn = DriverManager.getConnection(url, user, password);
                                stmt = conn.createStatement();
                                String sql = "SELECT * FROM contact1"; // Updated table name to contact1
                                rs = stmt.executeQuery(sql);

                                while (rs.next()) {
                                    int id = rs.getInt("id"); // Fetching the ID
                                    String name = rs.getString("name");
                                    String email = rs.getString("email");
                                    String mobile = rs.getString("mobile");
                                    String subject = rs.getString("subject");
                                    String message = rs.getString("message");
                        %>
                                    <tr>
                                        <td><%= id %></td> <!-- Displaying ID -->
                                        <td><%= name %></td>
                                        <td><%= email %></td>
                                        <td><%= mobile %></td>
                                        <td><%= subject %></td>
                                        <td><%= message %></td>
                                        <td>
                                            <!-- Delete Button -->
                                            <a href="deleteClient.jsp?id=<%= id %>" class="btn btn-danger btn-sm">Delete</a>
                                            <!-- Reply Button -->
                                            <a href="#" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#replyModal<%= id %>">Reply</a>
                                        </td>
                                    </tr>

                                    <!-- Modal for Reply -->
                                    <div class="modal fade" id="replyModal<%= id %>" tabindex="-1" role="dialog" aria-labelledby="replyModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="replyModalLabel">Reply to <%= name %></h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="sendReply.jsp" method="post">
                                                        <input type="hidden" name="id" value="<%= id %>">
                                                        <textarea name="reply" class="form-control" rows="4" placeholder="Write your reply here..."></textarea>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary">Send Reply</button>
                                                </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                // Close resources
                                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                                if (conn != null) try { conn.close(); } catch (SQLException e) {}
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2024 Quantum Global Network. All Rights Reserved.</p>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
