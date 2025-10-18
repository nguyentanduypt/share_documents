<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Giới thiệu - ShareFile</title>

            <!-- Fonts & Icons -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

            <!-- Libraries -->
            <link href="${pageContext.request.contextPath}/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/client/lib/owlcarousel/assets/owl.carousel.min.css"
                rel="stylesheet">

            <!-- Custom CSS -->
            <link href="${pageContext.request.contextPath}/client/css/bootstrap.min.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/client/css/style.css" rel="stylesheet">
        </head>

        <body>
            <!-- Header -->
            <jsp:include page="../layout/header.jsp" />

            <!-- Giới thiệu -->
            <div class="container py-5">
                <div class="text-center mb-5">
                    <h1 class="fw-bold text-primary">Về ShareFile</h1>
                    <p class="text-muted">Nền tảng chia sẻ tài liệu học tập miễn phí dành cho sinh viên</p>
                </div>

                <div class="row g-4 align-items-center">
                    <div class="col-lg-6">
                        <img src="https://img.freepik.com/premium-vector/file-share-logo-design-template_145155-2927.jpg"
                            alt="Giới thiệu ShareFile" class="img-fluid rounded shadow" height="300px" width="300px">
                    </div>
                    <div class="col-lg-6">
                        <h3 class="fw-semibold mb-3">Mục tiêu của chúng tôi</h3>
                        <p>
                            ShareFile được xây dựng với mục tiêu tạo ra một không gian nơi sinh viên có thể dễ dàng chia
                            sẻ
                            và tiếp cận các tài liệu học tập, bài giảng, đồ án, và luận văn. Mỗi tài liệu được chia sẻ
                            là
                            một bước tiến giúp cộng đồng học tập phát triển mạnh mẽ hơn.
                        </p>
                        <ul class="list-unstyled mt-3">
                            <li><i class="fa fa-check text-primary me-2"></i>Miễn phí và dễ sử dụng</li>
                            <li><i class="fa fa-check text-primary me-2"></i>Hỗ trợ nhiều định dạng file</li>
                            <li><i class="fa fa-check text-primary me-2"></i>Đảm bảo an toàn dữ liệu</li>
                        </ul>
                    </div>
                </div>

                <hr class="my-5">

                <div class="text-center mb-4">
                    <h3 class="fw-bold text-primary">Thành viên phát triển</h3>
                </div>

                <div class="row justify-content-center g-4">
                    <div class="col-md-4 text-center">
                        <div class="p-4 border rounded shadow-sm bg-white">
                            <img src="${pageContext.request.contextPath}/client/images/avatar1.png"
                                class="rounded-circle mb-3" width="100" height="100" alt="Avatar">
                            <h5 class="fw-semibold">Nguyễn Tấn Duy</h5>
                            <p class="text-muted mb-2">Sinh viên Công nghệ Phần mềm</p>
                            <p><i class="fa fa-envelope me-2"></i>nguyentanduy080504@gmail.com</p>
                        </div>
                    </div>

                    <div class="col-md-4 text-center">
                        <div class="p-4 border rounded shadow-sm bg-white">
                            <img src="${pageContext.request.contextPath}/client/images/avatar2.png"
                                class="rounded-circle mb-3" width="100" height="100" alt="Avatar">
                            <h5 class="fw-semibold">Đặng Trần Quốc Trinh</h5>
                            <p class="text-muted mb-2">Backend Developer</p>
                            <p><i class="fa fa-envelope me-2"></i>dangtranquoctrinh@example.com</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Features -->
            <jsp:include page="../layout/feature.jsp" />

            <!-- Footer -->
            <jsp:include page="../layout/footer.jsp" />

            <!-- Scripts -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/client/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/client/lib/lightbox/js/lightbox.min.js"></script>
            <script src="${pageContext.request.contextPath}/client/lib/owlcarousel/owl.carousel.min.js"></script>
            <script src="${pageContext.request.contextPath}/client/js/main.js"></script>
        </body>

        </html>