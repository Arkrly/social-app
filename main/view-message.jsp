<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Message"%>
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
    <title>View Messages | Social</title>
    <link rel="shortcut icon" href="image/logo.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .message-container {
            margin-top: 100px;
            margin-bottom: 55px;
        }
        .message-card {
            border-radius: 10px;
            margin-bottom: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .type_msg {
            position: fixed;
            bottom: 20px;
            left: 0;
            right: 0;
            padding: 10px;
        }
        .input_msg_write input {
            border-radius: 20px;
            outline: none;
        }
        @media (max-width: 800px) {
            .message-container {
                margin-top: 240px !important;
            }
        }
    </style>
</head>
<body>

    <%@include file="header.jsp"%>

    <div class="container message-container">
        <h3 class="text-center mb-4">Messages</h3>
        
        <%
            ArrayList<Message> messages = (ArrayList<Message>) request.getAttribute("messages");
            if (messages.isEmpty()) {
        %>
            <div class="alert alert-info" role="alert">
                No Messages.
            </div>
        <%
            } else {
                for (Message message : messages) {
                    String userName = message.getFrom_user().equals(session.getAttribute("user_id").toString())
                        ? "me" 
                        : new UserDAO().getUserById(Integer.parseInt(message.getFrom_user())).getFirst_name();
        %>
            <div class="message-card card <%=(message.getFrom_user().equals(session.getAttribute("user_id").toString()) ? "bg-primary text-white" : "bg-light")%>">
                <div class="card-body">
                    <h5 class="card-title d-flex justify-content-between">
                        <span><%= userName %></span>
                        <a href="${pageContext.request.contextPath}/view-message?id=<%= request.getAttribute("to_user") %>&delete=<%= message.getChat_id() %>" class="card-link"><i class="far fa-trash-alt" style="color: red;"></i></a>
                    </h5>
                    <p class="card-text"><%= message.getMessage() %></p>
                    <p class="card-text"><small class="text-muted"><%= message.getChat_time() %></small></p>
                </div>
            </div>
        <%
                }
            }
        %>
    </div>

    <div class="type_msg">
        <form method="post" action="view-message">
            <div class="input_msg_write">
                <input type="hidden" name="to_user" value="<%=request.getAttribute("to_user")%>" />
                <input type="text" name="message" class="write_msg form-control" placeholder="Type a message" required>
                <button class="btn btn-success" type="submit">
                    <i class="fa fa-paper-plane-o" aria-hidden="true"></i>
                </button>
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        window.scrollTo(0, document.documentElement.scrollHeight);
    </script>
</body>
</html>
