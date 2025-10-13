package com.example.sharefile.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import java.nio.file.*;
import java.time.LocalDateTime;
import java.io.File;
import java.util.List;

import com.example.sharefile.domain.Document;
import com.example.sharefile.domain.User;
import com.example.sharefile.repository.DocumentRepository;

@Service
public class DocumentService {

    @Autowired
    private DocumentRepository documentRepository;

    // 🔹 Cấu hình thư mục upload cố định trong project (tên trùng với cấu hình
    // trong WebMvcConfig)
    @Value("${file.upload-dir:src/main/webapp/resources/file/}")
    private String uploadDir;

    public Document saveFile(MultipartFile file, String title, String description, User uploader) throws Exception {
        String fileName = file.getOriginalFilename();

        // ✅ Lấy đường dẫn tuyệt đối để lưu file
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        Path filePath = Paths.get(uploadFolder.getAbsolutePath(), fileName);
        file.transferTo(filePath.toFile());

        // ✅ Lưu thông tin file vào DB
        Document newFile = new Document();
        newFile.setTitle(title);
        newFile.setDescription(description);
        newFile.setFileName(fileName);
        newFile.setFileType(file.getContentType());
        newFile.setUploadDate(LocalDateTime.now());
        newFile.setUploader(uploader);

        return documentRepository.save(newFile);
    }

    public List<Document> getAllFiles() {
        return documentRepository.findAll();
    }

    public Document findById(Long id) {
        return documentRepository.findById(id).orElse(null);
    }
}
