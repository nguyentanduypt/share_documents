package com.example.sharefile.controller.client;

import com.example.sharefile.domain.Category;
import com.example.sharefile.domain.Document;
import com.example.sharefile.service.CategoryService;
import com.example.sharefile.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping("/document")
public class DocumentController {

    @Autowired
    private DocumentService documentService;
    @Autowired
    private CategoryService categoryService;

    // ✅ Xem chi tiết tài liệu
    @GetMapping("/{id}")
    public String showDetail(@PathVariable Long id, Model model) {
        Document doc = documentService.findById(id);
        if (doc == null) {
            return "redirect:/?error=notfound";
        }

        // ✅ Tạo URL truy cập trực tiếp tới file
        String fileUrl = "/file/" + doc.getFileName();

        // ✅ Gửi dữ liệu sang JSP
        model.addAttribute("doc", doc);
        model.addAttribute("fileUrl", fileUrl);

        return "client/file/detail";
    }

    // ✅ Tải file về
    @GetMapping("/download/{id}")
    public ResponseEntity<Resource> downloadFile(@PathVariable("id") Long id) {
        try {
            Document doc = documentService.findById(id);
            if (doc == null) {
                return ResponseEntity.notFound().build();
            }

            Path filePath = Paths.get("src/main/webapp/resources/file/" + doc.getFileName());
            if (!Files.exists(filePath)) {
                return ResponseEntity.notFound().build();
            }

            Resource resource = new UrlResource(filePath.toUri());
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/")
    public String showHomePage(@RequestParam(required = false) Long categoryId, Model model) {
        List<Category> categories = categoryService.getAllCategories();

        List<Document> documents;
        if (categoryId != null) {
            documents = documentService.findByCategoryId(categoryId);
        } else {
            documents = documentService.getAllFiles();
        }

        model.addAttribute("categories", categories);
        model.addAttribute("documents", documents);
        model.addAttribute("selectedCategoryId", categoryId);
        return "client/homepage/show";
    }

}
