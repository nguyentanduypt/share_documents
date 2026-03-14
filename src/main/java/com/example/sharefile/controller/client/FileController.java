package com.example.sharefile.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.example.sharefile.domain.Document;
import com.example.sharefile.service.DocumentService;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;

@Controller
@RequestMapping("/file")
public class FileController {

    @Autowired
    private DocumentService documentService;

    @GetMapping("/{id}")
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@PathVariable Long id) {
        try {
            Document doc = documentService.findById(id);
            if (doc == null)
                return ResponseEntity.notFound().build();

            Path path = Paths.get(doc.getFilePath());
            if (!Files.exists(path))
                return ResponseEntity.notFound().build();

            Resource resource = new UrlResource(path.toUri());

            String contentType = Files.probeContentType(path);
            if (contentType == null)
                contentType = "application/octet-stream";

            // inline để xem trước
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + doc.getFileName() + "\"")
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(resource);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
