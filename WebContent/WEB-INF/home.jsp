<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post" %>
<%@ page import="dao.UserDAO" %>

<%
	// Redirect to login page if session or user ID is null
	if (session == null || session.getAttribute("user_id") == null) {
		response.sendRedirect("login");
		return;
	}
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
	<style type="text/css">
		.my-container {
			margin-top: 120px;
		}
		@media (max-width:800px) {
			.my-container {
				margin-top: 240px !important;
			}
		}
	</style>
</head>
<body class="bg-dark">

<%@ include file="header.jsp" %>

<main role="main">
	<div class="my-container">
		<div class="row">
			<div class="col-md-4 col-sm-12">
				<div style="padding: 20px;">
					<form action="home" method="post">
						<div class="form-group">
							<label for="post" style="color: #ffffff">Create Post</label>
							<textarea name="post" class="form-control" id="post" rows="3"></textarea>
						</div>
						<button type="submit" class="btn btn-primary">Post</button>
					</form>
				</div>
			</div>
			<div class="col-md-8 col-sm-12">
				<div style="padding: 20px;">
					<%
						// Retrieve posts list and handle if null or empty
						ArrayList<Post> posts = (ArrayList<Post>) request.getAttribute("posts");
						if (posts == null || posts.isEmpty()) {
					%>
					<h4 style="text-align: center; color: #ffffff;">No Posts.</h4>
					<%
					} else {
						UserDAO userDAO = new UserDAO();
						for (int i = 0; i < posts.size(); i++) {
							Post post = posts.get(i);
					%>

					<div class="card mb-3">
						<div class="card-body">
							<div class="row">
								<div class="col-2">
									<%
										try {
											String userImage = userDAO.getUserById(post.getUser_id()).getImage();
											if (userImage != null) {
									%>
									<img style="width: 100%; border-radius: 100%;" src="<%= userImage %>" />
									<%
									} else {
									%>
									<img style="width: 100%; border-radius: 100%;" src="image/default-profile.png" alt="Default Profile" />
									<%
											}
										} catch (Exception e) {
											out.println("<img style='width: 100%; border-radius: 100%;' src='image/default-profile.png' alt='Image Unavailable' />");
											e.printStackTrace(); // Log the error for debugging
										}
									%>
								</div>
								<div class="col-10">
									<%
										try {
											String userName;
											if (post.getUser_id() == (int) session.getAttribute("user_id")) {
												userName = "me";
											} else {
												userName = userDAO.getUserById(post.getUser_id()).getFirst_name();
											}
									%>
									<h5 class="card-title"><%= userName %></h5>
									<%
										} catch (Exception e) {
											out.println("<h5 class='card-title'>User Unavailable</h5>");
											e.printStackTrace();
										}
									%>
									<h6 class="card-subtitle mb-2 text-muted"><%= post.getBody() %></h6>
									<p class="card-text"><%= post.getPost_time() %></p>
								</div>
							</div>
						</div>
					</div>

					<%
							} // End of posts loop
						} // End of if-else for posts list
					%>

				</div>
			</div>
		</div>
	</div>
</main>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.ckeditor.com/4.25.0/standard/ckeditor.js"></script>
<script>
	CKEDITOR.replace('post');
</script>

</body>
</html>
