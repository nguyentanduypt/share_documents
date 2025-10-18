package com.example.sharefile.controller.admin;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
// @RequestMapping("/admin")
public class UserController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final UploadService uploadService;

    public UserController(UserService userService, PasswordEncoder passwordEncoder, UploadService uploadService) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.uploadService = uploadService;
    }

    // // 👤 Trang đăng ký admin
    // @GetMapping("/register")
    // public String getRegisterPage(Model model) {
    // model.addAttribute("registerUser", new RegisterDTO());
    // return "admin/auth/register";
    // }

    // // 💾 Xử lý đăng ký admin
    // @PostMapping("/register")
    // public String handleRegister(@ModelAttribute("registerUser") @Valid
    // RegisterDTO registerDTO,
    // BindingResult bindingResult,
    // @RequestParam("avatar") MultipartFile avatar) {

    // List<FieldError> errors = bindingResult.getFieldErrors();
    // for (FieldError error : errors) {
    // System.out.println(">>> " + error.getField() + " - " +
    // error.getDefaultMessage());
    // }

    // if (bindingResult.hasErrors()) {
    // return "admin/auth/register";
    // }

    // if (this.userService.checkEmailExist(registerDTO.getEmail())) {
    // bindingResult.rejectValue("email", "error.registerUser", "Email đã tồn tại");
    // return "admin/auth/register";
    // }

    // String avatarName = this.uploadService.handleSaveUploadedFile(avatar);

    // User user = this.userService.registerDTOtoUser(registerDTO);
    // user.setPassword(this.passwordEncoder.encode(user.getPassword()));
    // user.setAvatar(avatarName);
    // user.setRole(this.userService.getRoleByName("ADMIN"));

    // this.userService.handleSaveUser(user);
    // return "redirect:/admin/login";
    // }

    // // 🔑 Trang đăng nhập admin
    // @GetMapping("/login")
    // public String getLoginPage() {
    // return "admin/auth/login";
    // }

    // // 🚫 Trang lỗi truy cập admin
    // @GetMapping("/access-denied")
    // public String getAccessDeniedPage() {
    // return "admin/auth/access-denied";
    // }
    @RequestMapping("/admin/user")
    public String getUsersPage(Model model) {
        List<User> users = this.userService.getAllUsers();
        model.addAttribute("users1", users);
        System.out.println("check User:" + users);
        return "admin/user/show";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUsersDetailPage(Model model, @PathVariable long id) {
        System.out.println("check path id: " + id);
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        model.addAttribute("id", id);
        return "admin/user/detail";
    }

    @GetMapping(value = "/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserPage(Model model,
            @ModelAttribute("newUser") @Valid User duydeptrai,
            BindingResult newUserBindingResult,
            @RequestParam("avatarFile") MultipartFile file) {
        List<FieldError> errors = newUserBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>" + error.getField() + " - " + error.getDefaultMessage());
        }
        // validate user
        if (newUserBindingResult.hasErrors()) {
            return "admin/user/create";
        }
        // String avatar = this.userService.handleSaveUploadedFile(file, "avatar");
        String avatar = this.uploadService.handleSaveUploadedFileAvatar(file, "avatar");
        String hashpassword = this.passwordEncoder.encode(duydeptrai.getPassword());
        duydeptrai.setAvatar(avatar);
        duydeptrai.setPassword(hashpassword);
        duydeptrai.setRole(this.userService.getRoleByName(duydeptrai.getRole().getName()));
        this.userService.handleSaveUser(duydeptrai);
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/update/{id}")
    public String getUpdateDetailPage(Model model, @PathVariable long id) {
        User currentUser = this.userService.getUserById(id);
        model.addAttribute("newUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUser(Model model, @ModelAttribute("newUser") User duydeptrai) {
        User currentUser = this.userService.getUserById(duydeptrai.getId());
        if (currentUser != null) {
            currentUser.setFullName(duydeptrai.getFullName());
            currentUser.setPhone(duydeptrai.getPhone());
            // currentUser.setAddress(duydeptrai.getAddress());

            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newUser", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUser(Model model, @ModelAttribute("newUser") User duydeptrai) {
        this.userService.deleteUserById(duydeptrai.getId());
        return "redirect:/admin/user";
    }

}
