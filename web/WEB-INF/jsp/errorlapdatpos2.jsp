<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LỖI XỬ LÝ</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
    </head>
    <body>
        <div class="error">
            <div class="left">
                <img src="<%=request.getContextPath()%>/resources/img/orthers/errorlapdatpos.png"/>
            </div>
            <div class="right">
                <h3>LỖI: Đã gán đủ ${soluong} dòng máy ${dongmay} số lượng lắp đặt cho ĐVCNT ${maDvcnt}</h3>
                <h3 class="info1">
                    <a href="index.html">Trở về trang chủ</a>
                </h3>
            </div>
        </div>
    </body>
    
    
    <style>
        .error{
            height: 200px;
            width: 100%;
            padding-top: 5%;
        }
        .left{
            width: 20%;
            height: 200px;
            float: left;    
        }
        .left img{
            width: 200px;
            height: 200px;
        }
        .right{
            width: 80%;
            float: right;
            height: 200px;
        }
        .right .info1{
            margin-left: 46px;
        }
    </style>
</html>
