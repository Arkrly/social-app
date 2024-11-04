<%@ page import="dao.UserDAO" %>

<header>
	<div class="fixed-top d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
		<h3 class="my-0 mr-md-auto font-weight-normal">Social</h3>
		<nav class="my-2 my-md-0 mr-md-3">
			<a class="p-2 text-dark" href="${pageContext.request.contextPath}/home">Home</a>
			<a class="p-2 text-dark" href="${pageContext.request.contextPath}/profile">Profile</a>
			<a class="p-2 text-dark" href="${pageContext.request.contextPath}/message">Message</a>
		</nav>

		<div style="width: 110px; text-align: center;">
			<%
				try {
					UserDAO userDAO = new UserDAO();
					int userId = (int) session.getAttribute("user_id");
					String userImage = userDAO.getUserById(userId).getImage();
			%>
			<img style="border-radius: 100%; height: 60px; width: 60px;" src="<%= userImage %>"  alt=""/>
			<%
				} catch (Exception e) {
					out.println("<img style='border-radius: 100%; height: 60px; width: 60px;' src='/default-image.png' alt='User Image Unavailable'/>");
					e.printStackTrace(); // Log the exception for debugging
				}
			%>
		</div>

		<div>
			<div class="row">
				<%
					try {
						UserDAO userDAO = new UserDAO();
						int userId = (int) session.getAttribute("user_id");
						String userName = userDAO.getUserById(userId).getFirst_name() + " " + userDAO.getUserById(userId).getLast_name();
				%>
				<p style="text-align: center; width: 100%; margin-bottom: 2px;"><%= userName %></p>
				<%
					} catch (Exception e) {
						out.println("<p style='text-align: center; width: 100%; margin-bottom: 2px;'>User Name Unavailable</p>");
						e.printStackTrace(); // Log the exception for debugging
					}
				%>

				<a style="width: 100%;" class="btn btn-outline-primary" href="${pageContext.request.contextPath}/logout">Logout</a>
			</div>
		</div>
	</div>
</header>
