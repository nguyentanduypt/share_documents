package com.example.sharefile.service;

import java.io.IOException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class UploadService {

    public String handleSaveUploadedFile(MultipartFile multipartFile) {
        try {
            // Thư mục lưu file (resources/file)
            String uploadDir = System.getProperty("user.dir") + "/src/main/webapp/resources/file/";
            java.io.File directory = new java.io.File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            // Tạo tên file lưu
            String fileName = multipartFile.getOriginalFilename();
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
