package com.mycompany.patinetas.util;

import java.security.SecureRandom;
import java.util.Base64;
import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    
    // Coste del procesamiento (4-31, valor por defecto 10)
    private static final int LOG_ROUNDS = 12;
    
    /**
     * Genera un hash seguro de la contraseña
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(LOG_ROUNDS));
    }
    
    /**
     * Verifica si una contraseña coincide con el hash almacenado
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            // En caso de error en la verificación (hash mal formado, etc.)
            return false;
        }
    }
    
    public static String generateResetToken() {
        byte[] bytes = new byte[32];
        new SecureRandom().nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    public static boolean esContraseñaFuerte(String contraseña) {
        if (contraseña == null || contraseña.length() < 8) {
            return false;
        }

        boolean tieneMayus = !contraseña.equals(contraseña.toLowerCase());
        boolean tieneMinus = !contraseña.equals(contraseña.toUpperCase());
        boolean tieneNumero = contraseña.matches(".*\\d.*");
        boolean tieneEspecial = !contraseña.matches("[A-Za-z0-9]*");

        return tieneMayus && tieneMinus && tieneNumero && tieneEspecial;
    }
}