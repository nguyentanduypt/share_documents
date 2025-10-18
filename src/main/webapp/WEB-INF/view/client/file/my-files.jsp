<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Tài liệu của tôi - ShareFile</title>

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
            </head>
            <style>
                body {
                    padding-top: 90px;
                }
            </style>

            <body>
                <!-- Spinner -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>

                <!-- Header -->
                <jsp:include page="../layout/header.jsp" />

                <!-- Banner -->
                <div class="container-fluid bg-primary text-white py-5 text-center">
                    <h1 class="display-5 fw-bold">Tài liệu của tôi</h1>
                    <p class="mb-0">Quản lý, chỉnh sửa và tải xuống các tài liệu bạn đã chia sẻ</p>
                </div>

                <!-- My Documents Section -->
                <div class="container-fluid py-5">
                    <div class="container py-5">
                        <div class="tab-class text-center">
                            <div class="row g-4 mb-4">
                                <div class="col-lg-6 text-start">
                                    <h1 class="fw-bold">Danh sách tài liệu của bạn</h1>
                                </div>
                                <div class="col-lg-6 text-end">
                                    <a href="/upload" class="btn btn-primary rounded-pill px-4">
                                        <i class="fa fa-upload me-2"></i>Thêm tài liệu mới
                                    </a>
                                </div>
                            </div>

                            <!-- 🔹 Bộ lọc danh mục -->
                            <form action="${pageContext.request.contextPath}/my-files" method="get" class="mb-3">
                                <div class="row justify-content-center">
                                    <div class="col-md-4">
                                        <!-- <select name="categoryId" class="form-select" onchange="this.form.submit()">
                                            <option value="">-- Lọc theo danh mục --</option>
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.id}" ${cat.id==selectedCategoryId ? 'selected' : ''
                                                    }>
                                                    ${cat.nameCategory}
                                                </option>
                                            </c:forEach>
                                        </select> -->
                                    </div>
                                </div>
                            </form>

                            <!-- 🔹 Danh sách tài liệu -->
                            <div class="row g-4 mt-4">
                                <c:forEach var="doc" items="${documents}">
                                    <div class="col-md-6 col-lg-4 col-xl-3">
                                        <div
                                            class="rounded border border-secondary p-3 shadow-sm h-100 position-relative">
                                            <div class="d-flex align-items-center justify-content-between mb-2">
                                                <i class="fa fa-file-alt text-primary fa-2x"></i>
                                                <small class="text-muted">${doc.formattedDate}</small>
                                            </div>

                                            <h5 class="fw-bold mb-2 text-truncate">${doc.title}</h5>
                                            <p class="text-muted" style="font-size:14px; min-height: 40px;">
                                                ${doc.description}
                                            </p>

                                            <p style="font-size:13px;">Danh mục:
                                                <span class="fw-semibold text-primary">
                                                    ${doc.category.nameCategory}
                                                </span>
                                            </p>

                                            <div class="d-flex justify-content-between mt-3">
                                                <a href="/document/download/${doc.id}"
                                                    class="btn btn-outline-primary rounded-pill px-3">
                                                    <i class="fa fa-download me-2"></i>Tải về
                                                </a>

                                                <a href="/document/${doc.id}"
                                                    class="btn btn-outline-secondary rounded-pill px-3">
                                                    <i class="fa fa-eye me-2"></i>Xem
                                                </a>
                                            </div>

                                            <!-- Nút xóa ở góc -->
                                            <form action="/document/delete/${doc.id}" method="post"
                                                onsubmit="return confirm('Bạn có chắc muốn xóa tài liệu này?')">
                                                <button type="submit"
                                                    class="btn btn-sm btn-danger rounded-circle position-absolute top-0 end-0 mt-2 me-2">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty documents}">
                                    <p class="text-center text-muted mt-4">Bạn chưa tải lên tài liệu nào.</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
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