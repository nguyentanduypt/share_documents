package com.example.sharefile.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.sharefile.domain.Role;
import com.example.sharefile.domain.User;
import com.example.sharefile.domain.dto.RegisterDTO;
import com.example.sharefile.repository.DocumentRepository;
import com.example.sharefile.repository.RoleRepository;
import com.example.sharefile.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final DocumentRepository documentRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository,
            DocumentRepository documentRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.documentRepository = documentRepository;
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public User getUserById(long id) {
        return this.userRepository.findById(id);
    }

    public User handleSaveUser(User user) {
        User savedUser = this.userRepository.save(user);
        System.out.println("Saved user: " + savedUser);
        return savedUser;
    }

    public long countUsers() {
        return this.userRepository.count();
    }

    public long countDocuments() {
        return this.documentRepository.count();
    }

    public void deleteUserById(long id) {
        this.userRepository.deleteById(id);
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    public User findByUsername(String username) {
        return userRepository.findByEmail(username);
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        return user;
    }
}
