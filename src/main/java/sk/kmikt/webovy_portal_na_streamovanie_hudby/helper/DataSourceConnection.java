package sk.kmikt.webovy_portal_na_streamovanie_hudby.helper;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DataSourceConnection {
    public DataSourceConnection() {
    }

    public static Connection getConnection() throws NamingException, SQLException {
        Context initContext = new InitialContext();
        Context envContext = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("mvcpool");
        return ds.getConnection();
    }
}

