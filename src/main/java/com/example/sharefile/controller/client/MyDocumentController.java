package com.example.sharefile.controller.client;

import com.example.sharefile.domain.Document;
import com.example.sharefile.service.DocumentService;
import com.example.sharefile.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;
import java.util.List;

@Controller
public class MyDocumentController {

    @Autowired
    private DocumentService documentService;

    @Autowired
    private UserService userService;

    // Trang hiển thị tài liệu của người dùng hiện tại
    @GetMapping("/my-files")
    public String myFiles(Model model, Principal principal) {
        if (principal == null) {
            return "redirect:/login";
        }

        // Lấy user hiện tại
        var user = userService.findByUsername(principal.getName());

        // Lấy các tài liệu mà user này đã upload
        List<Document> documents = documentService.findByUploader(user);

        model.addAttribute("documents", documents);
        return "client/file/my-files";
    }
}
