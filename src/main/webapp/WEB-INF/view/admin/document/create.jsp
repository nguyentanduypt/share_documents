<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Thêm tài liệu - ShareFile</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/mammoth/1.7.0/mammoth.browser.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const documentFile = $("#documentFile");
                        documentFile.change(function (e) {
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

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Quản lý tài liệu</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Tài liệu</li>
                                </ol>

                                <div class="row mt-5">
                                    <div class="col-md-8 col-12 mx-auto">
                                        <h3>Thêm tài liệu mới</h3>
                                        <hr />

                                        <form:form method="post" action="/admin/document/create"
                                            modelAttribute="newDocument" class="row" enctype="multipart/form-data">

                                            <c:set var="errorTitle">
                                                <form:errors path="title" cssClass="invalid-feedback" />
                                            </c:set>
                                            <c:set var="errorDescription">
                                                <form:errors path="description" cssClass="invalid-feedback" />
                                            </c:set>

                                            <div class="mb-3 col-12">
                                                <label class="form-label">Tên tài liệu:</label>
                                                <form:input type="text"
                                                    class="form-control ${not empty errorTitle ? 'is-invalid' : ''}"
                                                    path="title" />
                                                ${errorTitle}
                                            </div>

                                            <div class="mb-3 col-12">
                                                <label class="form-label">Mô tả:</label>
                                                <form:textarea rows="3"
                                                    class="form-control ${not empty errorDescription ? 'is-invalid' : ''}"
                                                    path="description" />
                                                ${errorDescription}
                                            </div>

                                            <div class="mb-3 col-12">
                                                <label for="documentFile" class="form-label">Tệp tài liệu (.pdf, .docx,
                                                    .txt, .md):</label>
                                                <input class="form-control" type="file" id="documentFile"
                                                    name="documentFile" accept=".pdf,.doc,.docx,.txt,.md,.csv"
                                                    required />
                                            </div>

                                            <div class="col-12 mb-3">
                                                <label>Xem trước nội dung (nếu là file văn bản):</label>
                                                <pre id="filePreview"
                                                    style="white-space: pre-wrap; border: 1px solid #ccc; padding: 10px; height: 200px; overflow:auto;"></pre>
                                            </div>

                                            <div class="col-12 mb-5">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fa fa-upload me-2"></i> Tải lên
                                                </button>
                                                <a href="/admin/document" class="btn btn-secondary">Hủy</a>
                                            </div>

                                        </form:form>
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