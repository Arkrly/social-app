package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO(); // Initialize the UserDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String email = request.getParameter("email");
        String image = request.getParameter("image");

        // Create a new User object
        User user = new User(username, password, firstName, lastName, email, image);

        // Attempt to register the user
        String registrationResult = userDAO.register(user);

        // Check the result and redirect or forward accordingly
        if ("Registration Successful.".equals(registrationResult)) {
            // Registration successful, redirect to login page
            response.sendRedirect("login.jsp?message=Registration successful! Please log in.");
        } else {
            // Registration failed, set error message and forward to registration page
            request.setAttribute("errorMessage", registrationResult);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
