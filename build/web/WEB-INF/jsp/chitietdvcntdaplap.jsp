<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>ĐVCNT ĐÃ LẮP POS</title>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/themmoi.css"/>
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
                <li>Thông tin ĐVCNT</li>
            </ul>
            <center>
                <h2>THÔNG TIN ĐƠN VỊ CHẤP NHẬN THẺ
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> / ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>

    <center>
        <div class="content" style="height: auto">
            <table style="width: 100%; height: auto">
                <tr>
                    <th colspan="4">THÔNG TIN ĐVCNT</th>
                </tr>

                <tr>
                    <td colspan="4">Tên đơn vị đăng ký kinh doanh: <b>${tenDvcntVn}</td>
                </tr>  
                <c:choose>
                    <c:when test="${checkUploadBBBG != ''}">
                        <marquee style="font-weight: bold; float: left; color: red;" behavior="alternate" width="38%">${checkUploadBBBG}</marquee>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${uploadsuccess != ''}">
                        <marquee  style="font-weight: bold; float: left; color: darkgreen; width: 50%" behavior="alternate" width="58%">${uploadsuccess}</marquee>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${uploadfail != ''}">
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${uploadfail}</marquee>
                        </c:when>
                    </c:choose>
                <tr>
                    <td colspan="4">Tên tiếng Anh: <b>${tenDvcntEn}</b></td>
                </tr>                    
                <tr>
                    <td colspan="4">Địa chỉ: <b>${diachiDvcnt}</td>
                </tr>
                <tr>
                    <td colspan="4">Điện thoại: <b>${sdtDvcnt}</td>
                </tr>
                <tr>
                    <td colspan="1">GPĐKKD số: <b>${gpdkkdso}</td>
                    <td colspan="1">Ngày cấp: <b>${_GpdkkdNgaycap}</td>
                    <td colspan="2">Nơi cấp: <b>${gpdkkdNoicap}</td>
                </tr>
                <tr>
                    <td>Người đại diện theo pháp luật trên GPĐKKD: <b>${gpdkkdTennguoidaidien}</td>
                </tr>
                <tr>
                    <td colspan="4">Chức vụ: <b>${gpdkkdChucvu}</td>
                </tr>
                <tr>
                    <td colspan="1">CMT/CCCD/Hộ chiếu: <b>${gpdkkdCmnd}</td>
                    <td colspan="1">Ngày cấp: <b>${_GpdkkdNgaycapCmnd}</td>
                    <td colspan="2">Nơi cấp: <b>${gpdkkdNoicapCmnd}</td>
                </tr>
                <tr>
                    <td colspan="4">Mã số thuế: <b>${masothue}</td>
                </tr>
                <tr>
                    <td colspan="4">Người đại diện ký kết hợp đồng ĐVCNT: <b>${tennguoiKyhopdong}</td>
                </tr>
                <tr>
                    <td colspan="4">Chức vụ: <b>${chucvuHopdong}</td>
                </tr>
                <tr>
                    <td colspan="1">CMT/CCCD/Hộ chiếu: <b>${cmndHopdong}</td>
                    <td colspan="1">Ngày cấp: <b>${_NgaycapCmndHopdong}</td>
                    <td colspan="2">Nơi cấp: <b>${noicapCmndHopdong}</td>
                </tr>
                <tr>
                    <td colspan="2">Theo ủy quyền số (nếu có): <b>${soUyquyen}</td>
                    <td colspan="2">Ngày ủy quyền: <b>${_NgayUyquyen}</td>
                </tr>
                <tr>
                    <td colspan="4">Đang hợp tác với ngân hàng khác: <b>${nganhangHoptac}</td>
                </tr>
                <tr>
                    <td colspan="4">Loại hình ĐVCNT: 
                        <c:choose>
                            <c:when test="${loaihinhDvcnt == 1}">
                                <b>Hộ kinh doanh</b>
                            </c:when>
                            <c:otherwise>
                                <b>Tổ chức</b>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th colspan="4">KẾT QUẢ KHẢO SÁT</th>
                </tr>
                <tr>
                    <td colspan="4">Ngành nghề kinh doanh: <b>${nganhnghekd}</td>
                </tr>
                <tr>
                    <td colspan="4">Doanh số thanh toán thẻ dự kiến theo tháng: <b>${doanhsothanhtoandukien}</td>
                </tr>
                <tr>
                    <td colspan="4">Xếp loại theo kết quả khảo sát: <b>${xeploai}</td>
                </tr>
                <tr>
                    <td colspan="4">Lần đăng ký lắp POS: <b>${landk}</td>
                </tr>
                <tr>
                    <td colspan="4">Loại tiền thanh toán: <b>${loaitien}</td>
                </tr>
                <tr>
                    <td colspan="3" style="padding-top: 2%"><h3 style="float: left; text-decoration: underline">NHÂN VIÊN QUẢN LÝ ĐVCNT:</h3></td>
                </tr>
                <tr>
                    <td colspan="3" class="text">
                        Direct: <b>${get_direct_employee}</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="text">
                        InDirect: <b>${get_inDirect_employee}</b>
                    </td>
                </tr>                
                <tr>
                    <th colspan="4">
                        LOẠI THẺ CHẤP NHẬN THANH TOÁN & PHÍ CHIẾT KHẤU <i>(Đơn vị: % - Đã bao gồm VAT)</i>
                    </th>
                </tr>
            </table>
            <table id="table-loaithe">
                <tr>
                    <th>Loại thẻ</th>
                    <th>Chấp nhận</th>
                    <th>Mức phí(gồm VAT)</th>
                </tr>
                <tr>
                    <td>Thẻ ghi nợ nội địa SCB</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiGhinoscb != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiGhinoscb != ''}">
                        <center>${phiGhinoscb}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ ghi nợ nội địa liên minh</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiGhinoLienminh != ''}">
                        <center>X</center>
                        </c:when>
                        <c:otherwise></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiGhinoLienminh != ''}">
                        <center>${phiGhinoLienminh}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ MC/VS phát hành trong nước</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiVisa != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiVisa != ''}">
                        <center>${phiVisa}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ MC/VS phát hành nước ngoài</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiMastercard != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiMastercard != ''}">
                        <center>${phiMastercard}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ JCB, JCB Class, JBC Grande, JBC Card</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiJcb != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiJcb != ''}">
                        <center>${phiJcb}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ CUP</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiCup != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiCup != ''}">
                        <center>${phiCup}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ DinnerClub, Discover</td>
                    <td>
                        <c:choose>
                            <c:when test="${phiDiscover != ''}">
                        <center>X</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiDiscover != ''}">
                        <center>${phiDiscover}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <td>Thẻ khác</td>
                    <td>
                        <c:choose>
                            <c:when test="${tenThekhac != ''}">
                        <center>${tenThekhac}</center>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${phiThekhac != ''}">
                        <center>${phiThekhac}</center>
                        </c:when>
                    </c:choose>
                </td>
                </tr>
            </table></br>
            <table class="thongtinlapdat">
                <c:choose>
                    <c:when test="${tinhTrangDvcnt == 9}">
                        <tr>
                            <td colspan="12">
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="55%">${uploadsuccess}</marquee>
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${uploadfail}</marquee>
                        </td>
                        </tr>
                        <tr>
                            <th colspan="12">THÔNG TIN POS LẮP THÊM MỚI</th></br>
                        </tr>
                        <tr>
                            <th>Tên in trên hóa đơn: </th> 
                            <th>Địa chỉ lắp đặt: </th>
                            <th>Tên chủ TK</th>                    
                            <th>Loại máy</th>                   
                            <th>Seri</th>   
                            <th></th>
                        </tr>
                        <c:forEach items="${lst}" var="p">
                            <c:choose>
                                <c:when test="${p.ismapping == 3 && statusDvcnt != 5}">
                                    <tr>
                                        <td>${p.teninhoadon}</td>
                                        <td>${p.diachiLapdat}</td>
                                        <td>${p.tenchutk}</td>
                                        <td>${p.dongmay}</td>
                                        <td>${p.soseri}</td>    
                                        <td style=" border-collapse: collapse; width: 350px">
                                            <c:choose>
                                                <c:when test="${groupuser == 1 && statusDvcnt == 0 || statusDvcnt == 9}">
                                                    <form method="post" action="${pageContext.request.contextPath}/fileUploadBienBanBanGiaoPOSLapThem.do" enctype="multipart/form-data">
                                                        <input type="file" required  name="fileUploaded" class="xformUpload" style="width: 200px; float: left"/> 
                                                        <input type="submit" value="UPLOAD" class="xformUpload"/>
                                                    </form>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>

                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>

                    </c:when>
                    <c:when test="${tinhTrangDvcnt == 4}">
                        <tr><!-- THONG TIN POS DANG XU TAM KHOA -->
                            <td colspan="12">
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="55%">${uploadsuccess}</uploadsuccess>
                            <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${uploadfail}</uploadsuccess>
                                </td>
                                </tr>
                                <tr>
                                    <th colspan="12">THÔNG TIN POS KHÓA</th></br>
                                </tr>
                                <tr>
                                    <th>Tên in trên hóa đơn: </th> 
                                    <th>Địa chỉ lắp đặt: </th>
                                    <th>Tên chủ TK</th>                    
                                    <th>Loại máy</th>                   
                                    <th>Seri</th>   
                                    <th></th>
                                </tr>
                                <c:forEach items="${lstPOSDangXuLyKhoa}" var="p">
                                    <c:choose>
                                        <c:when test="${p.tinhtrang == 1}">
                                            <tr>
                                                <td>${p.teninhoadon}</td>
                                                <td>${p.diachiLapdat}</td>
                                                <td>${p.tenchutk}</td>
                                                <td>${p.dongmay}</td>
                                                <td>${p.soseri}</td>    
                                                <td style=" border-collapse: collapse; width: 350px; color: red; text-align: center">
                                                    YÊU CẦU KHÓA
                                                </td>
                                            </tr>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>

                            </c:when>
                            <c:when test="${tinhTrangDvcnt == 5}">
                                <tr><!-- THONG TIN POS DANG XU LY TAM KHOA -->
                                    <td colspan="12">
                                <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="55%">${uploadsuccess}</marquee>
                                <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${uploadfail}</marquee>
                                </td>
                                </tr>
                                <tr>
                                    <th colspan="12">THÔNG TIN POS TẠM KHÓA</th></br>
                                </tr>
                                <tr>
                                    <th>Tên in trên hóa đơn: </th> 
                                    <th>Địa chỉ lắp đặt: </th>
                                    <th>Tên chủ TK</th>                    
                                    <th>Loại máy</th>                   
                                    <th>Seri</th>   
                                    <th></th>
                                </tr>
                                <c:forEach items="${lstPOSDangXuLyTamKhoa}" var="p">
                                    <c:choose>
                                        <c:when test="${p.tinhtrang == 2 && statusDvcnt == 5}">
                                            <tr>
                                                <td>${p.teninhoadon}</td>
                                                <td>${p.diachiLapdat}</td>
                                                <td>${p.tenchutk}</td>
                                                <td>${p.dongmay}</td>
                                                <td>${p.soseri}</td>    
                                                <td style=" border-collapse: collapse; width: 350px; color: red; text-align: center">
                                                    TẠM KHÓA
                                                </td>
                                            </tr>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>

                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="12">
                                <center>
                                    <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${uploadfail}</marquee>
                                    <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                                    <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="55%">${uploadsuccess}</marquee>
                                </center>

                                </td>
                                </tr>
                                <tr>
                                    <td colspan="12">
                                        <c:choose>
                                            <c:when test="${statusDvcnt == 5}">
                                                File scan Biên bản thu hồi tạm khóa POS: <span></span>
                                                <a href="downloadfiletamkhoa.html?id=${FileuploadTamKhoa}">Download file</a></br></br>
                                            </c:when>
                                            <c:when test="${statusDvcnt == 4}">
                                                File scan Biên bản thu hồi khóa POS: <span></span>
                                                <a href="downloadfilekhoa.html?id=${FileuploadKhoa}">Download file</a></br></br>
                                            </c:when>
                                        </c:choose>
                                        File thông số nhận từ VTB: <span></span>
                                        <a href="downloadfilemapping.html?id=${fileMapping}">Download file</a></br></br>
                                    </td>                                
                                </tr>
                                <tr style="border: 1px solid; border-collapse: collapse; ">
                                    <th colspan="12" style="border: 1px solid; border-collapse: collapse">THÔNG TIN LẮP ĐẶT POS</th></br>
                                </tr>
                                <tr>
                                    <th style="border: 1px solid; border-collapse: collapse">Tên in trên hóa đơn: </th> 
                                    <th style="border: 1px solid; border-collapse: collapse">Địa chỉ lắp đặt: </th>
                                    <th style="border: 1px solid; border-collapse: collapse">Loại máy</th>                   
                                    <th style="border: 1px solid; border-collapse: collapse">Seri</th>                   
                                    <th style="border: 1px solid; border-collapse: collapse">Thông số</th>                   
                                    <th style="border: 1px solid; border-collapse: collapse">
                                        <c:choose>
                                            <c:when test="${statusDvcnt != 1}">
                                                Upload
                                            </c:when>
                                        </c:choose>
                                    </th>                   
                                </tr>
                                <c:forEach items="${lst}" var="p">
                                    <tr>
                                        <c:choose>
                                            <c:when test="${p.soseri != null && statusDvcnt != 5}">
                                                <td style="border: 1px solid; border-collapse: collapse">${p.teninhoadon}</td>
                                                <td style="border: 1px solid; border-collapse: collapse">${p.diachiLapdat}</td>
                                                <td style="border: 1px solid; border-collapse: collapse">${p.dongmay}</td>
                                                <td style="border: 1px solid; border-collapse: collapse">${p.soseri}</td>    
                                                <td style="border: 1px solid; border-collapse: collapse">
                                                    <p> &nbsp; </p>
                                                    <p>TID1: ${p.tid1}</p>
                                                    <p> &nbsp; </p>
                                                    <p>MID1: ${p.mid1}</p>
                                                    <p> &nbsp; </p>
                                                    <c:choose>
                                                        <c:when test="${p.tid2 != null}">
                                                            <p>TID2: ${p.tid2}</p>
                                                            <p> &nbsp; </p>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.mid2 != null}">
                                                            <p>MID2: ${p.mid2}</p>
                                                            <p> &nbsp; </p>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.tid3 != null}">
                                                            <p>TID3: ${p.tid3}</p>
                                                            <p> &nbsp; </p>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${p.mid3 != null}">
                                                            <p>MID3: ${p.mid3}</p>
                                                            <p> &nbsp; </p>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                            </c:when>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${groupuser == 1 && statusDvcnt == 0}">
                                                <td style="border: 1px solid; border-collapse: collapse;width: 350px">
                                            <center>
                                                <form method="post" action="${pageContext.request.contextPath}/fileUploadBienBanBanGiaoPOS.do" enctype="multipart/form-data">
                                                    <input type="file" required  name="fileUploaded" class="xformUpload" style="float:left; width: 250px;"/>  
                                                    <input type="submit" value="UPLOAD" class="xformUpload" style="float: left; height: 22px" />
                                                </form>
                                            </center>
                                            </td>
                                        </c:when>
                                    </c:choose>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                        </table>
                        </div>
                        <center>
                            </br>
                            </br>
                            <c:choose>
                                <c:when test="${groupuser == 1 && (statusDvcnt == 4 || statusDvcnt == 5)}">
                                    <div style="width: 50%;">
                                        <p style="float: left"><b>Upload biên bản thu hồi POS:</b></p>
                                        <form method="post" action="${pageContext.request.contextPath}/fileUploadBBTHTamKhoa.do" enctype="multipart/form-data">
                                            <input type="file" required  name="fileUploaded" class="xformUpload" style="float: left;"/> &nbsp; &nbsp;
                                            <input type="submit" value="UPLOAD" class="xformUpload" style="float: left; height: 22px; margin-left: 5px"/>
                                        </form>
                                    </div>
                                </c:when>
                            </c:choose>
                            </br>
                        </center>
                        <c:choose>
                            <c:when test="${groupuser == 1 && statusDuyet == 13 && (statusDvcnt == 0 || statusDvcnt == 9)}">
                                </br>        
                                <div class="_xacNhanBanGiao">
                                    <a href="xacnhanbangiao.html" class="xacNhanBanGiao">XÁC NHẬN ĐÃ LẮP ĐẶT CHO ĐVCNT</a>
                                </div>
                                </br>
                            </c:when>

                            <c:when test="${groupuser == 1 && statusDuyet == 13 && (statusDvcnt == 4 || statusDvcnt == 5)}">
                                </br>        
                                <div class="_xacNhanBanGiao">
                                    <a href="xacnhanthuhoipos.html" class="xacNhanBanGiao">XÁC NHẬN ĐÃ THU HỒI POS</a>
                                </div>
                                </br>
                            </c:when>
                            <c:when test="${groupuser == 1 && statusDuyet == 13 && (statusDvcnt == 2)}">
                                </br>        
                                <div class="_xacNhanBanGiao">
                                    <a href="hoantat_editpos.html" class="xacNhanBanGiao">HOÀN TẤT CHỈNH SỬA POS</a>
                                </div>
                                </br>
                            </c:when>
                        </c:choose>
                        </center>
                        </form>
                        </br>
                        <footer>
                            <center>

                                <h4><a href="index.html"><i class="fa fa-home"></i>Trở về trang chủ</a></h5>
                                    <span>-------------------------------------------------</span>
                                    <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
                            </center>
                        </footer>

                        <script src="<%=request.getContextPath()%>/resources/js/dangkydvcnt.js"></script>
                        <script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
                        </body>
                        </html>
