<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post" %>
<%@ page import="dao.PostDAO" %>
<%@ page import="dao.UserDAO" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login");
    }

    // Fetch posts and user data
    ArrayList<Post> posts = new PostDAO().getAllPosts(); // Replace with actual data fetching method
    User currentUser = new UserDAO().getUserById((int) session.getAttribute("user_id"));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home | Social</title>
    <link rel="shortcut icon" href="image/logo.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <style>
        .my-container {
            margin-top: 80px; /* Adjusted margin for navbar */
        }
    </style>
</head>
<body class="bg-light">

    <%@ include file="header.jsp" %>

    <div class="container my-container">
        <div class="row">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="card-title">What's on your mind?</h5>
                        <form method="post" action="post">
                            <div class="form-group">
                                <textarea class="form-control" name="post_body" rows="3" placeholder="Share your thoughts..."></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Post</button>
                        </form>
                    </div>
                </div>

                <% if (posts.isEmpty()) { %>
                    <h4 class="text-center">No Posts Yet.</h4>
                <% } else { %>
                    <% for (Post post : posts) { %>
                        <div class="card mb-3">
                            <div class="card-body">
                                <h5 class="card-title"><%= currentUser.getFirst_name() %></h5>
                                <p class="card-text"><%= post.getBody() %></p>
                                <p class="card-text"><small class="text-muted"><%= post.getPost_time() %></small></p>
                                <a href="post?delete=<%= post.getPost_id() %>" class="card-link text-danger"><i class="far fa-trash-alt"></i> Delete</a>
                                <a href="post?update=<%= post.getPost_id() %>" class="card-link"><i class="far fa-edit"></i> Edit</a>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </div>

            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="card-title">Friend Suggestions</h5>
                        <ul class="list-group list-group-flush">
                            <% 
                                // Mock data for friend suggestions
                                ArrayList<User> suggestions = new UserDAO().getFriendSuggestions(currentUser.getId());
                                for (User friend : suggestions) {
                            %>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <%= friend.getFirst_name() %> <%= friend.getLast_name() %>
                                    <button class="btn btn-sm btn-success">Add</button>
                                </li>
                            <% } %>
                        </ul>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Notifications</h5>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">You have 3 new messages.</li>
                            <li class="list-group-item">John Doe liked your post.</li>
                            <li class="list-group-item">You have 2 new friend requests.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
