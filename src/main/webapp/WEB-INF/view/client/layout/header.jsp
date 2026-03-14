<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- Header / Navbar Start -->
        <div class="container-fluid fixed-top bg-white shadow-sm">
            <div class="container">
                <nav class="navbar navbar-light navbar-expand-lg py-3">
                    <a href="/" class="navbar-brand">
                        <h2 class="text-primary m-0">ShareFile</h2>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="/" class="nav-item nav-link active">Trang chủ</a>
                            <!-- <a href="/documents" class="nav-item nav-link">Tài liệu</a> -->
                            <a href="/upload" class="nav-item nav-link">Tải lên</a>
                            <a href="/about" class="nav-item nav-link">Giới thiệu</a>
                        </div>

                        <!-- Nếu user đã đăng nhập -->
                        <c:if test="${not empty pageContext.request.userPrincipal}">
                            <div class="dropdown my-auto">
                                <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-user fa-2x text-primary"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end p-3" aria-labelledby="dropdownMenuLink">
                                    <li class="text-center mb-2">
                                        <img src="/images/avatar/${sessionScope.avatar}" class="rounded-circle"
                                            width="80" height="80" alt="avatar">
                                        <p class="mt-2 mb-1 fw-bold">
                                            <c:out value="${pageContext.request.userPrincipal.name}" />
                                        </p>
                                    </li>
                                    <!-- <li><a class="dropdown-item" href="/profile">Hồ sơ cá nhân</a></li> -->
                                    <li><a class="dropdown-item" href="/my-files">Tài liệu của tôi</a></li>
                                    <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                                        <li><a class="dropdown-item" href="/admin">Trang quản trị</a></li>
                                    </c:if>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li>
                                        <form action="/logout" method="post">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <button class="dropdown-item text-danger">Đăng xuất</button>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                        </c:if>

                        <!-- Nếu chưa đăng nhập -->
                        <c:if test="${empty pageContext.request.userPrincipal}">
                            <div class="d-flex">
                                <a href="/login" class="btn btn-outline-primary me-2">Đăng nhập</a>
                                <a href="/register" class="btn btn-primary">Đăng ký</a>
                            </div>
                        </c:if>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Header / Navbar End -->