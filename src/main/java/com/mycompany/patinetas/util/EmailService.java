package com.mycompany.patinetas.util;

import com.mycompany.patinetas.models.DetalleVenta;
import com.mycompany.patinetas.models.Venta;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailService {
    private final String username = "tambo.delivery.683@gmail.com";
    private final String password = "rcxx bito khcd rlmd"; // Usa contraseña de aplicación
    private final String nombreTienda = "Patinetas Shop";
    
    public void enviarEmailReset(String destinatario, String resetLink) throws MessagingException, UnsupportedEncodingException {
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
        message.setFrom(new InternetAddress(username, nombreTienda));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        message.setSubject("Restablece tu contraseña - Gestión de Patinetas");
        
        String contenido = "<html><body style='font-family: Arial, sans-serif;'>" 
            + "<div style='max-width: 600px; margin: 0 auto;'>" 
            + "<div style='background-color: #f8f9fa; padding: 20px; text-align: center;'>"
            + "<h1 style='color: #343a40;'>"
            + "<h2 style='color: #28a745;'>Restablecimiento de contraseña</h2>"
            + "<p>Hemos recibido una solicitud para restablecer tu contraseña.</p>"
            + "<p>Haz clic en el siguiente enlace para continuar:</p>"
            + "<p><a href=\"" + resetLink + "\">" + "Enlace de recuperacion" + "</a></p>"
            + "<p><small>Si no solicitaste este cambio, ignora este mensaje.</small></p>"
            + "</div>"
            + "</div></body></html>";
        
        message.setContent(contenido, "text/html; charset=utf-8");
        
        Transport.send(message);
    }
    
    public void enviarConfirmacionVenta(String destinatario, Venta venta, List<DetalleVenta> detalles) 
            throws MessagingException, UnsupportedEncodingException {
        
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
        message.setFrom(new InternetAddress(username, nombreTienda));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        message.setSubject("Confirmación de tu compra #" + venta.getId());
        
        String contenido = construirContenidoEmail(venta, detalles);
        message.setContent(contenido, "text/html; charset=utf-8");
        
        Transport.send(message);
    }
    
    private String construirContenidoEmail(Venta venta, List<DetalleVenta> detalles) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        StringBuilder sb = new StringBuilder();
        
        sb.append("<html><body style='font-family: Arial, sans-serif;'>");
        sb.append("<div style='max-width: 600px; margin: 0 auto;'>");
        
        // Encabezado
        sb.append("<div style='background-color: #f8f9fa; padding: 20px; text-align: center;'>");
        sb.append("<h1 style='color: #343a40;'>").append(nombreTienda).append("</h1>");
        sb.append("<h2 style='color: #28a745;'>¡Gracias por tu compra!</h2>");
        sb.append("</div>");
        
        // Resumen de la compra
        sb.append("<div style='padding: 20px;'>");
        sb.append("<h3 style='color: #343a40;'>Resumen de tu pedido #").append(venta.getId()).append("</h3>");
        sb.append("<p><strong>Fecha:</strong> ").append(dateFormat.format(venta.getFecha())).append("</p>");
        sb.append("<p><strong>Total:</strong> $").append(String.format("%.2f", venta.getTotal())).append("</p>");
        
        // Tabla de productos
        sb.append("<table style='width: 100%; border-collapse: collapse; margin: 20px 0;'>");
        sb.append("<tr style='background-color: #e9ecef;'>");
        sb.append("<th style='padding: 10px; text-align: left; border: 1px solid #dee2e6;'>Producto</th>");
        sb.append("<th style='padding: 10px; text-align: center; border: 1px solid #dee2e6;'>Cantidad</th>");
        sb.append("<th style='padding: 10px; text-align: right; border: 1px solid #dee2e6;'>Subtotal</th>");
        sb.append("</tr>");
        
        for (DetalleVenta detalle : detalles) {
            sb.append("<tr>");
            sb.append("<td style='padding: 10px; border: 1px solid #dee2e6;'>").append(detalle.getNombreProducto()).append("</td>");
            sb.append("<td style='padding: 10px; text-align: center; border: 1px solid #dee2e6;'>").append(detalle.getCantidad()).append("</td>");
            sb.append("<td style='padding: 10px; text-align: right; border: 1px solid #dee2e6;'>$")
              .append(String.format("%.2f", detalle.getSubtotal())).append("</td>");
            sb.append("</tr>");
        }
        
        sb.append("<tr style='font-weight: bold;'>");
        sb.append("<td colspan='2' style='padding: 10px; text-align: right; border: 1px solid #dee2e6;'>Total:</td>");
        sb.append("<td style='padding: 10px; text-align: right; border: 1px solid #dee2e6;'>$")
          .append(String.format("%.2f", venta.getTotal())).append("</td>");
        sb.append("</tr>");
        sb.append("</table>");
        
        // Mensaje final
        sb.append("<p>Tu pedido ha sido procesado exitosamente. Te avisaremos cuando sea enviado.</p>");
        sb.append("<p>Si tienes alguna pregunta, contáctanos respondiendo a este correo.</p>");
        
        sb.append("</div>");
        
        // Pie de página
        sb.append("<div style='background-color: #f8f9fa; padding: 20px; text-align: center; font-size: 12px; color: #6c757d;'>");
        sb.append("<p>© ").append(nombreTienda).append(" - Todos los derechos reservados</p>");
        sb.append("</div>");
        
        sb.append("</div></body></html>");
        
        return sb.toString();
    }
}