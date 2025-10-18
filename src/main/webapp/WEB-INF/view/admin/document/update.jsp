<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                <meta name="author" content="Hỏi Dân IT" />
                <title>Update Document </title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    // $(document).ready(() => {
                    //     const avatarFile = $("#avatarFile");
                    //     const orgImage = "${newProduct.image}";
                    //     if (orgImage) {
                    //         const imgURL = "/images/product/" + orgImage;
                    //         $("#avatarPreview").attr("src", imgURL);
                    //         $("#avatarPreview").css({ "display": "block" });
                    //     }
                    //     avatarFile.change(function (e) {
                    //         const imgURL = URL.createObjectURL(e.target.files[0]);
                    //         $("#avatarPreview").attr("src", imgURL);
                    //         $("#avatarPreview").css({ "display": "block" });
                    //     });
                    // });
                    // $(document).ready(() => {
                    //     const productFile = $("#productFile");
                    //     const orgImage = "${newProduct.image}";
                    //     if (orgImage) {
                    //         const imgURL = "/images/product/" + orgImage;
                    //         $("#productPreview").attr("src", imgURL);
                    //         $("#productPreview").css({ "display": "block" });
                    //     }
                    //     productFile.change(function (e) {
                    //         const imgURL = URL.createObjectURL(e.target.files[0]);
                    //         $("#productPreview").attr("src", imgURL);
                    //         $("#productPreview").css({ "display": "block" });
                    //     });
                    // });
                </script>
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Manage Update Document</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Update Document</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Update document</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/document/update"
                                                modelAttribute="document" class="row" enctype="multipart/form-data">
                                                <form:hidden path="id" />
                                                <c:set var="errorTitle">
                                                    <form:errors path="title" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorDescription">
                                                    <form:errors path="description" cssClass="invalid-feedback" />
                                                </c:set>


                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Title:</label>
                                                    <form:input type="text"
                                                        class="form-control ${not empty errorTitle ? 'is-invalid' : ''}"
                                                        path="title" />
                                                    ${errorTitle}
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Detail description:</label>
                                                    <form:input type="text"
                                                        class="form-control ${not empty errorDescription ? 'is-invalid' : ''}"
                                                        path="description" />
                                                    ${errorDescription}
                                                </div>


                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">Update</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>