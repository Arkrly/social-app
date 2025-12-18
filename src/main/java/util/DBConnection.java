package util;

import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;
import com.mysql.cj.jdbc.MysqlDataSource;

public class DBConnection {

    private static DBConnection instance;
    private final DataSource dataSource;

    private DBConnection() throws SQLException {
        // Read configuration from environment variables with defaults for local development
        String host = getEnv("DB_HOST", "localhost");
        String port = getEnv("DB_PORT", "3306");
        String database = getEnv("DB_NAME", "social_db");
        String user = getEnv("DB_USER", "root");
        String password = getEnv("DB_PASSWORD", "root");
        
        String url = String.format("jdbc:mysql://%s:%s/%s?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC", 
                                   host, port, database);
        
        MysqlDataSource mysqlDataSource = new MysqlDataSource();
        mysqlDataSource.setURL(url);
        mysqlDataSource.setUser(user);
        mysqlDataSource.setPassword(password);
        this.dataSource = mysqlDataSource;
    }

    private static String getEnv(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value != null && !value.isEmpty()) ? value : defaultValue;
    }

    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static DBConnection getInstance() throws SQLException {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }
}
