<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EXPORT PYC EDIT ĐVCNT</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/export.css"/>
        <link rel="SHORTCUT ICON" href="<%=request.getContextPath()%>/resources/img/logo/favicon.ico">
        <style>
            p{
                margin-bottom: 5px;
            }
        </style>
    </head>
    <body>
        <a id="export" target="_blank" class="btnPrint">Export to Word</a>
        <div id="docx">
            <div class="WordSection1">
                <center>
                    <table style="width: 90%; height: 100px; margin: 0; border: 1px solid; border-collapse: collapse">
                        <tr style="border: 1px solid; border-collapse: collapse">
                            <td style="border: 1px solid; border-collapse: collapse; width: 30%">
                                <p><center><b><h3>NGÂN HÀNG TMCP SÀI GÒN</h3></b></center></p>
                        <p><center><b><h4>(SAIGON COMMERCIAL BANK)</h4></b></center></p>
                        </td>
                        <td style="border: 1px solid; border-collapse: collapse; width: 40%"><h2><center>BIÊN BẢN GIAO NHẬN/THU HỒI/ THU ĐỔI MÁY MÓC THIẾT BỊ</center></h2></td>
                        <td style="border: 1px solid; border-collapse: collapse; width: 30%">
                            <p><center>KMH: <b>BM 05/QT-KDNHS-02</b></center></p>
                        <p><center>Ngày:  ...../${thang}/${nam}</center></p>
                        </td>
                        </tr>

                    </table>
                    <table style="width: 90%; height: 100px; margin: 0; font-size: 18px">
                        <tr>
                            <td colspan="3">
                                <p> &nbsp; </p>
                                <p>Hôm nay, ngày..... tháng ${thang} năm ${nam} tại Tp. Hồ Chí Minh, chúng tôi gồm: </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p><h3>Bên A: NGÂN HÀNG TMCP SÀI GÒN (SCB) – ${tencn}</h3></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p>Địa chỉ: 927 Trần Hưng Đạo, P.1, Q.5, TP. HCM</p>
                            </td>
                            <td></td>
                            <td>Điện thoại: (08) 3920 6540</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>Đại diện:.......................................................................................Chức vụ:.....................................</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p><h3>Bên B: ${tenDvcnt}</h3></p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>Địa chỉ: ${diaChiDvcnt}</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>Điện thoại: ${sdtDvcnt}</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p>Đại diện : ${tennguoidaidien}</p>
                            </td>
                            <td colspan="2">
                                <p>Chức vụ: ${chucVu}</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>Bên A tiến hành bàn giao đầy đủ các máy móc thiết bị (MMTB) theo đặc điểm và danh sách dưới đây:</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p><input type="checkbox" checked="checked" style="width:20px;height:20px;"/> Bàn giao / Thu hồi</p>
                            </td>
                        </tr>
                    </table>
                    <table  style="width: 80%; height: auto; margin: 0; border: 1px solid; border-collapse: collapse; font-size: 14px">
                        <tr style="border: 1px solid; border-collapse: collapse;">
                            <th style="border: 1px solid; border-collapse: collapse;">STT</th>
                            <th style="border: 1px solid; border-collapse: collapse;">Tên thiết bị</th>
                            <th style="border: 1px solid; border-collapse: collapse;">Số serial</th>
                            <th style="border: 1px solid; border-collapse: collapse;">Terminal ID</th>
                            <th style="border: 1px solid; border-collapse: collapse;">Địa điểm lắp đặt</th>
                            <th style="border: 1px solid; border-collapse: collapse;">Thu hồi</th>
                            <th style="border: 1px solid; border-collapse: collapse;">Cấp mới</th>
                        </tr>
                        <%
                            int index = 1;
                        %>
                        <c:forEach items="${lst}" var="p">
                            <c:choose>
                                <c:when test="${p.tinhtrang == 1}">
                                    <tr style="border: 1px solid; border-collapse: collapse;">
                                        <td style="border: 1px solid; border-collapse: collapse;"><center><%out.println(String.format("%d", index));
                                            index++;%></center></td>
                                    <td style="border: 1px solid; border-collapse: collapse;"><center>${p.dongmay}</center></td>
                                    <td style="border: 1px solid; border-collapse: collapse;"><center>${p.soseri}</center></td>
                                    <td style="border: 1px solid; border-collapse: collapse;"><center></center></td>
                                    <td style="border: 1px solid; border-collapse: collapse;">${p.diachiLapdat}</td>
                                    <td style="border: 1px solid; border-collapse: collapse;"><center>x</center></td>
                                    <td style="border: 1px solid; border-collapse: collapse;"><center></center></td>
                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </table>
                    <table style="width: 80%; height: auto; margin: 5px; font-size: 18px">
                        <tr style="border: 0;">
                            <td colspan="7" style="border: 0;">
                                <p>Thiết bị kèm theo:........... bộ chuyển điện, ...........dây nguồn, ...........SIM điện thoại</p>
                            </td>
                        </tr>
                    </table>
                    <table style="width: 90%; height: 100px; margin: 0; font-size: 18px">
                        <tr>
                            <td colspan="3">
                                <p><input type="checkbox" style="width:20px;height:20px;"/> Thu đổi</p>
                            </td>
                        </tr>
                    </table>
                    <table  style="width: 80%; height: auto; margin: 0; border: 1px solid; border-collapse: collapse; font-size: 12px">
                        <tr style="border: 1px solid; border-collapse: collapse;">
                            <th rowspan="2" style="border: 1px solid; border-collapse: collapse;">STT</th>
                            <th rowspan="2" style="border: 1px solid; border-collapse: collapse;">Địa điểm lắp đặt</th>
                            <th colspan="2" style="border: 1px solid; border-collapse: collapse;">Thiết bị cũ</th>
                            <th colspan="2" style="border: 1px solid; border-collapse: collapse;">Thiết bị mới</th>
                        </tr>
                        <tr style="border: 1px solid; border-collapse: collapse;">
                            <th style="border: 1px solid; border-collapse: collapse;"><center>Tên thiết bị</center></th>                        
                        <th style="border: 1px solid; border-collapse: collapse;"><center>Số serial</center></th>                        
                        <th style="border: 1px solid; border-collapse: collapse;"><center>Tên thiết bị</center></th>                        
                        <th style="border: 1px solid; border-collapse: collapse;"><center>Số serial</center></th>                        
                        </tr>
                        <tr style="border: 1px solid; border-collapse: collapse;">
                            <td style="border: 1px solid; border-collapse: collapse;"><center>1</center></td>
                        <td style="border: 1px solid; border-collapse: collapse;"><center></center></td>
                        <td style="border: 1px solid; border-collapse: collapse;"><center></center></td>
                        <td style="border: 1px solid; border-collapse: collapse;"><center></center></td>
                        <td style="border: 1px solid; border-collapse: collapse;"><center></center></td>
                        <td style="border: 1px solid; border-collapse: collapse;"><center></center></td>
                        </tr>
                    </table>
                    <table style="width: 80%; height: auto; margin: 5px; font-size: 18px">
                        <tr style="border: 0;">
                            <td colspan="7" style="border: 0;">
                                <p>Thiết bị kèm theo:........... bộ chuyển điện, ...........dây nguồn, ...........SIM điện thoại</p>
                            </td>
                        </tr>
                    </table>
                    <table style="width: 80%; height: auto; margin: 5px; font-size: 18px">
                        
                        <tr>
                            <td colspan="7" style="border: 0;">
                                <p><b>1. Trường hợp bên B được nhận bàn giao/thu đổi MMTB từ bên A: </b></p>
                                <p>
                                    -	Bên B xác nhận MMTB được lắp đặt hoạt động tốt, đồng thời cam kết bảo quản MMTB theo đúng quy định của hợp đồng và hoàn toàn chịu trách nhiệm nếu xảy ra mất mát hoặc hư hỏng MMTB.
                                </p>
                                <p>
                                    -	Bên A đã hướng dẫn cho Bên B các quy định trong thanh toán thẻ tại Hợp đồng ĐVCNT đã ký, sổ tay ĐVCNT và nội dung hướng dẫn sử dụng dịch vụ mặt sau biên bản này.
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="7" style="border: 0;">
                                <p><b>2. Trường hợp bên A thu hồi MMTB từ bên B:</b></p>
                                <p>
                                    Trình trạng hoạt động của MMTB:
                                </p>
                                <p>
                                    <input type="checkbox"/> Tốt &nbsp; &nbsp; 
                                    <input type="checkbox"/> Hư hỏng: .............................
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="7" style="border: 0;">
                                <p>
                                    Biện pháp xử lý (trường hợp MMTB hư hỏng):
                                </p>
                                <p>..................................................................................................................................................................................................................................................</p>
                                <p>..................................................................................................................................................................................................................................................</p>
                                <p>..................................................................................................................................................................................................................................................</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="7" style="border: 0;">
                                <p>
                                    Biên bản lập thành 02 bản, Bên A giữ 01 bản, Bên B giữ 01 bản, có giá trị pháp lý như nhau.
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                </br>
                                <p><b><center>Xác nhận của Bên B</center></b></p>
                                <p><b><center>Đại diện giao nhận</center></b></p>
                            </td>
                            <td colspan="3">
                                <p><b><center>Xác nhận của Bên A</center></b></p>
                                <p><b><center>Đại diện pháp lý</center></b></p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="7">
                                <p> &nbsp; </p></br>
                                <p> &nbsp; </p></br>
                            </td>
                        </tr>
                    </table>
                </center>
            </div>
        </div>
    </body>

    <script>
        /* HTML to Microsoft Word Export Demo 
         * This code demonstrates how to export an html element to Microsoft Word
         * with CSS styles to set page orientation and paper size.
         * Tested with Word 2010, 2013 and FireFox, Chrome, Opera, IE10-11
         * Fails in legacy browsers (IE<10) that lack window.Blob object
         */
        window.export.onclick = function () {

            if (!window.Blob) {
                alert('Your legacy browser does not support this action.');
                return;
            }

            var html, link, blob, url, css;

            // EU A4 use: size: 841.95pt 595.35pt;
            // US Letter use: size:11.0in 8.5in;

            css = (
                    '<style>' +
                    '@page WordSection1{size: 841.95pt 595.35pt;mso-page-orientation: landscape;}' +
                    'div.WordSection1 {page: WordSection1;}' +
                    'table{border:none}td{border:none;width:5em;padding:2px;}' +
                    '.abc{background-color:red;}' +
                    '</style>'
                    );

            html = window.docx.innerHTML;
            blob = new Blob(['\ufeff', css + html], {
                type: 'application/msword'
            });
            url = URL.createObjectURL(blob);
            link = document.createElement('A');
            link.href = url;
            // Set default file name. 
            // Word will append file extension - do not add an extension here.
            link.download = 'BIEN_BAN_THU_HOI_POS';
            document.body.appendChild(link);
            if (navigator.msSaveOrOpenBlob)
                navigator.msSaveOrOpenBlob(blob, 'BIEN_BAN_THU_HOI_POS.doc'); // IE10-11
            else
                link.click();  // other browsers
            document.body.removeChild(link);
        };

    </script>
</html>
