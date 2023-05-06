package sk.kmikt.webovy_portal_na_streamovanie_hudby.user;

import org.springframework.security.crypto.bcrypt.BCrypt;
import sk.kmikt.webovy_portal_na_streamovanie_hudby.helper.DataSourceConnection;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class UserController {
    public boolean insertUser(User user) throws SQLException, NamingException {
        String sql = "INSERT INTO users (name, dob, email, password) VALUES (?, ?, ?, ?)";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setDate(2, new java.sql.Date(user.getDob().getTime()));
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());

            return ps.executeUpdate() > 0;
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByEmail(String login) throws SQLException, NamingException {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, login);
            ResultSet rs = ps.executeQuery();

            if (rs.next())
            {
                int user_id = rs.getInt("user_id");
                String name = rs.getString("name");
                java.util.Date dob = new java.util.Date(rs.getDate("dob").getTime());
                String email = rs.getString("email");

                return login.equals(email) ? new User(user_id, name, dob, email) : null;
            }
            else
            {
                return null;
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }

        return null;
    }

    public User verifyLogin(String login, String password) throws SQLException, NamingException {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DataSourceConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, login);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String passwordHash = rs.getString("password");
                return BCrypt.checkpw(password, passwordHash) ? new User(rs.getString("name"), rs.getString("email")) : null;
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
