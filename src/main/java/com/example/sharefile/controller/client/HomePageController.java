package com.example.sharefile.controller.client;

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
import com.example.sharefile.domain.File;
import com.example.sharefile.domain.User;
import com.example.sharefile.domain.dto.RegisterDTO;
import com.example.sharefile.service.FileService;
import com.example.sharefile.service.UserService;

@Controller
public class HomePageController {

    private final FileService fileService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public HomePageController(FileService fileService,
            UserService userService,
            PasswordEncoder passwordEncoder) {
        this.fileService = fileService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    // Trang chủ hiển thị danh sách tài liệu
    @GetMapping("/")
    public String getHomePage(Model model) {
        List<File> documents = fileService.getAllFiles();
        model.addAttribute("documents", documents);
        return "client/homepage/show";
    }

    // Trang đăng ký user
    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    // Xử lý đăng ký tài khoản user
    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult) {

        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>> " + error.getField() + " - " + error.getDefaultMessage());
        }

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }

        User user = this.userService.registerDTOtoUser(registerDTO);
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("USER"));
        this.userService.handleSaveUser(user);

        return "redirect:/login";
    }

    // Trang đăng nhập client
    @GetMapping("/login")
    public String getLoginPage() {
        return "client/auth/login";
    }

    // Trang lỗi truy cập client
    @GetMapping("/access-denied")
    public String getAccessDeniedPage() {
        return "client/auth/access-denied";
    }
}
