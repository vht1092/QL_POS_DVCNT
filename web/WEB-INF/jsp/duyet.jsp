<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="1800">
        <title>DUYỆT THÔNG TIN ĐVCNT</title>
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
                <li>Duyệt thông tin ĐVCNT</li>
            </ul>
            <center>
                <h2>DUYỆT HỒ SƠ ĐƠN VỊ CHẤP NHẬN THẺ
                    <a class="dangxuat" href="${pageContext.request.contextPath}/logout"> &nbsp; / &nbsp; ĐĂNG XUẤT</a>
                    <span class="tennguoidung">CN: ${macn} / ${hoten}</span>
                </h2>
            </center>
        </header>
    </center>

    <center>
        <div class="content" style="height: auto">
            <table style="width: 100%; height: auto">
                <tr>
                    <td colspan="4">
                        <c:choose>
                            <c:when test="${(groupuser == 5) && (fileUpload2 == null || fileUpload2 == '') && statusDvcnt != 8 && statusDvcnt != 3 && statusDvcnt != 4 && statusDvcnt != 5}">
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="45%">${uploadsuccess}</marquee>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${(groupuser == 5) && (fileUpload2 == null || fileUpload2 == '') && statusDvcnt != 8 && statusDvcnt == 3 && statusDvcnt != 4}">                        
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="38%">${uploadsuccess}</marquee>
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>                        
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${(groupuser == 5) && (fileUpload2 == null || fileUpload2 == '') && statusDvcnt != 8 && statusDvcnt == 4}">                       
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="38%">${uploadsuccess}</marquee>
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>                        
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${(groupuser == 5) && (fileUpload2 == null || fileUpload2 == '') && statusDvcnt != 8 && statusDvcnt == 5}">                        
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="45%">${uploadsuccess}</marquee>
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>                        
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${(groupuser == 3 || groupuser == 5) && statusDvcnt == 8}">                        
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="45%">${uploadsuccess}</marquee>
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>                        
                        </c:when>
                    </c:choose>
                </td>
                </tr>
                <tr>
                    <th colspan="4">THÔNG TIN ĐVCNT</th>
                </tr>
                <tr>
                    <td colspan="4">Tên đơn vị đăng ký kinh doanh: <b>${tenDvcntVn}</td>
                </tr>                    
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
                    <td colspan="4">Mã số thuế: <b>${masothue}</td>
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
                    <td colspan="2">
                        <!--
                        c:choose
                            <when test="_NgayUyquyen != 0">Ngày ủy quyền: {_NgayUyquyen}
                        c:choose>
                        -->
                        <b></b>
                    </td>
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
                    <td colspan="4">Quan hệ khách hàng: <b>${loaiKhachHang}</td>
                </tr>
                <tr>
                    <th colspan="4">KẾT QUẢ KHẢO SÁT</th>
                </tr>
                <tr>
                    <td colspan="4">Ngành nghề kinh doanh: <b>${nganhnghekd}</td>
                </tr>
                <tr>
                    <td colspan="4">Doanh số thanh toán thẻ dự kiến theo tháng: <b>${doanhsothanhtoandukien} VNĐ/máy</td>
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
                    <th colspan="4">
                        NHÂN VIÊN QUẢN LÝ ĐVCNT
                    </th>
                </tr>
                <tr>
                    <td colspan="2">
                        Direct: <b>${get_direct_employee}
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        InDirect: <b>${get_inDirect_employee}
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
                    <td>Thẻ JCB, JCB Class, JBC Grande, JCB Card</td>
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
                    <td>Thẻ DinerClub, Discover</td>
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
            </table>
            </br>
            <table class="thongtinlapdat">
                <tr>
                    <td class="path" colspan="13">
                        <c:choose>
                            <c:when test="${statusDvcnt == 0}">
                                Hồ sơ đính kèm: <span style="background-color: yellow"></span>
                                <a href="downloadfile.html?id=${path_themmoi}">Download file</a> | 
                                <a href="export.html?id=${_id}" onclick="checkUpload()" target="_blank">Xuất bảng mô tả ĐVCNT</a> | 
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDvcnt == 3}">
                                Hồ sơ đính kèm: <span style="background-color: yellow"></span>
                                <a href="downloadfile.html?id=${path_edit}">Download file</a> | 
                                <a href="export.html?id=${_id}" onclick="checkUpload()" target="_blank">Xuất bảng mô tả ĐVCNT</a> | 
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDvcnt == 8}">
                                Hồ sơ đính kèm: <span style="background-color: yellow"></span>
                                <a href="downloadfile.html?id=${path_lapthem}">Download file</a> | 
                                <a href="export.html?id=${_id}" onclick="checkUpload()" target="_blank">Xuất bảng mô tả ĐVCNT</a> | 
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDvcnt == 4}">
                                File scan Biên bản thu hồi MMTB: <span style="background-color: yellow"></span>
                                <a href="downloadfiletamkhoa.html?id=${path_khoaPos}">Download file</a>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDvcnt == 5}">
                                File scan y/c khóa ĐVCNT  : <span style="background-color: yellow"></span>
                                <a href="downloadfiletamkhoa.html?id=${path_tamkhoa}">Download file</a>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet  > 6}">
                                <a href="export2.html?id=${_id}" >Xem thông tin duyệt trên hệ thống</a>
                            </c:when>
                        </c:choose>
                        </br>

                        </br>
                        <c:choose>
                            <c:when test="${(groupuser == 3 && statusDvcnt == 0)}"> <!--THEM MOI DVCNT: User 1 Phong KHDN Upload file trinh lanh dao ky-->
                                <form method="post" action="${pageContext.request.contextPath}/_fileUpload.do" enctype="multipart/form-data">
                                    <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                                    <input type="submit" value="UPLOAD FILE" class="xformUpload" />
                                    <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                                    <marquee style="font-weight: bold; float: left; color: darkgreen; font-size: 12px" behavior="alternate" width="85%">${uploadsuccess}</marquee>
                                </form>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${(groupuser == 3 && (statusDvcnt == 4 || statusDvcnt == 5))}"> <!--KHOA/TAM KHOA: User 1 Phong KHDN Upload file trinh lanh dao ky-->
                                <form method="post" action="${pageContext.request.contextPath}/_fileUploadTamKhoa.do" enctype="multipart/form-data">
                                    <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                                    <input type="submit" value="UPLOAD FILE" class="xformUpload" />
                                    <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="45%">${uploadsuccess}</marquee>
                                    <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                                </form>
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <c:choose>
                        <c:when test="${statusDvcnt == 5}">
                            <th colspan="13">POS YÊU CẦU TẠM KHÓA</th>
                            </c:when>
                        </c:choose>
                </tr>
                <c:choose>
                    <c:when test="${statusDvcnt == 5}">
                        <tr style="border: 1px solid; border-collapse: collapse">
                            <th>Tên in trên hóa đơn: </th> 
                            <th>Địa chỉ lắp đặt: </th>
                            <th>Số TK TGTT báo có: </th>
                            <th>Tên chủ TK</th>                    
                            <th>Loại máy</th>                   
                            <th>Seri</th>                   
                            <th>Thông số</th>                   
                            <th></th>                   
                        </tr>
                    </c:when>
                </c:choose>

                <c:forEach items="${lstPOSDangXuLyTamKhoa}" var="p">
                    <c:choose>
                        <c:when test="${p.tinhtrang == 2}">
                            <tr style="border: 1px solid; color: red; border-collapse: collapse">
                                <td style="border: 1px solid; border-collapse: collapse">${p.teninhoadon}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.diachiLapdat}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.soTktgtt}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.tenchutk}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.dongmay}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.soseri}</td>    
                                <td style="border: 1px solid; border-collapse: collapse;">
                                    <c:choose>
                                        <c:when test="${p.tid1 != null  && p.mid1 != null}"> <!---->
                                            <p> &nbsp; </p>
                                            <p>TID1: ${p.tid1}</p>
                                            <p> &nbsp; </p>
                                            <p>MID1: ${p.mid1}</p>

                                            <c:choose>
                                                <c:when test="${p.tid2 != null}">
                                                    <p> &nbsp; </p>
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
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>
                <tr>
                    <c:choose>
                        <c:when test="${statusDvcnt == 4}">
                            <th colspan="13">POS YÊU CẦU THU HỒI</th>
                            </c:when>
                        </c:choose>
                </tr>
                <c:choose>
                    <c:when test="${statusDvcnt == 4}">
                        <tr style="border: 1px solid; border-collapse: collapse">
                            <th>Tên in trên hóa đơn: </th> 
                            <th>Địa chỉ lắp đặt: </th>
                            <th>Số TK TGTT báo có: </th>
                            <th>Tên chủ TK</th>                    
                            <th>Loại máy</th>                   
                            <th>Seri</th>                   
                            <th>Thông số</th>                   
                            <th>Nơi lưu POS</th>                   
                        </tr>
                    </c:when>
                </c:choose>

                <c:forEach items="${lstPOSDangXuLyKhoa}" var="p">
                    <c:choose>
                        <c:when test="${p.tinhtrang == 1}">
                            <tr style="border: 1px solid; color: red; border-collapse: collapse">
                                <td style="border: 1px solid; border-collapse: collapse">${p.teninhoadon}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.diachiLapdat}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.soTktgtt}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.tenchutk}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.dongmay}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.soseri}</td>    
                                <td style="border: 1px solid; border-collapse: collapse; font-size: 5px">
                                    <c:choose>
                                        <c:when test="${p.tid1 != null  && p.mid2 != null}"> <!---->
                                            <p> &nbsp; </p>
                                            <p>TID1: ${p.tid1}</p>
                                            <p> &nbsp; </p>
                                            <p>MID1: ${p.mid1}</p>

                                            <c:choose>
                                                <c:when test="${p.tid2 != null}">
                                                    <p> &nbsp; </p>
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
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td><c:choose>
                                        <c:when test="${p.noiLuuPos != 'HO'}">DON VI ${p.noiLuuPos}</c:when>
                                    </c:choose></td>
                            </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>
                <tr>
                    <c:choose>
                        <c:when test="${statusDvcnt == 2}">
                            <th colspan="13">THÔNG TIN POS</th>
                            </c:when>
                            <c:when test="${statusDvcnt == 3}">
                            <th colspan="13">"THÔNG TIN" POS YÊU CẦU CHỈNH SỬA THÔNG TIN</th>
                            </c:when>
                            <c:otherwise>
                            <th colspan="13">THÔNG TIN LẮP ĐẶT POS</th>
                            </c:otherwise>
                        </c:choose>
                </tr>

                <tr style="border: 1px solid; border-collapse: collapse">
                    <th>Tên in trên hóa đơn: </th> 
                    <th>Địa chỉ lắp đặt: </th>
                    <th>Số TK TGTT báo có: </th>
                    <th>Tên chủ TK</th>                    
                    <th>Loại máy</th>                   
                    <th>Seri</th>                   
                    <th>Thông số</th>                   
                    <th>Chi tiết</th>                   
                </tr>
                <c:forEach items="${lst}" var="p">
                    <c:choose>
                        <c:when test="${p.ismapping == 1 
                                        || p.ismapping == 6 
                                        || p.ismapping == 0 
                                        || p.ismapping == '' 
                                        || p.ismapping == null 
                                        || (p.ismapping == 2 && statusDvcnt == 0) 
                                        && p.soseri != null}">
                                <tr style="border: 1px solid; border-collapse: collapse">
                                    <td style="border: 1px solid; border-collapse: collapse">${p.teninhoadon}</td>
                                    <td style="border: 1px solid; border-collapse: collapse">${p.diachiLapdat}</td>
                                    <td style="border: 1px solid; border-collapse: collapse">${p.soTktgtt}</td>
                                    <td style="border: 1px solid; border-collapse: collapse">${p.tenchutk}</td>
                                    <td style="border: 1px solid; border-collapse: collapse">${p.dongmay}</td>
                                    <td style="border: 1px solid; border-collapse: collapse">${p.soseri}</td>    
                                    <td style="border: 1px solid; border-collapse: collapse;">
                                        <c:choose>
                                            <c:when test="${p.tid1 != null  && p.mid1 != null}"> <!---->
                                                <p> &nbsp; </p>
                                                <p>TID1: ${p.tid1}</p>
                                                <p> &nbsp; </p>
                                                <p>MID1: ${p.mid1}</p>

                                                <c:choose>
                                                    <c:when test="${p.tid2 != null}">
                                                        <p> &nbsp; </p>
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
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="border: 1px solid; border-collapse: collapse"><a href="chitietposthemmoi.html?id=${p.stt}" class="detail">Chi tiết</a></td>
                                </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>
                <c:forEach items="${lstKhongCanTNTDuyet}" var="p">
                    <c:choose>
                        <c:when test="${p.ismapping == 5  && p.soseri != null}">
                            <tr style="border: 1px solid; border-collapse: collapse">
                                <td style="border: 1px solid; border-collapse: collapse">${p.teninhoadon}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.diachiLapdat}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.soTktgtt}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.tenchutk}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.dongmay}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.soseri}</td>   
                                <td style="border: 1px solid; border-collapse: collapse;">
                                    <p> &nbsp; </p>
                                    <p>TID1: ${p.tid1}</p>
                                    <p> &nbsp; </p>
                                    <p>MID1: ${p.mid1}</p>

                                    <c:choose>
                                        <c:when test="${p.tid2 != null}">
                                            <p> &nbsp; </p>
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
                                            <p>TID3: </p>
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
                            </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>
                <c:forEach items="${lstCanTNTDuyet}" var="p">
                    <c:choose>
                        <c:when test="${p.ismapping == 1 || p.ismapping == 3 || p.ismapping == 4}">
                            <tr style="border: 1px solid; border-collapse: collapse">
                                <td style="border: 1px solid; border-collapse: collapse">${p.teninhoadon}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.diachiLapdat}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.soTktgtt}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.tenchutk}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.dongmay}</td>
                                <td style="border: 1px solid; border-collapse: collapse">${p.soseri}</td>  
                                <td style="border: 1px solid; border-collapse: collapse">
                                    <p> &nbsp; </p>
                                    <p>TID1: ${p.tid1}</p>
                                    <p> &nbsp; </p>
                                    <p>MID1: ${p.mid1}</p>

                                    <c:choose>
                                        <c:when test="${p.tid2 != null}">
                                            <p> &nbsp; </p>
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
                                            <p>TID3: </p>
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
                                <td>
                                    <c:choose>
                                        <c:when test="${p.ismapping == 4}">
                                    <center><a href="chitietposthemmoi.html?id=${p.stt}"  class="detail">Chi tiết</a></center>
                                    </c:when>
                                </c:choose>
                            </td>
                            </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when  test="${statusDvcnt == 8}">
                        <tr style="background-color: #FDF6BF">
                            <td colspan="13"><center><b>THÔNG TIN POS YÊU CẦU LẮP THÊM<b/></center></td>
                        </tr>
                    </c:when>
                </c:choose>
                <c:forEach items="${lst}" var="p">
                    <c:choose>
                        <c:when test="${p.ismapping == 3 && p.soseri != null}">
                            <!--                            <tr>
                                                            <td colspan="13"><center><b>POS LẮP THÊM<b/></center></td>
                                                        </tr>-->
                            <tr>
                                <td>${p.teninhoadon}</td>
                                <td>${p.diachiLapdat}</td>
                                <td>${p.soTktgtt}</td>
                                <td>${p.tenchutk}</td>
                                <td>${p.dongmay}</td>
                                <td>${p.soseri}</td>    
                                <td style="border: 1px solid; border-collapse: collapse">
                                    <p> &nbsp; </p>
                                    <p>TID1: ${p.tid1}</p>
                                    <p> &nbsp; </p>
                                    <p>MID1: ${p.mid1}</p>

                                    <c:choose>
                                        <c:when test="${p.tid2 != null}">
                                            <p> &nbsp; </p>
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
                                <td>
                                    <c:choose>
                                        <c:when test="${p.ismapping == 3}">
                                    <center><a href="chitietposthemmoi.html?id=${p.stt}"  class="detail">Chi tiết</a></center>
                                    </c:when>
                                </c:choose>
                            </td>
                            </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>                


                <c:forEach items="${lst}" var="p">
                    <c:choose>
                        <c:when test="${p.ismapping == 2 && statusDvcnt == 8}">
                            <tr style="background-color: #FDF6BF">
                                <td>${p.teninhoadon}</td>
                                <td>${p.diachiLapdat}</td>
                                <td>${p.soTktgtt}</td>
                                <td>${p.tenchutk}</td>
                                <td>${p.dongmay}</td>
                                <td>${p.soseri}</td>    
                                <td style="border: 1px solid; border-collapse: collapse">
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.ismapping == 2}">
                                    <center><a href="chitietposthemmoi.html?id=${p.stt}"  class="detail">Chi tiết</a></center>
                                    </c:when>
                                </c:choose>
                            </td>
                            </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </table>
            <c:choose>
                <c:when test="${(groupuser == 5) && (fileUpload2 == null || fileUpload2 == '') && statusDvcnt != 8 && statusDvcnt != 3 && statusDvcnt != 4 && statusDvcnt != 5}">
                    <span><b>Upload file scan(pdf):</b></span>
                    <p> &nbsp; </p>
                    <form method="post" action="${pageContext.request.contextPath}/_fileUpload.do" enctype="multipart/form-data">
                        <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                        <input type="submit" value="UPLOAD FILE" class="xformUpload" />
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="45%">${uploadsuccess}</marquee>
                    </form>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${(groupuser == 5) && (fileUpload2 == null || fileUpload2 == '') && statusDvcnt != 8 && statusDvcnt == 3 && statusDvcnt != 4}">
                    <span><b>Upload giấy đề nghị chỉnh sửa(pdf):</b></span>
                    <p> &nbsp; </p>
                    <form method="post" action="${pageContext.request.contextPath}/_fileUploadEdit2.do" enctype="multipart/form-data">
                        <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                        <input type="submit" value="UPLOAD FILE" class="xformUpload" />
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="38%">${uploadsuccess}</marquee>
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                    </form>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${(groupuser == 5) && (fileUpload2 == null || fileUpload2 == '') && statusDvcnt != 8 && statusDvcnt == 4}">
                    <span><b>Upload biên bản thu hồi(pdf):</b></span>
                    <p> &nbsp; </p>
                    <form method="post" action="${pageContext.request.contextPath}/_fileUploadKhoa.do" enctype="multipart/form-data">
                        <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                        <input type="submit" value="UPLOAD FILE" class="xformUpload" />
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="38%">${uploadsuccess}</marquee>
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                    </form>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${(groupuser == 5) && (fileUpload2 == null || fileUpload2 == '') && statusDvcnt != 8 && statusDvcnt == 5}">
                    <span><b>Upload biên bản tạm khóa(pdf):</b></span>
                    <p> &nbsp; </p>
                    <form method="post" action="${pageContext.request.contextPath}/_fileUploadTamKhoa.do" enctype="multipart/form-data">
                        <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                        <input type="submit" value="UPLOAD FILE" class="xformUpload" />
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="45%">${uploadsuccess}</marquee>
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                    </form>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${(groupuser == 3 || groupuser == 5) && statusDvcnt == 8}">
                    <span><b>Upload file scan(yêu cầu lắp thêm POS)</b></span>
                    <p> &nbsp; </p>
                    <form method="post" action="${pageContext.request.contextPath}/_fileUploadLapThemPos.do" enctype="multipart/form-data">
                        <input type="file" required  name="fileUploaded" class="xformUpload"/>  
                        <input type="submit" value="UPLOAD FILE" class="xformUpload" />
                        <marquee style="font-weight: bold; float: left; color: darkgreen" behavior="alternate" width="45%">${uploadsuccess}</marquee>
                        <marquee style="font-weight: bold; float: left; color: red" behavior="alternate" width="38%">${error}</marquee>
                    </form>
                </c:when>
            </c:choose>

            <form action="${pageContext.request.contextPath}/xulyduyet" method="get" id="duyet">
                <table class="thongtinduyet">
                    <tr class="tr1">
                        <td colspan="2"><center>XỬ LÝ</center></td></br>
                    </tr>
                    <tr class="tr2">
                        <td>
                    <center><textarea id="text1" onkeypress="return blockSpecialChar(event)" maxlength="250" onblur="caps(this.id)" placeholder="Nhập ghi chú phản hồi(nếu có). Lưu ý: Nhập tiếng Việt không dấu, tối đa 250 ký tự." rows="8" cols="100" name="ghichu" form="duyet" style=""></textarea></center>
                    </td> 
                    <td>
                        <c:choose>
                            <c:when test="${statusDvcnt == 3 && groupuser == 7}">
                                <a href="exporteditinformation.html?id=${_maDvcnt}" target="_blank" class="pass" href="#">Xuất PYC</a>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${groupuser != 7}">
                                <input name="pass" type="submit" class="pass" href="#" value="DUYỆT THUẬN"/>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet == 10 || statusDuyet == 11}">
                                <input name="pass" type="submit" class="pass" href="#" value="DUYỆT THUẬN"/>
                            </c:when>
                        </c:choose>                       
                        <c:choose>
                            <c:when test="${groupuser == 7 && (statusDuyet == 7 || statusDuyet == 8)}">
                                <input name="pass" type="submit" class="pass" href="#" value="DUYỆT(GỬI PYC VTB)."/>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${statusDuyet <= 8 || statusDuyet == 12 || statusDuyet == 15 || statusDuyet == 16}">
                                <input name="fail" type="submit" class="fail" href="#" value="TỪ CHỐI"/>
                            </c:when>
                        </c:choose>
                    </td>                                
                    </tr>
                </table>
            </form>
        </div>
    </center>
</form>

<footer>
    <center>

        <h4><a href="index.html"><i class="fa fa-home"></i>Trở về trang chủ</a></h5>
            <span>-------------------------------------------------</span>
            <h5>&copy; 2019 - Bản quyền P.KT&VHT&NHS - Ngân Hàng TMCP Sài Gòn(SCB)</h5>
    </center>
</footer>
<script>

    function caps(id) {
        document.getElementById(id).value = document.getElementById(id).value.toUpperCase();
    }
</script>
<script src="<%=request.getContextPath()%>/resources/js/dangkydvcnt.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/exceptionRules.js"></script>
</body>
</html>
