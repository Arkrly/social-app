package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import model.User;
import util.DBConnection;

public class UserDAO {

    // Login method allowing for both email and username
    public boolean login(String identifier, String password) {
        boolean result = false;
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement(
                    "SELECT * FROM user WHERE (email = ? OR username = ?) AND password = ?"
            );
            st.setString(1, identifier);
            st.setString(2, identifier);
            st.setString(3, password);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                result = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result = false;
        }
        return result;
    }

    public String register(User user) {
        try {
            PreparedStatement st = getPreparedStatement(user);
            st.execute();
            return "Registration Successful.";
        } catch (SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
            return "Email already used.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Registration Failed.";
        }
    }

    private static PreparedStatement getPreparedStatement(User user) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement st = conn.prepareStatement(
                "INSERT INTO user (username, password, first_name, last_name, email, image) VALUES (?, ?, ?, ?, ?, ?);"
        );
        st.setString(1, user.getUsername());
        st.setString(2, user.getPassword());
        st.setString(3, user.getFirstName());
        st.setString(4, user.getLastName());
        st.setString(5, user.getEmail());
        st.setString(6, user.getImage());
        return st;
    }

    public ArrayList<User> getUsersForChat(String username) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM user WHERE username <> ?");
        st.setString(1, username);
        ResultSet rs = st.executeQuery();
        ArrayList<User> array = new ArrayList<>();
        while (rs.next()) {
            User u = new User();
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setFirstName(rs.getString("first_name"));
            u.setLastName(rs.getString("last_name"));
            u.setEmail(rs.getString("email"));
            u.setImage(rs.getString("image"));
            array.add(u);
        }
        return array;
    }

    public User getUserByUsername(String username) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM user WHERE username = ?");
        st.setString(1, username);
        ResultSet rs = st.executeQuery();
        User u = new User();
        if (rs.next()) {
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setFirstName(rs.getString("first_name"));
            u.setLastName(rs.getString("last_name"));
            u.setEmail(rs.getString("email"));
            u.setImage(rs.getString("image"));
        }
        return u;
    }

    public User getUserByEmail(String email) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM user WHERE email = ?");
        st.setString(1, email);
        ResultSet rs = st.executeQuery();
        User u = new User();
        if (rs.next()) {
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setFirstName(rs.getString("first_name"));
            u.setLastName(rs.getString("last_name"));
            u.setEmail(rs.getString("email"));
            u.setImage(rs.getString("image"));
        }
        return u;
    }

    public void deleteUser(String username) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement st = conn.prepareStatement("DELETE FROM user WHERE username = ?;");
        st.setString(1, username);
        st.executeUpdate();
    }

    public String updateProfile(User user) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement(
                    "UPDATE user SET first_name = ?, last_name = ?, email = ?, image = ? WHERE username = ?;"
            );
            st.setString(1, user.getFirstName());
            st.setString(2, user.getLastName());
            st.setString(3, user.getEmail());
            st.setString(4, user.getImage());
            st.setString(5, user.getUsername());
            st.executeUpdate();
            return "Profile Update Successful.";
        } catch (SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
            return "Email already used.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Profile Update Failed.";
        }
    }

    public String updatePassword(User user) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("UPDATE user SET password = ? WHERE username = ?;");
            st.setString(1, user.getPassword());
            st.setString(2, user.getUsername());
            st.executeUpdate();
            return "Password Update Successful.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Password Update Failed.";
        }
    }

    public User getUserByIdentifier(String identifier) {
        User user = null;
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement(
                    "SELECT * FROM user WHERE email = ? OR username = ?"
            );
            st.setString(1, identifier);
            st.setString(2, identifier);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setImage(rs.getString("image"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
