package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO(); // Initialize the UserDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String identifier = request.getParameter("identifier"); // This can be email or username
        String password = request.getParameter("password");

        // Attempt to log in the user using either email or username
        boolean isLoggedIn = userDAO.login(identifier, password);

        if (isLoggedIn) {
            // If login is successful, set the user session and redirect to the home page
            User loggedInUser = userDAO.getUserByIdentifier(identifier); // Fetch the user details
            request.getSession().setAttribute("user", loggedInUser); // Set the logged-in user in session
            response.sendRedirect("home.jsp"); // Redirect to home page
        } else {
            // If login fails, redirect to login page with error message
            request.setAttribute("errorMessage", "Invalid email or username/password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
