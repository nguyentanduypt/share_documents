package com.example.sharefile.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.example.sharefile.domain.User;
import com.example.sharefile.service.DocumentService;
import com.example.sharefile.domain.Document;

@Controller
@RequestMapping("/upload")
public class UploadController {

    @Autowired
    private DocumentService documentService;

    @GetMapping
    public String showUploadForm() {
        return "client/file/upload";
    }

    @PostMapping
    public String handleFileUpload(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("fileData") MultipartFile file,
            Model model) {

        if (file.isEmpty()) {
            model.addAttribute("message", "Vui lòng chọn file để tải lên!");
            return "client/file/upload";
        }

        try {
            // 🔹 Giả sử bạn chưa dùng login, ta tạo uploader tạm null
            User uploader = null;

            Document savedFile = documentService.saveFile(file, title, description, uploader);
            model.addAttribute("message", "Tải file thành công!");
            model.addAttribute("fileName", savedFile.getFileName());

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "Lỗi khi tải file lên: " + e.getMessage());
        }

        return "redirect:/";
    }
}
