package com.example.sharefile.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {
    private final ServletContext servletContext;

    public UploadService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public String handleSaveUploadedFileAvatar(MultipartFile file, String targetFolder) {
        // dont upload file
        if (file.isEmpty()) {
            return "";
        }
        String rootPath = this.servletContext.getRealPath("/resources/images");
        String finalName = "";
        try {
            byte[] bytes = file.getBytes();

            File dir = new File(rootPath + File.separator + targetFolder);
            if (!dir.exists())
                dir.mkdirs();

            // Create the file on server
            finalName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator +
                    finalName);

            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return finalName;
    }

    public String handleSaveUploadedFile(MultipartFile multipartFile) {
        try {
            // Thư mục lưu file (resources/file)
            String uploadDir = System.getProperty("user.dir") + "/src/main/webapp/resources/file/";
            java.io.File directory = new java.io.File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            // Tạo tên file lưu (tránh trùng tên)
            String originalName = multipartFile.getOriginalFilename();
            String fileName = System.currentTimeMillis() + "-" + originalName;
            String filePath = uploadDir + fileName;

            // Lưu file vật lý
            multipartFile.transferTo(new java.io.File(filePath));

            // Trả về tên file để lưu vào database
            return fileName;

        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lưu file: " + e.getMessage());
        }
    }

}
