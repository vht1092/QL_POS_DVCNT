<%-- 
    Document   : testupload
    Created on : Apr 17, 2018, 9:54:16 AM
    Author     : phuoclh1
--%>
<%@page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>





        <form name="uploadForm" action="themthongtinlapdatpos.html?id=${_id}" method="POST" enctype="multipart/form-data">

            <%
                String saveFile = new String();
                String contentType = request.getContentType();

                if (contentType != null && contentType.indexOf("multipart/form-data") >= 0) {
                    DataInputStream in = new DataInputStream(request.getInputStream());
                    int formDatalenght = request.getContentLength();

                    byte dataBytes[] = new byte[formDatalenght];
                    int byteRead = 0;
                    int totalByteRead = 0;

                    while (totalByteRead < formDatalenght) {
                        byteRead = in.read(dataBytes, totalByteRead, formDatalenght);
                        totalByteRead += byteRead;
                    }

                    String file = new String(dataBytes);
                    saveFile = file.substring(file.indexOf("filename=\"") + 10);
                    saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                    saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));

                    int lastIndex = contentType.lastIndexOf("=");
                    String bounddary = contentType.substring(lastIndex + 1, contentType.length());

                    int pos;

                    pos = file.indexOf("filename = \"");
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;

                    int boundaryLocation = file.indexOf(bounddary, pos) - 4;
                    int startPos = ((file.substring(0, pos)).getBytes()).length;
                    int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

                    saveFile = "C:/xxxx/" + saveFile;

                    File ff = new File(saveFile);
                    try {
                        FileOutputStream fileOut = new FileOutputStream(ff);
                        fileOut.write(dataBytes, startPos, (endPos - startPos));
                        fileOut.flush();
                        fileOut.close();
                    } catch (Exception e) {

                    }
                }
            %>

            <input type="file" required  name="file" value="" width="100"/>
            <input type="submit" value="UPLOAD" name="submit"/>
        </form>
    </body>
</html>
