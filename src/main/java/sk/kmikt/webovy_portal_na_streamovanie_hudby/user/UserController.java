package sk.kmikt.webovy_portal_na_streamovanie_hudby.user;

import org.springframework.security.crypto.bcrypt.BCrypt;
import sk.kmikt.webovy_portal_na_streamovanie_hudby.helper.DataSourceConnection;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class UserController {
    public boolean insertUser(User user) throws SQLException, NamingException
    {
        String sqlInsertUser = "INSERT INTO users (name, dob, email, password) VALUES (?, ?, ?, ?)";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlInsertUser);

            ps.setString(1, user.getName());
            ps.setDate(2, new java.sql.Date(user.getDob().getTime()));
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());

            return ps.executeUpdate() > 0;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateUser(User user) throws SQLException, NamingException
    {
        String sqlUpdateUser = "UPDATE users SET name = ?, dob = ?, email = ?, password = ? WHERE user_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlUpdateUser);

            ps.setString(1, user.getName());
            ps.setDate(2, new java.sql.Date(user.getDob().getTime()));
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getUser_id());

            return ps.executeUpdate() > 0;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteUser(int id) throws SQLException, NamingException
    {
        String sqlDeleteUser = "DELETE FROM users WHERE user_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlDeleteUser);

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return false;
    }

    public ArrayList<User> getAllUsers() throws SQLException, NamingException
    {
        String sqlGetAllUsers = "SELECT * FROM users";
        ArrayList<User> users = new ArrayList<>();

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlGetAllUsers);
            ResultSet rs = ps.executeQuery();

            while (rs.next())
            {
                int user_id = rs.getInt("user_id");
                String name = rs.getString("name");
                java.util.Date dob = new java.util.Date(rs.getDate("dob").getTime());
                String email = rs.getString("email");
                String password = rs.getString("password");
                boolean is_admin = rs.getBoolean("is_admin");

                User user = new User(user_id, name, dob, email, password, is_admin);
                users.add(user);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return users;
    }

    public User getUserByEmail(String login) throws SQLException, NamingException
    {
        String sqlGetUserByEmail = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlGetUserByEmail);
            ps.setString(1, login);
            ResultSet rs = ps.executeQuery();

            while (rs.next())
            {
                int user_id = rs.getInt("user_id");
                String name = rs.getString("name");
                java.util.Date dob = new java.util.Date(rs.getDate("dob").getTime());
                String email = rs.getString("email");

                return login.equals(email) ? new User(user_id, name, dob, email) : null;
            }

            return null;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }

        return null;
    }

    public User getUserById(int id) throws SQLException, NamingException
    {
        String sqlGetUserById = "SELECT * FROM users WHERE user_id = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlGetUserById);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next())
            {
                int user_id = rs.getInt("user_id");
                String name = rs.getString("name");
                java.util.Date dob = new java.util.Date(rs.getDate("dob").getTime());
                String email = rs.getString("email");
                String password = rs.getString("password");
                boolean is_admin = rs.getBoolean("is_admin");

                return id == user_id ? new User(user_id, name, dob, email, password, is_admin) : null;
            }

            return null;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }

        return null;
    }

    public User verifyLogin(String login, String password) throws SQLException, NamingException
    {
        String sqlVerifyLogin = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sqlVerifyLogin);
            ps.setString(1, login);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String passwordHash = rs.getString("password");
                return BCrypt.checkpw(password, passwordHash) ? new User(rs.getString("name"), rs.getString("email"), rs.getBoolean("is_admin")) : null;
            }
            else {
                return null;
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return null;
        }
    }
}
