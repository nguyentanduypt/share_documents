📄 Share Documents Web Application

A web-based document sharing system that allows users to upload, preview, and manage documents online.
The application is built using Java Spring Boot with MVC architecture and provides authentication, file preview, and role-based access control.

🚀 Features
👤 User Features

User registration and login

Upload documents (PDF, DOCX, TXT, CSV, images)

Preview files directly in the browser

View document details

Download documents

Manage personal uploaded files

🛠 Admin Features

Manage users

Manage uploaded documents

Control system content

📂 File Preview Support

PDF → preview using iframe

DOCX → preview using Mammoth.js

TXT / CSV → preview using iframe

Images → preview directly in browser

🏗 System Architecture

The project follows the MVC (Model - View - Controller) architecture.

Client (Browser)
        │
        │ HTTP Request
        ▼
Controller (Spring Boot)
        │
        │ Business Logic
        ▼
Service Layer
        │
        │ Data Access
        ▼
Repository (JPA)
        │
        │
        ▼
Database (MySQL)
Explanation

Model

Represents application data

Includes Entity classes (User, Document, etc.)

View

Implemented using JSP

Displays UI and document previews

Controller

Handles HTTP requests

Communicates with service layer

Returns responses to the client

🌐 Network Programming Concept

This application follows the Client–Server architecture.

Client: Web browser

Server: Spring Boot application

Communication protocol: HTTP/HTTPS

Data flow example (Preview File)

Client sends request

GET /file/{id}

Controller receives request

Server retrieves file information from database

Server reads file from storage

Server returns file using HTTP Response

ResponseEntity<Resource>

Browser renders the file (PDF, image, text, etc.)

🛠 Technologies Used
Backend

Java

Spring Boot

Spring MVC

Spring Security

Spring Data JPA

Frontend

JSP

HTML / CSS

JavaScript

Bootstrap

Database

MySQL

Libraries

Mammoth.js (DOCX preview)

📁 Project Structure
sharefile
│
├── controller
│   ├── client
│   └── admin
│
├── service
│
├── repository
│
├── domain
│
├── config
│
├── resources
│   ├── templates
│   ├── static
│   └── application.properties
│
└── uploads
🔐 Security

The system uses Spring Security for authentication and authorization.

Features include:

Login authentication

Role-based access control

Password encryption using BCrypt

Session management

📦 Installation & Setup
1️⃣ Clone repository
git clone https://github.com/yourusername/sharefile.git
2️⃣ Configure database

Edit application.properties

spring.datasource.url=jdbc:mysql://localhost:3306/sharefile
spring.datasource.username=root
spring.datasource.password=yourpassword
3️⃣ Run project

Using Maven

mvn spring-boot:run

Or run Application.java.

4️⃣ Open browser
http://localhost:8080
📷 Screenshots

(Add screenshots of your system here)

🎓 Academic Purpose

This project was developed as a Network Programming course project.

It demonstrates:

Client–Server architecture

HTTP communication

MVC design pattern

File upload and streaming

Web security implementation

👨‍💻 Author

Nguyễn Tấn Duy

Software Engineering Student

GitHub:
https://github.com/nguyentanduypt

📜 License

This project is for educational purposes.
