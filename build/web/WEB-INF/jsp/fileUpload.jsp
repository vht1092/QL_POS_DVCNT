<%-- 
    Document   : fileUpload
    Created on : Dec 18, 2017, 10:07:03 AM
    Author     : phuoclh1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>File Upload</title>
    </head>

    <body>
        <h1>Please upload a file</h1>
        <form method="post" action="${pageContext.request.contextPath}/fileUpload.do" enctype="multipart/form-data">
            <input type="file" required  name="fileUploaded" /> <input type="submit" />
        </form>
    </body>
</html>
