package com.example.sharefile.controller.admin;

import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import com.example.sharefile.domain.Document;
import com.example.sharefile.domain.User;
import com.example.sharefile.service.DocumentService;
import com.example.sharefile.service.UploadService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

@Controller
public class DocController {

    private final DocumentService documentService;
    private final UploadService uploadService;

    public DocController(
            UploadService uploadService,
            DocumentService documentService) {
        this.uploadService = uploadService;
        this.documentService = documentService;
    }

    @GetMapping("/admin/document")
    public String getDocument(Model model) {
        List<Document> docs = this.documentService.getAllFiles();
        model.addAttribute("documents", docs);
        return "admin/document/show";
    }

    // @GetMapping("/admin/document/create")
    // public String getCreateDocumentPage(Model model) {
    // model.addAttribute("newDocument", new Document());
    // return "admin/document/create";
    // }

    // @PostMapping("/admin/document/create")
    // public String handleCreateDocument(
    // @ModelAttribute("newDocument") Document document,
    // @RequestParam("documentFile") MultipartFile file,
    // Model model) {

    // try {
    // if (file.isEmpty()) {
    // model.addAttribute("message", "Vui lòng chọn file để tải lên!");
    // model.addAttribute("newDocument", document);
    // return "admin/document/create";
    // }

    // // Lấy admin đang đăng nhập
    // Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    // User uploader = (User) auth.getPrincipal();

    // // Lưu document vào DB (bạn cần đảm bảo service này thực sự lưu)
    // documentService.saveFile(file, document, uploader);

    // return "redirect:/admin/document";
    // } catch (Exception e) {
    // e.printStackTrace();
    // model.addAttribute("message", "Lỗi khi tải file lên: " + e.getMessage());
    // model.addAttribute("newDocument", document);
    // return "admin/document/create";
    // }
    // }

    // xem chi tiet document
    @GetMapping("/admin/document/{id}")
    public String getDocumentDetailPage(Model model, @PathVariable long id) {
        Document doc = this.documentService.fetchDocumentById(id).get();
        model.addAttribute("document", doc);
        model.addAttribute("id", id);
        return "admin/document/detail";
    }

    // update document
    @RequestMapping("/admin/document/update/{id}")
    public String getUpdateDetailPage(Model model, @PathVariable long id) {
        Document currentDocument = this.documentService.fetchDocumentById(id).get();
        model.addAttribute("document", currentDocument); // Đổi thành "document"
        return "admin/document/update";
    }

    @PostMapping("/admin/document/update")
    public String handleUpdateDocument(
            @ModelAttribute("document") @Valid Document doc, // Đổi thành "document"
            BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            return "admin/document/update";
        }

        Document currentDocument = documentService.findById(doc.getId());
        if (currentDocument == null) {
            return "redirect:/admin/document?error=notfound";
        }

        currentDocument.setTitle(doc.getTitle());
        currentDocument.setDescription(doc.getDescription());
        this.documentService.createDocument(currentDocument);

        return "redirect:/admin/document";
    }

    @GetMapping("/admin/document/delete/{id}")
    public String getDeleteDocumentPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newDocument", new Document());
        return "admin/document/delete";
    }

    @PostMapping("/admin/document/delete")
    public String postDeleteDocument(Model model, @ModelAttribute("newDocument") Document doc) {
        this.documentService.deleteDocument(doc.getId());
        return "redirect:/admin/document";
    }

}
