<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Hello</title>
    </head>
    <body>
        <form action="singleFileUpload" method="post" enctype="multipart/form-data">
    <table>
      <tr>
        <td>Select File</td>
        <td><input type="file" required  name="file"></td>
        <td><button type="submit">Upload</button></td>
      </tr>
    </table>
  </form>
    </body>
</html>