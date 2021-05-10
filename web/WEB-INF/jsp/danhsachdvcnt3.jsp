<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>DANH SÁCH ĐVCNT</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/dsdvcnt.css"/>
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
                        </div>
                    </div>
                </li>
                <li>Danh sách ĐVCNT</li>
            </ul>
            <center>
                <h2>ĐƠN VỊ CHẤP NHẬN THẺ ĐÃ LẮP ĐẶT POS
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> &nbsp;/&nbsp; ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>
    <center>
        <div class="content">
            <div class="timkiem">
                <form action="${pageContext.request.contextPath}/searchcombobox" method="get" class="timkiembasic">
                    <p>Tìm kiếm theo: </p>
                    <select name="dieukiensearchbasic">
                        <c:choose>
                            <c:when test="${keysearchbasic == '0'}">
                                <option value="0" selected="selected">TẤT CẢ</option>
                            </c:when>
                            <c:otherwise>
                                <option value="0">TẤT CẢ</option>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${keysearchbasic == '1'}">
                                <option value="1" selected="selected">MÃ ĐVCNT</option>
                            </c:when>
                            <c:otherwise>
                                <option value="1">MÃ ĐVCNT</option>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${keysearchbasic == '2'}">
                                <option value="2" selected="selected">SÔ GPKD</option>
                            </c:when>
                            <c:otherwise>
                                <option value="2">SÔ GPKD</option>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${keysearchbasic == '3'}">
                                <option value="3" selected="selected">CN QUẢN LÝ</option>
                            </c:when>
                            <c:otherwise>
                                <option value="3">CN QUẢN LÝ</option>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${keysearchbasic == '4'}">
                                <option value="4" selected="selected">DOANH NGHIỆP</option>
                            </c:when>
                            <c:otherwise>
                                <option value="4">DOANH NGHIỆP</option>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${keysearchbasic == '5'}">
                                <option value="5" selected="selected">HỘ KINH DOANH</option>
                            </c:when>
                            <c:otherwise>
                                <option value="5">HỘ KINH DOANH</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                    <input name="txtTimKiem" placeholder="Tìm kiếm..." class="txtTimKiem"/>
                    <input type="submit" value="TÌM KIẾM" class="submit"/>
                    <c:choose>
                        <c:when test="${error != null}">
                            <center>
                                <marquee style="font-weight: bold; float: left; color: red; background-color: yellow" behavior="alternate" width="65%%">${error}</marquee>
                            </center>
                        </c:when>
                    </c:choose>
                </form>

            </div>
            <table style="margin-top: 8%; width: 130%; font-size: 13px">
                <tr>
                    <th><a href="sortiddvcntdalap.html" class="sort">ID</a></th>
                    <th><a href="sortnamedvcntdalap.html" class="sort">Tên đơn vị</a></th>
                    <th>Số GPĐKKD</th>
                    <th>STATUS</th>
                    <th>Thao tác</th>
                    <th>Địa chỉ</th>
                    <th>Loại hình ĐVCNT</th>
                    <th>CN/User quản lý</th>
                </tr>

                <c:forEach items="${lst}" var="p">
                    <c:choose>
                        <c:when test="${(p.statusDvcnt == 1 || p.statusDvcnt == 2 || p.statusDvcnt == 3 || p.statusDvcnt == 6 || p.statusDvcnt == 7 || p.statusDvcnt == 8) && p.statusDuyet == 13}">
                            <tr class="row">
                                <td> <a class="xemthongtinduyet" href="xemthongtinduyet.html?id=${p.maDvcnt}" target="_blank"> ${p.maDvcnt}</a></td>
                                <td>${p.tenDvcntVn}</td>
                                <td>${p.gpdkkdso}</td>
                                <td class="chuyentiep2">
                                    <c:choose>
                                        <c:when test="${p.statusDvcnt == 1}">
                                            Hoạt động
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.statusDvcnt == 6}">
                                            <span style="color: red">Tạm khóa</span>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.statusDvcnt == 7}">
                                            <span style="color: red">Đóng</span>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.statusDvcnt == 3 || p.statusDvcnt == 2}">
                                            <span style="color: red">Đang chỉnh sửa(chưa gửi duyệt)</span>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${p.statusDvcnt == 8}">
                                            <span style="color: red">Đang lắp thêm POS(chưa gửi duyệt)</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td style="font-size: 13px">
                                    <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="detail">Chi tiết</a>
                                    <c:choose>
                                        <c:when test="${groupuser == 1 && (macn == p.cnQuanly) && p.statusDvcnt != 6 && p.statusDvcnt != 7}">
                                            <div class="dropdown">
                                                <button class="chinhsua">Chỉnh sửa</button>
                                                <div class="dropdown-content">
                                                    <a href="editdvcnt.html?id=${p.maDvcnt}" style="color: white">Thông tin ĐVCNT</a><br/>
                                                    <a href="listseditpos.html?id=${p.maDvcnt}" style="color: white">Thông tin POS</a><br/>
                                                </div>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${groupuser == 1 && (macn == p.cnQuanly) && p.statusDvcnt != 6 && p.statusDvcnt != 7}">
                                            <a href="lapthempos.html?id=${p.maDvcnt}" class="lapthempos">Lắp thêm POS</a>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${groupuser == 1 && (macn == p.cnQuanly) && p.statusDvcnt != 6 && p.statusDvcnt != 7}">
                                            <a href="pagetamkhoa.html?id=${p.maDvcnt}" class="chinhsua" style="background-color: red;">Tạm khóa</a><br/>
                                        </c:when>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${groupuser == 1 && (macn == p.cnQuanly) && p.statusDvcnt != 6 && p.statusDvcnt != 7}">
                                            <a href="pagekhoa.html?id=${p.maDvcnt}" target="_blank" class="chinhsua" style="background-color: red">Khóa</a><br/>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>${p.diachiDvcnt}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.loaihinhDvcnt == 1}">
                                            Hộ kinh doanh
                                        </c:when>
                                        <c:otherwise>
                                            Doanh nghiệp
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${p.cnQuanly} / ${p.user1Cn}</td>
                            </tr>
                        </c:when>
                        
                        <c:when test="${p.statusDvcnt == 3 && p.statusDuyet != 13}">
                            <tr class="row"><!--TRUONG HOP DVCNT dang duoc xu lý chỉnh sửa thông tin-->
                                <td> <a class="xemthongtinduyet" href="xemthongtinduyet.html?id=${p.maDvcnt}" target="_blank"> ${p.maDvcnt}</a></td>
                                <td>${p.tenDvcntVn}</td>
                                <td>${p.gpdkkdso}</td>
                                <td class="chuyentiep2"><span style="color: red">Đang xử lý edit thông tin</span></td>
                                <td style="font-size: 13px">
                                    <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="detail">Chi tiết</a>
                                </td>
                                <td>${p.diachiDvcnt}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.loaihinhDvcnt == 1}">
                                            Hộ kinh doanh
                                        </c:when>
                                        <c:otherwise>
                                            Doanh nghiệp
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${p.cnQuanly} / ${p.user1Cn}</td>
                            </tr>
                        </c:when>
                        <c:when test="${(p.statusDvcnt == 8 && p.statusDuyet != 13) || (p.statusDvcnt == 9 && p.statusDuyet == 13)}">
                            <tr class="row"><!--TRUONG HOP DVCNT dang duoc xu lý Lap Them POS-->
                                <td> <a class="xemthongtinduyet" href="xemthongtinduyet.html?id=${p.maDvcnt}" target="_blank"> ${p.maDvcnt}</a></td>
                                <td>${p.tenDvcntVn}</td>
                                <td>${p.gpdkkdso}</td>
                                <td class="chuyentiep2"><span style="color: red">Đang xử lý lắp thêm POS</span></td>
                                <td style="font-size: 13px">
                                    <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="detail">Chi tiết</a>
                                </td>
                                <td>${p.diachiDvcnt}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.loaihinhDvcnt == 1}">
                                            Hộ kinh doanh
                                        </c:when>
                                        <c:otherwise>
                                            Doanh nghiệp
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${p.cnQuanly} / ${p.user1Cn}</td>
                            </tr>
                        </c:when>
                        <c:when test="${p.statusDvcnt == 5}">
                            <tr class="row"><!--TRUONG HOP DVCNT dang duoc xu lý TAM KHOA-->
                                <td> <a class="xemthongtinduyet" href="xemthongtinduyet.html?id=${p.maDvcnt}" target="_blank"> ${p.maDvcnt}</a></td>
                                <td>${p.tenDvcntVn}</td>
                                <td>${p.gpdkkdso}</td>
                                <td class="chuyentiep2"><span style="color: red">Đang xử lý tạm khóa</span></td>
                                <td style="font-size: 13px">
                                    <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="detail">Chi tiết</a>
                                </td>
                                <td>${p.diachiDvcnt}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.loaihinhDvcnt == 1}">
                                            Hộ kinh doanh
                                        </c:when>
                                        <c:otherwise>
                                            Doanh nghiệp
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${p.cnQuanly} / ${p.user1Cn}</td>
                            </tr>
                        </c:when>
                        <c:when test="${p.statusDvcnt == 4}">
                            <tr class="row"><!--TRUONG HOP DVCNT dang duoc xu lý  KHOA-->
                                <td> <a class="xemthongtinduyet" href="xemthongtinduyet.html?id=${p.maDvcnt}" target="_blank"> ${p.maDvcnt}</a></td>
                                <td>${p.tenDvcntVn}</td>
                                <td>${p.gpdkkdso}</td>
                                <td class="chuyentiep2"><span style="color: red">Đang xử lý khóa</span></td>
                                <td style="font-size: 13px">
                                    <a href="chitietdvcntdaplap.html?id=${p.maDvcnt}" class="detail">Chi tiết</a>
                                </td>
                                <td>${p.diachiDvcnt}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.loaihinhDvcnt == 1}">
                                            Hộ kinh doanh
                                        </c:when>
                                        <c:otherwise>
                                            Doanh nghiệp
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${p.cnQuanly} / ${p.user1Cn}</td>
                            </tr>
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

    <style>
        ._dropbtn {
            background-color: #4CAF50;
            color: red;
            padding: 16px;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }

        ._dropdown {
            position: relative;
            display: inline-block;
        }

        ._dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        ._dropdown-content a {
            color: green;

            text-decoration: none;
            display: block;
        }

        ._dropdown-content a:hover {background-color: yellow}

        ._dropdown:hover ._dropdown-content {
            display: block;
        }

        ._dropdown:hover ._dropbtn {
            background-color: #3e8e41;
        }
    </style>

    <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>   
</body>
</html>
