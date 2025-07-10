package com.mycompany.patinetas.util;

import javax.servlet.ServletContext;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

public class FileUploadUtil {
    public static String guardarArchivo(Part filePart, String applicationPath) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        String uploadPath = applicationPath + "resources" + File.separator + "uploads";
        
        // Crear directorio si no existe
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Generar nombre único para el archivo
        String fileName = UUID.randomUUID().toString() + "-" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // Guardar archivo
        Files.copy(filePart.getInputStream(), Paths.get(uploadPath + File.separator + fileName));
        
        return "resources/uploads/" + fileName;
    }
}
