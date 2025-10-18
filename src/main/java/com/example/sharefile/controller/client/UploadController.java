package com.example.sharefile.controller.client;

import com.example.sharefile.domain.Category;
import com.example.sharefile.domain.Document;
import com.example.sharefile.domain.User;
import com.example.sharefile.service.CategoryService;
import com.example.sharefile.service.DocumentService;
import com.example.sharefile.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/upload")
public class UploadController {

    @Autowired
    private DocumentService documentService;

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public String showUploadForm(Model model) {
        model.addAttribute("categories", categoryService.getAllCategories());
        return "client/file/upload";
    }

    @PostMapping
    public String handleFileUpload(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("fileData") MultipartFile file,
            @RequestParam("categoryId") Long categoryId,
            Model model) {

        if (file.isEmpty()) {
            model.addAttribute("message", "Vui lòng chọn file để tải lên!");
            model.addAttribute("categories", categoryService.getAllCategories());
            return "client/file/upload";
        }

        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String email = authentication.getName(); // ✅ Lấy email người đang đăng nhập
            User uploader = userService.getUserByEmail(email); // ✅ Lấy User entity từ DB

            if (uploader == null) {
                System.out.println("⚠️ Không tìm thấy User trong DB theo email: " + email);
                model.addAttribute("message", "Bạn cần đăng nhập để upload file!");
                return "client/file/upload";
            }

            Category category = categoryService.findById(categoryId);
            Document savedFile = documentService.saveFile(file, title, description, uploader, category);

            model.addAttribute("message", "Tải file thành công!");
            return "redirect:/";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "Lỗi khi tải file lên: " + e.getMessage());
            model.addAttribute("categories", categoryService.getAllCategories());
            return "client/file/upload";
        }
    }

}
