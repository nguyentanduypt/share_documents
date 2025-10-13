package com.example.sharefile.controller.client;

import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.validation.Valid;
import com.example.sharefile.domain.Document;
import com.example.sharefile.domain.User;
import com.example.sharefile.domain.dto.RegisterDTO;
import com.example.sharefile.service.DocumentService;
import com.example.sharefile.service.UserService;

@Controller
public class HomePageController {

    private final DocumentService fileService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public HomePageController(DocumentService fileService,
            UserService userService,
            PasswordEncoder passwordEncoder) {
        this.fileService = fileService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    // Trang chủ hiển thị danh sách tài liệu
    @GetMapping("/")
    public String getHomePage(Model model) {
        List<Document> documents = fileService.getAllFiles();

        // Format ngày upload cho đẹp
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        documents.forEach(doc -> {
            if (doc.getUploadDate() != null) {
                doc.setFormattedDate(doc.getUploadDate().format(formatter));
            }
        });

        model.addAttribute("documents", documents);
        return "client/homepage/show";
    }

    // 🧍 Trang đăng ký user
    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    // 📝 Xử lý đăng ký tài khoản user
    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult) {

        // In ra lỗi validation (nếu có)
        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>> " + error.getField() + " - " + error.getDefaultMessage());
        }

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }

        // Tạo user mới từ RegisterDTO
        User user = this.userService.registerDTOtoUser(registerDTO);

        // Mã hóa mật khẩu
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);

        // Gán quyền mặc định là USER
        user.setRole(this.userService.getRoleByName("USER"));

        // Lưu user vào database
        this.userService.handleSaveUser(user);

        return "redirect:/login";
    }

    // 🔐 Trang đăng nhập client
    @GetMapping("/login")
    public String getLoginPage() {
        return "client/auth/login";
    }

    // 🚫 Trang lỗi truy cập client
    @GetMapping("/access-denied")
    public String getAccessDeniedPage() {
        return "client/auth/access-denied";
    }
}
