<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Message" %>
<%@ page import="dao.UserDAO" %>
<%
if (session == null || session.getAttribute("user_id") == null) {
    response.sendRedirect("login");
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Messages | Social</title>
    <link rel="shortcut icon" href="image/logo.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Light gray background */
        }
        .message-container {
            margin-top: 100px;
            margin-bottom: 100px;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .message {
            margin-bottom: 15px;
        }
        .type_msg {
            position: fixed;
            bottom: 20px;
            width: calc(100% - 40px);
            padding: 10px;
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

    <%@include file="header.jsp" %>

    <div class="container">
        <div class="message-container">
            <h4 class="text-center">Messages</h4>
            <%
            ArrayList<Message> messages = (ArrayList<Message>) request.getAttribute("messages");

            if (messages.size() == 0) {
                %>
                <h5 class="text-center text-muted">No Messages.</h5>
                <%
            }

            for (Message message : messages) {
                boolean isSender = message.getFrom_user().equals(session.getAttribute("user_id").toString());
                String userName = isSender ? "me" : new UserDAO().getUserById(Integer.parseInt(message.getFrom_user())).getFirst_name();
                String alertClass = isSender ? "alert-primary" : "alert-secondary";
                %>
                <div class="row justify-content-<%= isSender ? "end" : "start" %>">
                    <div class="col-8 alert <%= alertClass %> message" role="alert">
                        <h6>
                            <%= userName %> 
                            <a href="${pageContext.request.contextPath}/view-message?id=<%= request.getAttribute("to_user") %>&delete=<%= message.getChat_id() %>" class="card-link" style="float: right;">
                                <i style="color: red;" class="far fa-trash-alt"></i>
                            </a>
                        </h6>
                        <p><%= message.getMessage() %></p>
                        <p class="text-right text-muted"><%= message.getChat_time() %></p>
                    </div>
                </div>
                <%
            }
            %>
        </div>

        <div class="type_msg">
            <form method="post" action="view-message">
                <div class="input_msg_write">
                    <input type="hidden" name="to_user" value="<%= request.getAttribute("to_user") %>" />
                    <input type="text" name="message" class="write_msg" placeholder="Type a message" required style="padding: 10px; border-radius: 20px; border: 1px solid #ced4da; width: calc(100% - 70px); outline: none;" />
                    <button class="msg_send_btn btn btn-primary" type="submit" style="border-radius: 50%; margin-left: 10px;">
                        <i class="fa fa-paper-plane-o" aria-hidden="true"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        window.scrollTo(0, document.body.scrollHeight);
    </script>
</body>
</html>
