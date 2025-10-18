package com.example.sharefile.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.sharefile.domain.Document;
import com.example.sharefile.domain.User;

@Repository
public interface DocumentRepository extends JpaRepository<Document, Long> {
    List<Document> findByTitleContainingIgnoreCase(String keyword);

    List<Document> findByCategory_Id(Long categoryId);

    List<Document> findByUploader(User uploader);

}
