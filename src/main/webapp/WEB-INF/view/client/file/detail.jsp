<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chi tiết tài liệu - ShareFile</title>

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
                <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                <!-- Custom CSS -->
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                <link href="/client/css/style.css" rel="stylesheet">

                <style>
                    .file-viewer {
                        background-color: #fff;
                        border: 1px solid #dee2e6;
                        border-radius: 8px;
                        padding: 20px;
                        max-height: 600px;
                        overflow-y: auto;
                        white-space: pre-wrap;
                        font-family: "Courier New", monospace;
                        font-size: 15px;
                        line-height: 1.6;
                    }

                    .file-viewer::-webkit-scrollbar {
                        width: 8px;
                    }

                    .file-viewer::-webkit-scrollbar-thumb {
                        background-color: #ccc;
                        border-radius: 4px;
                    }
                </style>
            </head>

            <body>
                <!-- Spinner -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>

                <!-- Header -->
                <jsp:include page="../layout/header.jsp" />

                <!-- Main content -->
                <div class="container-fluid py-5">
                    <div class="container py-5">
                        <div class="text-center mb-5">
                            <h1 class="fw-bold text-primary">Chi tiết tài liệu</h1>
                            <p class="text-muted">Xem thông tin và nội dung tài liệu</p>
                        </div>

                        <c:if test="${not empty doc}">
                            <div class="rounded border border-secondary p-4 shadow-sm bg-white">
                                <h4 class="fw-bold mb-3">${doc.title}</h4>
                                <p><strong>Mô tả:</strong> ${doc.description}</p>
                                <p><strong>Người đăng:</strong> ${doc.uploader.fullName}</p>
                                <p><strong>Ngày đăng:</strong> ${doc.uploadDate}</p>

                                <div class="mt-4 d-flex gap-3">
                                    <a href="/document/download/${doc.id}"
                                        class="btn btn-outline-primary rounded-pill px-4">
                                        <i class="fa fa-download me-2"></i>Tải về
                                    </a>
                                    <a href="/" class="btn btn-outline-secondary rounded-pill px-4">
                                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                                    </a>
                                </div>

                                <hr class="my-4">

                                <h5 class="fw-bold mb-3"><i class="fa fa-book-open me-2 text-primary"></i>Nội dung tài
                                    liệu</h5>

                                <c:choose>
                                    <c:when test="${doc.fileName.endsWith('.pdf')}">
                                        <iframe src="${fileUrl}" width="100%" height="600px"></iframe>
                                    </c:when>

                                    <c:when test="${doc.fileName.endsWith('.docx')}">
                                        <div id="filePreview" class="file-viewer">Đang tải...</div>
                                        <script
                                            src="https://cdnjs.cloudflare.com/ajax/libs/mammoth/1.7.0/mammoth.browser.min.js"></script>
                                        <script>
                                            fetch("${fileUrl}")
                                                .then(r => r.arrayBuffer())
                                                .then(d => mammoth.convertToHtml({ arrayBuffer: d }))
                                                .then(res => document.getElementById("filePreview").innerHTML = res.value)
                                                .catch(() => document.getElementById("filePreview").innerText = "Không thể xem trước file DOCX này.");
                                        </script>
                                    </c:when>

                                    <c:when test="${doc.fileName.endsWith('.txt') || doc.fileName.endsWith('.csv')}">
                                        <iframe src="${fileUrl}" width="100%" height="600px"></iframe>
                                    </c:when>

                                    <c:when
                                        test="${doc.fileName.endsWith('.jpg') || doc.fileName.endsWith('.png') || doc.fileName.endsWith('.jpeg')}">
                                        <img src="${fileUrl}" class="img-fluid rounded shadow-sm"
                                            style="max-height:600px;">
                                    </c:when>

                                    <c:otherwise>
                                        <div class="alert alert-info text-center">
                                            Không thể hiển thị loại file này. Vui lòng tải về để xem.
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </c:if>

                        <c:if test="${empty doc}">
                            <div class="alert alert-warning text-center">
                                Không tìm thấy tài liệu bạn yêu cầu.
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Features + Footer -->
                <jsp:include page="../layout/feature.jsp" />
                <jsp:include page="../layout/footer.jsp" />

                <!-- Back to Top -->
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
                    <i class="fa fa-arrow-up"></i>
                </a>

                <!-- Scripts -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                <script src="/client/js/main.js"></script>
            </body>

            </html>