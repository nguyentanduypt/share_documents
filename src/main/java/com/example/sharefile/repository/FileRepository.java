package com.example.sharefile.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.sharefile.domain.File;

@Repository
public interface FileRepository extends JpaRepository<File, Long> {
}
