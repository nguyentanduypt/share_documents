package com.example.sharefile.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;
import java.util.Date;

import com.example.sharefile.domain.File;
import com.example.sharefile.domain.User;
import com.example.sharefile.repository.FileRepository;

@Service
public class FileService {

    @Autowired
    private FileRepository fileRepository;

    public File saveFile(MultipartFile file, String title, String description, User uploader) throws Exception {
        // Tạo tên file lưu vật lý
        String fileName = file.getOriginalFilename();
        String uploadDir = "uploads/"; // folder gốc trong project (bạn có thể đổi)
        java.nio.file.Path uploadPath = java.nio.file.Paths.get(uploadDir);

        // Tạo thư mục nếu chưa có
        if (!java.nio.file.Files.exists(uploadPath)) {
            java.nio.file.Files.createDirectories(uploadPath);
        }

        // Lưu file vật lý
        java.nio.file.Path filePath = uploadPath.resolve(fileName);
        file.transferTo(filePath.toFile());

        // Lưu thông tin vào DB
        File newFile = new File();
        newFile.setTitle(title);
        newFile.setDescription(description);
        newFile.setFileName(fileName);
        newFile.setFilePath(filePath.toString());
        newFile.setUploadDate(new Date());
        newFile.setUploader(uploader); // có thể null nếu chưa login

        return fileRepository.save(newFile);
    }

    // ✅ Lấy danh sách tất cả file
    public List<File> getAllFiles() {
        return fileRepository.findAll();
    }

    // ✅ Lấy file theo ID (sẽ dùng cho xem chi tiết / tải xuống)
    public File getFileById(Long id) {
        return fileRepository.findById(id).orElse(null);
    }
}
