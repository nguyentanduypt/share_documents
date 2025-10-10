<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Thanh Toán - Laptopshop</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="" name="keywords">
                    <meta content="" name="description">

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>
                    <!-- <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div> -->

                    <!-- <jsp:include page="../layout/header.jsp" /> -->

                    <!-- Checkout Page Start -->
                    <div class="container py-5 " style="margin-top: 100px;">
                        <h2 class="mb-4 text-center">Thông tin Thanh Toán</h2>

                        <div class="row g-4">
                            <!-- Left: Sản phẩm -->
                            <div class="col-lg-7">
                                <h4 class="mb-3">Sản phẩm bạn đã chọn</h4>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>Tên</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cartDetails}">
                                            <tr>
                                                <td>
                                                    <img src="/images/product/${item.product.image}"
                                                        alt="${item.product.name}" width="70" height="70">
                                                </td>
                                                <td>${item.product.name}</td>
                                                <td>
                                                    <fmt:formatNumber value="${item.price}" type="number" />đ
                                                </td>
                                                <td>${item.quantity}</td>
                                                <td>
                                                    <fmt:formatNumber value="${item.price * item.quantity}"
                                                        type="number" />
                                                    đ
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Right: Form và Thông tin thanh toán -->
                            <div class="col-lg-5">
                                <h4 class="mb-3">Thông tin người nhận</h4>
                                <form action="/place-order" method="post" modelAttribute="order">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="mb-3">
                                        <label for="receiverName" class="form-label">Họ và tên</label>
                                        <input type="text" class="form-control" id="receiverName" name="receiverName"
                                            required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="receiverAddress" class="form-label">Địa chỉ nhận hàng</label>
                                        <input type="text" class="form-control" id="receiverAddress"
                                            name="receiverAddress" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="receiverPhone" class="form-label">Số điện thoại</label>
                                        <input type="text" class="form-control" id="receiverPhone" name="receiverPhone"
                                            required>
                                    </div>

                                    <h5 class="mt-4">Phương thức thanh toán</h5>
                                    <p>Thanh toán khi nhận hàng (COD)</p>

                                    <div class="border-top pt-3">
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Tạm tính:</span>
                                            <strong>
                                                <fmt:formatNumber value="${totalPrice}" type="number" />đ
                                            </strong>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Phí vận chuyển:</span>
                                            <strong>0đ</strong>
                                        </div>
                                        <div class="d-flex justify-content-between border-top pt-2">
                                            <span><strong>Tổng cộng:</strong></span>
                                            <strong class="text-primary">
                                                <fmt:formatNumber value="${totalPrice}" type="number" />đ
                                            </strong>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary w-100 mt-4">Xác nhận đặt hàng</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Checkout Page End -->

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>