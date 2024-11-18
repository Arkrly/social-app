<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="model.Post"%>
<%@ page import="dao.UserDAO"%>
<%
if (session == null || session.getAttribute("user_id") == null) {
    response.sendRedirect("login");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Post | Social</title>
    <link rel="shortcut icon" href="image/logo.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 100px;
            margin-bottom: 100px;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-control {
            border-radius: 20px;
        }
        .btn-custom {
            border-radius: 20px;
        }
    </style>
</head>
<body>

    <%@include file="header.jsp" %>

    <div class="container">
        <h2 class="text-center">Update Your Post</h2>
        <form method="post" action="profile">
            <input type="hidden" name="post_id" value="<%= request.getAttribute("post_id") %>">
            <input type="hidden" name="type" value="update_post">
            <div class="form-group">
                <label for="postBody">Post Content</label>
                <textarea id="postBody" name="post_body" class="form-control" rows="5" required><%= ((Post) request.getAttribute("post")).getBody() %></textarea>
            </div>
            <div class="form-group text-center">
                <button type="submit" class="btn btn-primary btn-custom">Update Post</button>
                <a href="profile" class="btn btn-secondary btn-custom">Cancel</a>
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
