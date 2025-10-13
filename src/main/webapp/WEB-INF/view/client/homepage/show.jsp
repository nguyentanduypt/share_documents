<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Trang chủ - ShareFile</title>

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

            <body>
                <!-- Spinner -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>

                <!-- Header -->
                <jsp:include page="../layout/header.jsp" />

                <!-- Banner -->
                <jsp:include page="../layout/banner.jsp" />

                <!-- Documents Section -->
                <div class="container-fluid py-5">
                    <div class="container py-5">
                        <div class="tab-class text-center">
                            <div class="row g-4">
                                <div class="col-lg-6 text-start">
                                    <h1>Tài liệu mới nhất</h1>
                                </div>
                                <div class="col-lg-6 text-end">
                                    <a href="/upload" class="btn btn-primary rounded-pill px-4">Tải lên tài liệu</a>
                                </div>
                            </div>

                            <div class="row g-4 mt-4">
                                <c:forEach var="doc" items="${documents}">
                                    <div class="col-md-6 col-lg-4 col-xl-3">
                                        <div class="rounded border border-secondary p-3 shadow-sm h-100">
                                            <div class="d-flex align-items-center justify-content-between mb-2">
                                                <i class="fa fa-file-alt text-primary fa-2x"></i>
                                                <small class="text-muted">
                                                    ${doc.formattedDate}
                                                </small>
                                            </div>

                                            <h5 class="fw-bold mb-2 text-truncate">${doc.title}</h5>
                                            <p class="text-muted" style="font-size:14px; min-height: 40px;">
                                                ${doc.description}
                                            </p>

                                            <p style="font-size:13px;">Người đăng:
                                                <span class="fw-semibold">
                                                    ${doc.uploader.firstName} ${doc.uploader.lastName}
                                                </span>
                                            </p>

                                            <div class="d-flex justify-content-between mt-3">
                                                <a href="/document/download/${doc.id}"
                                                    class="btn btn-outline-primary rounded-pill px-3">
                                                    <i class="fa fa-download me-2"></i>Tải về
                                                </a>

                                                <a href="/document/${doc.id}"
                                                    class="btn btn-outline-secondary rounded-pill px-3">
                                                    <i class="fa fa-eye me-2"></i>Xem chi tiết
                                                </a>

                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty documents}">
                                    <p class="text-center text-muted">Chưa có tài liệu nào được tải lên.</p>
                                </c:if>

                            </div>
                        </div>
                    </div>
                </div>

                <!-- Features -->
                <jsp:include page="../layout/feature.jsp" />

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