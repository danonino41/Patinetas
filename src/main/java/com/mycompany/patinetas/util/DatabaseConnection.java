package com.mycompany.patinetas.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/gestionpatinetas?useUnicode=true&characterEncoding=UTF-8&useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "admin";
    
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Configuración adicional para evitar problemas comunes
            Properties connectionProps = new Properties();
            connectionProps.put("user", USER);
            connectionProps.put("password", PASSWORD);
            connectionProps.put("useSSL", "false");
            connectionProps.put("autoReconnect", "true");
            connectionProps.put("serverTimezone", "UTC");
            
            Connection connection = DriverManager.getConnection(URL, connectionProps);
            
            // Verifica que la conexión sea válida
            if (connection == null || connection.isClosed()) {
                throw new SQLException("[DEBUG]: No se pudo establecer la conexión");
            }
            
            return connection;
            
        } catch (ClassNotFoundException e) {
            throw new SQLException("[DEBUG]: Driver JDBC no encontrado", e);
        }
    }
}