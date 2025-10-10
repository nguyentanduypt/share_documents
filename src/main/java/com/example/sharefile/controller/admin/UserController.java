package com.example.sharefile.controller.admin;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import com.example.sharefile.domain.User;
import com.example.sharefile.domain.dto.RegisterDTO;
import com.example.sharefile.service.UserService;
import com.example.sharefile.service.UploadService;

@Controller
@RequestMapping("/admin")
public class UserController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final UploadService uploadService;

    public UserController(UserService userService, PasswordEncoder passwordEncoder, UploadService uploadService) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.uploadService = uploadService;
    }

    // 👤 Trang đăng ký admin
    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "admin/auth/register";
    }

    // 💾 Xử lý đăng ký admin
    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult,
            @RequestParam("avatar") MultipartFile avatar) {

        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>> " + error.getField() + " - " + error.getDefaultMessage());
        }

        if (bindingResult.hasErrors()) {
            return "admin/auth/register";
        }

        if (this.userService.checkEmailExist(registerDTO.getEmail())) {
            bindingResult.rejectValue("email", "error.registerUser", "Email đã tồn tại");
            return "admin/auth/register";
        }

        String avatarName = this.uploadService.handleSaveUploadedFile(avatar);

        User user = this.userService.registerDTOtoUser(registerDTO);
        user.setPassword(this.passwordEncoder.encode(user.getPassword()));
        user.setAvatar(avatarName);
        user.setRole(this.userService.getRoleByName("ADMIN"));

        this.userService.handleSaveUser(user);
        return "redirect:/admin/login";
    }

    // 🔑 Trang đăng nhập admin
    @GetMapping("/login")
    public String getLoginPage() {
        return "admin/auth/login";
    }

    // 🚫 Trang lỗi truy cập admin
    @GetMapping("/access-denied")
    public String getAccessDeniedPage() {
        return "admin/auth/access-denied";
    }
}
