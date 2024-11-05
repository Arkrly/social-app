<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList"%>
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
    <title>Profile | Social</title>
    <link rel="shortcut icon" href="image/logo.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-card {
            margin: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .my-container {
            margin-top: 100px;
        }
        .post-card {
            margin-bottom: 15px;
            border-radius: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        @media (max-width: 800px) {
            .my-container {
                margin-top: 240px !important;
            }
        }
    </style>
</head>
<body>

    <%@include file="header.jsp" %>

    <main role="main">
        <div class="container my-container">
            <%
                if(request.getAttribute("pmsg") != null) {
            %>
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <%=request.getAttribute("pmsg")%>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            <%
                }
            %>
            <div class="row">
                <div class="col-md-4">
                    <div class="card profile-card text-center">
                        <img src="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getImage() %>" class="card-img-top" alt="Profile Image">
                        <div class="card-body">
                            <h5 class="card-title">My Profile</h5>
                            <p class="card-text">First Name: <%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getFirst_name() %></p>
                            <p class="card-text">Last Name: <%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getLast_name() %></p>
                            <p class="card-text">Email: <%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getEmail() %></p>
                            <a href="profile?deactivate=<%= session.getAttribute("user_id") %>" class="btn btn-danger btn-block">Deactivate</a>
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#profileUpdate">Update</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div>
                        <%
                            ArrayList<Post> posts = (ArrayList<Post>) request.getAttribute("posts");
                            if(posts.isEmpty()) {
                        %>
                            <h4 class="text-center text-muted">No Posts.</h4>
                        <%
                            } else {
                                for(Post post : posts) {
                        %>
                            <div class="card post-card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-2">
                                            <img src="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getImage() %>" class="img-fluid rounded-circle" alt="Profile Image">
                                        </div>
                                        <div class="col-10">
                                            <h5 class="card-title">me</h5>
                                            <h6 class="card-subtitle mb-2 text-muted"><%= post.getBody() %></h6>
                                            <p class="card-text"><small class="text-muted"><%= post.getPost_time() %></small></p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <a href="${pageContext.request.contextPath}/profile?post-delete=<%= post.getPost_id() %>" class="card-link float-right"><i class="far fa-trash-alt" style="color:red;"></i></a>
                                            <a href="${pageContext.request.contextPath}/profile?post-update=<%= post.getPost_id() %>" class="card-link float-right mr-2"><i class="far fa-edit"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Modal for Profile Update -->
    <div class="modal fade" id="profileUpdate" tabindex="-1" role="dialog" aria-labelledby="profileUpdateTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="profileUpdateTitle">Edit Profile</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h4>Change Profile</h4>
                            <form method="post" action="profile">
                                <input type="hidden" name="type" value="change_profile">
                                <div class="form-group">
                                    <label for="first_name">First Name</label>
                                    <input type="text" class="form-control" name="first_name" id="first_name" required value="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getFirst_name() %>">
                                </div>
                                <div class="form-group">
                                    <label for="last_name">Last Name</label>
                                    <input type="text" class="form-control" name="last_name" id="last_name" required value="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getLast_name() %>">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" name="email" id="email" required value="<%= new UserDAO().getUserById((int) session.getAttribute("user_id")).getEmail() %>">
                                </div>
                                <button type="submit" class="btn btn-primary btn-block">Update Profile</button>
                            </form>
                        </div>
                        <div class="col-md-6">
                            <h4>Change Password</h4>
                            <form method="post" action="profile">
                                <input type="hidden" name="type" value="change_password">
                                <div class="form-group">
                                    <label for="password">New Password</label>
                                    <input type="password" class="form-control" name="password" id="password" required placeholder="Type your new password">
                                </div>
                                <div class="form-group">
                                    <label for="cpassword">Confirm Password</label>
                                    <input type="password" class="form-control" name="cpassword" id="cpassword" required placeholder="Confirm your new password">
                                </div>
                                <button type="submit" class="btn btn-primary btn-block">Update Password</button>
                            </form>
                        </div>
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
