package com.mycompany.patinetas.util;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailService {
    private final String username = "tambo.delivery.683@gmail.com";
    private final String password = "rcxx bito khcd rlmd"; // Usa contraseña de aplicación
    
    public void enviarEmailReset(String destinatario, String resetLink) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        
        Session session = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
        
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        message.setSubject("Restablece tu contraseña - Gestión de Patinetas");
        
        String contenido = "<h2>Restablecimiento de contraseña</h2>"
            + "<p>Hemos recibido una solicitud para restablecer tu contraseña.</p>"
            + "<p>Haz clic en el siguiente enlace para continuar:</p>"
            + "<p><a href=\"" + resetLink + "\">" + resetLink + "</a></p>"
            + "<p><small>Si no solicitaste este cambio, ignora este mensaje.</small></p>";
        
        message.setContent(contenido, "text/html; charset=utf-8");
        
        Transport.send(message);
    }
}