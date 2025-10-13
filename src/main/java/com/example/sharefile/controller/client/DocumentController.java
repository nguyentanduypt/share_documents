package com.example.sharefile.controller.client;

import com.example.sharefile.domain.Document;
import com.example.sharefile.service.DocumentService;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import java.io.FileInputStream;

@Controller
public class DocumentController {

    @Autowired
    private DocumentService documentService;

    // ✅ Xem chi tiết tài liệu
    @GetMapping("/document/{id}")
    public String showDetail(@PathVariable Long id, Model model) throws IOException {
        Document doc = documentService.findById(id);
        if (doc == null) {
            return "redirect:/?error=notfound";
        }
        model.addAttribute("doc", doc);

        String content = "";
        String filePath = doc.getFilePath();

        if (filePath != null && (filePath.endsWith(".txt") || filePath.endsWith(".md") || filePath.endsWith(".csv"))) {
            Path path = Paths.get(filePath);
            if (Files.exists(path)) {
                content = Files.readString(path);
            } else {
                content = "⚠️ File không tồn tại trong hệ thống.";
            }
        } else {
            content = "⚠️ Không có nội dung hoặc định dạng file không hỗ trợ hiển thị.";
        }

        model.addAttribute("content", content);
        return "client/file/detail";
    }

    // ✅ 2. Tải file về
    @GetMapping("/download/{id}")
    public ResponseEntity<Resource> downloadFile(@PathVariable("id") Long id) {
        try {
            Document doc = documentService.findById(id);
            if (doc == null) {
                return ResponseEntity.notFound().build();
            }

            Path filePath = Paths.get("src/main/webapp/resources/file/" + doc.getFileName());
            Resource resource = new UrlResource(filePath.toUri());

            if (!resource.exists()) {
                return ResponseEntity.notFound().build();
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
