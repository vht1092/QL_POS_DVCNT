<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>ĐVCNT ĐANG XỬ LÝ</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/dsdvcnt.css"/>
        <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>

        <style>
            table, table tr, table tr td {cursor: pointer;}
            table tr.active td {background-color: #ADFF2F;}
        </style>
    </head>
    <body>
    <center>
        <header>
            <ul class="breadcrumb">
                <li><a href="index.html">Trang chủ</a></li>
                <li>
                    <div class="dropdown">
                        <button class="dropbtn">Quản lý ĐVCNT</button>
                        <div class="dropdown-content">
                            <c:choose>
                                <c:when test="${groupuser == 1}">
                                    <a href="themmoidvcnt.html">Thêm ĐVCNT mới</a><br/>
                                </c:when>
                            </c:choose>
                            <a href="dvcntdangxuly.html">ĐVCNT đang xử lý</a><br/>
                            <c:choose>
                                <c:when test="${groupuser == 1 || groupuser == 2}">
                                    <a href="danhsachdvcnt1.html">ĐVCNT đã lắp đặt</a><br/>
                                </c:when>
                                <c:when test="${groupuser == 3 || groupuser == 4}">
                                    <a href="danhsachdvcnt2.html">ĐVCNT đã lắp đặt</a><br/>
                                </c:when>
                                <c:when test="${groupuser == 5 || groupuser == 6}">
                                    <a href="danhsachdvcnt3.html">ĐVCNT đã lắp đặt</a><br/>
                                </c:when>
                                <c:otherwise>
                                    <a href="danhsachdvcnt.html">ĐVCNT đã lắp đặt</a><br/>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${groupuser == 7}">
                                    <a href="xuatphieuyeucau.html" target="_blank">Xuất giấy đề nghị</a><br/>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${groupuser == 7}">
                                    <a href="tao_user.html" target="_blank">Tạo người dùng mới</a><br/>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </li>
                <li>Danh sách hồ sơ xử lý</li>
            </ul>
            <center>
                <h2>DANH SÁCH HỒ SƠ XỬ LÝ
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> &nbsp; / &nbsp; ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <center>
        <div class="content">
            <center>
                <div class="timkiem">
                    <form action="${pageContext.request.contextPath}/search-dvcnt-by-keyword" method="get" class="timkiembasic">
                        <p>Tìm kiếm theo: </p>
                        <select name="key-search">
                            <c:choose>
                                <c:when test="${keysearchbasic == '1'}">
                                    <option onclick="emtytxtSearch()" value="1" selected="selected">--- TẤT CẢ ---</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="1" on="emtytxtSearch()">--- TẤT CẢ ---</option>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${keysearchbasic == '2'}">
                                    <option value="2" selected="selected">MÃ ĐVCNT</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="2">MÃ ĐVCNT</option>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${keysearchbasic == '7'}">
                                    <option value="7" selected="selected">TÊN ĐVCNT</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="7">TÊN ĐVCNT</option>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${keysearchbasic == '3'}">
                                    <option value="3" selected="selected">SỐ GPKD</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="3">SỐ GPKD</option>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${keysearchbasic == '4'}">
                                    <option value="4" selected="selected">CN QUẢN LÝ</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="4">CN QUẢN LÝ</option>
                                </c:otherwise>
                            </c:choose>

                        </select>
                        <c:choose>
                            <c:when test="${txtsearchbasic != ''}">
                                <input name="txtsearch" onblur="caps(this.id)" id="txtsearch" placeholder="Tìm kiếm..." class="txtTimKiem" value="${txtsearchbasic}"/>
                            </c:when>
                            <c:otherwise>
                                <input name="txtsearch" onblur="caps(this.id)" id="txtsearch" placeholder="Tìm kiếm..." class="txtTimKiem"/>        
                            </c:otherwise>
                        </c:choose>
                        <input type="submit" value="TÌM KIẾM" class="submit"/>
                    </form>
                </div>
            </center>

            <table class="dvcnt-pendding" id="testTable">   
                <c:choose>
                    <c:when test="${confirm != '' && confirm != 'null' && confirm != null}">
                        <tr style="padding: 10px;">
                            <td colspan="10" style="color: red; text-align: left; padding: 10px; font-weight: bold; border: none">
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="35%">${confirm}</marquee>
                        </td>
                        </tr>
                    </c:when>
                </c:choose>
                <tr>
                    <th><a href="sortid.html" class="sort">ID</a></th>
                    <th>Số GPĐKKD</th>
                    <th><a href="sortname.html" class="sort">Tên Đơn vị chấp nhận thẻ</a></th>
                    <th><a href="sortstatus.html" class="sort">Trạng thái</a></th>
                    <th>Thao tác</th>
                    <th><a class="sort">Loại đăng ký</a></th>
                    <th>Ngày tạo yêu cầu</th>
                    <th>Mã đơn vị</th>
                    <th>User QL</th>
                        <c:choose>
                            <c:when test="${groupuser == 2}">
                            <td>Gán quyền quản lý</td>
                        </c:when>
                    </c:choose>
                </tr>

                <c:forEach items="${lstThemMoi}" var="p">
                    <!--User ở CN/PGD chỉ thấy đc ĐVCNT do đơn vị của mình quản lý-->
                    <c:choose>
                        <c:when test="${p.cnQuanly == macn && (groupuser == 1 || groupuser == 2)}">
                            <c:choose>
                                <c:when test="${p.statusDvcnt != 1 && p.statusDvcnt != 6 && p.statusDvcnt != 7}">
                                    <!--PHONG KHACH HANG DOANH NGHIEP-->
                                    <c:choose>
                                        <c:when test="${(groupuser == 3 || groupuser == 4) && p.loaihinhDvcnt == 2}">
                                            <tr class="row">
                                                <td><a href="export2.html?id=${p.maDvcnt}" class="detail" target="_blank">${p.maDvcnt}</a></td>
                                                <td>${p.gpdkkdso}</td>
                                                <td>${p.tenDvcntVn}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 2}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 3}">
                                                            <span class="chuyentiep2">Chuyển đến (2)CN/PGD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 4  && p.loaihinhDvcnt == 2}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 0}">
                                                            <span class="trave">Trả về</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 5}">
                                                            <span class="chuyentiep2">P.SP&CS KHDN đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 6}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 7}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 17}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 8}">
                                                            <span class="chuyentiep2">P.KTT&NHS đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 9}">
                                                            <span class="chuyentiep2">Gửi yêu cầu sang VTB</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 10}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đang map thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 11}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đã map đủ thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 12}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS gửi duyệt</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 4}">
                                                            <span class="hoantattaothongso">(2)P.KTT&NHS đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 5}">
                                                            <span class="hoantattaothongso"></span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt <=2}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất tạo thông số</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 9}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất t/số lắp thêm</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet <= 2) && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="chitietdvcnt.html?id=${p.maDvcnt}" class="detail">Điều chỉnh</a> | 
                                                        </c:when>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="delete">Thông tin máy POS</a><span class="space">&nbsp;</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 2 || p.statusDuyet == 0) && groupuser == 1 && macn == p.cnQuanly}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="info">Xem thông tin lắp đặt </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS thấy link Mapping thong so-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && (p.statusDvcnt == 0 || p.statusDvcnt == 8)}">
                                                            <a href="taothongso.html?id=${p.maDvcnt}" class="info">Tạo thông số </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS DUYET HOAN TAT CHINH SUA-->
                                                    <c:choose>      
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && ( p.statusDvcnt == 3 ||  p.statusDvcnt == 4 ||  p.statusDvcnt == 5)}">
                                                            <a href="ho1guiduyetchinhsua.html?id=${p.maDvcnt}" class="info">Hoàn tất(Gửi duyệt)</a> 
                                                            &nbsp;| <a href="trave.html?id=${p.maDvcnt}" class="duyet">Trả về</a>
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 2 CN/PGD-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 3 && (groupuser == 2) && macn == p.cnQuanly}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 4 || p.statusDuyet == 5) && (groupuser == 3 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 6 && (groupuser == 4 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet > 13 && p.statusDuyet < 16) && (groupuser == 5 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 16) && (groupuser == 6 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.KTT&NHS-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 7 || p.statusDuyet == 17) && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 8 && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 10  && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 11 && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 12 && groupuser == 8}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.KTT&NHS-->
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 0}">
                                                            <span style="color: green">ĐĂNG KÝ MỚI</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 2 || p.statusDvcnt == 3}">
                                                            <span style="color: orange"><span style="color: orangered">CHỈNH SỬA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 5}">
                                                            <span style="color: orange"><span style="color: red">TẠM <span style="color: orange"><span style="color: red">KHÓA</span></span></span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 4}">
                                                            <span style="color: orange"><span style="color: red">KHÓA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${p.user1CnNgaynhap}</td>
                                                <td>${p.cnQuanly}</td>
                                                <td>${p.user1Cn}</td>
                                            </tr>
                                        </c:when>
                                    </c:choose>

                                    <!--PHONG KHACH HANG CA NHAN-->
                                    <c:choose>
                                        <c:when test="${(groupuser == 5 || groupuser == 6) && p.loaihinhDvcnt == 1 && p.statusDvcnt != 1}">
                                            <tr class="row">
                                                <td><a href="export2.html?id=${p.maDvcnt}" class="detail" target="_blank">${p.maDvcnt}</a></td>
                                                <td>${p.gpdkkdso}</td>
                                                <td>${p.tenDvcntVn}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 2}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 3}">
                                                            <span class="chuyentiep2">Chuyển đến (2)CN/PGD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 14  && p.loaihinhDvcnt == 1}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 0}">
                                                            <span class="trave">Trả về</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>


                                                        <c:when test="${p.statusDuyet == 15}">
                                                            <span class="chuyentiep2">P.QLKDTD đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 16}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 7}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 17}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 8}">
                                                            <span class="chuyentiep2">P.KTT&NHS đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 9}">
                                                            <span class="chuyentiep2">Gửi yêu cầu sang VTB</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 10}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đang map thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 11}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đã map đủ thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 12}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS gửi duyệt</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 4}">
                                                            <span class="hoantattaothongso">(2)P.KTT&NHS đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 5}">
                                                            <span class="hoantattaothongso"></span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt <=2}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất tạo thông số</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 9}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất t/số lắp thêm</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet <= 2) && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="chitietdvcnt.html?id=${p.maDvcnt}" class="detail">Điều chỉnh</a> | 
                                                        </c:when>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="delete">Thông tin máy POS</a><span class="space">&nbsp;</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 2 || p.statusDuyet == 0) && groupuser == 1 && macn == p.cnQuanly}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="info">Xem thông tin lắp đặt </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS thấy link Mapping thong so-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && (p.statusDvcnt == 0 || p.statusDvcnt == 8)}">
                                                            <a href="taothongso.html?id=${p.maDvcnt}" class="info">Tạo thông số </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS DUYET HOAN TAT CHINH SUA-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && ( p.statusDvcnt == 3 ||  p.statusDvcnt == 4 ||  p.statusDvcnt == 5)}">
                                                            <a href="ho1guiduyetchinhsua.html?id=${p.maDvcnt}" class="info">Hoàn tất(Gửi duyệt)</a>
                                                            &nbsp;| <a href="trave.html?id=${p.maDvcnt}" class="duyet">Trả về</a>
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 2 CN/PGD-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 3 && (groupuser == 2) && macn == p.cnQuanly}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 4 || p.statusDuyet == 5) && (groupuser == 3 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 6 && (groupuser == 4 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet > 13 && p.statusDuyet < 16) && (groupuser == 5 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 16) && (groupuser == 6 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.KTT&NHS-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 7 || p.statusDuyet == 17) && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 8 && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 10  && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 11 && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 12 && groupuser == 8}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 0}">
                                                            <span style="color: green">ĐĂNG KÝ MỚI</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 2 || p.statusDvcnt == 3}">
                                                            <span style="color: orange"><span style="color: orangered">CHỈNH SỬA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 5}">
                                                            <span style="color: orange"><span style="color: red">TẠM <span style="color: orange"><span style="color: red">KHÓA</span></span></span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 4}">
                                                            <span style="color: orange"><span style="color: red">KHÓA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 8}">
                                                            <span style="color: orange"><span style="color: purple">LẮP THÊM POS</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${p.user1CnNgaynhap}</td>
                                                <td>${p.cnQuanly}</td>
                                                <td>${p.user1Cn}</td>
                                            </tr>
                                        </c:when>
                                    </c:choose>

                                    <!--CN/PGD HOAC HOI SO-->       
                                    <c:choose>
                                        <c:when test="${groupuser < 3 || groupuser > 6 && p.statusDvcnt != 1}">
                                            <tr class="row">
                                                <td><a href="export2.html?id=${p.maDvcnt}" class="detail" target="_blank">${p.maDvcnt}</a></td>
                                                <td>${p.gpdkkdso}</td>
                                                <td>${p.tenDvcntVn}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && p.user1Cn == mauser}">
                                                            <div class="dropdownDangTaoHoS">
                                                                <button class="dropDangTaoHoSo">Đ/vị đang tạo hồ sơ</button>
                                                                <div class="dropdownDangTaoHoS-content">
                                                                    <p> &nbsp; </p>
                                                                    <span>Xóa ĐVCNT ${p.maDvcnt} ?</span>
                                                                    <center><a class="xacNhanXoaHoSoDvcnt" href="xoadvcntdangxuly?id=${p.maDvcnt}"><span class="btnxacnhanxoa">Xác nhận xóa</span></a></center>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 1}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 2}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 3}">
                                                            <span class="chuyentiep2">Chuyển đến (2)CN/PGD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 4  && p.loaihinhDvcnt == 2}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 14  && p.loaihinhDvcnt == 1}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 0}">
                                                            <span class="trave">Trả về</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 5}">
                                                            <span class="chuyentiep2">P.SP&CS KHDN đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 15}">
                                                            <span class="chuyentiep2">P.QLKDTD đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 6}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 16}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 7}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 17}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 8}">
                                                            <span class="chuyentiep2">P.KTT&NHS đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 9}">
                                                            <span class="chuyentiep2">Gửi yêu cầu sang VTB</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 10}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đang map thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 11}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đã map đủ thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 12}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS gửi duyệt</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 4}">
                                                            <span class="hoantattaothongso">(2)P.KTT&NHS đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 5}">
                                                            <span class="hoantattaothongso"></span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt <=2}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất tạo thông số</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 9}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất t/số lắp thêm</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet <= 2 && p.statusDvcnt != 10 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="chitietdvcnt.html?id=${p.maDvcnt}" class="detail">Điều chỉnh</a> | 
                                                        </c:when>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser && p.user1Cn == mauser}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="delete">Thông tin máy POS</a><span class="space">&nbsp;</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 2 || p.statusDuyet == 0) && groupuser == 1 && macn == p.cnQuanly}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="info">Xem thông tin lắp đặt </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS thấy link Mapping thong so-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && (p.statusDvcnt == 0 || p.statusDvcnt == 8)}">
                                                            <a href="taothongso.html?id=${p.maDvcnt}" class="info">Tạo thông số </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS DUYET HOAN TAT CHINH SUA-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && ( p.statusDvcnt == 3 ||  p.statusDvcnt == 4 ||  p.statusDvcnt == 5)}">
                                                            <a href="ho1guiduyetchinhsua.html?id=${p.maDvcnt}" class="info">Hoàn tất(Gửi duyệt)</a>
                                                            &nbsp;| <a href="trave.html?id=${p.maDvcnt}" class="duyet">Trả về</a>
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 2 CN/PGD-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 3 && (groupuser == 2) && macn == p.cnQuanly}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 4 || p.statusDuyet == 5) && (groupuser == 3 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 6 && (groupuser == 4 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet > 13 && p.statusDuyet < 16) && (groupuser == 5 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 16) && (groupuser == 6 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.KTT&NHS-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 7 || p.statusDuyet == 17) && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 8 && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 10  && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 11 && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 12 && groupuser == 8}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 13 && groupuser == 1 && macn == p.cnQuanly && p.statusDvcnt == 4}">
                                                            <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="nhanhosothuhoipos">Duyệt thu hồi POS</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 13 && groupuser == 1 && macn == p.cnQuanly && p.statusDvcnt == 5}">
                                                            <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="nhanhosothuhoipos">Duyệt thu hồi POS_</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 13 && groupuser == 1 && macn == p.cnQuanly && (p.statusDvcnt != 3 && p.statusDvcnt != 4 && p.statusDvcnt != 5 && p.statusDvcnt != 8)}">
                                                            <a href="bienbanBanGiao.html?id=${p.maDvcnt}" class="nhanhosolapdat" target="_blank">Export</a>
                                                            <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="nhanhosolapdat">Hoàn tất hồ sơ</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.KTT&NHS-->
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 10}">
                                                            <span style="color: red">ĐÃ XÓA</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 0}">
                                                            <span style="color: green">ĐĂNG KÝ MỚI</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 2 || p.statusDvcnt == 3}">
                                                            <span style="color: orange"><span style="color: orangered">CHỈNH SỬA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 5}">
                                                            <span style="color: orange"><span style="color: red">TẠM <span style="color: orange"><span style="color: red">KHÓA</span></span></span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 4}">
                                                            <span style="color: orange"><span style="color: red">KHÓA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 8}">
                                                            <span style="color: orange"><span style="color: purple">LẮP THÊM POS</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${p.user1CnNgaynhap}</td>
                                                <td>${p.cnQuanly}</td>
                                                <td>${p.user1Cn}</td>
                                                <c:choose>
                                                    <c:when test="${groupuser == 2}">
                                                        <td>PHAN QUYEN USER</td>
                                                    </c:when>
                                                </c:choose>
                                            </tr>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        </c:when>                       
                    </c:choose>



                    <!--Nhân viên HO thấy đc DS tất cả ĐVCNT-->
                    <c:choose>
                        <c:when test="${groupuser >= 7}">
                            <c:choose>
                                <c:when test="${p.statusDvcnt != 1 && p.statusDvcnt != 6 && p.statusDvcnt != 7}">
                                    <!--PHONG KHACH HANG DOANH NGHIEP-->
                                    <c:choose>
                                        <c:when test="${(groupuser == 3 || groupuser == 4) && p.loaihinhDvcnt == 2}">
                                            <tr class="row">
                                                <td><a href="export2.html?id=${p.maDvcnt}" class="detail" target="_blank">${p.maDvcnt}</a></td>
                                                <td>${p.gpdkkdso}</td>
                                                <td>${p.tenDvcntVn}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 2}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 3}">
                                                            <span class="chuyentiep2">Chuyển đến (2)CN/PGD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 4  && p.loaihinhDvcnt == 2}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 0}">
                                                            <span class="trave">Trả về</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 5}">
                                                            <span class="chuyentiep2">P.SP&CS KHDN đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 6}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 7}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 17}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 8}">
                                                            <span class="chuyentiep2">P.KTT&NHS đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 9}">
                                                            <span class="chuyentiep2">Gửi yêu cầu sang VTB</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 10}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đang map thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 11}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đã map đủ thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 12}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS gửi duyệt</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 4}">
                                                            <span class="hoantattaothongso">(2)P.KTT&NHS đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 5}">
                                                            <span class="hoantattaothongso"></span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt <=2}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất tạo thông số</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 9}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất t/số lắp thêm</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet <= 2) && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="chitietdvcnt.html?id=${p.maDvcnt}" class="detail">Điều chỉnh</a> | 
                                                        </c:when>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="delete">Thông tin máy POS</a><span class="space">&nbsp;</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 2 || p.statusDuyet == 0) && groupuser == 1 && macn == p.cnQuanly}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="info">Xem thông tin lắp đặt </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS thấy link Mapping thong so-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && (p.statusDvcnt == 0 || p.statusDvcnt == 8)}">
                                                            <a href="taothongso.html?id=${p.maDvcnt}" class="info">Tạo thông số </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS DUYET HOAN TAT CHINH SUA-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && ( p.statusDvcnt == 3 ||  p.statusDvcnt == 4 ||  p.statusDvcnt == 5)}">
                                                            <a href="ho1guiduyetchinhsua.html?id=${p.maDvcnt}" class="info">Hoàn tất(Gửi duyệt)</a> 
                                                            &nbsp;| <a href="trave.html?id=${p.maDvcnt}" class="duyet">Trả về</a>
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 2 CN/PGD-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 3 && (groupuser == 2) && macn == p.cnQuanly}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 4 || p.statusDuyet == 5) && (groupuser == 3 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 6 && (groupuser == 4 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet > 13 && p.statusDuyet < 16) && (groupuser == 5 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 16) && (groupuser == 6 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.KTT&NHS-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 7 || p.statusDuyet == 17) && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 8 && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 10  && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 11 && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 12 && groupuser == 8}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.KTT&NHS-->
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 0}">
                                                            <span style="color: green">ĐĂNG KÝ MỚI</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 2 || p.statusDvcnt == 3}">
                                                            <span style="color: orange"><span style="color: orangered">CHỈNH SỬA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 5}">
                                                            <span style="color: orange"><span style="color: red">TẠM <span style="color: orange"><span style="color: red">KHÓA</span></span></span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 4}">
                                                            <span style="color: orange"><span style="color: red">KHÓA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${p.user1CnNgaynhap}</td>
                                                <td>${p.cnQuanly}</td>
                                                <td>${p.user1Cn}</td>
                                            </tr>
                                        </c:when>
                                    </c:choose>

                                    <!--PHONG KHACH HANG CA NHAN-->
                                    <c:choose>
                                        <c:when test="${(groupuser == 5 || groupuser == 6) && p.loaihinhDvcnt == 1 && p.statusDvcnt != 1}">
                                            <tr class="row">
                                                <td><a href="export2.html?id=${p.maDvcnt}" class="detail" target="_blank">${p.maDvcnt}</a></td>
                                                <td>${p.gpdkkdso}</td>
                                                <td>${p.tenDvcntVn}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 2}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 3}">
                                                            <span class="chuyentiep2">Chuyển đến (2)CN/PGD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 14  && p.loaihinhDvcnt == 1}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 0}">
                                                            <span class="trave">Trả về</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>


                                                        <c:when test="${p.statusDuyet == 15}">
                                                            <span class="chuyentiep2">P.QLKDTD đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 16}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 7}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 17}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 8}">
                                                            <span class="chuyentiep2">P.KTT&NHS đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 9}">
                                                            <span class="chuyentiep2">Gửi yêu cầu sang VTB</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 10}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đang map thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 11}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đã map đủ thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 12}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS gửi duyệt</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 4}">
                                                            <span class="hoantattaothongso">(2)P.KTT&NHS đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 5}">
                                                            <span class="hoantattaothongso"></span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt <=2}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất tạo thông số</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 9}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất t/số lắp thêm</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet <= 2) && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="chitietdvcnt.html?id=${p.maDvcnt}" class="detail">Điều chỉnh</a> | 
                                                        </c:when>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="delete">Thông tin máy POS</a><span class="space">&nbsp;</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 2 || p.statusDuyet == 0) && groupuser == 1 && macn == p.cnQuanly}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="info">Xem thông tin lắp đặt </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS thấy link Mapping thong so-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && (p.statusDvcnt == 0 || p.statusDvcnt == 8)}">
                                                            <a href="taothongso.html?id=${p.maDvcnt}" class="info">Tạo thông số </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS DUYET HOAN TAT CHINH SUA-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && ( p.statusDvcnt == 3 ||  p.statusDvcnt == 4 ||  p.statusDvcnt == 5)}">
                                                            <a href="ho1guiduyetchinhsua.html?id=${p.maDvcnt}" class="info">Hoàn tất(Gửi duyệt)</a>
                                                            &nbsp;| <a href="trave.html?id=${p.maDvcnt}" class="duyet">Trả về</a>
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 2 CN/PGD-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 3 && (groupuser == 2) && macn == p.cnQuanly}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 4 || p.statusDuyet == 5) && (groupuser == 3 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 6 && (groupuser == 4 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet > 13 && p.statusDuyet < 16) && (groupuser == 5 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 16) && (groupuser == 6 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.KTT&NHS-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 7 || p.statusDuyet == 17) && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 8 && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 10  && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 11 && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 12 && groupuser == 8}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 0}">
                                                            <span style="color: green">ĐĂNG KÝ MỚI</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 2 || p.statusDvcnt == 3}">
                                                            <span style="color: orange"><span style="color: orangered">CHỈNH SỬA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 5}">
                                                            <span style="color: orange"><span style="color: red">TẠM <span style="color: orange"><span style="color: red">KHÓA</span></span></span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 4}">
                                                            <span style="color: orange"><span style="color: red">KHÓA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 8}">
                                                            <span style="color: orange"><span style="color: purple">LẮP THÊM POS</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${p.user1CnNgaynhap}</td>
                                                <td>${p.cnQuanly}</td>
                                                <td>${p.user1Cn}</td>
                                            </tr>
                                        </c:when>
                                    </c:choose>

                                    <!--CN/PGD HOAC HOI SO-->       
                                    <c:choose>
                                        <c:when test="${groupuser < 3 || groupuser > 6 && p.statusDvcnt != 1}">
                                            <tr class="row">
                                                <td><a href="export2.html?id=${p.maDvcnt}" class="detail" target="_blank">${p.maDvcnt}</a></td>
                                                <td>${p.gpdkkdso}</td>
                                                <td>${p.tenDvcntVn}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 2}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 3}">
                                                            <span class="chuyentiep2">Chuyển đến (2)CN/PGD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 4  && p.loaihinhDvcnt == 2}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 14  && p.loaihinhDvcnt == 1}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 0}">
                                                            <span class="trave">Trả về</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 5}">
                                                            <span class="chuyentiep2">P.SP&CS KHDN đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 15}">
                                                            <span class="chuyentiep2">P.QLKDTD đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 6}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 16}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 7}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 17}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 8}">
                                                            <span class="chuyentiep2">P.KTT&NHS đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 9}">
                                                            <span class="chuyentiep2">Gửi yêu cầu sang VTB</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 10}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đang map thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 11}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đã map đủ thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 12}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS gửi duyệt</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 4}">
                                                            <span class="hoantattaothongso">(2)P.KTT&NHS đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 5}">
                                                            <span class="hoantattaothongso"></span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt <=2}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất tạo thông số</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 9}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất t/số lắp thêm</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td><!--Thao tac-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet <= 2) && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="chitietdvcnt.html?id=${p.maDvcnt}" class="detail">Điều chỉnh</a> | 
                                                        </c:when>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="delete">Thông tin máy POS</a><span class="space">&nbsp;</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 2 || p.statusDuyet == 0) && groupuser == 1 && macn == p.cnQuanly}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="info">Xem thông tin lắp đặt </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS thấy link Mapping thong so-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && (p.statusDvcnt == 0 || p.statusDvcnt == 8)}">
                                                            <a href="taothongso.html?id=${p.maDvcnt}" class="info">Tạo thông số </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS DUYET HOAN TAT CHINH SUA-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && ( p.statusDvcnt == 3 ||  p.statusDvcnt == 4 ||  p.statusDvcnt == 5)}">
                                                            <a href="ho1guiduyetchinhsua.html?id=${p.maDvcnt}" class="info">Hoàn tất(Gửi duyệt)</a>
                                                            &nbsp;| <a href="trave.html?id=${p.maDvcnt}" class="duyet">Trả về</a>
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 2 CN/PGD-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 3 && (groupuser == 2) && macn == p.cnQuanly}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 4 || p.statusDuyet == 5) && (groupuser == 3 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 6 && (groupuser == 4 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet > 13 && p.statusDuyet < 16) && (groupuser == 5 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 16) && (groupuser == 6 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.KTT&NHS-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 7 || p.statusDuyet == 17) && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 8 && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 10  && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 11 && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 12 && groupuser == 8}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 13 && groupuser == 1 && macn == p.cnQuanly && p.statusDvcnt == 4}">
                                                            <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="nhanhosothuhoipos">Duyệt thu hồi POS</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 13 && groupuser == 1 && macn == p.cnQuanly && p.statusDvcnt == 5}">
                                                            <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="nhanhosothuhoipos">Duyệt thu hồi POS_</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 13 && groupuser == 1 && macn == p.cnQuanly && (p.statusDvcnt != 3 && p.statusDvcnt != 4 && p.statusDvcnt != 5 && p.statusDvcnt != 8)}">
                                                            <a href="bienbanBanGiao.html?id=${p.maDvcnt}" class="nhanhosolapdat" target="_blank">Export</a>
                                                            <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="nhanhosolapdat">Hoàn tất hồ sơ</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.KTT&NHS-->
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 0}">
                                                            <span style="color: green">ĐĂNG KÝ MỚI</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 2 || p.statusDvcnt == 3}">
                                                            <span style="color: orange"><span style="color: orangered">CHỈNH SỬA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 5}">
                                                            <span style="color: orange"><span style="color: red">TẠM <span style="color: orange"><span style="color: red">KHÓA</span></span></span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 4}">
                                                            <span style="color: orange"><span style="color: red">KHÓA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 8}">
                                                            <span style="color: orange"><span style="color: purple">LẮP THÊM POS</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    ${fn:substring(p.user1CnNgaynhap, 6, 8)}/
                                                    ${fn:substring(p.user1CnNgaynhap, 4, 6)}/
                                                    ${fn:substring(p.user1CnNgaynhap, 0, 4)}
                                                </td>
                                                <td>${p.cnQuanly}</td>
                                                <td>${p.user1Cn}</td>
                                            </tr>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        </c:when>                       
                    </c:choose>

                    <!--Nhân viên P.SP&CS KHDN hoac P.TDBH  thấy đc ĐVCNT thuộc loại hình Tổ chức hoặc hộ kinh doanh-->                        
                    <c:choose>
                        <c:when test="${groupuser >= 3 && groupuser <= 6}">
                            <c:choose>
                                <c:when test="${p.statusDvcnt != 1 && p.statusDvcnt != 6 && p.statusDvcnt != 7}">
                                    <!--PHONG KHACH HANG DOANH NGHIEP-->
                                    <c:choose>
                                        <c:when test="${(groupuser == 3 || groupuser == 4) && p.loaihinhDvcnt == 2}">
                                            <tr class="row">
                                                <td><a href="export2.html?id=${p.maDvcnt}" class="detail" target="_blank">${p.maDvcnt}</a></td>
                                                <td>${p.gpdkkdso}</td>
                                                <td>
                                                    ${p.tenDvcntVn}
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 2}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 3}">
                                                            <span class="chuyentiep2">Chuyển đến (2)CN/PGD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 4  && p.loaihinhDvcnt == 2}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 0}">
                                                            <span class="trave">Trả về</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 5}">
                                                            <span class="chuyentiep2">P.SP&CS KHDN đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 6}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 7}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 17}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 8}">
                                                            <span class="chuyentiep2">P.KTT&NHS đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 9}">
                                                            <span class="chuyentiep2">Gửi yêu cầu sang VTB</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 10}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đang map thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 11}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đã map đủ thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 12}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS gửi duyệt</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 4}">
                                                            <span class="hoantattaothongso">(2)P.KTT&NHS đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 5}">
                                                            <span class="hoantattaothongso"></span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt <=2}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất tạo thông số</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 9}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất t/số lắp thêm</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet <= 2) && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="chitietdvcnt.html?id=${p.maDvcnt}" class="detail">Điều chỉnh</a> | 
                                                        </c:when>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="delete">Thông tin máy POS</a><span class="space">&nbsp;</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 2 || p.statusDuyet == 0) && groupuser == 1 && macn == p.cnQuanly}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="info">Xem thông tin lắp đặt </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS thấy link Mapping thong so-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && (p.statusDvcnt == 0 || p.statusDvcnt == 8)}">
                                                            <a href="taothongso.html?id=${p.maDvcnt}" class="info">Tạo thông số </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS DUYET HOAN TAT CHINH SUA-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && ( p.statusDvcnt == 3 ||  p.statusDvcnt == 4 ||  p.statusDvcnt == 5)}">
                                                            <a href="ho1guiduyetchinhsua.html?id=${p.maDvcnt}" class="info">Hoàn tất(Gửi duyệt)</a> 
                                                            &nbsp;| <a href="trave.html?id=${p.maDvcnt}" class="duyet">Trả về</a>
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 2 CN/PGD-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 3 && (groupuser == 2) && macn == p.cnQuanly}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 4 || p.statusDuyet == 5) && (groupuser == 3 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 6 && (groupuser == 4 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet > 13 && p.statusDuyet < 16) && (groupuser == 5 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 16) && (groupuser == 6 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.KTT&NHS-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 7 || p.statusDuyet == 17) && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 8 && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 10  && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 11 && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 12 && groupuser == 8}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.KTT&NHS-->
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 0}">
                                                            <span style="color: green">ĐĂNG KÝ MỚI</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 2 || p.statusDvcnt == 3}">
                                                            <span style="color: orange"><span style="color: orangered">CHỈNH SỬA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 5}">
                                                            <span style="color: orange"><span style="color: red">TẠM <span style="color: orange"><span style="color: red">KHÓA</span></span></span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 4}">
                                                            <span style="color: orange"><span style="color: red">KHÓA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${p.user1CnNgaynhap}</td>
                                                <td>${p.cnQuanly}</td>
                                                <td>${p.user1Cn}</td>
                                            </tr>
                                        </c:when>
                                    </c:choose>

                                    <!--PHONG KHACH HANG CA NHAN-->
                                    <c:choose>
                                        <c:when test="${(groupuser == 5 || groupuser == 6) && p.loaihinhDvcnt == 1 && p.statusDvcnt != 1}">
                                            <tr class="row">
                                                <td><a href="export2.html?id=${p.maDvcnt}" class="detail" target="_blank">${p.maDvcnt}</a></td>
                                                <td>${p.gpdkkdso}</td>
                                                <td>
                                                    <a href="export2.html?id=${p.maDvcnt}" style="text-decoration: none; text-align: left;" target="_blank">${p.tenDvcntVn}</a>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 2}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 3}">
                                                            <span class="chuyentiep2">Chuyển đến (2)CN/PGD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 14  && p.loaihinhDvcnt == 1}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 0}">
                                                            <span class="trave">Trả về</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 15}">
                                                            <span class="chuyentiep2">P.QLKDTD đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 16}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 7}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 17}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 8}">
                                                            <span class="chuyentiep2">P.KTT&NHS đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 9}">
                                                            <span class="chuyentiep2">Gửi yêu cầu sang VTB</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 10}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đang map thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 11}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đã map đủ thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 12}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS gửi duyệt</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 4}">
                                                            <span class="hoantattaothongso">(2)P.KTT&NHS đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 5}">
                                                            <span class="hoantattaothongso"></span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt <=2}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất tạo thông số</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 9}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất t/số lắp thêm</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet <= 2) && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="chitietdvcnt.html?id=${p.maDvcnt}" class="detail">Điều chỉnh</a> | 
                                                        </c:when>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="delete">Thông tin máy POS</a><span class="space">&nbsp;</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 2 || p.statusDuyet == 0) && groupuser == 1 && macn == p.cnQuanly}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="info">Xem thông tin lắp đặt </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS thấy link Mapping thong so-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && (p.statusDvcnt == 0 || p.statusDvcnt == 8)}">
                                                            <a href="taothongso.html?id=${p.maDvcnt}" class="info">Tạo thông số </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS DUYET HOAN TAT CHINH SUA-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && ( p.statusDvcnt == 3 ||  p.statusDvcnt == 4 ||  p.statusDvcnt == 5)}">
                                                            <a href="ho1guiduyetchinhsua.html?id=${p.maDvcnt}" class="info">Hoàn tất(Gửi duyệt)</a>
                                                            &nbsp;| <a href="trave.html?id=${p.maDvcnt}" class="duyet">Trả về</a>
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 2 CN/PGD-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 3 && (groupuser == 2) && macn == p.cnQuanly}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 4 || p.statusDuyet == 5) && (groupuser == 3 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 6 && (groupuser == 4 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet > 13 && p.statusDuyet < 16) && (groupuser == 5 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 16) && (groupuser == 6 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.KTT&NHS-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 7 || p.statusDuyet == 17) && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 8 && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 10  && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 11 && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 12 && groupuser == 8}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 0}">
                                                            <span style="color: green">ĐĂNG KÝ MỚI</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 2 || p.statusDvcnt == 3}">
                                                            <span style="color: orange"><span style="color: orangered">CHỈNH SỬA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 5}">
                                                            <span style="color: orange"><span style="color: red">TẠM <span style="color: orange"><span style="color: red">KHÓA</span></span></span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 4}">
                                                            <span style="color: orange"><span style="color: red">KHÓA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 8}">
                                                            <span style="color: orange"><span style="color: purple">LẮP THÊM POS</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${p.user1CnNgaynhap}</td>
                                                <td>${p.cnQuanly}</td>
                                                <td>${p.user1Cn}</td>
                                            </tr>
                                        </c:when>
                                    </c:choose>

                                    <!--CN/PGD HOAC HOI SO-->       
                                    <c:choose>
                                        <c:when test="${groupuser < 3 || groupuser > 6 && p.statusDvcnt != 1}">
                                            <tr class="row">
                                                <td><a href="export2.html?id=${p.maDvcnt}" class="detail" target="_blank">${p.maDvcnt}</a></td>
                                                <td>${p.gpdkkdso}</td>
                                                <td>
                                                    <a href="export2.html?id=${p.maDvcnt}" target="_blank">${p.tenDvcntVn}</a>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 2}">
                                                            Đ/vị đang tạo hồ sơ
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 3}">
                                                            <span class="chuyentiep2">Chuyển đến (2)CN/PGD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 4  && p.loaihinhDvcnt == 2}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 14  && p.loaihinhDvcnt == 1}">
                                                            <span class="chuyentiep2">Đang chuyển đến P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 0}">
                                                            <span class="trave">Trả về</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>

                                                        <c:when test="${p.statusDuyet == 5}">
                                                            <span class="chuyentiep2">P.SP&CS KHDN đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 15}">
                                                            <span class="chuyentiep2">P.QLKDTD đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 6}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.SP&CS KHDN</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 16}">
                                                            <span class="chuyentiep2">Chuyển đến (2)P.QLKDTD</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 7}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 17}">
                                                            <span class="chuyentiep2">Chuyển đến P.KTT&NHS</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 8}">
                                                            <span class="chuyentiep2">P.KTT&NHS đã nhận</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 9}">
                                                            <span class="chuyentiep2">Gửi yêu cầu sang VTB</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 10}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đang map thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 11}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS đã map đủ thông số</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 12}">
                                                            <span class="chuyentiep2">(1)P.KTT&NHS gửi duyệt</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 4}">
                                                            <span class="hoantattaothongso">(2)P.KTT&NHS đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 5}">
                                                            <span class="hoantattaothongso"></span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt <=2}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất tạo thông số</span>
                                                        </c:when>
                                                        <c:when test="${p.statusDuyet == 13 && p.statusDvcnt == 9}">
                                                            <span class="hoantattaothongso">P.KTT&NHS hoàn tất t/số lắp thêm</span>
                                                            <a href="quytrinhduyet.html?id=${p.maDvcnt}" target="_blank" class="detail">Chi tiết</a>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet <= 2) && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="chitietdvcnt.html?id=${p.maDvcnt}" class="detail">Điều chỉnh</a> | 
                                                        </c:when>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 1 && groupuser == 1 && macn == p.cnQuanly && p.user1Cn == mauser}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="delete">Thông tin máy POS</a><span class="space">&nbsp;</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 2 || p.statusDuyet == 0) && groupuser == 1 && macn == p.cnQuanly}">
                                                            <a href="themthongtinlapdatpos.html?id=${p.maDvcnt}" class="info">Xem thông tin lắp đặt </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS thấy link Mapping thong so-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && (p.statusDvcnt == 0 || p.statusDvcnt == 8)}">
                                                            <a href="taothongso.html?id=${p.maDvcnt}" class="info">Tạo thông số </a>&nbsp;| 
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 1 P.KTT&NHS DUYET HOAN TAT CHINH SUA-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 9 || p.statusDuyet == 10) && groupuser == 7 && macn == '000' && ( p.statusDvcnt == 3 ||  p.statusDvcnt == 4 ||  p.statusDvcnt == 5)}">
                                                            <a href="ho1guiduyetchinhsua.html?id=${p.maDvcnt}" class="info">Hoàn tất(Gửi duyệt)</a>
                                                            &nbsp;| <a href="trave.html?id=${p.maDvcnt}" class="duyet">Trả về</a>
                                                        </c:when>
                                                    </c:choose>

                                                    <!--User cap 2 CN/PGD-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 3 && (groupuser == 2) && macn == p.cnQuanly}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 4 || p.statusDuyet == 5) && (groupuser == 3 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.SP&CS KHDN-->
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 6 && (groupuser == 4 && p.loaihinhDvcnt == 2)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet > 13 && p.statusDuyet < 16) && (groupuser == 5 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.QLKDTD-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 16) && (groupuser == 6 && p.loaihinhDvcnt == 1)}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 1 P.KTT&NHS-->
                                                    <c:choose>
                                                        <c:when test="${(p.statusDuyet == 7 || p.statusDuyet == 17) && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 8 && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 10  && groupuser == 7}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 11 && groupuser == 7}">
                                                            <a href="chuyentiep.html?id=${p.maDvcnt}" class="duyet">Gửi duyệt th/số</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 12 && groupuser == 8}">
                                                            <a href="duyet.html?id=${p.maDvcnt}" class="duyet">Chờ duyệt</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 13 && groupuser == 1 && macn == p.cnQuanly && p.statusDvcnt == 4}">
                                                            <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="nhanhosothuhoipos">Duyệt thu hồi POS</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 13 && groupuser == 1 && macn == p.cnQuanly && p.statusDvcnt == 5}">
                                                            <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="nhanhosothuhoipos">Duyệt thu hồi POS_</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDuyet == 13 && groupuser == 1 && macn == p.cnQuanly && (p.statusDvcnt != 3 && p.statusDvcnt != 4 && p.statusDvcnt != 5 && p.statusDvcnt != 8)}">
                                                            <a href="bienbanBanGiao.html?id=${p.maDvcnt}" class="nhanhosolapdat" target="_blank">Export</a>
                                                            <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="nhanhosolapdat">Hoàn tất hồ sơ</a>
                                                        </c:when>
                                                    </c:choose>
                                                    <!--User cap 2 P.KTT&NHS-->
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 0}">
                                                            <span style="color: green">ĐĂNG KÝ MỚI</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 2 || p.statusDvcnt == 3}">
                                                            <span style="color: orange"><span style="color: orangered">CHỈNH SỬA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 5}">
                                                            <span style="color: orange"><span style="color: red">TẠM <span style="color: orange"><span style="color: red">KHÓA</span></span></span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 4}">
                                                            <span style="color: orange"><span style="color: red">KHÓA</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.statusDvcnt == 8}">
                                                            <span style="color: orange"><span style="color: purple">LẮP THÊM POS</span></span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${p.user1CnNgaynhap}</td>
                                                <td>${p.cnQuanly}</td>
                                                <td>${p.user1Cn}</td>
                                            </tr>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        </c:when>                       
                    </c:choose>
                </c:forEach>
            </table>
        </div>
    </center>

    <footer>
        <center>
            <h4><a href="index.html">Trở về trang chủ</a></h5>
                <span>-------------------------------------------------</span>
                <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
        </center>
    </footer>
</center>

<script>

    function caps(id) {
        document.getElementById(id).value = document.getElementById(id).value.toUpperCase();
    }
</script>
<script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
<script>
    $(document).ready(function () {
        $("#testTable").children("tbody").children("tr").children("td").click(function () {
            $(this.parentNode).toggleClass("active");
        });
    });
</script>
</body>
</html>
