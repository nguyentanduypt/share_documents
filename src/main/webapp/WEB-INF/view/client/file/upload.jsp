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
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/mammoth/1.7.0/mammoth.browser.min.js"></script>
                <script>
                    $(document).ready(function () {
                        const fileInput = $("#fileData");
                        fileInput.change(function (e) {
                            const file = e.target.files[0];
                            const preview = $("#filePreview");
                            if (!file) {
                                preview.text("");
                                return;
                            }
                            if (file.type.startsWith("text/")) {
                                const reader = new FileReader();
                                reader.onload = function (event) {
                                    preview.text(event.target.result);
                                };
                                reader.readAsText(file);
                            } else if (file.name.endsWith(".docx")) {
                                const reader = new FileReader();
                                reader.onload = function (event) {
                                    mammoth.convertToHtml({ arrayBuffer: event.target.result })
                                        .then(function (resultObject) {
                                            preview.html(resultObject.value);
                                        })
                                        .catch(function () {
                                            preview.text("Không thể xem trước file docx này.");
                                        });
                                };
                                reader.readAsArrayBuffer(file);
                            } else {
                                preview.text("Xem trước chỉ hỗ trợ file .txt, .md, .csv, .docx");
                            }
                        });
                    });
                </script>
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
                            <label for="category">Danh mục:</label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.nameCategory}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="fileData" class="form-label fw-bold">Chọn file</label>
                            <input type="file" class="form-control" id="fileData" name="fileData" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Tải lên</button>
                        <div class="mb-3">
                            <label>Xem trước nội dung (nếu là file văn bản):</label>
                            <pre id="filePreview"
                                style="white-space: pre-wrap; border: 1px solid #ccc; padding: 10px; height: 500px; overflow:auto;"></pre>
                        </div>
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