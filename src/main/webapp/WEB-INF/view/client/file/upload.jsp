<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Upload - ShareFile</title>

                <!-- Fonts & Icons -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries -->
                <link href="${pageContext.request.contextPath}/client/lib/lightbox/css/lightbox.min.css"
                    rel="stylesheet">
                <link href="${pageContext.request.contextPath}/client/lib/owlcarousel/assets/owl.carousel.min.css"
                    rel="stylesheet">

                <!-- Custom CSS -->
                <link href="${pageContext.request.contextPath}/client/css/bootstrap.min.css" rel="stylesheet">
                <link href="${pageContext.request.contextPath}/client/css/style.css" rel="stylesheet">
            </head>

            <body>

                <!-- Header -->
                <jsp:include page="../layout/header.jsp" />

                <!-- Upload Form -->
                <div class="container mt-5 mb-5">
                    <h2 class="text-center mb-4">Tải Lên Tài Liệu</h2>

                    <form action="${pageContext.request.contextPath}/upload" method="post" enctype="multipart/form-data"
                        class="border p-4 rounded shadow bg-light">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        <div class="mb-3">
                            <label for="title" class="form-label fw-bold">Tên tài liệu</label>
                            <input type="text" class="form-control" id="title" name="title"
                                placeholder="Nhập tên tài liệu" required>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label fw-bold">Mô tả</label>
                            <textarea class="form-control" id="description" name="description"
                                placeholder="Mô tả ngắn về tài liệu (ví dụ: bài giảng, đề thi, đồ án...)"
                                rows="3"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="fileData" class="form-label fw-bold">Chọn file</label>
                            <input type="file" class="form-control" id="fileData" name="fileData" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Tải lên</button>
                    </form>

                </div>

                <!-- Features -->
                <jsp:include page="../layout/feature.jsp" />

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />

                <!-- Scripts -->
                <script src="${pageContext.request.contextPath}/client/js/bootstrap.bundle.min.js"></script>
                <script src="${pageContext.request.contextPath}/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="${pageContext.request.contextPath}/client/lib/owlcarousel/owl.carousel.min.js"></script>
                <script src="${pageContext.request.contextPath}/client/js/main.js"></script>

            </body>

            </html>