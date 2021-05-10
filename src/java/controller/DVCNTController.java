package controller;

import entity.*;
import entity.TtHistaff;
import entity.TtLogDvcnt;
import entity.TtPosLive;
import entity.TtPosTempLive;
import entity.UserAcc;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.TtDvcntModel;
import model.TtPosModel;
import model.TtPosTempModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import model.HistaffModel;
import model.TtLogDvcntModel;
import model.UserAccModel;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import javax.servlet.http.*;
import javax.servlet.*;

@Controller
public class DVCNTController {

    private HttpSession _session;
    private static int static_gpdkkdNgaycap;
    private static int static_gpdkkdNgaycapCmnd;
    private static int static_ngaycapCmndHopdong;
    private static int static_ngayUyquyen;
    private static String _maDvcnt;
    private static Byte _loaiHinhDvcnt;
    private static String _success = "";
    private static int checkStatusSort = 1;
    private static int checkStatusSort1 = 1;

    // Lấy danh sách tất cả ĐVCNT đã lắp => CN/PGD xem
    @RequestMapping(value = "danhsachdvcnt1", method = RequestMethod.GET)
    public String getAll1(Model m, HttpServletRequest request) {
        _session = request.getSession();

        Byte groupUser = (Byte) _session.getAttribute("groupuser");
        String maCN_Of_User = String.valueOf(_session.getAttribute("macn"));

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        m.addAttribute("lst", model.getAll_TheoMaCN(maCN_Of_User));
        m.addAttribute("groupuser", groupUser);

        return "danhsachdvcnt1";
    }

    // Lấy danh sách tất cả ĐVCNT đã lắp => P.SP&CS KHDN xem
    @RequestMapping(value = "danhsachdvcnt2", method = RequestMethod.GET)
    public String getAll2(Model m, HttpServletRequest request) {
        _session = request.getSession();

        Byte groupUser = (Byte) _session.getAttribute("groupuser");

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        m.addAttribute("lst", model.getAll_PhongKHDN());
        m.addAttribute("groupuser", groupUser);
        return "danhsachdvcnt2";
    }

    // Lấy danh sách tất cả ĐVCNT đã lắp => P.TĐBH xem
    @RequestMapping(value = "danhsachdvcnt3", method = RequestMethod.GET)
    public String getAll3(Model m, HttpServletRequest request) {
        _session = request.getSession();

        Byte groupUser = (Byte) _session.getAttribute("groupuser");

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        m.addAttribute("lst", model.getAll_PKHCN());
        m.addAttribute("groupuser", groupUser);
        return "danhsachdvcnt3";
    }

    // Lấy danh sách tất cả ĐVCNT đã lắp => P.KTT&NHS xem
    @RequestMapping(value = "danhsachdvcnt", method = RequestMethod.GET)
    public String getAll(Model m, HttpServletRequest request) {
        _session = request.getSession();

        Byte groupUser = (Byte) _session.getAttribute("groupuser");

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        m.addAttribute("groupuser", groupUser);

        m.addAttribute("lst", model.getAll());

        if (groupUser == 1 || groupUser == 2) {
            return "danhsachdvcnt1";
        } else if (groupUser == 3 || groupUser == 4) {
            return "danhsachdvcnt2";
        } else if (groupUser == 5 || groupUser == 6) {
            return "danhsachdvcnt3";
        } else {
            return "danhsachdvcnt";
        }
    }

    // Lấy danh sách tất cả ĐVCNT đang xử lý
    @RequestMapping(value = "dvcntdangxuly", method = RequestMethod.GET)
    public String _getAll(Model m, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        m.addAttribute("lstThemMoi", model.getAll());
//        m.addAttribute("lstThemMoi", model.getListDvcntDangXuLyThemMoi());
        m.addAttribute("lstChinhSua1", model.getListDvcntDangChinhSua1()); // CHINH SUA KO CAN P.KTT&NHS DUYET
        m.addAttribute("lstChinhSua2", model.getListDvcntDangChinhSua2()); // CHINH SUA CAN P.KTT&NHS DUYET

        m.addAttribute("lstTamKhoa", model.getListDvcntTamKhoa()); // KHOA DVCNT
        m.addAttribute("soluongtamkhoa", model.getListDvcntTamKhoa().size());

        m.addAttribute("lstDong", model.getListDvcntDong()); // CLOSE DVCNT
        m.addAttribute("soluongDong", model.getListDvcntDong().size());

        m.addAttribute("lstLapThemPos", model.getListDvcntLapThemPos()); // DVCNT THEM MOI
        m.addAttribute("soluongDvcntLapthemPos", model.getListDvcntLapThemPos().size());
        return "dvcntdangxuly";
    }

    // Xem chi tiết ĐVCNT
    @RequestMapping(value = "chitietdvcnt", method = RequestMethod.GET)
    public String chiTietDvcnt(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        static_gpdkkdNgaycap = p.getGpdkkdNgaycap();
        static_gpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        static_ngaycapCmndHopdong = p.getNgaycapCmndHopdong();
        if (p.getNgayUyquyen() == null) {
            static_ngayUyquyen = 0;
        } else {
            static_ngayUyquyen = p.getNgayUyquyen();
        }

        _session.setAttribute("_maDvcnt", p.getMaDvcnt());
        m.addAttribute("maDvcnt", p.getMaDvcnt());
        m.addAttribute("tenDvcntVn", p.getTenDvcntVn());
        m.addAttribute("tenDvcntEn", p.getTenDvcntEn());
        m.addAttribute("diachiDvcnt", p.getDiachiDvcnt());
        m.addAttribute("sdtDvcnt", p.getSdtDvcnt());
        m.addAttribute("gpdkkdso", p.getGpdkkdso());

        int gpdkkdNgaycap = p.getGpdkkdNgaycap();
        String str_gpdkkdNgaycap = String.valueOf(gpdkkdNgaycap);
        String nam_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(0, 4);
        String thang_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(4, 6);
        String ngay_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(6, 8);
        String _GpdkkdNgaycap = ngay_gpdkkdNgaycap + "/" + thang_gpdkkdNgaycap + "/" + nam_gpdkkdNgaycap;
        m.addAttribute("_GpdkkdNgaycap", _GpdkkdNgaycap);

        m.addAttribute("gpdkkdNoicap", p.getGpdkkdNoicap());
        m.addAttribute("gpdkkdTennguoidaidien", p.getGpdkkdTennguoidaidien());
        m.addAttribute("gpdkkdChucvu", p.getGpdkkdChucvu());
        m.addAttribute("gpdkkdCmnd", p.getGpdkkdCmnd());

        int GpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        String str_GpdkkdNgaycapCmnd = String.valueOf(GpdkkdNgaycapCmnd);
        String nam_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(0, 4);
        String thang_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(4, 6);
        String ngay_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(6, 8);
        String _GpdkkdNgaycapCmnd = ngay_GpdkkdNgaycapCmnd + "/" + thang_GpdkkdNgaycapCmnd + "/" + nam_GpdkkdNgaycapCmnd;
        m.addAttribute("_GpdkkdNgaycapCmnd", _GpdkkdNgaycapCmnd);

        m.addAttribute("gpdkkdNoicapCmnd", p.getGpdkkdNoicap());
        m.addAttribute("masothue", p.getMasothue());
        m.addAttribute("tennguoiKyhopdong", p.getTennguoiKyhopdong());
        m.addAttribute("chucvuHopdong", p.getChucvuHopdong());
        m.addAttribute("cmndHopdong", p.getCmndHopdong());

        int NgaycapCmndHopdong = p.getNgaycapCmndHopdong();
        String str_NgaycapCmndHopdong = String.valueOf(NgaycapCmndHopdong);
        String nam_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(0, 4);
        String thang_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(4, 6);
        String ngay_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(6, 8);
        String _NgaycapCmndHopdong = ngay_NgaycapCmndHopdong + "/" + thang_NgaycapCmndHopdong + "/" + nam_NgaycapCmndHopdong;
        m.addAttribute("_NgaycapCmndHopdong", _NgaycapCmndHopdong);

        m.addAttribute("noicapCmndHopdong", p.getNoicapCmndHopdong());
        String soUyquyen = p.getSoUyquyen();
        m.addAttribute("soUyquyen", soUyquyen);

        if (p.getNgayUyquyen() == null) {
            m.addAttribute("_NgayUyquyen", '0');
        } else {
            int NgayUyquyen = p.getNgayUyquyen();
            if (NgayUyquyen != 0) {
                String str_NgayUyquyen = String.valueOf(NgayUyquyen);
                String nam_NgayUyquyen = str_NgayUyquyen.substring(0, 4);
                String thang_NgayUyquyen = str_NgayUyquyen.substring(4, 6);
                String ngay_NgayUyquyen = str_NgayUyquyen.substring(6, 8);
                String _NgayUyquyen = ngay_NgayUyquyen + "/" + thang_NgayUyquyen + "/" + nam_NgayUyquyen;
                m.addAttribute("_NgayUyquyen", _NgayUyquyen);
            } else {
                m.addAttribute("_NgayUyquyen", NgayUyquyen);
            }
        }

        String nganhang_hoptac = p.getNganhangHoptac();
        if (nganhang_hoptac.equals(" ,")) {
            nganhang_hoptac = "Khong";
            m.addAttribute("nganhangHoptac", nganhang_hoptac);
        } else {
            m.addAttribute("nganhangHoptac", p.getNganhangHoptac());
        }
        m.addAttribute("loaihinhDvcnt", p.getLoaihinhDvcnt());
        m.addAttribute("nganhnghekd", p.getNganhnghekd());
        m.addAttribute("doanhsothanhtoandukien", p.getDoanhsothanhtoandukien());
        m.addAttribute("xeploai", p.getXeploai());
        m.addAttribute("landk", p.getLandk());
        m.addAttribute("slpos", p.getSlpos());
        m.addAttribute("dongmayDexuat", p.getDongmayDexuat());
        m.addAttribute("phiGhinoscb", p.getPhiGhinoscb());
        m.addAttribute("phiGhinoLienminh", p.getPhiGhinoLienminh());
        m.addAttribute("phiVisa", p.getPhiVisa());
        m.addAttribute("phiMastercard", p.getPhiMastercard());
        m.addAttribute("phiJcb", p.getPhiJcb());
        m.addAttribute("phiCup", p.getPhiCup());
        m.addAttribute("phiDiscover", p.getPhiDiscover());
        m.addAttribute("tenThekhac", p.getTenThekhac());
        m.addAttribute("phiThekhac", p.getPhiThekhac());
        m.addAttribute("loaitien", p.getLoaitien());
        m.addAttribute("loaihinhDvcnt", p.getLoaihinhDvcnt());

        m.addAttribute("tienkyquyMoto", p.getTienkyquyMoto());
        m.addAttribute("hanmucVnd", p.getHanmucVnd());
        m.addAttribute("hanmucUsd", p.getHanmucUsd());

        return "chitietdvcnt";
    }

    // Thêm mới ĐVCNT
    @RequestMapping(value = "/xulythemmoidvcnt", method = RequestMethod.POST)
    public String themDVCNT(Model m, @ModelAttribute(value = "_dvcnt") TtDvcntLive p, HttpServletRequest request) {
        _session = request.getSession();

        TtDvcntModel model = new TtDvcntModel();
        //Kiem tra GPKD da duoc tao chua?
        String so_GPDKKD = request.getParameter("gpdkkdso");
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        lst = model.getListBySoGpkd2(so_GPDKKD);
        int soLuong = lst.size();
        if (soLuong == 1) {
            String alert = "Lỗi: GPĐKKD số '" + so_GPDKKD + "' đã tồn tại. Nhấn 'Back' trên trình duyệt để chỉnh sửa !";
            _session.setAttribute("success", alert);
            return "redirect:themmoidvcnt.html";
        }

        // Ngan Hang Hop Tac
        String khong_nganhangHoptac = request.getParameter("_nganhangHoptac");
        String co_NganHangHoptac = request.getParameter("_coNganHangHoptac");

        if (co_NganHangHoptac == null) {
            co_NganHangHoptac = "";
        }

        if (!co_NganHangHoptac.equals("")) {
            p.setNganhangHoptac(co_NganHangHoptac);
        } else {
            p.setNganhangHoptac(khong_nganhangHoptac);
        }

        // Lần đăng ký
        String lan_dangky = request.getParameter("landk");
        String lan_dangky_txt = request.getParameter("_landk");

        if (lan_dangky_txt == null) {
            lan_dangky_txt = "";
        }

        if (Byte.parseByte(lan_dangky) == 3) {
            p.setLandk(Byte.parseByte(lan_dangky_txt));
        } else {
            p.setLandk(Byte.parseByte(lan_dangky));
        }

        String loaiDoanhNghiep = request.getParameter("loaiDoanhNghiep");
        p.setLoaiDoanhNghiep(loaiDoanhNghiep);

        // doanh so du kien
        String doanhsodukien = request.getParameter("_doanhsothanhtoandukien");
        String _doanhsodukien = doanhsodukien.replaceAll(",", "");
        p.setDoanhsothanhtoandukien(Long.parseLong(_doanhsodukien));

        String ngaycap_gpkd = formatTime(request.getParameter("ngaycap_gpkd"));
        String thangcap_gpkd = formatTime(request.getParameter("thangcap_gpkd"));
        String namcap_gpkd = formatTime(request.getParameter("namcap_gpkd"));
        String temp1 = namcap_gpkd + thangcap_gpkd + ngaycap_gpkd;
        int gpkd = Integer.parseInt(temp1);
        p.setGpdkkdNgaycap(gpkd);

        String ngaycap_cmndnguoidaidien = formatTime(request.getParameter("ngaycap_cmndnguoidaidien"));
        String thangcap_cmndnguoidaidien = formatTime(request.getParameter("thangcap_cmndnguoidaidien"));
        String namcap_cmndnguoidaidien = formatTime(request.getParameter("namcap_cmndnguoidaidien"));
        String temp2 = namcap_cmndnguoidaidien + thangcap_cmndnguoidaidien + ngaycap_cmndnguoidaidien;
        int cmnd_nguoidaidien = Integer.parseInt(temp2);
        p.setGpdkkdNgaycapCmnd(cmnd_nguoidaidien);

        String ngaycap_cmndhopdong = formatTime(request.getParameter("ngaycap_cmndnguoikyhd"));
        String thangcap_cmndhopdong = formatTime(request.getParameter("thangcap_cmndnguoikyhd"));
        String namcap_cmndhopdong = formatTime(request.getParameter("namcap_cmndnguoikyhd"));
        String temp3 = namcap_cmndhopdong + thangcap_cmndhopdong + ngaycap_cmndhopdong;
        int cmnd_hopdong = Integer.parseInt(temp3);
        p.setNgaycapCmndHopdong(cmnd_hopdong);

        p.setDiachiDvcnt(request.getParameter("diaChiDvcnt"));

        String UserNhap = (String) _session.getAttribute("mauser");
        p.setUser1Cn(UserNhap);
        String cnQuanly = (String) _session.getAttribute("macn");
        p.setCnQuanly(cnQuanly);

        // Ngay uy quyen
        String ngay_uyquyen = formatTime(request.getParameter("ngay_uyquyen"));
        String thang_uyquyen = formatTime(request.getParameter("thang_uyquyen"));
        String nam_uyquyen = formatTime(request.getParameter("nam_uyquyen"));
        String temp4 = nam_uyquyen + thang_uyquyen + ngay_uyquyen;
        if (request.getParameter("soUyquyen") == null || request.getParameter("soUyquyen").equals("")) {
            temp4 = "0";
        }
        int ngayuyquyen = Integer.parseInt(temp4);
        p.setNgayUyquyen(ngayuyquyen);

        // Thoi gian lap dat
        String ngay_thoigianlap = formatTime(request.getParameter("ngay_thoigianlap"));
        String thang_thoigianlap = formatTime(request.getParameter("thang_thoigianlap"));
        String nam_thoigianlap = formatTime(request.getParameter("nam_thoigianlap"));
        String temp5 = nam_thoigianlap + thang_thoigianlap + ngay_thoigianlap;
        p.setThoiGianLapDat(Integer.parseInt(temp5));
        p.setUser1CnNgaynhap(get_SystemTime());
        p.setLoaiKhachHang(request.getParameter("loaiKhachHang"));
        p.setDongmayDexuat("");
        p.setTienkyquyMoto(Long.parseLong("0"));

        // cac loai phi
        String phiThekhac = request.getParameter("phiThekhac");
        if (!phiThekhac.equals("")) {
            p.setPhiThekhac(phiThekhac);
        }
        p.setPhiGhinoscb(format_Fee(request.getParameter("phiGhinoscb")));
        p.setPhiGhinoLienminh(format_Fee(request.getParameter("phiGhinoLienminh")));
        p.setPhiVisa(format_Fee(request.getParameter("phiVisa")));
        p.setPhiMastercard(format_Fee(request.getParameter("phiMastercard")));
        p.setPhiJcb(format_Fee(request.getParameter("phiJcb")));
        p.setPhiCup(format_Fee(request.getParameter("phiCup")));
        p.setPhiDiscover(format_Fee(request.getParameter("phiDiscover")));
        Byte tinhtrang = 0; // Pendding
        p.setStatusDvcnt(tinhtrang);

        Byte status_duyet = 1;
        p.setStatusDuyet(status_duyet);

        String ma_DVCNT = "";

        long size = model.countAll() + 1;
        for (long i = size; i < Long.MAX_VALUE; i++) {
            String maDvcnt = "";
            if (i >= 1 && i <= 9) {
                maDvcnt = "00000" + String.valueOf(i);
            } else if (i >= 10 && i <= 99) {
                maDvcnt = "0000" + String.valueOf(i);//M001000000
            } else if (i >= 100 && size <= 999) {
                maDvcnt = "000" + String.valueOf(i);
            } else if (i >= 1000 && size <= 1999) {
                maDvcnt = "00" + String.valueOf(i);
            } else if (i >= 10000 && size <= 19999) {
                maDvcnt = "0" + String.valueOf(i);
            } else {
                maDvcnt = String.valueOf(i);
            }
            ma_DVCNT = "M" + (String) _session.getAttribute("macn") + maDvcnt;

            TtDvcntLive temp = new TtDvcntLive();
            temp = model.getTtDvcnt(ma_DVCNT); // Kiểm tra ma_DVCNT đã tồn tại hay chưa?

            if (temp == null) {
                p.setMaDvcnt(ma_DVCNT);
                // GHI LOG
                TtLogDvcntModel modelLog = new TtLogDvcntModel();
                TtLogDvcnt log = new TtLogDvcnt();
                log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
                log.setLogLevel((Byte) _session.getAttribute("groupuser"));
                log.setLogTime(get_SystemTime());
                log.setLogMid(ma_DVCNT);
                try {
                    model.create(p);
                    log.setLogContent("Tạo mới ĐVCNT: " + request.getParameter("tenDvcntVn") + "(chưa gán POS)");
                    modelLog.create(log); // create log
                    _success = "Đã thêm mới ĐVCNT " + "'" + request.getParameter("tenDvcntVn") + "'";
                    _session.setAttribute("success", _success);
                } catch (Exception e) {
                    log.setLogContent("ERROR: Tạo mới ĐVCNT: "
                            + request.getParameter("tenDvcntVn")
                            + "(chưa gán POS) không thành công(themmoidvcnt.html). Chi tiết: "
                            + e.toString());
                    modelLog.create(log); // create log
                }
                break;
            }
        }
        return "redirect:themmoidvcnt.html";
    }

    // Duyệt
    @RequestMapping(value = "duyet", method = RequestMethod.GET)
    public String duyet(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        _maDvcnt = id;
        _session.setAttribute("_maDvcnt", _maDvcnt);
        _session.setAttribute("_id", _maDvcnt);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        // Số lượng POS đã map
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdamap = modelTemp.countByIsMapping(id); // ISMAPPING = 1
        int soluongPOSThemMoidamap = modelTemp.countByIsMappingPOSThemMoi(id); // ISMAPPING = 3
        int slposdamap = soluongdamap + soluongPOSThemMoidamap;

        // Số lượng POS đã gán
        int soluongdagan = modelTemp.countById(id);

        // If số lượng map không bằng số lượng đã đăng ký thì không vào đc man hinh duyet thong so!
        Byte groupUserDuyet = (Byte) _session.getAttribute("groupuser");
        if (slposdamap < soluongdagan && groupUserDuyet == 7 && p.getStatusDuyet() == 10) {
            return "redirect:dvcntdangxuly.html";
        }

        static_gpdkkdNgaycap = p.getGpdkkdNgaycap();
        static_gpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        static_ngaycapCmndHopdong = p.getNgaycapCmndHopdong();

        if (p.getNgayUyquyen() == null) {
            static_ngayUyquyen = 0;
        } else {
            static_ngayUyquyen = p.getNgayUyquyen();
        }

        m.addAttribute("maDvcnt", p.getMaDvcnt());
        m.addAttribute("tenDvcntVn", p.getTenDvcntVn());
        m.addAttribute("tenDvcntEn", p.getTenDvcntEn());
        m.addAttribute("diachiDvcnt", p.getDiachiDvcnt());
        m.addAttribute("sdtDvcnt", p.getSdtDvcnt());
        m.addAttribute("gpdkkdso", p.getGpdkkdso());

        Byte statusDvcnt = p.getStatusDvcnt();
        if (statusDvcnt == 4 || statusDvcnt == 5) { //  Khóa/Tạm khóa ĐVCNT
            m.addAttribute("path_khoaPos", p.getFileuploadKhoa());
        }
        if (statusDvcnt == 3) {
            m.addAttribute("path_edit", p.getFileUpload3()); // File edit DVCNT
        }
        if (statusDvcnt == 8) {
            m.addAttribute("path_lapthem", p.getFileUpload2()); // File lắp thêm POS
        } else {
            m.addAttribute("path_themmoi", p.getFileUpload()); // File them moi DVCNT
        }

//        m.addAttribute("fileUpload2", p.getFileUpload2());
        int gpdkkdNgaycap = p.getGpdkkdNgaycap();
        String str_gpdkkdNgaycap = String.valueOf(gpdkkdNgaycap);
        String nam_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(0, 4);
        String thang_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(4, 6);
        String ngay_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(6, 8);
        String _GpdkkdNgaycap = ngay_gpdkkdNgaycap + "/" + thang_gpdkkdNgaycap + "/" + nam_gpdkkdNgaycap;
        m.addAttribute("_GpdkkdNgaycap", _GpdkkdNgaycap);

        m.addAttribute("gpdkkdNoicap", p.getGpdkkdNoicap());
        m.addAttribute("gpdkkdTennguoidaidien", p.getGpdkkdTennguoidaidien());
        m.addAttribute("gpdkkdChucvu", p.getGpdkkdChucvu());
        m.addAttribute("gpdkkdCmnd", p.getGpdkkdCmnd());

        int GpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        String str_GpdkkdNgaycapCmnd = String.valueOf(GpdkkdNgaycapCmnd);
        String nam_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(0, 4);
        String thang_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(4, 6);
        String ngay_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(6, 8);
        String _GpdkkdNgaycapCmnd = ngay_GpdkkdNgaycapCmnd + "/" + thang_GpdkkdNgaycapCmnd + "/" + nam_GpdkkdNgaycapCmnd;
        m.addAttribute("_GpdkkdNgaycapCmnd", _GpdkkdNgaycapCmnd);

        m.addAttribute("gpdkkdNoicapCmnd", p.getGpdkkdNoicap());
        m.addAttribute("masothue", p.getMasothue());
        m.addAttribute("tennguoiKyhopdong", p.getTennguoiKyhopdong());
        m.addAttribute("chucvuHopdong", p.getChucvuHopdong());
        m.addAttribute("cmndHopdong", p.getCmndHopdong());

        int NgaycapCmndHopdong = p.getNgaycapCmndHopdong();
        String str_NgaycapCmndHopdong = String.valueOf(NgaycapCmndHopdong);
        String nam_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(0, 4);
        String thang_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(4, 6);
        String ngay_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(6, 8);
        String _NgaycapCmndHopdong = ngay_NgaycapCmndHopdong + "/" + thang_NgaycapCmndHopdong + "/" + nam_NgaycapCmndHopdong;
        m.addAttribute("_NgaycapCmndHopdong", _NgaycapCmndHopdong);

        m.addAttribute("noicapCmndHopdong", p.getNoicapCmndHopdong());
        m.addAttribute("soUyquyen", p.getSoUyquyen());

        String _NgayUyquyen = "";
        if (p.getNgayUyquyen() == null) {
            _NgayUyquyen = "0";
        } else {
            int NgayUyquyen = p.getNgayUyquyen();

            if (NgayUyquyen != 0) {
                String str_NgayUyquyen = String.valueOf(NgayUyquyen);
                String nam_NgayUyquyen = str_NgayUyquyen.substring(0, 4);
                String thang_NgayUyquyen = str_NgayUyquyen.substring(4, 6);
                String ngay_NgayUyquyen = str_NgayUyquyen.substring(6, 8);
                _NgayUyquyen = ngay_NgayUyquyen + "/" + thang_NgayUyquyen + "/" + nam_NgayUyquyen;
            } else {
                _NgayUyquyen = "0";
            }
        }
        m.addAttribute("_NgayUyquyen", _NgayUyquyen);

        String nganhang_hoptac = p.getNganhangHoptac();
        if (nganhang_hoptac.equals(" ,")) {
            nganhang_hoptac = "Không";
            m.addAttribute("nganhangHoptac", nganhang_hoptac);
        } else {
            m.addAttribute("nganhangHoptac", p.getNganhangHoptac());
        }
        m.addAttribute("loaihinhDvcnt", p.getLoaihinhDvcnt());
        _loaiHinhDvcnt = p.getLoaihinhDvcnt();

        m.addAttribute("nganhnghekd", p.getNganhnghekd());

        long _doanhsothanhtoandukien = p.getDoanhsothanhtoandukien();
        DecimalFormat formatter = new DecimalFormat("###,###,###");
        String doanhsothanhtoandukien = formatter.format(_doanhsothanhtoandukien);
        m.addAttribute("doanhsothanhtoandukien", doanhsothanhtoandukien);

        m.addAttribute("xeploai", p.getXeploai());
        m.addAttribute("landk", p.getLandk());
        m.addAttribute("slpos", p.getSlpos());
        m.addAttribute("dongmayDexuat", p.getDongmayDexuat());
        m.addAttribute("phiGhinoscb", p.getPhiGhinoscb());

        if (p.getPhiGhinoscb() == null) {
            String PhiGhinoscb = "";
            m.addAttribute("phiGhinoscb", PhiGhinoscb);
        } else {
            m.addAttribute("phiGhinoscb", p.getPhiGhinoscb());
        }
        if (p.getPhiGhinoLienminh() == null) {
            String phiGhinoLienminh = "";
            m.addAttribute("phiGhinoLienminh", phiGhinoLienminh);
        } else {
            m.addAttribute("phiGhinoLienminh", p.getPhiGhinoLienminh());
        }
        if (p.getPhiVisa() == null) {
            String PhiVisa = "";
            m.addAttribute("phiVisa", PhiVisa);
        } else {
            m.addAttribute("phiVisa", p.getPhiVisa());
        }
        if (p.getPhiMastercard() == null) {
            String PhiMastercard = "";
            m.addAttribute("phiMastercard", PhiMastercard);
        } else {
            m.addAttribute("phiMastercard", p.getPhiMastercard());
        }
        if (p.getPhiJcb() == null) {
            String PhiJcb = "";
            m.addAttribute("phiJcb", PhiJcb);
        } else {
            m.addAttribute("phiJcb", p.getPhiJcb());
        }
        if (p.getPhiCup() == null) {
            String PhiCup = "";
            m.addAttribute("phiCup", PhiCup);
        } else {
            m.addAttribute("phiCup", p.getPhiCup());
        }
        if (p.getPhiDiscover() == null) {
            String PhiDiscover = "";
            m.addAttribute("phiDiscover", PhiDiscover);
        } else {
            m.addAttribute("phiDiscover", p.getPhiDiscover());
        }
        if (p.getPhiThekhac() == null) {
            String PhiThekhac = "";
            m.addAttribute("phiThekhac", PhiThekhac);
        } else {
            m.addAttribute("phiThekhac", p.getPhiThekhac());
        }
        m.addAttribute("tenThekhac", p.getTenThekhac());
        m.addAttribute("loaitien", p.getLoaitien());
        m.addAttribute("loaihinhDvcnt", p.getLoaihinhDvcnt());
        m.addAttribute("loaiKhachHang", p.getLoaiKhachHang());

//        long moto = p.getTienkyquyMoto();
//        if (p.getTienkyquyMoto() == null) {
//            String tienkyquyMoto = "";
//            m.addAttribute("tienkyquyMoto", tienkyquyMoto);
//        } else {
//            long _tienkyquyMoto = p.getTienkyquyMoto();
//            String tienkyquyMoto = formatter.format(_tienkyquyMoto);
//            m.addAttribute("tienkyquyMoto", tienkyquyMoto);
//        }
//        long _hanmucUsd = p.getHanmucUsd();
//        String hanmucUsd = formatter.format(_hanmucUsd);
//        m.addAttribute("hanmucUsd", hanmucUsd);
//
//        long _hanmucVnd = p.getHanmucVnd();
//        String hanmucVnd = formatter.format(_hanmucVnd);
//        m.addAttribute("hanmucVnd", hanmucVnd);
        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = modelDvcnt.getTtDvcnt(id);
        Byte groupUser = (Byte) _session.getAttribute("groupuser");

        // Lấy DS POS đang được yêu cầu chỉnh sửa
        Byte tinhTrangDvcnt = dvcnt.getStatusDvcnt();
        if (tinhTrangDvcnt == 2) {
            m.addAttribute("lstKhongCanTNTDuyet", modelTemp.getDSPOSChinhSua(id));
        }
        if (tinhTrangDvcnt == 3) {
            m.addAttribute("lstCanTNTDuyet", modelTemp.getDSPOSChinhSua1(id));
        } else {
            m.addAttribute("lst", modelTemp.getAllById(id));
        }

        // Lấy danh sách POS đăng ký lắp mới
        TtPosModel modelPOS = new TtPosModel();
        if (tinhTrangDvcnt == 5) {
            m.addAttribute("lstPOSDangXuLyThemMoi", modelPOS.getDSPOSDangXuLyThemMoi(id));
        }

        // Lấy danh sách POS tạm khóa.
//        if (tinhTrangDvcnt == 5) {
//            m.addAttribute("lstPOSDangXuLyTamKhoa", modelPOS.getDSPOSDangXuLyTamKhoa(id));
//        }
        // Lấy danh sách POS Khóa.
        if (tinhTrangDvcnt == 4) {
            m.addAttribute("lstPOSDangXuLyKhoa", modelPOS.getDSPOSDangXuLKhoa(id));
        }

        // Cap nhat trang thai "Đã nhận"
        if (groupUser == 3) {
            Byte status = 5;
            dvcnt.setStatusDuyet(status); // P.SP&CS KHDN đã nhận
            modelDvcnt.update(dvcnt);
        }
        if (groupUser == 5) {
            Byte status = 15;
            dvcnt.setStatusDuyet(status); // P.QLKDTD đã nhận
            modelDvcnt.update(dvcnt);;
        }
        if (groupUser == 7 && p.getStatusDuyet() == 7) {
            Byte status = 8;
            dvcnt.setStatusDuyet(status); // P.KTT&NHS đã nhận
            modelDvcnt.update(dvcnt);
        }
        if (groupUser == 7 && p.getStatusDuyet() == 17) {
            Byte status = 8;
            dvcnt.setStatusDuyet(status); // P.KTT&NHS đã nhận
            modelDvcnt.update(dvcnt);
        }

        // If số lượng map  bằng số lượng đã đăng ký -> STATUS_DUYET = 11: Đã map đủ thông số
        if (soluongdamap == soluongdagan && groupUserDuyet == 7 && p.getStatusDuyet() == 10) {
            Byte status = 11; // Đã map đủ thông số
            p.setStatusDuyet(status);
            model.update(p);
        }
        m.addAttribute("statusDuyet", dvcnt.getStatusDuyet());
        m.addAttribute("statusDvcnt", dvcnt.getStatusDvcnt());

        // Lay thong tin Hi-staff
        String get_direct_name = p.getDirectCode() + " - " + p.getDirectName();
        String get_direct_job = " - (" + p.getDirectJobtitleCode() + ") - " + p.getDirectJobtitleName();
        String get_direct_employee = get_direct_name + get_direct_job;
        m.addAttribute("get_direct_employee", get_direct_employee);

        if (p.getIndirectCode() != null) {
            String get_inDirect_name = p.getIndirectCode() + " - " + p.getIndirectName();
            String get_indirect_job = " - (" + p.getIndirectJobtitleCode() + ") - " + p.getIndirectJobtitleName();
            String get_inDirect_employee = get_inDirect_name + get_indirect_job;
            m.addAttribute("get_inDirect_employee", get_inDirect_employee);
        }

        return "duyet";
    }

    // Xem chi tiết ĐVCNT đã lắp
    @RequestMapping(value = "chitietdvcntdaplap", method = RequestMethod.GET)
    public String chiTietDvcntDaLap(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        _maDvcnt = id;
        _session.setAttribute("_maDvcnt", _maDvcnt);
        _session.setAttribute("_id", _maDvcnt);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);
        Byte tinhtrangDvcnt = p.getStatusDvcnt();

        // Số lượng POS đã map
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdamap = modelTemp.countByIsMapping(id);

        // Số lượng POS đã gán
        int soluongdagan = modelTemp.countById(id);

        // If số lượng map không bằng số lượng đã đăng ký thì không vào đc ma hinh duyet thong so!
        Byte groupUserDuyet = (Byte) _session.getAttribute("groupuser");
        if (soluongdamap < soluongdagan && groupUserDuyet == 7 && p.getStatusDuyet() == 10) {
            return "redirect:dvcntdangxuly.html";
        }

        static_gpdkkdNgaycap = p.getGpdkkdNgaycap();
        static_gpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        static_ngaycapCmndHopdong = p.getNgaycapCmndHopdong();

        if (p.getNgayUyquyen() == null) {
            static_ngayUyquyen = 0;
        } else {
            static_ngayUyquyen = p.getNgayUyquyen();
        }

        m.addAttribute("maDvcnt", p.getMaDvcnt());
        m.addAttribute("tenDvcntVn", p.getTenDvcntVn());
        m.addAttribute("tenDvcntEn", p.getTenDvcntEn());
        m.addAttribute("diachiDvcnt", p.getDiachiDvcnt());
        m.addAttribute("sdtDvcnt", p.getSdtDvcnt());
        m.addAttribute("gpdkkdso", p.getGpdkkdso());
        m.addAttribute("statusDuyet", p.getStatusDuyet());
        m.addAttribute("statusDvcnt", p.getStatusDvcnt());
        m.addAttribute("fileMapping", p.getFileMapping());

        int gpdkkdNgaycap = p.getGpdkkdNgaycap();
        String str_gpdkkdNgaycap = String.valueOf(gpdkkdNgaycap);
        String nam_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(0, 4);
        String thang_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(4, 6);
        String ngay_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(6, 8);
        String _GpdkkdNgaycap = ngay_gpdkkdNgaycap + "/" + thang_gpdkkdNgaycap + "/" + nam_gpdkkdNgaycap;
        m.addAttribute("_GpdkkdNgaycap", _GpdkkdNgaycap);

        m.addAttribute("gpdkkdNoicap", p.getGpdkkdNoicap());
        m.addAttribute("gpdkkdTennguoidaidien", p.getGpdkkdTennguoidaidien());
        m.addAttribute("gpdkkdChucvu", p.getGpdkkdChucvu());
        m.addAttribute("gpdkkdCmnd", p.getGpdkkdCmnd());

        int GpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        String str_GpdkkdNgaycapCmnd = String.valueOf(GpdkkdNgaycapCmnd);
        String nam_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(0, 4);
        String thang_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(4, 6);
        String ngay_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(6, 8);
        String _GpdkkdNgaycapCmnd = ngay_GpdkkdNgaycapCmnd + "/" + thang_GpdkkdNgaycapCmnd + "/" + nam_GpdkkdNgaycapCmnd;
        m.addAttribute("_GpdkkdNgaycapCmnd", _GpdkkdNgaycapCmnd);

        m.addAttribute("gpdkkdNoicapCmnd", p.getGpdkkdNoicap());
        m.addAttribute("masothue", p.getMasothue());
        m.addAttribute("tennguoiKyhopdong", p.getTennguoiKyhopdong());
        m.addAttribute("chucvuHopdong", p.getChucvuHopdong());
        m.addAttribute("cmndHopdong", p.getCmndHopdong());

        int NgaycapCmndHopdong = p.getNgaycapCmndHopdong();
        String str_NgaycapCmndHopdong = String.valueOf(NgaycapCmndHopdong);
        String nam_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(0, 4);
        String thang_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(4, 6);
        String ngay_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(6, 8);
        String _NgaycapCmndHopdong = ngay_NgaycapCmndHopdong + "/" + thang_NgaycapCmndHopdong + "/" + nam_NgaycapCmndHopdong;
        m.addAttribute("_NgaycapCmndHopdong", _NgaycapCmndHopdong);

        m.addAttribute("noicapCmndHopdong", p.getNoicapCmndHopdong());
        m.addAttribute("soUyquyen", p.getSoUyquyen());

        String _NgayUyquyen = "";
        if (p.getNgayUyquyen() == null) {
            _NgayUyquyen = "0";
        } else {
            int NgayUyquyen = p.getNgayUyquyen();
            if (NgayUyquyen != 0) {
                String str_NgayUyquyen = String.valueOf(NgayUyquyen);
                String nam_NgayUyquyen = str_NgayUyquyen.substring(0, 4);
                String thang_NgayUyquyen = str_NgayUyquyen.substring(4, 6);
                String ngay_NgayUyquyen = str_NgayUyquyen.substring(6, 8);
                _NgayUyquyen = ngay_NgayUyquyen + "/" + thang_NgayUyquyen + "/" + nam_NgayUyquyen;
            } else {
                _NgayUyquyen = "0";
            }
        }
        m.addAttribute("_NgayUyquyen", _NgayUyquyen);

        String nganhang_hoptac = p.getNganhangHoptac();
        if (nganhang_hoptac.equals(" ,")) {
            nganhang_hoptac = "Không";
            m.addAttribute("nganhangHoptac", nganhang_hoptac);
        } else {
            m.addAttribute("nganhangHoptac", p.getNganhangHoptac());
        }
        m.addAttribute("loaihinhDvcnt", p.getLoaihinhDvcnt());
        _loaiHinhDvcnt = p.getLoaihinhDvcnt();

        m.addAttribute("nganhnghekd", p.getNganhnghekd());

        long _doanhsothanhtoandukien = p.getDoanhsothanhtoandukien();
        DecimalFormat formatter = new DecimalFormat("###,###,###");
        String doanhsothanhtoandukien = formatter.format(_doanhsothanhtoandukien);
        m.addAttribute("doanhsothanhtoandukien", doanhsothanhtoandukien);

        m.addAttribute("xeploai", p.getXeploai());
        m.addAttribute("landk", p.getLandk());
        m.addAttribute("slpos", p.getSlpos());
        m.addAttribute("dongmayDexuat", p.getDongmayDexuat());
        m.addAttribute("phiGhinoscb", p.getPhiGhinoscb());
        m.addAttribute("tinhTrangDvcnt", p.getStatusDvcnt());

        if (p.getPhiGhinoscb() == null) {
            String PhiGhinoscb = "";
            m.addAttribute("phiGhinoscb", PhiGhinoscb);
        } else {
            m.addAttribute("phiGhinoscb", p.getPhiGhinoscb());
        }
        if (p.getPhiGhinoLienminh() == null) {
            String phiGhinoLienminh = "";
            m.addAttribute("phiGhinoLienminh", phiGhinoLienminh);
        } else {
            m.addAttribute("phiGhinoLienminh", p.getPhiGhinoLienminh());
        }
        if (p.getPhiVisa() == null) {
            String PhiVisa = "";
            m.addAttribute("phiVisa", PhiVisa);
        } else {
            m.addAttribute("phiVisa", p.getPhiVisa());
        }
        if (p.getPhiMastercard() == null) {
            String PhiMastercard = "";
            m.addAttribute("phiMastercard", PhiMastercard);
        } else {
            m.addAttribute("phiMastercard", p.getPhiMastercard());
        }
        if (p.getPhiJcb() == null) {
            String PhiJcb = "";
            m.addAttribute("phiJcb", PhiJcb);
        } else {
            m.addAttribute("phiJcb", p.getPhiJcb());
        }
        if (p.getPhiCup() == null) {
            String PhiCup = "";
            m.addAttribute("phiCup", PhiCup);
        } else {
            m.addAttribute("phiCup", p.getPhiCup());
        }
        if (p.getPhiDiscover() == null) {
            String PhiDiscover = "";
            m.addAttribute("phiDiscover", PhiDiscover);
        } else {
            m.addAttribute("phiDiscover", p.getPhiDiscover());
        }
        if (p.getPhiThekhac() == null) {
            String PhiThekhac = "";
            m.addAttribute("phiThekhac", PhiThekhac);
        } else {
            m.addAttribute("phiThekhac", p.getPhiThekhac());
        }
        m.addAttribute("tenThekhac", p.getTenThekhac());
        m.addAttribute("loaitien", p.getLoaitien());
        m.addAttribute("loaihinhDvcnt", p.getLoaihinhDvcnt());
        m.addAttribute("FileuploadTamKhoa", p.getFileuploadTamKhoa());
        m.addAttribute("FileuploadKhoa", p.getFileuploadKhoa());

        // Lay thong tin Hi-staff
        String get_direct_name = p.getDirectCode() + " - " + p.getDirectName();
        String get_direct_job = " - (" + p.getDirectJobtitleCode() + ") - " + p.getDirectJobtitleName();
        String get_direct_employee = get_direct_name + get_direct_job;
        m.addAttribute("get_direct_employee", get_direct_employee);

        if (p.getIndirectCode() != null) {
            String get_inDirect_name = p.getIndirectCode() + " - " + p.getIndirectName();
            String get_indirect_job = " - (" + p.getIndirectJobtitleCode() + ") - " + p.getIndirectJobtitleName();
            String get_inDirect_employee = get_inDirect_name + get_indirect_job;
            m.addAttribute("get_inDirect_employee", get_inDirect_employee);
        }

//        long moto = p.getTienkyquyMoto();
//        if (p.getTienkyquyMoto() == null) {
//            String tienkyquyMoto = "";
//            m.addAttribute("tienkyquyMoto", tienkyquyMoto);
//        } else {
//            long _tienkyquyMoto = p.getTienkyquyMoto();
//            String tienkyquyMoto = formatter.format(_tienkyquyMoto);
//            m.addAttribute("tienkyquyMoto", tienkyquyMoto);
//        }
        m.addAttribute("lst", modelTemp.getAllById(id));

        // Lấy danh sách POS tạm khóa.
        TtPosModel modelPOS = new TtPosModel();
        if (tinhtrangDvcnt == 5) {
            m.addAttribute("lstPOSDangXuLyTamKhoa", modelPOS.getDSPOSDangXuLyTamKhoa(id));
        }

        // Lấy danh sách POS khóa.
        if (tinhtrangDvcnt == 4) {
            m.addAttribute("lstPOSDangXuLyKhoa", modelPOS.getDSPOSDangXuLKhoa(id));
        }

        return "chitietdvcntdaplap";
    }

    // Xử lý duyệt
    @RequestMapping(value = "/xulyduyet", method = RequestMethod.GET)
    public String xuLyDuyet(Model m, @ModelAttribute(value = "_duyetdvcnt") TtDvcntLive p, HttpServletRequest request) {
        _session = request.getSession();

        String ghichu = request.getParameter("ghichu");
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = model.getTtDvcnt(_maDvcnt);

        String UserDuyet = (String) _session.getAttribute("mauser");
        Byte groupUserDuyet = (Byte) _session.getAttribute("groupuser");

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_duyet = "";
        ngay_gio_duyet = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);

        String DuyetThuan = "Đã duyệt thuận ĐVCNT " + _maDvcnt;
        // GHI LOG
        TtLogDvcntModel modelLog = new TtLogDvcntModel();
        TtLogDvcnt log = new TtLogDvcnt();
        log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
        log.setLogLevel((Byte) _session.getAttribute("groupuser"));
        log.setLogTime(get_SystemTime());
        log.setLogMid(_maDvcnt);

        // GUI EMAIL THONG BAO DON VI SAU KHI (2)P.KTT DUYET
        String tenCNPGD = String.valueOf(_session.getAttribute("tencn"));
        UserAccModel userModel = new UserAccModel();

        //USER 1
        String user1CnPGD = dvcnt.getUser1Cn();
        int lenght_user1CnPGD = user1CnPGD.length();
        int number = 20 - lenght_user1CnPGD;
        for (int i = 1; i <= number; i++) {
            user1CnPGD += " "; // Vì username dưới DB luôn là 20 kí tự nên phải thêm bước này
        }
        String email_1 = userModel._getEmail(user1CnPGD);

        //USER 2
        String user2CnPGD = "", email_2 = "";
        if (dvcnt.getUser2Cn() != null) {
            user2CnPGD = dvcnt.getUser2Cn();
            int lenght_user2CnPGD = user2CnPGD.length();
            number = 20 - lenght_user2CnPGD;
            for (int i = 1; i <= number; i++) {
                user2CnPGD += " "; // Vì username dưới DB luôn là 20 kí tự nên phải thêm bước này
            }
            email_2 = userModel._getEmail(user2CnPGD);
        }
        String email = email_1 + "," + email_2;
        String mail_PhongKHDN_DaDuyet = "P.SP&CS KHDN da duyet chuyen tiep ho so DVCNT: " + dvcnt.getTenDvcntVn()
                + "\n\nThong bao tu dong, vui long khong tra loi email nay. Cam on quy A/C !\n\n";;
        String content_TaoMoiDvcnt;
        // END GUI EMAIL THONG BAO DON VI SAU KHI (2)P.KTT DUYET
        // Đồng ý duyệt
        if (request.getParameter("pass") != null) {
            // User cap 2 CN/PGD duyet
            if (groupUserDuyet == 2) {
                if (_loaiHinhDvcnt == 2) { // KHDN
                    String email_KHDN = "";
                    dvcnt.setUser2Cn(UserDuyet);
                    dvcnt.setUser2CnDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2CnNote(ghichu);
                    Byte status = 4; // Chuyển đến P.SP&CS KHDN
                    dvcnt.setStatusDuyet(status);
                    model.update(dvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(2)CN/PGD chuyển tiếp đến P.SP&CS KHDN");
                    modelLog.create(log); // create log

                    // GUI EMAIL THONG BAO P.KHDN SAU KHI DON VI GUI DUYET                    
                    content_TaoMoiDvcnt = "Ho so DVCNT: " + dvcnt.getTenDvcntVn() + " da hoan tat nhap duyet o " + tenCNPGD + ".\n\n"
                            + "Kinh de nghi A/C thuc hien som cac buoc tiep theo dung quy trinh.\n\n"
                            + "Thong bao tu dong, vui long khong tra loi email nay. Cam on quy A/C !\n\n";
                    UserAccModel modelUser = new UserAccModel();
                    List<UserAcc> lst = modelUser.getUser_byBranch_byRole("000", "3");
                    for (int i = 0; i < lst.size(); i++) {
                        String temp = lst.get(i).getEmail();
                        email_KHDN += ", ";
                        email_KHDN += temp;
                    }
                    try {
                        send_Email(email_KHDN + ",nghiandh@scb.com.vn", content_TaoMoiDvcnt);
                    } catch (Exception e) {
                        System.out.println("LOI GUI MAIL DEN P.KHDN: " + e.toString());
                    }
                } else { // KHCN
                    dvcnt.setUser2Cn(UserDuyet);
                    dvcnt.setUser2CnDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2CnNote(ghichu);
                    Byte status = 14; // Chuyển đến P.QLKDTD
                    dvcnt.setStatusDuyet(status);
                    model.update(dvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(2)CN/PGD chuyển tiếp đến P.QLKDTD");
                    modelLog.create(log); // create log
                }
            }
            // PHONG KHACH HANG DOANH NGHIEP
            // User cap 1 P.SP&CS KHDN duyet
            if (groupUserDuyet == 3) {
                dvcnt.setUser1Pkhdn(UserDuyet);
                dvcnt.setUser1PkhdnDate(Long.parseLong(ngay_gio_duyet));
                dvcnt.setUser1PkhdnNote(ghichu);
                Byte status = 6; // Chuyển đến (2)P.SP&CS KHDN
                dvcnt.setStatusDuyet(status);
                model.update(dvcnt);
                _session.setAttribute("confirm", DuyetThuan);
                log.setLogContent("(1)P.SP&CS KHDN chuyển tiếp user cấp 2");
                modelLog.create(log); // create log
            }
            // User cap 2 P.SP&CS KHDN duyet
            if (groupUserDuyet == 4) {
                if (dvcnt.getStatusDvcnt() == 2) { // DUYỆT THÀNH CÔNG EDIT ĐVCNT KO CẦN P.KTT&NHS DUYỆT
                    dvcnt.setUser2Pkhdn(UserDuyet);
                    dvcnt.setUser2PkhdnDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2PkhdnNote(ghichu);
                    Byte status = 13;
                    dvcnt.setStatusDuyet(status);
                    Byte statusDVCNT = 1;
                    dvcnt.setStatusDvcnt(statusDVCNT);
                    model.update(dvcnt);

                    TtPosTempModel modelTemp = new TtPosTempModel();
                    modelTemp.capNhatIsmappingEditBasic(_maDvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(2)P.SP&CS KHDN duyệt edit ĐVCNT(P.KTT&NHS không cần duyệt)");
                    modelLog.create(log); // create log
                    return "redirect:danhsachdvcnt.html";
                } else {
                    dvcnt.setUser2Pkhdn(UserDuyet);
                    dvcnt.setUser2PkhdnDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2PkhdnNote(ghichu);
                    Byte status = 7; // Chuyển đến P.KTT&NHS
                    dvcnt.setStatusDuyet(status);
                    model.update(dvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(2)P.SP&CS KHDN chuyển tiếp P.KTT&NHS");
                    modelLog.create(log); // create log
                    // Gui mail thong bao cho DON VI & (1).P.KTT
                    try {
                        send_Email(email + ",nghiandh@scb.com.vn", mail_PhongKHDN_DaDuyet);
                    } catch (Exception e) {
                        System.out.println("LOI GUI MAIL: " + e.toString());
                    }
                }
            }
            // PHONG KHACH HANG CA NHAN
            // User cap 1 P.QLKDTD duyet
            if (groupUserDuyet == 5) {
                dvcnt.setUser1Ptdbh(UserDuyet);
                dvcnt.setUser1PtdbhDate(Long.parseLong(ngay_gio_duyet));
                dvcnt.setUser1PtdbhNote(ghichu);
                Byte status = 16; // Chuyển đến (2)P.QLKDTD
                dvcnt.setStatusDuyet(status);
                model.update(dvcnt);
                _session.setAttribute("confirm", DuyetThuan);
                log.setLogContent("(1)P.QLKDTD chuyển tiếp user cấp 2");
                modelLog.create(log); // create log
            }
            // User cap 2 P.QLKDTD duyet

            if (groupUserDuyet == 6) {
                if (dvcnt.getStatusDvcnt() == 2) { // DUYỆT THÀNH CÔNG EDIT ĐVCNT KO CẦN P.KTT&NHS DUYỆT
                    dvcnt.setUser2Pkhdn(UserDuyet);
                    dvcnt.setUser2PkhdnDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2PkhdnNote(ghichu);
                    Byte status = 13;
                    dvcnt.setStatusDuyet(status);
                    Byte statusDVCNT = 1;
                    dvcnt.setStatusDvcnt(statusDVCNT);
                    model.update(dvcnt);

                    TtPosTempModel modelTemp = new TtPosTempModel();
                    modelTemp.capNhatIsmappingEditBasic(_maDvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(2)P.QLKDTD duyệt edit ĐVCNT(P.KTT&NHS không cần duyệt)");
                    modelLog.create(log); // create log
                    return "redirect:danhsachdvcnt.html";
                } else {
                    dvcnt.setUser2Ptdbh(UserDuyet);
                    dvcnt.setUser2PtdbhDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2PtdbhNote(ghichu);
                    Byte status = 17; // Chuyển đến P.KTT&NHS
                    dvcnt.setStatusDuyet(status);
                    model.update(dvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(2)P.QLKDTD chuyển tiếp P.KTT&NHS");
                    modelLog.create(log); // create log
//                    String maDvcnt = (String) _session.getAttribute("_maDvcnt");
//                    return exportPDF2(request, m, maDvcnt);
                }
            }
            // User cap 1 P.KTT&NHS duyet
            if (groupUserDuyet == 7) {
                if ((dvcnt.getStatusDuyet() == 11 && (dvcnt.getStatusDvcnt() == 0
                        || dvcnt.getStatusDvcnt() == 8)) || dvcnt.getStatusDuyet() == 10) {
                    dvcnt.setUser1Ptnt(UserDuyet);
                    dvcnt.setUser1PtntDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser1PtntNote(ghichu);
                    Byte status = 12; // Gửi duyệt thông số
                    dvcnt.setStatusDuyet(status);
                    model.update(dvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(1)P.KTT&NHS chuyển tiếp user cấp 2");
                    modelLog.create(log); // create log

                    // Cap nhat thời gian USER1_TNT_DATE ở bảng TT_POS_TEMP
                    if (dvcnt.getStatusDuyet() != 11 && dvcnt.getStatusDuyet() == 12) {
                        String time = ngay_gio_duyet.substring(0, 8);
                        TtPosTempModel modelTemp = new TtPosTempModel();
//                        modelTemp.capNhatTinhTrangDangChoXuatPYC(_maDvcnt, Long.parseLong(time));
                    }
                } else {
                    dvcnt.setUser1Ptnt(UserDuyet);
                    dvcnt.setUser1PtntDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser1PtntNote(ghichu);
                    Byte status = 9; // GUI YEU CAU SANG VTB
                    dvcnt.setStatusDuyet(status);
                    model.update(dvcnt);

                    String maDvcnt = (String) _session.getAttribute("_maDvcnt");
                    String time = ngay_gio_duyet.substring(0, 8);
                    TtPosTempModel modelTemp = new TtPosTempModel();

                    DuyetThuan = "ĐVCNT: " + _maDvcnt + " => Gửi PYC sang VTB";
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(1)P.KTT&NHS gửi yêu cầu sang VTB");
                    modelLog.create(log); // create log

                    if (dvcnt.getStatusDvcnt() != 3 && dvcnt.getStatusDvcnt() != 4 && dvcnt.getStatusDvcnt() != 5) {
                        modelTemp.capNhatTinhTrangDangChoXuatPYC(maDvcnt, Long.parseLong(time));
                    }
                }
            }
            // User cap 2 P.KTT&NHS duyet
            if (groupUserDuyet == 8) {
                if (dvcnt.getStatusDvcnt() == 3) { // HOÀN TẤT EDIT THÔNG TIN
                    dvcnt.setUser2Ptnt(UserDuyet);
                    dvcnt.setUser2PtntDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2PtntNote(ghichu);
                    Byte status = 13;
                    Byte statusDvcnt = 1;
                    dvcnt.setStatusDuyet(status);
                    dvcnt.setStatusDvcnt(statusDvcnt);

                    // Trả về các cột chứa thông tin edit cũ về NULL
//                    dvcnt.setedit1(null);
//                    dvcnt.setedit2(null);
//                    dvcnt.setedit3(null);
//                    dvcnt.setedit4(null);
                    model.update(dvcnt);

                    // Reset ismapping về 1 trong bảng TT_POS_TEMP
                    TtPosTempModel modelTemp = new TtPosTempModel();
                    modelTemp.capNhatEditAdvanceNull(_maDvcnt);
                    _session.setAttribute("confirm", DuyetThuan);

                    log.setLogContent("(2)P.KTT&NHS duyệt thuận edit đvcnt: " + dvcnt.getTenDvcntVn());
                    modelLog.create(log); // create log

                    String content = "Ho so CHINH SUA THONG TIN cua DVCNT: " + dvcnt.getTenDvcntVn() + " da hoan tat nhap duyet o cac phong ban HO.\n"
                            + "Kinh de nghi A/C thuc hien som cac buoc tiep theo dung quy trinh.\n"
                            + "Thong bao tu dong, vui long khong tra loi email nay. Cam on quy A/C !\n";

                    try {
                        send_Email(email, content);
                    } catch (Exception e) {
                        System.out.println("LOI GUI MAIL: " + e.toString());
                    }

                    return "redirect:dvcntdangxuly.html";
                } else if (dvcnt.getStatusDvcnt() == 4) { // XÁC NHAN KHÓA POS => Chuyển về đơn vị để thu hồi POS
                    dvcnt.setUser2Ptnt(UserDuyet);
                    dvcnt.setUser2PtntDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2PtntNote(ghichu);
                    Byte status = 13;
                    Byte statusDvcnt = 4;
                    dvcnt.setStatusDuyet(status);
                    dvcnt.setStatusDvcnt(statusDvcnt);
                    model.update(dvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(2)P.KTT&NHS duyệt thuận yêu cầu thu hồi POS đvcnt: " + dvcnt.getTenDvcntVn());
                    modelLog.create(log); // create log

                    String content_ThuHoiPos = "Ho so THU HOI POS cua DVCNT: " + dvcnt.getTenDvcntVn() + " da hoan tat nhap duyet o cac phong ban HO.\n"
                            + "Kinh de nghi A/C thuc hien som cac buoc tiep theo dung quy trinh.\n"
                            + "Thong bao tu dong, vui long khong tra loi email nay. Cam on quy A/C !\n";

                    try {
                        send_Email(email, content_ThuHoiPos);
                    } catch (Exception e) {
                        System.out.println("LOI GUI MAIL: " + e.toString());
                    }
                    return "redirect:dvcntdangxuly.html";
                } else if (dvcnt.getStatusDvcnt() == 5) { // TẠM KHÓA ĐVCNT
//                    dvcnt.setUser2Ptnt(UserDuyet);
//                    dvcnt.setUser2PtntDate(Long.parseLong(ngay_gio_duyet));
//                    dvcnt.setUser2PtntNote(ghichu);
//                    Byte status = 13;
//                    Byte statusDvcnt = 5;
//                    dvcnt.setStatusDuyet(status);
//                    dvcnt.setStatusDvcnt(statusDvcnt);
//                    model.update(dvcnt);
//                    _session.setAttribute("confirm", DuyetThuan);
//                    log.setLogContent("(2)P.KTT&NHS duyệt thuận yêu cầu tạm khóa POS đvcnt: " + dvcnt.getTenDvcntVn());
//                    modelLog.create(log); // create log
//                    return "redirect:dvcntdangxuly.html";
                } else if (dvcnt.getStatusDvcnt() == 8) { // TNT hoàn tất thông số LẮP THÊM POS
                    dvcnt.setUser2Ptnt(UserDuyet);
                    dvcnt.setUser2PtntDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2PtntNote(ghichu);
                    Byte status = 13;
                    Byte statusDvcnt = 9; // Bàn giao thông số Lắp Thêm POS về đơn vị
                    dvcnt.setStatusDuyet(status);
                    dvcnt.setStatusDvcnt(statusDvcnt);
                    model.update(dvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(2)P.KTT&NHS duyệt thuận yêu cầu lắp thêm POS đvcnt: " + dvcnt.getTenDvcntVn());
                    modelLog.create(log); // create log

                    String content_LapThemPos = "Ho so LAP THEM POS, DVCNT: " + dvcnt.getTenDvcntVn() + " da hoan tat nhap duyet o cac phong ban HO.\n"
                            + "Kinh de nghi A/C thuc hien som cac buoc tiep theo dung quy trinh.\n"
                            + "Thong bao tu dong, vui long khong tra loi email nay. Cam on quy A/C !\n";

                    try {
                        send_Email(email, content_LapThemPos);
                    } catch (Exception e) {
                        System.out.println("LOI GUI MAIL: " + e.toString());
                    }
                    return "redirect:dvcntdangxuly.html";
                } else {
                    dvcnt.setUser2Ptnt(UserDuyet);
                    dvcnt.setUser2PtntDate(Long.parseLong(ngay_gio_duyet));
                    dvcnt.setUser2PtntNote(ghichu);
                    Byte status = 13; // Hoàn tất tạo thông số
                    dvcnt.setStatusDuyet(status);
                    model.update(dvcnt);
                    TtPosTempModel posTempModel = new TtPosTempModel();
                    posTempModel.updateIssMappingBang_1(_maDvcnt);
                    _session.setAttribute("confirm", DuyetThuan);
                    log.setLogContent("(2)P.KTT&NHS duyệt thông số ĐVCNT: " + dvcnt.getTenDvcntVn());
                    modelLog.create(log); // create log

                    try {
                        content_TaoMoiDvcnt = "Ho so DVCNT: " + dvcnt.getTenDvcntVn() + " da hoan tat nhap duyet o cac phong ban HO.\n\n"
                                + "Kinh de nghi A/C thuc hien som cac buoc tiep theo dung quy trinh.\n\n"
                                + "Thong bao tu dong, vui long khong tra loi email nay. Cam on quy A/C !\n\n";
                        send_Email(email, content_TaoMoiDvcnt);
                    } catch (Exception e) {
                        System.out.println("LOI GUI MAIL: " + e.toString());
                    }
                    return "redirect:dvcntdangxuly.html";
                }
            }
        }

        // TRẢ VỀ ĐƠN VỊ , 
        if (request.getParameter("fail") != null) {
            // User cap 2 CN/PGD duyet
            if (groupUserDuyet == 2) {
                dvcnt.setUser2Cn(UserDuyet);
                dvcnt.setUser2CnDate(Long.parseLong(ngay_gio_duyet));
                dvcnt.setUser2CnNote(ghichu);
                Byte status = 0; // Không hợp lệ -> trả về đơn vị xử lý
                dvcnt.setStatusDuyet(status);
                model.update(dvcnt);
            }
            // User cap 1 P.SP&CS KHDN duyet
            if (groupUserDuyet == 3) {
                dvcnt.setUser1Pkhdn(UserDuyet);
                dvcnt.setUser1PkhdnDate(Long.parseLong(ngay_gio_duyet));
                dvcnt.setUser1PkhdnNote(ghichu);
                Byte status = 0; // Không hợp lệ -> trả về đơn vị xử lý
                dvcnt.setStatusDuyet(status);
                model.update(dvcnt);
            }
            // User cap 2 P.SP&CS KHDN duyet
            if (groupUserDuyet == 4) {
                dvcnt.setUser2Pkhdn(UserDuyet);
                dvcnt.setUser2PkhdnDate(Long.parseLong(ngay_gio_duyet));
                dvcnt.setUser2PkhdnNote(ghichu);
                Byte status = 0; // Không hợp lệ -> trả về đơn vị xử lý
                dvcnt.setStatusDuyet(status);

                // Reset tat ca USER, NGAYDUYET, GHICHU về null
                dvcnt.setUser2Cn("");
                dvcnt.setUser2CnNote("");
                dvcnt.setUser2CnDate(null);

                dvcnt.setUser1Pkhdn("");
                dvcnt.setUser1PkhdnNote("");
                dvcnt.setUser1PkhdnDate(null);

                dvcnt.setUser2Pkhdn("");
                dvcnt.setUser2PkhdnNote("");
                dvcnt.setUser2PkhdnDate(null);

                dvcnt.setUser1Ptdbh("");
                dvcnt.setUser1PtdbhNote("");
                dvcnt.setUser1PtdbhDate(null);

                dvcnt.setUser2Ptdbh("");
                dvcnt.setUser2PtdbhNote("");
                dvcnt.setUser2PtdbhDate(null);

                dvcnt.setUser1Ptnt("");
                dvcnt.setUser1PtntNote("");
                dvcnt.setUser1PtntDate(null);

                dvcnt.setUser2Ptnt("");
                dvcnt.setUser2PtntNote("");
                dvcnt.setUser2PtntDate(null);

                model.update(dvcnt);
            }
            // PHONG KHACH HANG CA NHAN
            // User cap 1 P.QLKDTD
            if (groupUserDuyet == 5) {
                dvcnt.setUser1Ptdbh(UserDuyet);
                dvcnt.setUser1PtdbhDate(Long.parseLong(ngay_gio_duyet));
                dvcnt.setUser1PtdbhNote(ghichu);
                Byte status = 0; // Không hợp lệ -> trả về đơn vị xử lý
                dvcnt.setStatusDuyet(status);

                // Reset tat ca USER, NGAYDUYET, GHICHU về null
                dvcnt.setUser2Cn("");
                dvcnt.setUser2CnNote("");
                dvcnt.setUser2CnDate(null);

                dvcnt.setUser1Pkhdn("");
                dvcnt.setUser1PkhdnNote("");
                dvcnt.setUser1PkhdnDate(null);

                dvcnt.setUser2Pkhdn("");
                dvcnt.setUser2PkhdnNote("");
                dvcnt.setUser2PkhdnDate(null);

                dvcnt.setUser1Ptdbh("");
                dvcnt.setUser1PtdbhNote("");
                dvcnt.setUser1PtdbhDate(null);

                dvcnt.setUser2Ptdbh("");
                dvcnt.setUser2PtdbhNote("");
                dvcnt.setUser2PtdbhDate(null);

                dvcnt.setUser1Ptnt("");
                dvcnt.setUser1PtntNote("");
                dvcnt.setUser1PtntDate(null);

                dvcnt.setUser2Ptnt("");
                dvcnt.setUser2PtntNote("");
                dvcnt.setUser2PtntDate(null);

                model.update(dvcnt);
            }
            // User cap 2 P.QLKDTD
            if (groupUserDuyet == 6) {
                dvcnt.setUser2Ptdbh(UserDuyet);
                dvcnt.setUser2PtdbhDate(Long.parseLong(ngay_gio_duyet));
                dvcnt.setUser2PtdbhNote(ghichu);
                Byte status = 0; // Không hợp lệ -> trả về đơn vị xử lý
                dvcnt.setStatusDuyet(status);

                // Reset tat ca USER, NGAYDUYET, GHICHU về null
                dvcnt.setUser2Cn("");
                dvcnt.setUser2CnNote("");
                dvcnt.setUser2CnDate(null);

                dvcnt.setUser1Pkhdn("");
                dvcnt.setUser1PkhdnNote("");
                dvcnt.setUser1PkhdnDate(null);

                dvcnt.setUser2Pkhdn("");
                dvcnt.setUser2PkhdnNote("");
                dvcnt.setUser2PkhdnDate(null);

                dvcnt.setUser1Ptdbh("");
                dvcnt.setUser1PtdbhNote("");
                dvcnt.setUser1PtdbhDate(null);

                dvcnt.setUser2Ptdbh("");
                dvcnt.setUser2PtdbhNote("");
                dvcnt.setUser2PtdbhDate(null);

                dvcnt.setUser1Ptnt("");
                dvcnt.setUser1PtntNote("");
                dvcnt.setUser1PtntDate(null);

                dvcnt.setUser2Ptnt("");
                dvcnt.setUser2PtntNote("");
                dvcnt.setUser2PtntDate(null);

                model.update(dvcnt);
            }
            // User cap 1 P.KTT&NHS duyet
            if (groupUserDuyet == 7) {
                dvcnt.setUser1Ptnt(UserDuyet);
                dvcnt.setUser1PtntDate(Long.parseLong(ngay_gio_duyet));
                dvcnt.setUser1PtntNote(ghichu);
                Byte status = 0; // Không hợp lệ -> trả về đơn vị xử lý
                dvcnt.setStatusDuyet(status);

                // Reset tat ca USER, NGAYDUYET, GHICHU về null
                dvcnt.setUser2Cn("");
                dvcnt.setUser2CnNote("");
                dvcnt.setUser2CnDate(null);

                dvcnt.setUser1Pkhdn("");
                dvcnt.setUser1PkhdnNote("");
                dvcnt.setUser1PkhdnDate(null);

                dvcnt.setUser2Pkhdn("");
                dvcnt.setUser2PkhdnNote("");
                dvcnt.setUser2PkhdnDate(null);

                dvcnt.setUser1Ptdbh("");
                dvcnt.setUser1PtdbhNote("");
                dvcnt.setUser1PtdbhDate(null);

                dvcnt.setUser2Ptdbh("");
                dvcnt.setUser2PtdbhNote("");
                dvcnt.setUser2PtdbhDate(null);

                dvcnt.setUser1Ptnt("");
                dvcnt.setUser1PtntNote("");
                dvcnt.setUser1PtntDate(null);

                dvcnt.setUser2Ptnt("");
                dvcnt.setUser2PtntNote("");
                dvcnt.setUser2PtntDate(null);

                model.update(dvcnt);
            }
            // 2(P.KTT&NHS)
            if (groupUserDuyet == 8) {
                Byte status = 10; // Trả về [1]P.KTT&NHS để chỉnh sửa thông số
                dvcnt.setStatusDuyet(status);
                model.update(dvcnt);

                TtPosTempModel modelPosTemp = new TtPosTempModel();
                modelPosTemp.updateIssMappingBangTru_1(_maDvcnt);

                _session.setAttribute("confirm", "Trả hồ sơ về (1)P.KTT&NHS");
                return "redirect:dvcntdangxuly.html";
            }
            log.setLogContent("Trả hồ sơ về đơn vị");
            modelLog.create(log); // create log
        }
        return "redirect:dvcntdangxuly.html";
    }

    // Gửi duyệt trực tiếp từ trang dvcntdangxuly => Chỉ user 1 P.KTT&NHS thấy
    @RequestMapping(value = "/chuyentiep", method = RequestMethod.GET)
    public String chuyentiep(@RequestParam(value = "id", required = false) String id, Model m, @ModelAttribute(value = "_duyetdvcnt") TtDvcntLive p, HttpServletRequest request) throws AddressException {
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = model.getTtDvcnt(id);

        String UserDuyet = (String) _session.getAttribute("mauser");
        Byte groupUserDuyet = (Byte) _session.getAttribute("groupuser");

        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countByIsMappingBangTru1(id);
        //int soluongdagan = modelTemp.countByIsMappingBangTru1(id);

        // Số lượng POS đã đăng ký
//        TtDvcntModel modelDvcnt = new TtDvcntModel();
//        TtDvcntLive ttdvcnt = new TtDvcntLive();
//        ttdvcnt = modelDvcnt.getTtDvcnt(id);
        int statusDvcnt = dvcnt.getStatusDvcnt();
        if (statusDvcnt == 8) {
            int soLuongDangKyLapThem = dvcnt.getSllapthem();
            int posThemMoiDaMap = modelTemp.countByIsMappingBang3(_maDvcnt);
            if (soLuongDangKyLapThem != posThemMoiDaMap) {
                _session.setAttribute("confirm", "Chưa gán đủ thông số !");
                return _getAll(m, request);
            }
        } else {
            int soluongPosDaDangKy = dvcnt.getSlpos();
            if (soluongdagan < soluongPosDaDangKy) {
                _session.setAttribute("confirm", "Chưa gán đủ thông số !");
                return _getAll(m, request);
            }
        }

        if (null == dvcnt.getFileMapping() || dvcnt.getFileMapping().equals("")) {
            _session.setAttribute("confirm", " Gửi duyệt không thành công: Chưa upload file thông số !");
            return _getAll(m, request);
        }

        // User cap 1 P.KTT&NHS duyet
        if (groupUserDuyet == 7) {
            if ((dvcnt.getStatusDuyet() == 11 && (dvcnt.getStatusDvcnt() == 0 || dvcnt.getStatusDvcnt() == 8)) || dvcnt.getStatusDuyet() == 10) {
                dvcnt.setUser1Ptnt(UserDuyet);
                dvcnt.setUser1PtntDate(get_SystemTime());
                Byte status = 12; // Gửi duyệt thông số
                dvcnt.setStatusDuyet(status);
                model.update(dvcnt);
                String info = "Đã gửi duyệt ĐVCNT " + dvcnt.getMaDvcnt();
                _session.setAttribute("confirm", info);
                modelTemp.updateIssMappingBang6(id); // Cap nhat ismapping = 6: POS đã map nhưng (2)P.KTT&NHS chua duyet

                // GHI LOG
                TtLogDvcntModel modelLog = new TtLogDvcntModel();
                TtLogDvcnt log = new TtLogDvcnt();
                log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
                log.setLogLevel((Byte) _session.getAttribute("groupuser"));
                log.setLogTime(get_SystemTime());
                log.setLogMid(id);
                log.setLogContent("(1)P.KTT&NHS chuyển tiếp user cấp 2");
                modelLog.create(log); // create log

                // Cap nhat thời gian USER1_TNT_DATE ở bảng TT_POS_TEMP
                if (dvcnt.getStatusDuyet() != 11 && dvcnt.getStatusDuyet() == 12) {
                    //TtPosTempModel modelTemp = new TtPosTempModel();
//                        modelTemp.capNhatTinhTrangDangChoXuatPYC(_maDvcnt, Long.parseLong(time));
                }
            }
        }
        return "redirect:dvcntdangxuly.html";
    }

    // Update ĐVCNT
    @RequestMapping(value = "/updatedvcnt", method = RequestMethod.POST,
            produces = "application/x-www-form-urlencoded;charset=UTF-8")
    public String updateDVCNT(@ModelAttribute(value = "_updatedvcnt") TtDvcntLive p,
            HttpServletRequest request, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        _session = request.getSession();

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p1 = new TtDvcntLive();
        p1 = model.getTtDvcnt(p.getMaDvcnt());

        String fileupload1 = p1.getFileUpload();
        p.setFileUpload(fileupload1);

        p.setGpdkkdNgaycap(static_gpdkkdNgaycap);
        p.setGpdkkdNgaycapCmnd(static_gpdkkdNgaycapCmnd);
        p.setNgaycapCmndHopdong(static_ngaycapCmndHopdong);
        p.setNgayUyquyen(static_ngayUyquyen);
        p.setCnQuanly((String) _session.getAttribute("macn"));

        p.setGpdkkdNgaycap(p1.getGpdkkdNgaycap());
        p.setGpdkkdNgaycapCmnd(p1.getGpdkkdNgaycapCmnd());
        p.setNgaycapCmndHopdong(p1.getNgaycapCmndHopdong());
        p.setNgayUyquyen(p1.getNgayUyquyen());

        String doanhsodukien = request.getParameter("_doanhsothanhtoandukien");
        String _doanhsodukien = doanhsodukien.replaceAll(",", "");
        p.setDoanhsothanhtoandukien(Long.parseLong(_doanhsodukien));

        Byte tinhtrang = 0;
        p.setStatusDvcnt(tinhtrang);
        Byte tinhtrangduyet = 1;
        p.setStatusDuyet(tinhtrangduyet);

        String maUser = (String) _session.getAttribute("mauser");
        p.setUser1Cn(maUser);

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);
        long user1DonviNgaynhap = Long.parseLong(ngay_gio_nhap);
        p.setUser1CnNgaynhap(user1DonviNgaynhap);

        if (request.getParameter("paxS90") == null && request.getParameter("paxS78") == null
                && request.getParameter("paxP70s") == null && request.getParameter("paxP80") == null
                && request.getParameter("pax78") == null && request.getParameter("vx520") == null) {
            String dongmay_dexuat = request.getParameter("_dongmayDexuat");
            p.setDongmayDexuat(dongmay_dexuat);
        } else {
            String dongmay1 = request.getParameter("paxS90");
            String dongmay2 = request.getParameter("paxS78");
            String dongmay3 = request.getParameter("paxP70s");
            String dongmay4 = request.getParameter("paxP80");
            String dongmay5 = request.getParameter("pax78");
            String dongmay6 = request.getParameter("vx520");

            if (request.getParameter("paxS90") == null) {
                dongmay1 = "";
            }
            if (request.getParameter("paxS78") == null) {
                dongmay2 = "";
            }
            if (request.getParameter("paxP70s") == null) {
                dongmay3 = "";
            }
            if (request.getParameter("paxP80") == null) {
                dongmay4 = "";
            }
            if (request.getParameter("pax78") == null) {
                dongmay5 = "";
            }
            if (request.getParameter("vx520") == null) {
                dongmay6 = "";
            }

            String dongmay_dexuat = "";
            if (!dongmay1.equals("")) {
                dongmay_dexuat = dongmay1 + " - ";
            }
            if (!dongmay2.equals("")) {
                dongmay_dexuat = dongmay_dexuat + dongmay2 + " - ";
            }
            if (!dongmay3.equals("")) {
                dongmay_dexuat = dongmay_dexuat + dongmay3 + " - ";
            }
            if (!dongmay4.equals("")) {
                dongmay_dexuat = dongmay_dexuat + dongmay4 + " - ";
            }
            if (!dongmay5.equals("")) {
                dongmay_dexuat = dongmay_dexuat + dongmay5 + " - ";
            }
            if (!dongmay6.equals("")) {
                dongmay_dexuat = dongmay_dexuat + dongmay6;
            }
            p.setDongmayDexuat(dongmay_dexuat);
        }
        String diachiDvcnt = request.getParameter("diaChiDvcnt");
        p.setDiachiDvcnt(diachiDvcnt);
        model.update(p);
        String confirm = "Cập nhật thông tin thành công !";
        _session.setAttribute("confirm", confirm);

        return "redirect:dvcntdangxuly.html";
    }

    // Định dạng dữ liệu thời gian
    public String formatTime(String n) {
        String kq = n;
        int temp = Integer.parseInt(n);
        if (temp >= 1 && temp <= 9) {
            kq = "0" + String.valueOf(temp);
        }
        return kq;
    }

    public static String _formatTime(int n) {
        String temp = String.valueOf(n);
        if (n >= 1 && n <= 9) {
            temp = "0" + String.valueOf(n);
        }
        return temp;
    }
// Tim kiem trong dvcntdangxuly

    @RequestMapping(value = "/search-dvcnt-by-keyword", method = RequestMethod.GET)
    public String searchPOSByKeyWord(Model m, HttpServletRequest request) {
        _session = request.getSession();

        String searchCbb = request.getParameter("key-search");
        String txtsearchCbb = request.getParameter("txtsearch");
        m.addAttribute("keysearchbasic", searchCbb);
        m.addAttribute("txtsearchbasic", txtsearchCbb);
        TtDvcntModel model = new TtDvcntModel();

        if (!txtsearchCbb.equals("") || (request.getParameter("txtsearch") != null)) {
            if (searchCbb.equals("1")) {
                m.addAttribute("txtsearchbasic", "");
                _getAll(m, request);
            }
            if (searchCbb.equals("2")) {
                m.addAttribute("lstThemMoi", model.getListDsDvctDaLap_byMaDvcnt(txtsearchCbb));
            }
            if (searchCbb.equals("3")) {
                m.addAttribute("lstThemMoi", model.getListBySoGpkd(txtsearchCbb));
            }
            if (searchCbb.equals("4")) {
                m.addAttribute("lstThemMoi", model.getListByCNQuanLy(txtsearchCbb));
            }
            if (searchCbb.equals("5")) {
                m.addAttribute("lst", model.getListDoanhNghiep());
            }
            if (searchCbb.equals("6")) {
                m.addAttribute("lst", model.getListHoKinhDoanh());
            }
            if (searchCbb.equals("7")) {
                m.addAttribute("lstThemMoi", model.getListTheoTenDvcnt(txtsearchCbb));
            }
        }
        return "dvcntdangxuly";
    }

    @RequestMapping(value = "/xoadvcntdangxuly", method = RequestMethod.GET)
    public String xoadvcntdangxuly(@RequestParam(value = "id", required = false) String id, Model m, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);
        if (p == null) {
            return "redirect:dvcntdangxuly.html";
        }

        String tenDvcnt = p.getTenDvcntVn();

        // Xóa ĐVCNT đang tạo mới chưa đc user cấp 2 CN/PGD duyệt
        p.setStatusDuyet(Byte.parseByte("-1"));
        p.setStatusDvcnt(Byte.parseByte("10"));
        model.update(p);

        String confirm = "Đã xóa ĐVCNT " + id + " - " + tenDvcnt;
        m.addAttribute("confirm", confirm);

        m.addAttribute("lstThemMoi", model.getAll());
//        m.addAttribute("lstThemMoi", model.getListDvcntDangXuLyThemMoi());
        m.addAttribute("lstChinhSua1", model.getListDvcntDangChinhSua1()); // CHINH SUA KO CAN P.KTT&NHS DUYET
        m.addAttribute("lstChinhSua2", model.getListDvcntDangChinhSua2()); // CHINH SUA CAN P.KTT&NHS DUYET

        m.addAttribute("lstTamKhoa", model.getListDvcntTamKhoa()); // KHOA DVCNT
        m.addAttribute("soluongtamkhoa", model.getListDvcntTamKhoa().size());

        m.addAttribute("lstDong", model.getListDvcntDong()); // CLOSE DVCNT
        m.addAttribute("soluongDong", model.getListDvcntDong().size());

        m.addAttribute("lstLapThemPos", model.getListDvcntLapThemPos()); // DVCNT THEM MOI
        m.addAttribute("soluongDvcntLapthemPos", model.getListDvcntLapThemPos().size());
        return "dvcntdangxuly";
    }

    // Tim kiem trong danhsachdvcnt
    @RequestMapping(value = "/searchcombobox", method = RequestMethod.GET)
    public String danhsachdvcnt(Model m, HttpServletRequest request) {
        _session = request.getSession();

        String searchCbb = request.getParameter("dieukiensearchbasic");
        String txtsearchCbb = request.getParameter("txtTimKiem");
        m.addAttribute("keysearchbasic", searchCbb);
        m.addAttribute("txtsearchbasic", txtsearchCbb);
        TtDvcntModel model = new TtDvcntModel();

        if (!txtsearchCbb.equals("") || (request.getParameter("txtTimKiem") != null)) {
            if (searchCbb.equals("0")) {
                m.addAttribute("txtsearchbasic", "");
                m.addAttribute("lst", model.getAll());
            }
            if (searchCbb.equals("1")) {
                m.addAttribute("lst", model.getListDsDvctDaLap_byMaDvcnt(txtsearchCbb));
            }
            if (searchCbb.equals("2")) {
                m.addAttribute("lst", model.getListDsDvctDaLap_bySoGPDKKD(txtsearchCbb));
            }
            if (searchCbb.equals("3")) {
                m.addAttribute("lst", model.getListDsDvctDaLap_byCNQuanLy(txtsearchCbb));
            }
            if (searchCbb.equals("4")) {
                Byte doanhnghiep = 2;
                m.addAttribute("lst", model.getListDsDvctDaLap_loaihinhDvcnt(doanhnghiep));
            }
            if (searchCbb.equals("5")) {
                Byte doanhnghiep = 1;
                m.addAttribute("lst", model.getListDsDvctDaLap_loaihinhDvcnt(doanhnghiep));
            }
        }
        return "danhsachdvcnt";
    }

    // USER 1 CN/PGD XÁC NHẬN ĐÃ NHẬN BÀN GIAO CHO ĐƠN VỊ
    @RequestMapping(value = "xacnhanbangiao", method = RequestMethod.GET)
    public String xacNhanBanGiaoDVCNT(HttpServletRequest request, Model m) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = model.getTtDvcnt(_maDvcnt);
        Byte tinhTrangDuyet = dvcnt.getStatusDuyet();

        String statusDvcnt = String.valueOf(dvcnt.getStatusDvcnt());
        if (statusDvcnt.equals("0")) {
            String bbbg_themmoi = String.valueOf(dvcnt.getBbbgThemmoi());
            if (bbbg_themmoi.equals("null")) {
                m.addAttribute("checkUploadBBBG", "Chưa upload biên bản bàn giao !");
                return chiTietDvcntDaLap(m, _maDvcnt, request);
            }
        }

        Byte groupuser = (Byte) _session.getAttribute("groupuser");

        if (groupuser == 1 && tinhTrangDuyet == 13) {
            Byte status = 1; // Đã lắp đặt POS cho ĐVCNT.
            dvcnt.setStatusDvcnt(status);

            Byte sllapthem = 0;
            dvcnt.setSllapthem(sllapthem);
            model.update(dvcnt);

            //
            String userThucHien = String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", "");
            TtPosTempModel modelTemp = new TtPosTempModel();
            modelTemp.capNhatPosLapThemQuaBangTT_POS(_maDvcnt, userThucHien);

            // GHI LOG
            TtLogDvcntModel modelLog = new TtLogDvcntModel();
            TtLogDvcnt log = new TtLogDvcnt();
            log.setLogUser(userThucHien);
            log.setLogLevel((Byte) _session.getAttribute("groupuser"));
            log.setLogTime(get_SystemTime());
            log.setLogMid(_maDvcnt);
            log.setLogContent("(1)CN/PGD xác nhận hoàn tất hồ sơ đvcnt: " + dvcnt.getTenDvcntVn());
            modelLog.create(log); // create log
        } else {
            return "redirect:dvcntdangxuly.html";
        }

        String error = "Đã hoàn tất hồ sơ ĐVCNT " + _maDvcnt;
        _session.setAttribute("error", error);

        return "redirect:danhsachdvcnt1.html";
    }

    // USER 1 CN/PGD XÁC NHẬN ĐÃ NHẬN THU HỒI POS
    @RequestMapping(value = "xacnhanthuhoipos", method = RequestMethod.GET)
    public String xacNhanThuHoiPos(HttpServletRequest request, Model m) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        _maDvcnt = (String) _session.getAttribute("_maDvcnt");
        dvcnt = model.getTtDvcnt(_maDvcnt);

        Byte tinhTrangDuyet = dvcnt.getStatusDuyet();
        Byte tinhTrangDvcnt = dvcnt.getStatusDvcnt();
        Byte groupuser = (Byte) _session.getAttribute("groupuser");

        String confirm = "Đã xử lý ĐVCNT " + _maDvcnt;
        _session.setAttribute("confirm", confirm);
        _session.setAttribute("error", confirm);

        // Trường hợp thu hồi pos
        if (groupuser == 1 && tinhTrangDuyet == 13 && (tinhTrangDvcnt == 4)) {
            TtPosModel modelPos = new TtPosModel();
            LocalDateTime now = LocalDateTime.now();
            int year = now.getYear();
            int month = now.getMonthValue();
            int day = now.getDayOfMonth();
            String ngay_gio_nhap = "";
            ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day);
            int user1DonviNgaynhap = Integer.parseInt(ngay_gio_nhap);
            modelPos.update_thuhoiPos(_maDvcnt, user1DonviNgaynhap);

            //TtPosTempModel modelTemp = new TtPosTempModel();
            // modelTemp.update_thuhoiPosTemp(_maDvcnt);
            Byte status = 1; // đã khóa
            dvcnt.setStatusDvcnt(status);
            model.update(dvcnt);
        }
//        if (groupuser == 1 && tinhTrangDuyet == 13 && (tinhTrangDvcnt == 5)) {
//            TtPosModel modelPos = new TtPosModel();
//            modelPos.update_TamKhoa_Pos(_maDvcnt);
//            Byte status = 1; // đã tạm khóa POS, không khóa ĐVCNT
//            dvcnt.setStatusDvcnt(status);
//            model.update(dvcnt);
//        } else {
//            return "redirect:dvcntdangxuly.html";
//        }
        return "redirect:danhsachdvcnt.html";
    }

    // User 1 CN/PGD hoan tat edit POS
    @RequestMapping(value = "hoantat_editpos", method = RequestMethod.GET)
    public String update_HoanTatEditPos(HttpServletRequest request, Model m) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        _maDvcnt = (String) _session.getAttribute("_maDvcnt");
        dvcnt = model.getTtDvcnt(_maDvcnt);
        Byte tinhTrangDuyet = dvcnt.getStatusDuyet();
        Byte tinhTrangDvcnt = dvcnt.getStatusDvcnt();
        Byte groupuser = (Byte) _session.getAttribute("groupuser");

        String confirm = "Đã xử lý ĐVCNT " + _maDvcnt;
        _session.setAttribute("confirm", confirm);
        _session.setAttribute("error", confirm);

        if (groupuser == 1 && tinhTrangDuyet == 13 && (tinhTrangDvcnt == 2)) {
            TtPosTempModel modelPos = new TtPosTempModel();
            modelPos.update_HoanTatEditPos(_maDvcnt);

            //TtPosTempModel modelTemp = new TtPosTempModel();
            // modelTemp.update_thuhoiPosTemp(_maDvcnt);
            Byte status = 1; // đã khóa
            dvcnt.setStatusDvcnt(status);
            model.update(dvcnt);
        }
//        if (groupuser == 1 && tinhTrangDuyet == 13 && (tinhTrangDvcnt == 5)) {
//            TtPosModel modelPos = new TtPosModel();
//            modelPos.update_TamKhoa_Pos(_maDvcnt);
//            Byte status = 1; // đã tạm khóa POS, không khóa ĐVCNT
//            dvcnt.setStatusDvcnt(status);
//            model.update(dvcnt);
//        } else {
//            return "redirect:dvcntdangxuly.html";
//        }
        return "redirect:danhsachdvcnt.html";
    }

    // LẮP THÊM POS CHO ĐVCNT ĐÃ LẮP ĐẶT POS CỦA SCB
    @RequestMapping(value = "lapthempos", method = RequestMethod.GET)
    public String lapThemPos(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();
        _session.removeAttribute("error");

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        _session.setAttribute("mid", id);
        m.addAttribute("_id", id);
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = model.getTtDvcnt(id);

        String nguoidaidien = dvcnt.getGpdkkdTennguoidaidien();
        String gpdkkd = dvcnt.getGpdkkdso();
        String cmndNguoiDaiDien = dvcnt.getGpdkkdCmnd();
        String diachi = dvcnt.getDiachiDvcnt();

        _session.setAttribute("nguoidaidien_lapthempos", nguoidaidien);
        _session.setAttribute("gpdkkd_lapthempos", gpdkkd);
        _session.setAttribute("cmndNguoiDaiDien_lapthempos", cmndNguoiDaiDien);
        _session.setAttribute("diachi_lapthempos", diachi);

        m.addAttribute("tendvcnt", dvcnt.getTenDvcntVn());
        Byte soluonglapthem = dvcnt.getSllapthem();
        _session.setAttribute("soluonglapthem", soluonglapthem);
        if (soluonglapthem == null) {
            soluonglapthem = 0;
        }
        _session.setAttribute("soluonglapthem", soluonglapthem);

        // Load lên danh sách POS đã lắp
        TtPosModel modelPos = new TtPosModel();
        int soLuongPosDaLap = modelPos.countPOSByMid(id);
        m.addAttribute("soluongdalap", soLuongPosDaLap);
        _session.setAttribute("listPosDaLap", modelPos.getListPosByIdDVCNT(String.valueOf(_session.getAttribute("mid"))));

        // Load danh sach thông tin POS_TEMP vừa đc thêm mới.
        TtPosTempModel modelTemp = new TtPosTempModel();
        _session.setAttribute("listPosThemMoi", modelTemp.getDSPOSThemMoi(id));

        return "lapthempos";
    }

    // LẮP THÊM POS CHO ĐVCNT ĐÃ LẮP ĐẶT POS CỦA SCB
    @RequestMapping(value = "same", method = RequestMethod.GET)
    public String same(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        TtPosModel model = new TtPosModel();
        TtPosLive pos = new TtPosLive();
        String maPos = model.getPosBySeriNo(id);
        pos = model.getTtPos(maPos);

        String loaitien = (String) pos.getLoaitien();
        String dongmay = pos.getDongmay();
        String teninhoadon = pos.getTeninhoadon();
        String soTktgtt = pos.getSoTktgtt();
        String tenChuTaiKhoan = pos.getTenchutk();
        String diaChiLapDat = pos.getDiachiLapdat();
        Byte gddb1 = pos.getGddb1();
        Byte gddb2 = pos.getGddb2();
        Byte gddb3 = pos.getGddb3();
        Byte gddb4 = pos.getGddb4();
        Byte gddb5 = pos.getGddb5();
        Byte gddb6 = pos.getGddb6();
        Byte gddb7 = pos.getGddb7();
        Byte gddb8 = pos.getGddb8();
        Byte gddb9 = pos.getGddb9();

        String str_hanmucvnd = String.valueOf(pos.getHanmucVnd());
        long hanmucvnd = 0;
        if (str_hanmucvnd == "null") {
            hanmucvnd = 0;
        } else {
            hanmucvnd = pos.getHanmucVnd();
        }

        String str_hanmucusd = String.valueOf(pos.getHanmucUsd());
        long hanmucusd = 0;
        if (str_hanmucusd == "null") {
            hanmucusd = 0;
        } else {
            hanmucusd = pos.getHanmucUsd();;
        }

        String str_phiMoto = String.valueOf(pos.getPhimo());
        long phiMoto = 0;
        if (str_phiMoto == "null") {
            phiMoto = 0;
        } else {
            phiMoto = pos.getPhimo();;
        }

        String ghichu = pos.getGhichu();

        m.addAttribute("loaitien", loaitien);
        m.addAttribute("dongmay", dongmay);
        m.addAttribute("teninhoadon", teninhoadon);
        m.addAttribute("soTktgtt", soTktgtt);
        m.addAttribute("tenChuTaiKhoan", tenChuTaiKhoan);
        m.addAttribute("diaChiLapDat", diaChiLapDat);
        m.addAttribute("gddb1", gddb1);
        m.addAttribute("gddb2", gddb2);
        m.addAttribute("gddb3", gddb3);
        m.addAttribute("gddb4", gddb4);
        m.addAttribute("gddb5", gddb5);
        m.addAttribute("gddb6", gddb6);
        m.addAttribute("gddb7", gddb7);
        m.addAttribute("gddb8", gddb8);
        m.addAttribute("gddb9", gddb9);
        m.addAttribute("phiMoto", phiMoto);
        m.addAttribute("hanmucvnd", hanmucvnd);
        m.addAttribute("hanmucusd", hanmucusd);
        m.addAttribute("ghichu", ghichu);

        String mid = String.valueOf(_session.getAttribute("mid"));
        _session.setAttribute("_id", mid);

        return lapThemPos(request, m, mid);
    }

    // Xử lý lắp thêm POS cho ĐVCNT đã lắp
    @RequestMapping(value = "/xulylapthempos", method = RequestMethod.GET)
    public String xuLyLapThemPos(Model m, HttpServletRequest request) {
        _session = request.getSession();

        String Mid = request.getParameter("maDvcnt");
        _session.setAttribute("_maDvcnt", Mid);
        _session.setAttribute("_id", Mid);

        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive posTemp = new TtPosTempLive();

        int SLDangKyLapThem = Integer.parseInt(request.getParameter("soluonglapthem"));
        //Byte SLDangKyLapThem = (Byte) _session.getAttribute("soluonglapthem");

        if (SLDangKyLapThem == 0) { // Nếu user nhập SL lắp thêm bằng 0 thì return lập tức
            return lapThemPos(request, m, Mid);
        } else {
            int soluongdanhap = 0;
            soluongdanhap = model.countPosThemMoi(Mid);

            if (soluongdanhap >= SLDangKyLapThem) {
                String error = "Đã nhập đủ " + SLDangKyLapThem + " thiết bị cho ĐVCNT " + Mid;
                m.addAttribute("error", error);
                return lapThemPos(request, m, Mid);
            } else {
                String tenDvcnt = request.getParameter("tenDvcnt");
                String soTktgtt = request.getParameter("soTktgtt");
                String tenchutk = request.getParameter("tenchutk");
                String dongmay = request.getParameter("dongmay");
                String teninhoadon = request.getParameter("teninhoadon");
                String diachiLapdat = request.getParameter("diachiLapdat");
                String loaitien = request.getParameter("loaitien");

                Byte gddb1, gddb2, gddb3, gddb4, gddb5, gddb6, gddb7, gddb8, gddb9;

                if (request.getParameter("gddb1") == null) {
                    gddb1 = 0;
                } else {
                    gddb1 = Byte.parseByte(request.getParameter("gddb1"));
                }

                if (request.getParameter("gddb2") == null) {
                    gddb2 = 0;
                } else {
                    gddb2 = Byte.parseByte(request.getParameter("gddb2"));
                }

                if (request.getParameter("gddb3") == null) {
                    gddb3 = 0;
                } else {
                    gddb3 = Byte.parseByte(request.getParameter("gddb3"));
                }

                if (request.getParameter("gddb4") == null) {
                    gddb4 = 0;
                } else {
                    gddb4 = Byte.parseByte(request.getParameter("gddb4"));
                }

                if (request.getParameter("gddb5") == null) {
                    gddb5 = 0;
                } else {
                    gddb5 = Byte.parseByte(request.getParameter("gddb5"));
                }

                if (request.getParameter("gddb6") == null) {
                    gddb6 = 0;
                } else {
                    gddb6 = Byte.parseByte(request.getParameter("gddb6"));
                }

                if (request.getParameter("gddb7") == null) {
                    gddb7 = 0;
                } else {
                    gddb7 = Byte.parseByte(request.getParameter("gddb7"));
                }

                if (request.getParameter("gddb8") == null) {
                    gddb8 = 0;
                } else {
                    gddb8 = Byte.parseByte(request.getParameter("gddb8"));
                }

                if (request.getParameter("gddb9") == null) {
                    gddb9 = 0;
                } else {
                    gddb9 = Byte.parseByte(request.getParameter("gddb9"));
                }

                String str_tienkyquyMoto = request.getParameter("tienkyquyMoto");
                String str_hanmucVnd = request.getParameter("hanmucVnd");
                String str_hanmucUsd = request.getParameter("hanmucUsd");

                long tienkyquyMoto = 0;
                long hanMucVND = 0;
                long hanMucUSD = 0;

                if (str_tienkyquyMoto.equals("")) {
                    str_tienkyquyMoto = "0";
                    tienkyquyMoto = Long.parseLong(str_tienkyquyMoto);
                } else {
                    tienkyquyMoto = Long.parseLong(str_tienkyquyMoto);
                }

                if (str_hanmucVnd.equals("")) {
                    str_hanmucVnd = "0";
                    hanMucVND = Long.parseLong(str_hanmucVnd);
                } else {
                    hanMucVND = Long.parseLong(str_hanmucVnd);
                }

                if (str_hanmucUsd.equals("")) {
                    str_hanmucUsd = "0";
                    hanMucUSD = Long.parseLong(str_hanmucUsd);
                } else {
                    hanMucUSD = Long.parseLong(str_hanmucUsd);
                }

                String ghichu = request.getParameter("ghichu");

                posTemp.setMid(Mid);
                posTemp.setTenDvcnt(tenDvcnt);
                posTemp.setSoTktgtt(soTktgtt);
                posTemp.setTenchutk(tenchutk);
                posTemp.setDongmay(dongmay);
                posTemp.setTeninhoadon(teninhoadon);
                posTemp.setDiachiLapdat(diachiLapdat);
                posTemp.setLoaitien(loaitien);
                posTemp.setGddb1(gddb1);
                posTemp.setGddb2(gddb2);
                posTemp.setGddb3(gddb3);
                posTemp.setGddb4(gddb4);
                posTemp.setGddb5(gddb5);
                posTemp.setGddb6(gddb6);
                posTemp.setGddb7(gddb7);
                posTemp.setGddb8(gddb8);
                posTemp.setGddb9(gddb9);

                m.addAttribute("loaitien", loaitien);
                m.addAttribute("dongmay", dongmay);
                m.addAttribute("teninhoadon", teninhoadon);
                m.addAttribute("soTktgtt", soTktgtt);
                m.addAttribute("tenChuTaiKhoan", tenchutk);
                m.addAttribute("diaChiLapDat", diachiLapdat);
                m.addAttribute("gddb1", gddb1);
                m.addAttribute("gddb2", gddb2);
                m.addAttribute("gddb3", gddb3);
                m.addAttribute("gddb4", gddb4);
                m.addAttribute("gddb5", gddb5);
                m.addAttribute("gddb6", gddb6);
                m.addAttribute("gddb7", gddb7);
                m.addAttribute("gddb8", gddb8);
                m.addAttribute("gddb9", gddb9);
                m.addAttribute("hanmucvnd", hanMucVND);
                m.addAttribute("hanmucusd", hanMucUSD);
                m.addAttribute("phiMoto", tienkyquyMoto);
                m.addAttribute("ghichu", ghichu);

                if (gddb1 == 1 && (tienkyquyMoto == 0 || hanMucVND == 0 || hanMucUSD == 0)) {
                    String error = "Chưa nhập số tiền dịch vụ MOTO, hạn mức VND hoặc USD?";
                    m.addAttribute("error", error);
                    return lapThemPos(request, m, Mid);
                }
                posTemp.setPhimo(tienkyquyMoto);
                posTemp.setHanmucVnd(hanMucVND);
                posTemp.setHanmucUsd(hanMucUSD);
                posTemp.setGhichu(ghichu);

                Byte ismapping = 2; // POS đc thêm mới cho ĐVCNT
                posTemp.setIsmapping(ismapping);

                // Lấy số GPĐKKD / Tên người đại diện / CMT, Passport / Địa chỉ ĐKKD ở TT_DVCNT cập nhật zô TT_POS_TEMP
                String nguoidaidien = (String) _session.getAttribute("nguoidaidien_lapthempos");
                String gpdkkd = (String) _session.getAttribute("gpdkkd_lapthempos");
                String cmndNguoiDaiDien = (String) _session.getAttribute("cmndNguoiDaiDien_lapthempos");
                String diachi = (String) _session.getAttribute("diachi_lapthempos");

                posTemp.setGpdkkdTennguoidaidien(nguoidaidien);
                posTemp.setGpdkkdso(gpdkkd);
                posTemp.setDiachiDvcnt(diachi);
                posTemp.setGpdkkdCmnd(cmndNguoiDaiDien);
                model.create(posTemp);

                // GHI LOG
                TtLogDvcntModel modelLog = new TtLogDvcntModel();
                TtLogDvcnt log = new TtLogDvcnt();
                log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
                log.setLogLevel((Byte) _session.getAttribute("groupuser"));
                log.setLogTime(get_SystemTime());
                log.setLogMid(Mid);
                log.setLogContent("(1)CN/PGD lắp thêm POS tên in HĐ: " + teninhoadon + "(lapthempos.html)");
                modelLog.create(log); // create log

                // CAP NHAT SL_LAPTHEM VAO BANG TT_DVCNT
                TtDvcntModel modelDvcnt = new TtDvcntModel();
                TtDvcntLive dvcnt = new TtDvcntLive();
                dvcnt = modelDvcnt.getTtDvcnt(Mid);
                dvcnt.setSllapthem(Byte.parseByte(String.valueOf(SLDangKyLapThem)));
                Byte statusDvcnt = 8;
                dvcnt.setStatusDvcnt(statusDvcnt);
                modelDvcnt.update(dvcnt);
            }
        }
        return lapThemPos(request, m, Mid);
    }

    // CHỈNH SỬA THÔNG TIN ĐVCNT ĐÃ LẮP ĐẶT POS
    @RequestMapping(value = "editdvcnt", method = RequestMethod.GET)
    public String editDvcnt(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        m.addAttribute("maDvcnt", p.getMaDvcnt());
        _session.setAttribute("_maDvcnt", p.getMaDvcnt());
        _session.setAttribute("_id", p.getMaDvcnt());
        m.addAttribute("tenDvcntVn", p.getTenDvcntVn());
        _session.setAttribute("tenDvcntVn", p.getTenDvcntVn());
        m.addAttribute("tenDvcntEn", p.getTenDvcntEn());
        m.addAttribute("diachiDvcnt", p.getDiachiDvcnt());
        _session.setAttribute("diachiDvcnt", p.getDiachiDvcnt());
        m.addAttribute("sdtDvcnt", p.getSdtDvcnt());
        m.addAttribute("gpdkkdso", p.getGpdkkdso());

        int gpdkkdNgaycap = p.getGpdkkdNgaycap();
        String str_gpdkkdNgaycap = String.valueOf(gpdkkdNgaycap);
        String nam_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(0, 4);
        String thang_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(4, 6);
        String ngay_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(6, 8);
        String _GpdkkdNgaycap = ngay_gpdkkdNgaycap + "/" + thang_gpdkkdNgaycap + "/" + nam_gpdkkdNgaycap;
        m.addAttribute("_GpdkkdNgaycap", _GpdkkdNgaycap);
        _session.setAttribute("_sessionGpdkkdNgaycap", p.getGpdkkdNgaycap());

        m.addAttribute("gpdkkdNoicap", p.getGpdkkdNoicap());
        m.addAttribute("gpdkkdTennguoidaidien", p.getGpdkkdTennguoidaidien());
        _session.setAttribute("tenNguoiDaiDienGPKD", p.getGpdkkdTennguoidaidien());
        m.addAttribute("gpdkkdChucvu", p.getGpdkkdChucvu());
        m.addAttribute("gpdkkdCmnd", p.getGpdkkdCmnd());
        _session.setAttribute("CMNDnguoiDaiDienGPKD", p.getGpdkkdCmnd());

        int GpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        String str_GpdkkdNgaycapCmnd = String.valueOf(GpdkkdNgaycapCmnd);
        String nam_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(0, 4);
        String thang_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(4, 6);
        String ngay_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(6, 8);
        String _GpdkkdNgaycapCmnd = ngay_GpdkkdNgaycapCmnd + "/" + thang_GpdkkdNgaycapCmnd + "/" + nam_GpdkkdNgaycapCmnd;
        m.addAttribute("_GpdkkdNgaycapCmnd", _GpdkkdNgaycapCmnd);
        _session.setAttribute("_sessionGpdkkdNgaycapCmnd", p.getGpdkkdNgaycapCmnd());

        m.addAttribute("gpdkkdNoicapCmnd", p.getGpdkkdNoicapCmnd());
        m.addAttribute("masothue", p.getMasothue());
        m.addAttribute("tennguoiKyhopdong", p.getTennguoiKyhopdong());
        m.addAttribute("chucvuHopdong", p.getChucvuHopdong());
        m.addAttribute("cmndHopdong", p.getCmndHopdong());

        int NgaycapCmndHopdong = p.getNgaycapCmndHopdong();
        String str_NgaycapCmndHopdong = String.valueOf(NgaycapCmndHopdong);
        String nam_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(0, 4);
        String thang_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(4, 6);
        String ngay_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(6, 8);
        String _NgaycapCmndHopdong = ngay_NgaycapCmndHopdong + "/" + thang_NgaycapCmndHopdong + "/" + nam_NgaycapCmndHopdong;
        m.addAttribute("_NgaycapCmndHopdong", _NgaycapCmndHopdong);
        _session.setAttribute("_sessionNgaycapCmndHopdong", p.getNgaycapCmndHopdong());

        m.addAttribute("noicapCmndHopdong", p.getNoicapCmndHopdong());
        m.addAttribute("soUyquyen", p.getSoUyquyen());

        int NgayUyquyen = p.getNgayUyquyen();
        String _NgayUyquyen = "";

        if (NgayUyquyen != 0) {
            String str_NgayUyquyen = String.valueOf(NgayUyquyen);
            String nam_NgayUyquyen = str_NgayUyquyen.substring(0, 4);
            String thang_NgayUyquyen = str_NgayUyquyen.substring(4, 6);
            String ngay_NgayUyquyen = str_NgayUyquyen.substring(6, 8);
            _NgayUyquyen = ngay_NgayUyquyen + "/" + thang_NgayUyquyen + "/" + nam_NgayUyquyen;
        } else {
            _NgayUyquyen = "0";
        }

        m.addAttribute("_NgayUyquyen", _NgayUyquyen);
        _session.setAttribute("_sessionNgayUyquyen", p.getNgayUyquyen());

        String nganhang_hoptac = p.getNganhangHoptac();
        if (nganhang_hoptac.equals(" ,")) {
            nganhang_hoptac = "Khong";
            m.addAttribute("nganhangHoptac", nganhang_hoptac);
        } else {
            m.addAttribute("nganhangHoptac", p.getNganhangHoptac());
        }
        m.addAttribute("loaihinhDvcnt", p.getLoaihinhDvcnt());
        m.addAttribute("nganhnghekd", p.getNganhnghekd());
        _session.setAttribute("nganhNgheKinhDoanh", p.getNganhnghekd());
        m.addAttribute("doanhsothanhtoandukien", p.getDoanhsothanhtoandukien());
        m.addAttribute("xeploai", p.getXeploai());
        m.addAttribute("landk", p.getLandk());
        m.addAttribute("slpos", p.getSlpos());
        m.addAttribute("dongmayDexuat", p.getDongmayDexuat());
        _session.setAttribute("dongMay", p.getDongmayDexuat());
        m.addAttribute("phiGhinoscb", p.getPhiGhinoscb());
        m.addAttribute("phiGhinoLienminh", p.getPhiGhinoLienminh());
        m.addAttribute("phiVisa", p.getPhiVisa());
        m.addAttribute("phiMastercard", p.getPhiMastercard());
        m.addAttribute("phiJcb", p.getPhiJcb());
        m.addAttribute("phiCup", p.getPhiCup());
        m.addAttribute("phiDiscover", p.getPhiDiscover());
        m.addAttribute("tenThekhac", p.getTenThekhac());
        m.addAttribute("phiThekhac", p.getPhiThekhac());
        m.addAttribute("loaitien", p.getLoaitien());
        m.addAttribute("loaihinhDvcnt", p.getLoaihinhDvcnt());
        m.addAttribute("tienkyquyMoto", p.getTienkyquyMoto());
        m.addAttribute("hanmucVnd", p.getHanmucVnd());
        m.addAttribute("hanmucUsd", p.getHanmucUsd());

        String getDirectCode = p.getDirectCode();
        if (getDirectCode != null) {
            String get_direct_employee = p.getDirectCode() + " - " + p.getDirectName();
            m.addAttribute("get_direct_employee", get_direct_employee);
        }

        String getIndirectCode = p.getIndirectCode();
        if (getIndirectCode != null) {
            String get_inDirect_employee = p.getIndirectCode() + " - " + p.getIndirectName();
            m.addAttribute("get_inDirect_employee", get_inDirect_employee);
        }

        // Lay thong tin HISTAFF
        HistaffModel staffModel = new HistaffModel();
        List<TtHistaff> lst = new ArrayList<TtHistaff>();
        List<TtHistaff> lstResult = new ArrayList<TtHistaff>();
        TtHistaff staff = new TtHistaff();
        lst = staffModel.getAll();
        Byte loaihinhDvcnt = p.getLoaihinhDvcnt();
        String maDonVi = String.valueOf(_session.getAttribute("macn"));

        if (loaihinhDvcnt == 1) {
            for (int i = 0; i < lst.size(); i++) {
                staff = lst.get(i);
                String ma_chucdanh = staff.getJobtitleCode();
                String ma_donvi = staff.getBranchCode();
                if ((ma_chucdanh.equals("51-192")
                        || ma_chucdanh.equals("53-125")
                        || ma_chucdanh.equals("53-145")
                        || ma_chucdanh.equals("53-146")
                        || ma_chucdanh.equals("53-148")
                        || ma_chucdanh.equals("53-152")
                        || ma_chucdanh.equals("61-008")
                        || ma_chucdanh.equals("61-009")
                        || ma_chucdanh.equals("61-011")
                        || ma_chucdanh.equals("61-024")) && ma_donvi.equals(maDonVi)) {
                    lstResult.add(staff);
                }
            }
        }
        if (loaihinhDvcnt == 2) {
            for (int i = 0; i < lst.size(); i++) {
                staff = lst.get(i);
                String ma_chucdanh = staff.getJobtitleCode();
                String ma_donvi = staff.getBranchCode();
                if ((ma_chucdanh.equals("40-007")
                        || ma_chucdanh.equals("41-001")
                        || ma_chucdanh.equals("43-002")
                        || ma_chucdanh.equals("43-010")
                        || ma_chucdanh.equals("44-004")
                        || ma_chucdanh.equals("53-143")
                        || ma_chucdanh.equals("53-147")
                        || ma_chucdanh.equals("53-149")
                        || ma_chucdanh.equals("53-151")
                        || ma_chucdanh.equals("61-001")
                        || ma_chucdanh.equals("61-003")
                        || ma_chucdanh.equals("61-011")) && ma_donvi.equals(maDonVi)) {
                    lstResult.add(staff);
                }
            }
        }
        m.addAttribute("list_employee", lstResult);
        return "editdvcnt";
    }

    // XỬ LÝ CHỈNH SỬA THÔNG TIN ĐVCNT ĐÃ LẮP ĐẶT POS
    @RequestMapping(value = "/xulyeditdvcnt", method = RequestMethod.GET)
    public String xuLyEditDVCNT(Model m, @ModelAttribute(value = "_updatedvcnt") TtDvcntLive p1, HttpServletRequest request) {
        _session = request.getSession();

        String mid = (String) _session.getAttribute("_maDvcnt");
        _session.setAttribute("_id", mid);
        _session.removeAttribute("error");

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(mid);
        String id = p.getMaDvcnt();

        String tenDvcnt = request.getParameter("tenDvcntVn");
        String diachiDvcnt = request.getParameter("diaChiDvcnt");
        String tenNguoiDaiDienGPKD = request.getParameter("gpdkkdTennguoidaidien");
        String CMNDnguoiDaiDienGPKD = request.getParameter("gpdkkdCmnd");
//        String nganhNgheKinhDoanh = request.getParameter("nganhnghekd");

        String _tenDvcnt = (String) _session.getAttribute("tenDvcntVn");
        String _diachiDvcnt = (String) _session.getAttribute("diachiDvcnt");
        String _tenNguoiDaiDienGPKD = (String) _session.getAttribute("tenNguoiDaiDienGPKD");
        String _CMNDnguoiDaiDienGPKD = (String) _session.getAttribute("CMNDnguoiDaiDienGPKD");

        // GHI LOG
        TtLogDvcntModel modelLog = new TtLogDvcntModel();
        TtLogDvcnt log = new TtLogDvcnt();
        log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
        log.setLogLevel((Byte) _session.getAttribute("groupuser"));
        log.setLogTime(get_SystemTime());
        log.setLogMid(mid);

        while (true) {
            if (!tenDvcnt.equals(_tenDvcnt) || !diachiDvcnt.equals(_diachiDvcnt)
                    || !tenNguoiDaiDienGPKD.equals(_tenNguoiDaiDienGPKD)
                    || !CMNDnguoiDaiDienGPKD.equals(_CMNDnguoiDaiDienGPKD)) {
                Byte tinhtrangduyet = 13;
                p.setStatusDuyet(tinhtrangduyet);
                Byte tinhtrangDVCNT = 3; // CHỈNH SỬA THÔNG TIN ĐVCNT CẦN P.KTT&NHS PHÊ DUYỆT
                p.setStatusDvcnt(tinhtrangDVCNT);
                log.setLogContent("(1)CN/PGD edit ĐVCNT(cần P.KTT&NHS duyệt)");
                break;
            } else {
                Byte statusDvcnt = p.getStatusDvcnt();
                if (statusDvcnt == 3) {
                    log.setLogContent("(1)CN/PGD edit ĐVCNT(cần P.KTT&NHS duyệt)");
                    break;
                }
                Byte tinhtrangduyet = 13;
                p.setStatusDuyet(tinhtrangduyet);
                Byte tinhtrangDVCNT = 2; // EDIT KO CẦN P.KTT&NHS DUYỆT.
                p.setStatusDvcnt(tinhtrangDVCNT);
                log.setLogContent("(1)CN/PGD edit ĐVCNT(không cần P.KTT&NHS duyệt)");
                break;
            }
        }

        p.setTenDvcntVn(tenDvcnt);
        p.setDiachiDvcnt(diachiDvcnt);
        p.setGpdkkdTennguoidaidien(tenNguoiDaiDienGPKD);
        p.setGpdkkdCmnd(CMNDnguoiDaiDienGPKD);

        if (!tenDvcnt.equals(_tenDvcnt)) {
            p.setedit1(_tenDvcnt);
        }
        if (!tenNguoiDaiDienGPKD.equals(_tenNguoiDaiDienGPKD)) {
            p.setedit2(_tenNguoiDaiDienGPKD);
        }
        if (!CMNDnguoiDaiDienGPKD.equals(_CMNDnguoiDaiDienGPKD)) {
            p.setedit3(_CMNDnguoiDaiDienGPKD);
        }
        if (!diachiDvcnt.equals(_diachiDvcnt)) {
            p.setedit4(_diachiDvcnt);
        }

        p.setCnQuanly((String) _session.getAttribute("macn"));

        String maUser = (String) _session.getAttribute("mauser");
        p.setUser1Cn(maUser);

        int _GpdkkdNgaycap = (int) _session.getAttribute("_sessionGpdkkdNgaycap");
        int _GpdkkdNgaycapCmnd = (int) _session.getAttribute("_sessionGpdkkdNgaycapCmnd");
        int _NgaycapCmndHopdong = (int) _session.getAttribute("_sessionNgaycapCmndHopdong");
        int _NgayUyquyen = (int) _session.getAttribute("_sessionNgayUyquyen");

        p.setGpdkkdNgaycap(_GpdkkdNgaycap);
        p.setGpdkkdNgaycapCmnd(_GpdkkdNgaycapCmnd);
        p.setNgaycapCmndHopdong(_NgaycapCmndHopdong);
        p.setNgayUyquyen(_NgayUyquyen);

        p.setTenDvcntEn((String) request.getParameter("tenDvcntEn"));
        p.setSdtDvcnt((String) request.getParameter("sdtDvcnt"));
        p.setGpdkkdso((String) request.getParameter("gpdkkdso"));
        p.setGpdkkdNoicap((String) request.getParameter("gpdkkdNoicap"));
        p.setMasothue((String) request.getParameter("masothue"));
        p.setMasothue((String) request.getParameter("masothue"));
        p.setGpdkkdChucvu((String) request.getParameter("gpdkkdChucvu"));
        p.setGpdkkdNoicapCmnd((String) request.getParameter("gpdkkdNoicapCmnd"));
        p.setTennguoiKyhopdong((String) request.getParameter("tennguoiKyhopdong"));
        p.setChucvuHopdong((String) request.getParameter("chucvuHopdong"));
        p.setCmndHopdong((String) request.getParameter("cmndHopdong"));
        p.setNoicapCmndHopdong((String) request.getParameter("noicapCmndHopdong"));
        p.setSoUyquyen((String) request.getParameter("soUyquyen"));
        p.setNganhangHoptac((String) request.getParameter("nganhangHoptac"));
        p.setLoaihinhDvcnt((Byte) Byte.parseByte(request.getParameter("loaihinhDvcnt")));
        p.setNganhnghekd((String) request.getParameter("nganhnghekd"));
        p.setDoanhsothanhtoandukien((long) Long.parseLong(request.getParameter("doanhsothanhtoandukien")));
        p.setLandk((Byte) Byte.parseByte(request.getParameter("landk")));
        p.setLandk((Byte) Byte.parseByte(request.getParameter("landk")));

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);
        long user1DonviNgaynhap = Long.parseLong(ngay_gio_nhap);
        p.setUser1CnNgaynhap(user1DonviNgaynhap); // CAP NHAT THOI GIAN EDIT

        p.setPhiGhinoscb(request.getParameter("phiGhinoscb"));
        p.setPhiGhinoLienminh(request.getParameter("phiGhinoLienminh"));
        p.setPhiVisa(request.getParameter("phiVisa"));
        p.setPhiMastercard(request.getParameter("phiMastercard"));
        p.setPhiJcb(request.getParameter("phiJcb"));
        p.setPhiCup(request.getParameter("phiCup"));
        p.setPhiDiscover(request.getParameter("phiDiscover"));

        if (request.getParameter("phiThekhac").equals(null) || request.getParameter("phiThekhac").equals("")) {
            p.setPhiThekhac("0");
        } else {
            p.setPhiThekhac(request.getParameter("phiThekhac"));
        }

        p.setTenThekhac((String) request.getParameter("tenThekhac"));
        p.setLoaitien((String) request.getParameter("loaitien"));

        model.update(p);
        modelLog.create(log);
        return editDvcnt(m, id, request);
    }

    // Quay về trang listseditpos.html
    @RequestMapping(value = "trove_listseditpos", method = RequestMethod.GET)
    public String quayve_dseditPOS(HttpServletRequest request, Model m,
            @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();
        id = String.valueOf(_session.getAttribute("_id"));
        return dseditPOS(request, m, id);
    }

    // Quay về trang duyet.html
    @RequestMapping(value = "trove_duyet", method = RequestMethod.GET)
    public String quayve_trang_duyet(HttpServletRequest request, Model m,
            @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();
        id = String.valueOf(_session.getAttribute("_id"));
        return duyet(m, id, request);
    }

    // DS POS đã lắp đặt
    @RequestMapping(value = "listseditpos", method = RequestMethod.GET)
    public String dseditPOS(HttpServletRequest request, Model m,
            @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }
        m.addAttribute("maDvcnt", id);
        _session.setAttribute("maDvcnt", id);
        _session.setAttribute("_id", id);

        TtPosTempModel modelTemp = new TtPosTempModel();
        m.addAttribute("lst", modelTemp.getAllById(id));
        return "listseditpos";
    }

    // Chi tiết thông tin POS.
    @RequestMapping(value = "editpos", method = RequestMethod.GET)
    public String editPOS(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        String maDvcnt = (String) _session.getAttribute("maDvcnt");
        m.addAttribute("maDvcnt", maDvcnt);
        TtDvcntModel dvcntModel = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = dvcntModel.getTtDvcnt(maDvcnt);
        m.addAttribute("tenDvcnt", dvcnt.getTenDvcntVn());

        //
        TtPosModel model = new TtPosModel();
        String maPOS = model.getPosBySeriNo(id);
        _session.setAttribute("soseri", id);

        TtPosLive pos = new TtPosLive();
        pos = model.getPosById(maPOS);
        _session.setAttribute("soTktgtt", pos.getSoTktgtt());
        _session.setAttribute("_dongmay", pos.getDongmay());
        _session.setAttribute("teninhoadon", pos.getTeninhoadon());
        _session.setAttribute("soTktgtt", pos.getSoTktgtt());
        _session.setAttribute("tenchutk", pos.getTenchutk());

        _session.setAttribute("gddb1", pos.getGddb1());
        _session.setAttribute("gddb2", pos.getGddb2());
        _session.setAttribute("gddb3", pos.getGddb3());
        _session.setAttribute("gddb4", pos.getGddb4());
        _session.setAttribute("gddb5", pos.getGddb5());
        _session.setAttribute("gddb6", pos.getGddb6());
        _session.setAttribute("gddb7", pos.getGddb7());
        _session.setAttribute("gddb8", pos.getGddb8());
        _session.setAttribute("gddb9", pos.getGddb9());

        if (pos.getDiachiLapdat() == null) {
            _session.setAttribute("diachiLapdat", "");
        } else {
            _session.setAttribute("diachiLapdat", pos.getDiachiLapdat());
        }
        //
        if (pos.getMcc() == null) {
            _session.setAttribute("mcc", "");
        } else {
            _session.setAttribute("mcc", pos.getMcc());
        }

        return "editpos";
    }

    // XỬ LÝ CHỈNH SỬA THÔNG TIN ĐVCNT ĐÃ LẮP ĐẶT POS
    @RequestMapping(value = "/editposdalap", method = RequestMethod.GET)
    public String xuLyEditPOS(Model m, @ModelAttribute(value = "_updatedvcnt") TtDvcntLive p1, HttpServletRequest request) {
        _session = request.getSession();

        String dongmay = request.getParameter("dongmay");
        String teninhoadon = request.getParameter("teninhoadon");
        String diachiLapdat = request.getParameter("diachiLapdat");
        String mcc = request.getParameter("mcc");
        String soTktgtt = request.getParameter("soTktgtt");
        String tenchutk = request.getParameter("tenchutk");
//        String ghichu = request.getParameter("ghichu");
        String maDvcnt = request.getParameter("maDvcnt");

        Byte gddb1, gddb2, gddb3, gddb4, gddb5, gddb6, gddb7, gddb8, gddb9;

        if (request.getParameter("gddb1") == null) {
            gddb1 = 0;
        } else {
            gddb1 = Byte.parseByte(request.getParameter("gddb1"));
        }

        if (request.getParameter("gddb2") == null) {
            gddb2 = 0;
        } else {
            gddb2 = Byte.parseByte(request.getParameter("gddb2"));
        }

        if (request.getParameter("gddb3") == null) {
            gddb3 = 0;
        } else {
            gddb3 = Byte.parseByte(request.getParameter("gddb3"));
        }

        if (request.getParameter("gddb4") == null) {
            gddb4 = 0;
        } else {
            gddb4 = Byte.parseByte(request.getParameter("gddb4"));
        }

        if (request.getParameter("gddb5") == null) {
            gddb5 = 0;
        } else {
            gddb5 = Byte.parseByte(request.getParameter("gddb5"));
        }

        if (request.getParameter("gddb6") == null) {
            gddb6 = 0;
        } else {
            gddb6 = Byte.parseByte(request.getParameter("gddb6"));
        }

        if (request.getParameter("gddb7") == null) {
            gddb7 = 0;
        } else {
            gddb7 = Byte.parseByte(request.getParameter("gddb7"));
        }

        if (request.getParameter("gddb8") == null) {
            gddb8 = 0;
        } else {
            gddb8 = Byte.parseByte(request.getParameter("gddb8"));
        }

        if (request.getParameter("gddb9") == null) {
            gddb9 = 0;
        } else {
            gddb9 = Byte.parseByte(request.getParameter("gddb9"));
        }

        String _dongmay = (String) _session.getAttribute("_dongmay");
        String _teninhoadon = (String) _session.getAttribute("teninhoadon");
        String _diachiLapdat = (String) _session.getAttribute("diachiLapdat");
        String _mcc = (String) _session.getAttribute("mcc");
        Byte _gddb1 = (Byte) _session.getAttribute("gddb1");
        Byte _gddb2 = (Byte) _session.getAttribute("gddb2");
        Byte _gddb3 = (Byte) _session.getAttribute("gddb3");
        Byte _gddb4 = (Byte) _session.getAttribute("gddb4");
        Byte _gddb5 = (Byte) _session.getAttribute("gddb5");
        Byte _gddb6 = (Byte) _session.getAttribute("gddb6");
        Byte _gddb7 = (Byte) _session.getAttribute("gddb7");
        Byte _gddb8 = (Byte) _session.getAttribute("gddb8");
        Byte _gddb9 = (Byte) _session.getAttribute("gddb9");

        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = modelDvcnt.getTtDvcnt(maDvcnt);

        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive posTemp = new TtPosTempLive();
        long STT_POS_TEMP = model.getPosBySeriNo(((String) _session.getAttribute("soseri")));
        posTemp = model.getTtPosTemp(STT_POS_TEMP);

        // GHI LOG
        TtLogDvcntModel modelLog = new TtLogDvcntModel();
        TtLogDvcnt log = new TtLogDvcnt();
        log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
        log.setLogLevel((Byte) _session.getAttribute("groupuser"));
        log.setLogTime(get_SystemTime());
        log.setLogMid(maDvcnt);

        // CHỈNH SỬA THÔNG TIN POS CẦN P.KTT&NHS PHÊ DUYỆT
        while (true) {
            if (!dongmay.equals(_dongmay) || !teninhoadon.equals(_teninhoadon)
                    || !diachiLapdat.equals(_diachiLapdat) || !mcc.equals(_mcc)
                    || !gddb1.equals(_gddb1) || !gddb2.equals(_gddb2) || !gddb3.equals(_gddb3)
                    || !gddb4.equals(_gddb4) || !gddb5.equals(_gddb5) || !gddb6.equals(_gddb6)
                    || !gddb7.equals(_gddb7) || !gddb8.equals(_gddb8) || !gddb9.equals(_gddb9)) {
                Byte tinhtrangduyet = 13;
                p.setStatusDuyet(tinhtrangduyet);
                Byte tinhtrangDVCNT = 3; // EDIT CẦN P.KTT&NHS DUYỆT.
                p.setStatusDvcnt(tinhtrangDVCNT);
                modelDvcnt.update(p);
                log.setLogContent("(1)CN/PGD edit POS(cần P.KTT&NHS duyệt)");

                // Cập nhật tình trạng edit pos(cần P.KTT duyệt) vào TT_POS_TEMP
                Byte ismapping = 4;
                posTemp.setIsmapping(ismapping);
                model.update(posTemp);
                break;
            } else {
                Byte tinhtrangduyet = 13;
                p.setStatusDuyet(tinhtrangduyet);
                Byte tinhtrangDVCNT = 2; // EDIT KO CẦN P.KTT&NHS DUYỆT.
                p.setStatusDvcnt(tinhtrangDVCNT);
                modelDvcnt.update(p);

                if (posTemp.getIsmapping() == 4) {
                    log.setLogContent("(1)CN/PGD edit POS(cần P.KTT&NHS duyệt)");
                    break;
                }
                // Cập nhật tình trạng edit pos vào TT_POS_TEMP
                Byte ismapping = 5;
                posTemp.setIsmapping(ismapping);
                model.update(posTemp);
                log.setLogContent("(1)CN/PGD edit POS(không cần P.KTT&NHS duyệt)");
                break;
            }
        }
        modelLog.create(log); // create log

        // CẬP NHẬT NHỮNG THÔNG TIN ĐÃ EDIT CẦN P.KTT&NHS DUYỆT VÀO TT_POS_TEMP
        if (!teninhoadon.equals(_teninhoadon)) {
            posTemp.setedit1(_teninhoadon);
        } else {
            posTemp.setedit1("");
        }

        if (!diachiLapdat.equals(_diachiLapdat)) {
            posTemp.setedit2(_diachiLapdat);
        } else {
            posTemp.setedit2("");
        }

        if (!mcc.equals(_mcc)) {
            posTemp.setedit3(_mcc);
        } else {
            posTemp.setedit3("");
        }

        if (!dongmay.equals(_dongmay)) {
            posTemp.setedit4(_dongmay);
        } else {
            posTemp.setedit4("");
        }

        // GDDB        
        posTemp.seteditGddb1(_gddb1);
        posTemp.seteditGddb2(_gddb2);
        posTemp.seteditGddb3(_gddb3);
        posTemp.seteditGddb4(_gddb4);
        posTemp.seteditGddb5(_gddb5);
        posTemp.seteditGddb6(_gddb6);
        posTemp.seteditGddb7(_gddb7);
        posTemp.seteditGddb8(_gddb8);
        posTemp.seteditGddb9(_gddb9);

        // CẬP NHẬT THÔNG TIN VÀO POS_TEMP
        posTemp.setSoTktgtt(soTktgtt);
        posTemp.setTenchutk(tenchutk);
        posTemp.setDongmay(dongmay);
        posTemp.setTeninhoadon(teninhoadon);
        posTemp.setDiachiLapdat(diachiLapdat);
        posTemp.setMcc(mcc);
        posTemp.setGddb1(gddb1);
        posTemp.setGddb2(gddb2);
        posTemp.setGddb3(gddb3);
        posTemp.setGddb4(gddb4);
        posTemp.setGddb5(gddb5);
        posTemp.setGddb6(gddb6);
        posTemp.setGddb7(gddb7);
        posTemp.setGddb8(gddb8);
        posTemp.setGddb9(gddb9);
        model.update(posTemp);

        // CẬP NHẬT VÀO TT_POS
        TtPosModel modelPOS = new TtPosModel();
        TtPosLive pos = new TtPosLive();
        String maPOS = modelPOS.getPosBySeriNo((String) _session.getAttribute("soseri"));
        pos = modelPOS.getPosById(maPOS);

        pos.setSoTktgtt(soTktgtt);
        pos.setTenchutk(tenchutk);
        pos.setDongmay(dongmay);
        pos.setTeninhoadon(teninhoadon);
        pos.setDiachiLapdat(diachiLapdat);
        pos.setMcc(mcc);
        pos.setGddb1(gddb1);
        pos.setGddb2(gddb2);
        pos.setGddb3(gddb3);
        pos.setGddb4(gddb4);
        pos.setGddb5(gddb5);
        pos.setGddb6(gddb6);
        pos.setGddb7(gddb7);
        pos.setGddb8(gddb8);
        pos.setGddb9(gddb9);
        modelPOS.update(pos);

        return dseditPOS(request, m, (String) _session.getAttribute("maDvcnt"));
    }

    // GỬI DUYỆT ĐVCNT CÓ CHỈNH SỬA THÔNG TIN KO CẦN P.KTT&NHS DUYỆT
    @RequestMapping(value = "/guiduyetchinhsua", method = RequestMethod.GET)
    public String guiDuyetEditDvcnt(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        String fileUploadEdit = p.getFileUpload3();

        if (fileUploadEdit == null || fileUploadEdit.equals("")) {
            String error = "Chưa đính kèm hồ sơ pháp lý ĐVCNT";
            m.addAttribute("error", error);
            return editDvcnt(m, id, request);
        }

        String UserNhap = (String) _session.getAttribute("mauser");
        p.setUser1Cn(UserNhap);
        String cnQuanly = (String) _session.getAttribute("macn");
        p.setCnQuanly(cnQuanly);
        p.setUser1CnNgaynhap(get_SystemTime());

        // Reset tat ca USER, NGAYDUYET, GHICHU về null
        p.setUser2Cn("");
        long emty = 0;
        p.setUser2CnDate(emty);
        p.setUser2CnNote("");
        p.setUser1Ptdbh("");
        p.setUser1PtdbhDate(emty);
        p.setUser1PtdbhNote("");
        p.setUser2Ptdbh("");
        p.setUser2PtdbhDate(emty);
        p.setUser2PtdbhNote("");
        p.setUser1Pkhdn("");
        p.setUser1PkhdnDate(emty);
        p.setUser1PkhdnNote("");
        p.setUser2Pkhdn("");
        p.setUser2PkhdnDate(emty);
        p.setUser2PkhdnNote("");
        p.setUser1Ptnt("");
        p.setUser1PtntDate(emty);
        p.setUser1PtntNote("");
        p.setUser2Ptnt("");
        p.setUser2PtntDate(emty);
        p.setUser2PtntNote("");

        Byte tinhtrangduyet = 3; // Chuyển đến (2)CN/PGD
        p.setStatusDuyet(tinhtrangduyet);
        model.update(p);
        String confirm = "Gửi duyệt edit ĐVCNT " + id;
        _session.setAttribute("confirm", confirm);

        // GHI LOG
        TtLogDvcntModel modelLog = new TtLogDvcntModel();
        TtLogDvcnt log = new TtLogDvcnt();
        log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
        log.setLogLevel((Byte) _session.getAttribute("groupuser"));
        log.setLogTime(get_SystemTime());
        log.setLogMid(id);
        log.setLogContent("(1)CN/PGD gửi duyệt edit ĐVCNT");
        modelLog.create(log); // create log

        return "redirect:dvcntdangxuly.html";
    }

    @RequestMapping(value = "/guiduyetchinhsuapos", method = RequestMethod.GET)
    public String guiDuyetEditPosChoDvcnt(HttpServletRequest request, Model m,
            @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        String fileUploadEdit = p.getFileUpload3();

        if (fileUploadEdit == null || fileUploadEdit.equals("")) {
            String error = "Chưa đính kèm hồ sơ pháp lý ĐVCNT";
            m.addAttribute("error", error);
            return dseditPOS(request, m, id);
        }

        Byte statusDuyet = 3; // (1)CN/PGD Complete
        p.setStatusDuyet(statusDuyet);

        String UserNhap = (String) _session.getAttribute("mauser");
        p.setUser1Cn(UserNhap);
        String cnQuanly = (String) _session.getAttribute("macn");
        p.setCnQuanly(cnQuanly);
        p.setUser1CnNgaynhap(get_SystemTime());

        // Reset tat ca USER, NGAYDUYET, GHICHU về null
        p.setUser2Cn("");
        p.setUser2CnNote("");
        p.setUser2CnDate(null);

        p.setUser1Pkhdn("");
        p.setUser1PkhdnNote("");
        p.setUser1PkhdnDate(null);

        p.setUser2Pkhdn("");
        p.setUser2PkhdnNote("");
        p.setUser2PkhdnDate(null);

        p.setUser1Ptdbh("");
        p.setUser1PtdbhNote("");
        p.setUser1PtdbhDate(null);

        p.setUser2Ptdbh("");
        p.setUser2PtdbhNote("");
        p.setUser2PtdbhDate(null);

        p.setUser1Ptnt("");
        p.setUser1PtntNote("");
        p.setUser1PtntDate(null);

        p.setUser2Ptnt("");
        p.setUser2PtntNote("");
        p.setUser2PtntDate(null);
        model.update(p);
        String confirm = "Gửi duyệt edit ĐVCNT " + id;
        _session.setAttribute("confirm", confirm);

        // GHI LOG
        TtLogDvcntModel modelLog = new TtLogDvcntModel();
        TtLogDvcnt log = new TtLogDvcnt();
        log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
        log.setLogLevel((Byte) _session.getAttribute("groupuser"));
        log.setLogTime(get_SystemTime());
        log.setLogMid(id);
        log.setLogContent("(1)CN/PGD gửi duyệt edit ĐVCNT/POS");
        modelLog.create(log); // create log

        return "redirect:dvcntdangxuly";
    }

    // GỬI DUYỆT ĐVCNT CÓ CHỈNH SỬA THÔNG TIN CẦN P.KTT&NHS DUYỆT
    @RequestMapping(value = "/ho1guiduyetchinhsua", method = RequestMethod.GET)
    public String guiDuyetEditDvcntCanTNTduyet(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);
        Byte tinhtrangduyet = 12; // Chuyển đến (2)TNT
        p.setStatusDuyet(tinhtrangduyet);
        model.update(p);

        String confirm = "Đã duyệt thuận ĐVCNT " + id;
        _session.setAttribute("confirm", confirm);

        // GHI LOG
        TtLogDvcntModel modelLog = new TtLogDvcntModel();
        TtLogDvcnt log = new TtLogDvcnt();
        log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
        log.setLogLevel((Byte) _session.getAttribute("groupuser"));
        log.setLogTime(get_SystemTime());
        log.setLogMid(id);
        log.setLogContent("(1)P.KTT&NHS chuyển tiếp user cấp 2");
        modelLog.create(log); // create log

        return "redirect:dvcntdangxuly.html";
    }

    // TRẨ VỀ : CHỈNH SỬA THÔNG TIN ĐVCNT 
    @RequestMapping(value = "/trave", method = RequestMethod.GET)
    public String traVe(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        UserAccModel userModel = new UserAccModel();
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = model.getTtDvcnt(id);

        //USER 1
        String user1CnPGD = dvcnt.getUser1Cn();
        int lenght_user1CnPGD = user1CnPGD.length();
        int number = 20 - lenght_user1CnPGD;
        for (int i = 1; i <= number; i++) {
            user1CnPGD += " "; // Vì username dưới DB luôn là 20 kí tự nên phải thêm bước này
        }
        String email_1 = userModel._getEmail(user1CnPGD);

        //USER 2
        String user2CnPGD = "", email_2 = "";
        if (dvcnt.getUser2Cn() != null) {
            user2CnPGD = dvcnt.getUser2Cn();
            int lenght_user2CnPGD = user2CnPGD.length();
            number = 20 - lenght_user2CnPGD;
            for (int i = 1; i <= number; i++) {
                user2CnPGD += " "; // Vì username dưới DB luôn là 20 kí tự nên phải thêm bước này
            }
            email_2 = userModel._getEmail(user2CnPGD);
        }
        String email = email_1 + "," + email_2;

        Byte tinhtrangduyet = 0; // Chuyển đến (2)CN/PGD
        dvcnt.setStatusDuyet(tinhtrangduyet);

        try {
            String content = "TRA VE: DVCNT " + dvcnt.getTenDvcntVn()
                    + "\n\nThong bao tu dong, vui long khong tra loi email nay. Cam on quy A/C !\n\n";;
            send_Email(email + ",nghiandh@scb.com.vn", content);
        } catch (Exception e) {
            System.out.println("LOI GUI MAIL: " + e.toString());
        }

        model.update(dvcnt);

        return "redirect:dvcntdangxuly.html";
    }

    @RequestMapping(value = "tamkhoa", method = RequestMethod.GET)
    public String tamKhoa(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        return "redirect:dvcntdangxuly.html";
    }

    @RequestMapping(value = "bienbanthuhoipos", method = RequestMethod.GET)
    public String bienbanthuhoipos(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        _session.setAttribute("_id", id);

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        m.addAttribute("ngay", day);
        m.addAttribute("thang", month);
        m.addAttribute("nam", year);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        m.addAttribute("tenDvcnt", p.getTenDvcntVn());
        m.addAttribute("diaChiDvcnt", p.getDiachiDvcnt());
        m.addAttribute("sdtDvcnt", p.getSdtDvcnt());
        m.addAttribute("tennguoidaidien", p.getGpdkkdTennguoidaidien());
        m.addAttribute("chucVu", p.getGpdkkdChucvu());

        TtPosModel modelPos = new TtPosModel();
        m.addAttribute("lst", modelPos.getListPosByMid(id));

        return "bienbanthuhoipos";
    }

    @RequestMapping(value = "bienbanthuhoipos_tamkhoa", method = RequestMethod.GET)
    public String bienbanthuhoipos_tamkhoa(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        _session.setAttribute("_id", id);

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        m.addAttribute("ngay", day);
        m.addAttribute("thang", month);
        m.addAttribute("nam", year);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        m.addAttribute("tenDvcnt", p.getTenDvcntVn());
        m.addAttribute("diaChiDvcnt", p.getDiachiDvcnt());
        m.addAttribute("sdtDvcnt", p.getSdtDvcnt());
        m.addAttribute("tennguoidaidien", p.getGpdkkdTennguoidaidien());
        m.addAttribute("chucVu", p.getGpdkkdChucvu());

        TtPosModel modelPos = new TtPosModel();
        m.addAttribute("lst", modelPos.getListPosByMid(id));

        return "bienbanthuhoipos_tamkhoa";
    }

    @RequestMapping(value = "bienbanBanGiao", method = RequestMethod.GET)
    public String bienbanBanGiao(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        _session.setAttribute("_id", id);

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        m.addAttribute("ngay", day);
        m.addAttribute("thang", month);
        m.addAttribute("nam", year);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        m.addAttribute("StatusDvcnt", p.getStatusDvcnt());

        m.addAttribute("tenDvcnt", p.getTenDvcntVn());
        m.addAttribute("diaChiDvcnt", p.getDiachiDvcnt());
        m.addAttribute("sdtDvcnt", p.getSdtDvcnt());

        m.addAttribute("tennguoidaidien", p.getGpdkkdTennguoidaidien());
        m.addAttribute("chucVu", p.getGpdkkdChucvu());

        // Ghi nhan thong tin User duyet tren he thong vao Bien Bản Bàn Giao
        UserAccModel modelUser = new UserAccModel();
        UserAcc username = new UserAcc();

        // User 1 Chi Nhanh / Phong Giao Dich
        username = modelUser.getUserByUsername(p.getUser1Cn());
        m.addAttribute("tenUser1ChiNhanh", username.getHoten());

        long getUser1ChiNhanhNgayNhap = p.getUser1CnNgaynhap();

        String str_getUser1ChiNhanhNgaynhap = String.valueOf(getUser1ChiNhanhNgayNhap);
        String nam_getUser1CnNgaynhap = str_getUser1ChiNhanhNgaynhap.substring(0, 4);
        String thang_getUser1CnNgaynhap = str_getUser1ChiNhanhNgaynhap.substring(4, 6);
        String ngay_getUser1CnNgaynhap = str_getUser1ChiNhanhNgaynhap.substring(6, 8);
//        String gio_getUser1CnNgaynhap = str_getUser1ChiNhanhNgaynhap.substring(8, 10);
//        String phut_getUser1CnNgaynhap = str_getUser1ChiNhanhNgaynhap.substring(10, 12);
//        String giay_getUser1CnNgaynhap = str_getUser1ChiNhanhNgaynhap.substring(12, 14);
        String _getUser1CnNgaynhap = ngay_getUser1CnNgaynhap + "/" + thang_getUser1CnNgaynhap + "/" + nam_getUser1CnNgaynhap;
        m.addAttribute("getUser1ChiNhanhNgayNhap", _getUser1CnNgaynhap);

        // User 2 Chi Nhanh / Phong Giao Dich
        username = modelUser.getUserByUsername(p.getUser2Cn());
        m.addAttribute("tenUser2ChiNhanh", username.getHoten());

        String getUser2CnDate = String.valueOf(p.getUser2CnDate());
        if (!getUser2CnDate.equals("null")) {
            long getUser2ChiNhanhNgayNhap = p.getUser2CnDate();
            String str_getUser2ChiNhanhNgaynhap = String.valueOf(getUser2ChiNhanhNgayNhap);
            String nam_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(0, 4);
            String thang_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(4, 6);
            String ngay_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(6, 8);
            String _getUser2CnNgaynhap = ngay_getUser2CnNgaynhap + "/" + thang_getUser2CnNgaynhap + "/" + nam_getUser2CnNgaynhap;
            m.addAttribute("getUser2ChiNhanhNgayNhap", _getUser2CnNgaynhap);
        }

//        String gio_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(8, 10);
//        String phut_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(10, 12);
//        String giay_getUser2nNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(12, 14);
        m.addAttribute("loaihinhDvcnt", p.getLoaihinhDvcnt());

        // User 1 P.KH CA NHAN
        username = modelUser.getUserByUsername(p.getUser1Ptdbh());
        m.addAttribute("tenUser1KhachHangCaNhan", username.getHoten());

        String string_User1KhachHangCaNhan = String.valueOf(p.getUser1PtdbhDate());
        if (string_User1KhachHangCaNhan != "null") {
            long getUser1KhachHangCaNhan = p.getUser1PtdbhDate();

            String str_getUser1KhachHangCaNhan = String.valueOf(getUser1KhachHangCaNhan);
            String nam_getUser1KhachHangCaNhan = str_getUser1KhachHangCaNhan.substring(0, 4);
            String thang_getUser1KhachHangCaNhan = str_getUser1KhachHangCaNhan.substring(4, 6);
            String ngay_getUser1KhachHangCaNhan = str_getUser1KhachHangCaNhan.substring(6, 8);
//        String gio_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(8, 10);
//        String phut_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(10, 12);
//        String giay_getUser2nNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(12, 14);
            String _getUser1KhachHangCaNhan = ngay_getUser1KhachHangCaNhan + "/" + thang_getUser1KhachHangCaNhan + "/" + nam_getUser1KhachHangCaNhan;
            m.addAttribute("getUser1KhachHangCaNhanNgayNhap", _getUser1KhachHangCaNhan);
        }

        // User 2 P.KH CA NHAN
        username = modelUser.getUserByUsername(p.getUser2Ptdbh());
        m.addAttribute("tenUser2KhachHangCaNhan", username.getHoten());

        String string_user2KhachHangCaNhan = String.valueOf(p.getUser2PtdbhDate());

        if (string_user2KhachHangCaNhan != "null") {
            long getUser2KhachHangCaNhan = p.getUser2PtdbhDate();

            String str_getUser2KhachHangCaNhan = String.valueOf(getUser2KhachHangCaNhan);
            String nam_getUser2KhachHangCaNhan = str_getUser2KhachHangCaNhan.substring(0, 4);
            String thang_getUser2KhachHangCaNhan = str_getUser2KhachHangCaNhan.substring(4, 6);
            String ngay_getUser2KhachHangCaNhan = str_getUser2KhachHangCaNhan.substring(6, 8);
//        String gio_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(8, 10);
//        String phut_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(10, 12);
//        String giay_getUser2nNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(12, 14);
            String _getUser2KhachHangCaNhan = ngay_getUser2KhachHangCaNhan + "/" + thang_getUser2KhachHangCaNhan + "/" + nam_getUser2KhachHangCaNhan;
            m.addAttribute("getUser2KhachHangCaNhanNgayNhap", _getUser2KhachHangCaNhan);
        }

        // User 1 P.KH DOANH NGHIEP
        username = modelUser.getUserByUsername(p.getUser1Pkhdn());
        m.addAttribute("tenUser1Pkhdn", username.getHoten());

        String string_getUser1Pkhdn = String.valueOf(p.getUser1PkhdnDate());

        if (string_getUser1Pkhdn != "null") {
            long getUser1Pkhdn = p.getUser1PkhdnDate();
            String str_getUser1Pkhdn = String.valueOf(getUser1Pkhdn);
            String nam_getUser1Pkhdn = str_getUser1Pkhdn.substring(0, 4);
            String thang_getUser1Pkhdn = str_getUser1Pkhdn.substring(4, 6);
            String ngay_getUser1Pkhdn = str_getUser1Pkhdn.substring(6, 8);
//        String gio_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(8, 10);
//        String phut_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(10, 12);
//        String giay_getUser2nNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(12, 14);
            String _getUser1Pkhdn = ngay_getUser1Pkhdn + "/" + thang_getUser1Pkhdn + "/" + nam_getUser1Pkhdn;
            m.addAttribute("getUser1PkhdnNgayNhap", _getUser1Pkhdn);
        }

        // User 2 P.KH DOANH NGHIEP
        username = modelUser.getUserByUsername(p.getUser2Pkhdn());
        m.addAttribute("tenUser2Pkhdn", username.getHoten());

        String string_getUser2Pkhdn = String.valueOf(p.getUser2PkhdnDate());

        if (string_getUser2Pkhdn != "null") {
            long getUser2Pkhdn = p.getUser2PkhdnDate();
            String str_getUser2Pkhdn = String.valueOf(getUser2Pkhdn);
            String nam_getUser2Pkhdn = str_getUser2Pkhdn.substring(0, 4);
            String thang_getUser2Pkhdn = str_getUser2Pkhdn.substring(4, 6);
            String ngay_getUser2Pkhdn = str_getUser2Pkhdn.substring(6, 8);
//        String gio_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(8, 10);
//        String phut_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(10, 12);
//        String giay_getUser2nNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(12, 14);
            String _getUser2Pkhdn = ngay_getUser2Pkhdn + "/" + thang_getUser2Pkhdn + "/" + nam_getUser2Pkhdn;
            m.addAttribute("getUser2PkhdnNgayNhap", _getUser2Pkhdn);
        }

        // User 1 P.KTT&NHS
        username = modelUser.getUserByUsername(p.getUser1Ptnt());
        m.addAttribute("tenUser1Ptnt", username.getHoten());

        String string_getUser1Ptnt = String.valueOf(p.getUser1PtntDate());
        if (string_getUser1Ptnt != "null") {
            long getUser1PTnt = p.getUser1PtntDate();

            String str_getUser1Ptnt = String.valueOf(getUser1PTnt);
            String nam_getUser1Ptnt = str_getUser1Ptnt.substring(0, 4);
            String thang_getUser1Ptnt = str_getUser1Ptnt.substring(4, 6);
            String ngay_getUser1Ptnt = str_getUser1Ptnt.substring(6, 8);
//        String gio_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(8, 10);
//        String phut_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(10, 12);
//        String giay_getUser2nNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(12, 14);
            String _getUser1Ptnt = ngay_getUser1Ptnt + "/" + thang_getUser1Ptnt + "/" + nam_getUser1Ptnt;
            m.addAttribute("getUser1PtntNgayNhap", _getUser1Ptnt);
        }

        // User 2 P.KTT&NHS
        username = modelUser.getUserByUsername(p.getUser2Ptnt());
        m.addAttribute("tenUser2Ptnt", username.getHoten());

        String getUser2PtntDate = String.valueOf(p.getUser2PtntDate());
        if (!getUser2PtntDate.equals("null")) {
            long getUser2PTnt = p.getUser2PtntDate();
            String str_getUser2Ptnt = String.valueOf(getUser2PTnt);
            String nam_getUser2Ptnt = str_getUser2Ptnt.substring(0, 4);
            String thang_getUser2Ptnt = str_getUser2Ptnt.substring(4, 6);
            String ngay_getUser2Ptnt = str_getUser2Ptnt.substring(6, 8);
            String _getUser2Ptnt = ngay_getUser2Ptnt + "/" + thang_getUser2Ptnt + "/" + nam_getUser2Ptnt;
            m.addAttribute("getUser2PtntNgayNhap", _getUser2Ptnt);
        }

//        String gio_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(8, 10);
//        String phut_getUser2CnNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(10, 12);
//        String giay_getUser2nNgaynhap = str_getUser2ChiNhanhNgaynhap.substring(12, 14);
        TtPosTempModel modelTemp = new TtPosTempModel();
        m.addAttribute("lst", modelTemp.getAllById(id));

        return "bienbanBanGiao";
    }

    @RequestMapping(value = "xemthongtinduyet", method = RequestMethod.GET)
    public String xemthongtinduyet(HttpServletRequest request, Model m, @RequestParam(value = "id",
            required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }
        TtLogDvcntModel model = new TtLogDvcntModel();
        m.addAttribute("list", model.getAll_TheoMaDvcnt(id));
        _session.setAttribute("_id", id);
        return "xemthongtinduyet";
    }

    @RequestMapping(value = "khoa", method = RequestMethod.GET)
    public String Khoa(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = model.getTtDvcnt(id);

        if (dvcnt.getFileuploadTamKhoa() == null || dvcnt.getFileuploadTamKhoa().equals("")) {
            String error = "Chưa upload file scan";
            m.addAttribute("error", error);
            m.addAttribute("lst", model.getAll());
            return "danhsachdvcnt";
        } else {
            m.addAttribute("error", "");
            Byte statusDuyet = 3; // CHUYEN DEN (2)CN/PGD
            dvcnt.setStatusDuyet(statusDuyet);

            Byte statusDvcnt = 5;
            dvcnt.setStatusDvcnt(statusDvcnt); // TAM KHOA

            dvcnt.setUser2Cn("");
            long emty = 0;
            dvcnt.setUser2CnDate(emty);
            dvcnt.setUser2CnNote("");
            dvcnt.setUser1Ptdbh("");
            dvcnt.setUser1PtdbhDate(emty);
            dvcnt.setUser1PtdbhNote("");
            dvcnt.setUser2Ptdbh("");
            dvcnt.setUser2PtdbhDate(emty);
            dvcnt.setUser2PtdbhNote("");
            dvcnt.setUser1Pkhdn("");
            dvcnt.setUser1PkhdnDate(emty);
            dvcnt.setUser1PkhdnNote("");
            dvcnt.setUser2Pkhdn("");
            dvcnt.setUser2PkhdnDate(emty);
            dvcnt.setUser2PkhdnNote("");
            dvcnt.setUser1Ptnt("");
            dvcnt.setUser1PtntDate(emty);
            dvcnt.setUser1PtntNote("");
            dvcnt.setUser2Ptnt("");
            dvcnt.setUser2PtntDate(emty);
            dvcnt.setUser2PtntNote("");
            model.update(dvcnt);
        }
        return "redirect:dvcntdangxuly.html";
    }

    // Xóa thông tin lắp đặt (Xóa trong TABLE TT_POS_TEMP)
    @RequestMapping(value = "xoathongtinlapdatposmoi", method = RequestMethod.GET)
    public String xoaThongTinLapDatPosMoi(Model m, @RequestParam(value = "id", required = false) long id, HttpServletRequest request) {
        _session = request.getSession();
        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive pos = new TtPosTempLive();
        pos = model.getTtPosTemp(id);
        model.remove(pos);
        String Mid = (String) _session.getAttribute("_maDvcnt");

        // Load danh sach thông tin POS_TEMP vừa đc thêm mới.
        TtPosTempModel modelTemp = new TtPosTempModel();
        m.addAttribute("listPosThemMoi", modelTemp.getDSPOSThemMoi(Mid));
        return lapThemPos(request, m, Mid);
    }

    //
    @RequestMapping(value = "hoantat_lapdatthempos", method = RequestMethod.GET)
    public String hoanTatLapDatThemPos(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();

        String Mid = id;

        // Số lượng POS đã đăng ký lắp thêm
        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive posTemp = new TtPosTempLive();
        Byte SLDangKyLapThem = (Byte) _session.getAttribute("soluonglapthem");

        int soluongdanhap = model.countPosThemMoi(Mid);

        if (SLDangKyLapThem > soluongdanhap) {
            String error = "Chưa gán gán đủ " + SLDangKyLapThem + " máy POS cho ĐVCNT " + Mid;
            m.addAttribute("error", error);
            return lapThemPos(request, m, Mid);
        } else if (SLDangKyLapThem < soluongdanhap) {
            String error = "Gán thừa thông tin lắp đặt. Xin kiểm tra lại !";
            m.addAttribute("error", error);
            return lapThemPos(request, m, Mid);
        } else {
            TtDvcntModel modelDvcnt = new TtDvcntModel();
            TtDvcntLive ttdvcnt = new TtDvcntLive();
            ttdvcnt = modelDvcnt.getTtDvcnt(Mid);

            Byte status = 3; // (1)CN/PGD Complete
            ttdvcnt.setStatusDuyet(status);

            Byte statusDvcnt = 8; //
            ttdvcnt.setStatusDvcnt(statusDvcnt);

            // Reset tat ca USER, NGAYDUYET, GHICHU về null
            ttdvcnt.setUser2Cn("");
            ttdvcnt.setUser2CnNote("");
            ttdvcnt.setUser2CnDate(null);

            ttdvcnt.setUser1Pkhdn("");
            ttdvcnt.setUser1PkhdnNote("");
            ttdvcnt.setUser1PkhdnDate(null);

            ttdvcnt.setUser2Pkhdn("");
            ttdvcnt.setUser2PkhdnNote("");
            ttdvcnt.setUser2PkhdnDate(null);

            ttdvcnt.setUser1Ptdbh("");
            ttdvcnt.setUser1PtdbhNote("");
            ttdvcnt.setUser1PtdbhDate(null);

            ttdvcnt.setUser2Ptdbh("");
            ttdvcnt.setUser2PtdbhNote("");
            ttdvcnt.setUser2PtdbhDate(null);

            ttdvcnt.setUser1Ptnt("");
            ttdvcnt.setUser1PtntNote("");
            ttdvcnt.setUser1PtntDate(null);

            ttdvcnt.setUser2Ptnt("");
            ttdvcnt.setUser2PtntNote("");
            ttdvcnt.setUser2PtntDate(null);

            modelDvcnt.update(ttdvcnt);
            m.addAttribute("status", ttdvcnt.getStatusDuyet());
        }
        return "redirect:dvcntdangxuly.html";
    }

    @RequestMapping(value = "chitietposthemmoi", method = RequestMethod.GET)
    public String duyetposthemmoi(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();
        long _id = Long.parseLong(id);

        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive p = new TtPosTempLive();
        p = model.getTtPosTemp(_id);

        String mid = p.getMid();

        m.addAttribute("maDvcnt", p.getMid());
        m.addAttribute("tenDvcnt", p.getTenDvcnt());
        m.addAttribute("loaitien", p.getLoaitien());
        m.addAttribute("dongmay", p.getDongmay());
        m.addAttribute("teninhoadon", p.getTeninhoadon());
        m.addAttribute("soTktgtt", p.getSoTktgtt());
        m.addAttribute("tenchutk", p.getTenchutk());
        m.addAttribute("diachiLapdat", p.getDiachiLapdat());

        m.addAttribute("gddb1", p.getGddb1());
        m.addAttribute("gddb2", p.getGddb2());
        m.addAttribute("gddb3", p.getGddb3());
        m.addAttribute("gddb4", p.getGddb4());
        m.addAttribute("gddb5", p.getGddb5());
        m.addAttribute("gddb6", p.getGddb6());
        m.addAttribute("gddb7", p.getGddb7());
        m.addAttribute("gddb8", p.getGddb8());
        m.addAttribute("gddb9", p.getGddb9());

        m.addAttribute("hanmucVnd", p.getHanmucVnd());
        m.addAttribute("hanmucUsd", p.getHanmucUsd());
        m.addAttribute("ghichu", p.getGhichu());
        m.addAttribute("tenNganhNghe", p.getTenNganhNghe());
        m.addAttribute("tienkyquyMoto", p.getPhimo());

        return "chitietposthemmoi";
    }

    // export PDF
    @RequestMapping(value = "export", method = RequestMethod.GET)
    public String exportPDF(HttpServletRequest request, Model m,
            @RequestParam(value = "id", required = false) String id,
            HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        m.addAttribute("maDvcnt", id);

        // Số lượng POS_TEMP đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(id);
        m.addAttribute("soluongdagan", soluongdagan);

        // Số lượng POS đã đăng ký
        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = modelDvcnt.getTtDvcnt(id);
        int _soluongPos = ttdvcnt.getSlpos();

        if (_soluongPos > soluongdagan) {
            String error = "Chưa gán gán đủ " + _soluongPos + " máy POS cho ĐVCNT " + id;
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(id);
            Byte status = 1;
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);
            return "themthongtinlapdatpos";
        } else if (_soluongPos < soluongdagan) {
//            String error = "Gán thừa thông tin lắp đặt. Xin kiểm tra lại !";
//            m.addAttribute("error", error);
//            m.addAttribute("lstPosTemp", modelTemp.getAllById(id));
//            TtDvcntLive dvcnt = new TtDvcntLive();
//            dvcnt = modelDvcnt.getTtDvcnt(id);
//            Byte status = 1;
//            dvcnt.setStatusDuyet(status);
//            modelDvcnt.update(dvcnt);
//            return "themthongtinlapdatpos";
        }

        // Lấy ngay/thang/nam hiện tại
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        m.addAttribute("day", day);
        m.addAttribute("month", month);
        m.addAttribute("year", year);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        m.addAttribute("tendonviVn", p.getTenDvcntVn());
        m.addAttribute("tendonviEn", p.getTenDvcntEn());
        m.addAttribute("diachi", p.getDiachiDvcnt());
        m.addAttribute("sdtdvcnt", p.getSdtDvcnt());
        m.addAttribute("soGpdkkd", p.getGpdkkdso());

        int gpdkkdNgaycap = p.getGpdkkdNgaycap();
        String str_gpdkkdNgaycap = String.valueOf(gpdkkdNgaycap);
        String nam_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(0, 4);
        String thang_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(4, 6);
        String ngay_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(6, 8);
        String _GpdkkdNgaycap = ngay_gpdkkdNgaycap + "/" + thang_gpdkkdNgaycap + "/" + nam_gpdkkdNgaycap;
        m.addAttribute("GpdkkdNgaycap", _GpdkkdNgaycap);

        m.addAttribute("noiCapGpkd", p.getGpdkkdNoicap());
        m.addAttribute("tenNguoidaidien", p.getGpdkkdTennguoidaidien());
        m.addAttribute("GpdkkdChucvu", p.getGpdkkdChucvu());
        m.addAttribute("GpdkkdCmnd", p.getGpdkkdCmnd());

        int GpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        String str_GpdkkdNgaycapCmnd = String.valueOf(GpdkkdNgaycapCmnd);
        String nam_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(0, 4);
        String thang_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(4, 6);
        String ngay_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(6, 8);
        String _GpdkkdNgaycapCmnd = ngay_GpdkkdNgaycapCmnd + "/" + thang_GpdkkdNgaycapCmnd + "/" + nam_GpdkkdNgaycapCmnd;
        m.addAttribute("GpdkkdNgaycapCmnd", _GpdkkdNgaycapCmnd);

        m.addAttribute("GpdkkdNoicap", p.getGpdkkdNoicap());
        m.addAttribute("masothue", p.getMasothue());
        m.addAttribute("nguoidaidienkyhopdong", p.getTennguoiKyhopdong());
        m.addAttribute("ChucVuNguoiyhopdong", p.getChucvuHopdong());
        m.addAttribute("CmndNguoiyhopdong", p.getCmndHopdong());

        int NgaycapCmndHopdong = p.getNgaycapCmndHopdong();
        String str_NgaycapCmndHopdong = String.valueOf(NgaycapCmndHopdong);
        String nam_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(0, 4);
        String thang_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(4, 6);
        String ngay_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(6, 8);
        String _NgaycapCmndHopdong = ngay_NgaycapCmndHopdong + "/" + thang_NgaycapCmndHopdong + "/" + nam_NgaycapCmndHopdong;
        m.addAttribute("NgaycapCmndHopdong", _NgaycapCmndHopdong);

        m.addAttribute("NoiCapCmndNguoiyhopdong", p.getNoicapCmndHopdong());
        m.addAttribute("souyquyen", p.getSoUyquyen());

        String _NgayUyquyen = "";
        if (p.getNgayUyquyen() != null) {
            int NgayUyquyen = p.getNgayUyquyen();

            if (NgayUyquyen != 0) {
                String str_NgayUyquyen = String.valueOf(NgayUyquyen);
                String nam_NgayUyquyen = str_NgayUyquyen.substring(0, 4);
                String thang_NgayUyquyen = str_NgayUyquyen.substring(4, 6);
                String ngay_NgayUyquyen = str_NgayUyquyen.substring(6, 8);
                _NgayUyquyen = ngay_NgayUyquyen + "/" + thang_NgayUyquyen + "/" + nam_NgayUyquyen;
            } else {
                _NgayUyquyen = "0";
            }
        }

        m.addAttribute("ngayuyquyen", _NgayUyquyen);
        m.addAttribute("nganhanghoptac", p.getNganhangHoptac());
        m.addAttribute("nganhnghekinhdoanh", p.getNganhnghekd());

        long _doanhsothanhtoandukien = p.getDoanhsothanhtoandukien();
        DecimalFormat formatter = new DecimalFormat("###,###,###");
        String doanhsothanhtoandukien = formatter.format(_doanhsothanhtoandukien);
        m.addAttribute("doanhsodukien", doanhsothanhtoandukien);

        m.addAttribute("xeploai", p.getXeploai());
        m.addAttribute("landk", p.getLandk());
        m.addAttribute("soluongdk", p.getSlpos());

        TtPosTempModel _modelTemp = new TtPosTempModel();
        m.addAttribute("lstPosTemp", _modelTemp.getAllById(id));

        if (p.getPhiGhinoscb() == null) {
            String PhiGhinoscb = "";
            m.addAttribute("phiGhinoscb", PhiGhinoscb);
        } else {
            m.addAttribute("phiGhinoscb", p.getPhiGhinoscb());
        }
        if (p.getPhiGhinoLienminh() == null) {
            String phiGhinoLienminh = "";
            m.addAttribute("phiGhinoLienminh", phiGhinoLienminh);
        } else {
            m.addAttribute("phiGhinoLienminh", p.getPhiGhinoLienminh());
        }
        if (p.getPhiVisa() == null) {
            String PhiVisa = "";
            m.addAttribute("phiVisa", PhiVisa);
        } else {
            m.addAttribute("phiVisa", p.getPhiVisa());
        }
        if (p.getPhiMastercard() == null) {
            String PhiMastercard = "";
            m.addAttribute("phiMastercard", PhiMastercard);
        } else {
            m.addAttribute("phiMastercard", p.getPhiMastercard());
        }
        if (p.getPhiJcb() == null) {
            String PhiJcb = "";
            m.addAttribute("phiJcb", PhiJcb);
        } else {
            m.addAttribute("phiJcb", p.getPhiJcb());
        }
        if (p.getPhiCup() == null) {
            String PhiCup = "";
            m.addAttribute("phiCup", PhiCup);
        } else {
            m.addAttribute("phiCup", p.getPhiCup());
        }
        if (p.getPhiDiscover() == null) {
            String PhiDiscover = "";
            m.addAttribute("phiDiscover", PhiDiscover);
        } else {
            m.addAttribute("phiDiscover", p.getPhiDiscover());
        }
        if (p.getPhiThekhac() == null) {
            String PhiThekhac = "";
            m.addAttribute("phiThekhac", PhiThekhac);
        } else {
            m.addAttribute("phiThekhac", p.getPhiThekhac());
        }

        m.addAttribute("loaitien", p.getLoaitien());
        m.addAttribute("tenthekhac", p.getTenThekhac());

        // Lay thong tin user nhap duyet
        UserAccModel modelUser = new UserAccModel();
        UserAcc userThaoTac = new UserAcc();

        String userNhapDonVi = p.getUser1Cn();
        userThaoTac = modelUser.getUserByUsername(userNhapDonVi);
        m.addAttribute("userNhapDonVi", userThaoTac.getHoten());

        String userDuyetDonVi = p.getUser2Cn();
        userThaoTac = modelUser.getUserByUsername(userDuyetDonVi);
        m.addAttribute("userDuyetDonVi", userThaoTac.getHoten());

        // Lay thong tin Hi-staff
        String get_direct_name = p.getDirectCode() + " - " + p.getDirectName();
        String get_direct_job = " - (" + p.getDirectJobtitleCode() + ") - " + p.getDirectJobtitleName();
        String get_direct_employee = get_direct_name + get_direct_job;
        m.addAttribute("get_direct_employee", get_direct_employee);

        if (p.getIndirectCode() != null) {
            String get_inDirect_name = p.getIndirectCode() + " - " + p.getIndirectName();
            String get_indirect_job = " - (" + p.getIndirectJobtitleCode() + ") - " + p.getIndirectJobtitleName();
            String get_inDirect_employee = get_inDirect_name + get_indirect_job;
            m.addAttribute("get_inDirect_employee", get_inDirect_employee);
        }

//        long phiMo = p.getTienkyquyMoto();
//        String _phiMo = formatter.format(phiMo);
//        m.addAttribute("phiMo", _phiMo);
        return "export";
    }

    @RequestMapping(value = "exportlapthempos", method = RequestMethod.GET)
    public String exportlapthempos(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        m.addAttribute("maDvcnt", id);

        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(id);
        m.addAttribute("soluongdagan", soluongdagan);

        // Số lượng POS đã đăng ký
        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = modelDvcnt.getTtDvcnt(id);
        int _soluongPos = ttdvcnt.getSlpos();

        if (_soluongPos > soluongdagan) {
            String error = "Chưa gán gán đủ " + _soluongPos + " máy POS cho ĐVCNT " + id;
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(id);
            Byte status = 1;
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);
            return "themthongtinlapdatpos";
        }

        // Lấy ngay/thang/nam hiện tại
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        m.addAttribute("day", day);
        m.addAttribute("month", month);
        m.addAttribute("year", year);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        m.addAttribute("tendonviVn", p.getTenDvcntVn());
        m.addAttribute("tendonviEn", p.getTenDvcntEn());
        m.addAttribute("diachi", p.getDiachiDvcnt());
        m.addAttribute("sdtdvcnt", p.getSdtDvcnt());
        m.addAttribute("soGpdkkd", p.getGpdkkdso());

        int gpdkkdNgaycap = p.getGpdkkdNgaycap();
        String str_gpdkkdNgaycap = String.valueOf(gpdkkdNgaycap);
        String nam_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(0, 4);
        String thang_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(4, 6);
        String ngay_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(6, 8);
        String _GpdkkdNgaycap = ngay_gpdkkdNgaycap + "/" + thang_gpdkkdNgaycap + "/" + nam_gpdkkdNgaycap;
        m.addAttribute("GpdkkdNgaycap", _GpdkkdNgaycap);

        m.addAttribute("noiCapGpkd", p.getGpdkkdNoicap());
        m.addAttribute("tenNguoidaidien", p.getGpdkkdTennguoidaidien());
        m.addAttribute("GpdkkdChucvu", p.getGpdkkdChucvu());
        m.addAttribute("GpdkkdCmnd", p.getGpdkkdCmnd());

        int GpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        String str_GpdkkdNgaycapCmnd = String.valueOf(GpdkkdNgaycapCmnd);
        String nam_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(0, 4);
        String thang_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(4, 6);
        String ngay_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(6, 8);
        String _GpdkkdNgaycapCmnd = ngay_GpdkkdNgaycapCmnd + "/" + thang_GpdkkdNgaycapCmnd + "/" + nam_GpdkkdNgaycapCmnd;
        m.addAttribute("GpdkkdNgaycapCmnd", _GpdkkdNgaycapCmnd);

        m.addAttribute("GpdkkdNoicap", p.getGpdkkdNoicap());
        m.addAttribute("masothue", p.getMasothue());
        m.addAttribute("nguoidaidienkyhopdong", p.getTennguoiKyhopdong());
        m.addAttribute("ChucVuNguoiyhopdong", p.getChucvuHopdong());
        m.addAttribute("CmndNguoiyhopdong", p.getCmndHopdong());

        int NgaycapCmndHopdong = p.getNgaycapCmndHopdong();
        String str_NgaycapCmndHopdong = String.valueOf(NgaycapCmndHopdong);
        String nam_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(0, 4);
        String thang_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(4, 6);
        String ngay_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(6, 8);
        String _NgaycapCmndHopdong = ngay_NgaycapCmndHopdong + "/" + thang_NgaycapCmndHopdong + "/" + nam_NgaycapCmndHopdong;
        m.addAttribute("NgaycapCmndHopdong", _NgaycapCmndHopdong);

        m.addAttribute("NoiCapCmndNguoiyhopdong", p.getNoicapCmndHopdong());
        m.addAttribute("souyquyen", p.getSoUyquyen());

        int NgayUyquyen = p.getNgayUyquyen();
        String _NgayUyquyen = "";

        if (NgayUyquyen != 0) {
            String str_NgayUyquyen = String.valueOf(NgayUyquyen);
            String nam_NgayUyquyen = str_NgayUyquyen.substring(0, 4);
            String thang_NgayUyquyen = str_NgayUyquyen.substring(4, 6);
            String ngay_NgayUyquyen = str_NgayUyquyen.substring(6, 8);
            _NgayUyquyen = ngay_NgayUyquyen + "/" + thang_NgayUyquyen + "/" + nam_NgayUyquyen;
        } else {
            _NgayUyquyen = "0";
        }

        m.addAttribute("ngayuyquyen", _NgayUyquyen);

        m.addAttribute("nganhanghoptac", p.getNganhangHoptac());
        m.addAttribute("nganhnghekinhdoanh", p.getNganhnghekd());

        long _doanhsothanhtoandukien = p.getDoanhsothanhtoandukien();
        DecimalFormat formatter = new DecimalFormat("###,###,###");
        String doanhsothanhtoandukien = formatter.format(_doanhsothanhtoandukien);
        m.addAttribute("doanhsodukien", doanhsothanhtoandukien);

        m.addAttribute("xeploai", p.getXeploai());
        m.addAttribute("landk", p.getLandk());
        m.addAttribute("soluongdk", p.getSlpos());

        TtPosTempModel _modelTemp = new TtPosTempModel();
        m.addAttribute("lstPosTemp", _modelTemp.getAllById(id));

        if (p.getPhiGhinoscb() == null) {
            String PhiGhinoscb = "";
            m.addAttribute("phiGhinoscb", PhiGhinoscb);
        } else {
            m.addAttribute("phiGhinoscb", p.getPhiGhinoscb());
        }
        if (p.getPhiGhinoLienminh() == null) {
            String phiGhinoLienminh = "";
            m.addAttribute("phiGhinoLienminh", phiGhinoLienminh);
        } else {
            m.addAttribute("phiGhinoLienminh", p.getPhiGhinoLienminh());
        }
        if (p.getPhiVisa() == null) {
            String PhiVisa = "";
            m.addAttribute("phiVisa", PhiVisa);
        } else {
            m.addAttribute("phiVisa", p.getPhiVisa());
        }
        if (p.getPhiMastercard() == null) {
            String PhiMastercard = "";
            m.addAttribute("phiMastercard", PhiMastercard);
        } else {
            m.addAttribute("phiMastercard", p.getPhiMastercard());
        }
        if (p.getPhiJcb() == null) {
            String PhiJcb = "";
            m.addAttribute("phiJcb", PhiJcb);
        } else {
            m.addAttribute("phiJcb", p.getPhiJcb());
        }
        if (p.getPhiCup() == null) {
            String PhiCup = "";
            m.addAttribute("phiCup", PhiCup);
        } else {
            m.addAttribute("phiCup", p.getPhiCup());
        }
        if (p.getPhiDiscover() == null) {
            String PhiDiscover = "";
            m.addAttribute("phiDiscover", PhiDiscover);
        } else {
            m.addAttribute("phiDiscover", p.getPhiDiscover());
        }
        if (p.getPhiThekhac() == null) {
            String PhiThekhac = "";
            m.addAttribute("phiThekhac", PhiThekhac);
        } else {
            m.addAttribute("phiThekhac", p.getPhiThekhac());
        }

        m.addAttribute("loaitien", p.getLoaitien());
        m.addAttribute("tenthekhac", p.getTenThekhac());

//        long phiMo = p.getTienkyquyMoto();
//        String _phiMo = formatter.format(phiMo);
//        m.addAttribute("phiMo", _phiMo);
        return "exportlapthempos";
    }

    // export PDF
    @RequestMapping(value = "export2", method = RequestMethod.GET)
    public String exportPDF2(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        m.addAttribute("maDvcnt", id);

        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(id);
        m.addAttribute("soluongdagan", soluongdagan);

        // Số lượng POS đã đăng ký
        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = modelDvcnt.getTtDvcnt(id);
        Byte statusDvcnt = ttdvcnt.getStatusDvcnt();
        int _soluongPos = ttdvcnt.getSlpos();

        if (_soluongPos > soluongdagan) {
            String error = "Chưa gán gán đủ " + _soluongPos + " máy POS cho ĐVCNT " + id;
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(id);
            Byte status = 1;
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);
            return "themthongtinlapdatpos";
        } else if (_soluongPos < soluongdagan && statusDvcnt != 3 && statusDvcnt != 4 && statusDvcnt != 5 && statusDvcnt != 8) {
            String error = "Gán thừa thông tin lắp đặt. Xin kiểm tra lại !";
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(id);
            Byte status = 1;
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);
            return "themthongtinlapdatpos";
        }

        // Lấy ngay/thang/nam hiện tại
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        m.addAttribute("day", day);
        m.addAttribute("month", month);
        m.addAttribute("year", year);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        m.addAttribute("tendonviVn", p.getTenDvcntVn());
        m.addAttribute("tendonviEn", p.getTenDvcntEn());
        m.addAttribute("diachi", p.getDiachiDvcnt());
        m.addAttribute("sdtdvcnt", p.getSdtDvcnt());
        m.addAttribute("soGpdkkd", p.getGpdkkdso());

        int gpdkkdNgaycap = p.getGpdkkdNgaycap();
        String str_gpdkkdNgaycap = String.valueOf(gpdkkdNgaycap);
        String nam_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(0, 4);
        String thang_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(4, 6);
        String ngay_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(6, 8);
        String _GpdkkdNgaycap = ngay_gpdkkdNgaycap + "/" + thang_gpdkkdNgaycap + "/" + nam_gpdkkdNgaycap;
        m.addAttribute("GpdkkdNgaycap", _GpdkkdNgaycap);

        m.addAttribute("noiCapGpkd", p.getGpdkkdNoicap());
        m.addAttribute("tenNguoidaidien", p.getGpdkkdTennguoidaidien());
        m.addAttribute("GpdkkdChucvu", p.getGpdkkdChucvu());
        m.addAttribute("GpdkkdCmnd", p.getGpdkkdCmnd());

        int GpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        String str_GpdkkdNgaycapCmnd = String.valueOf(GpdkkdNgaycapCmnd);
        String nam_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(0, 4);
        String thang_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(4, 6);
        String ngay_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(6, 8);
        String _GpdkkdNgaycapCmnd = ngay_GpdkkdNgaycapCmnd + "/" + thang_GpdkkdNgaycapCmnd + "/" + nam_GpdkkdNgaycapCmnd;
        m.addAttribute("GpdkkdNgaycapCmnd", _GpdkkdNgaycapCmnd);

        m.addAttribute("GpdkkdNoicap", p.getGpdkkdNoicap());
        m.addAttribute("masothue", p.getMasothue());
        m.addAttribute("nguoidaidienkyhopdong", p.getTennguoiKyhopdong());
        m.addAttribute("ChucVuNguoiyhopdong", p.getChucvuHopdong());
        m.addAttribute("CmndNguoiyhopdong", p.getCmndHopdong());

        int NgaycapCmndHopdong = p.getNgaycapCmndHopdong();
        String str_NgaycapCmndHopdong = String.valueOf(NgaycapCmndHopdong);
        String nam_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(0, 4);
        String thang_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(4, 6);
        String ngay_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(6, 8);
        String _NgaycapCmndHopdong = ngay_NgaycapCmndHopdong + "/" + thang_NgaycapCmndHopdong + "/" + nam_NgaycapCmndHopdong;
        m.addAttribute("NgaycapCmndHopdong", _NgaycapCmndHopdong);

        m.addAttribute("NoiCapCmndNguoiyhopdong", p.getNoicapCmndHopdong());
        m.addAttribute("souyquyen", p.getSoUyquyen());

        String _NgayUyquyen = "";
        if (p.getNgayUyquyen() == null) {
            _NgayUyquyen = "0";
        } else {
            int NgayUyquyen = p.getNgayUyquyen();

            if (NgayUyquyen != 0) {
                String str_NgayUyquyen = String.valueOf(NgayUyquyen);
                String nam_NgayUyquyen = str_NgayUyquyen.substring(0, 4);
                String thang_NgayUyquyen = str_NgayUyquyen.substring(4, 6);
                String ngay_NgayUyquyen = str_NgayUyquyen.substring(6, 8);
                _NgayUyquyen = ngay_NgayUyquyen + "/" + thang_NgayUyquyen + "/" + nam_NgayUyquyen;
            } else {
                _NgayUyquyen = "0";
            }
        }

        m.addAttribute("ngayuyquyen", _NgayUyquyen);
        m.addAttribute("nganhanghoptac", p.getNganhangHoptac());
        m.addAttribute("nganhnghekinhdoanh", p.getNganhnghekd());

        long _doanhsothanhtoandukien = p.getDoanhsothanhtoandukien();
        DecimalFormat formatter = new DecimalFormat("###,###,###");
        String doanhsothanhtoandukien = formatter.format(_doanhsothanhtoandukien);
        m.addAttribute("doanhsodukien", doanhsothanhtoandukien);

        m.addAttribute("xeploai", p.getXeploai());
        m.addAttribute("landk", p.getLandk());
        m.addAttribute("soluongdk", p.getSlpos());

        TtPosTempModel _modelTemp = new TtPosTempModel();
        m.addAttribute("lstPosTemp", _modelTemp.getAllById(id));

        if (p.getPhiGhinoscb() == null) {
            String PhiGhinoscb = "";
            m.addAttribute("phiGhinoscb", PhiGhinoscb);
        } else {
            m.addAttribute("phiGhinoscb", p.getPhiGhinoscb());
        }
        if (p.getPhiGhinoLienminh() == null) {
            String phiGhinoLienminh = "";
            m.addAttribute("phiGhinoLienminh", phiGhinoLienminh);
        } else {
            m.addAttribute("phiGhinoLienminh", p.getPhiGhinoLienminh());
        }
        if (p.getPhiVisa() == null) {
            String PhiVisa = "";
            m.addAttribute("phiVisa", PhiVisa);
        } else {
            m.addAttribute("phiVisa", p.getPhiVisa());
        }
        if (p.getPhiMastercard() == null) {
            String PhiMastercard = "";
            m.addAttribute("phiMastercard", PhiMastercard);
        } else {
            m.addAttribute("phiMastercard", p.getPhiMastercard());
        }
        if (p.getPhiJcb() == null) {
            String PhiJcb = "";
            m.addAttribute("phiJcb", PhiJcb);
        } else {
            m.addAttribute("phiJcb", p.getPhiJcb());
        }
        if (p.getPhiCup() == null) {
            String PhiCup = "";
            m.addAttribute("phiCup", PhiCup);
        } else {
            m.addAttribute("phiCup", p.getPhiCup());
        }
        if (p.getPhiDiscover() == null) {
            String PhiDiscover = "";
            m.addAttribute("phiDiscover", PhiDiscover);
        } else {
            m.addAttribute("phiDiscover", p.getPhiDiscover());
        }
        if (p.getPhiThekhac() == null) {
            String PhiThekhac = "";
            m.addAttribute("phiThekhac", PhiThekhac);
        } else {
            m.addAttribute("phiThekhac", p.getPhiThekhac());
        }

        m.addAttribute("loaitien", p.getLoaitien());
        m.addAttribute("tenthekhac", p.getTenThekhac());
        m.addAttribute("loaihinhdvcnt", p.getLoaihinhDvcnt());

        // Phong Khach Hang Doanh Nghiep
        String usernameDoanhNghiep = p.getUser1Pkhdn();
        UserAccModel modelUser = new UserAccModel();
        UserAcc nguoidung = new UserAcc();
        nguoidung = modelUser.getUserByUsername(usernameDoanhNghiep);
        String fullnamedn = nguoidung.getHoten();
        m.addAttribute("fullnameDn", fullnamedn);
        m.addAttribute("ghichu1dn", p.getUser1PkhdnNote());

        String username2DoanhNghiep = p.getUser2Pkhdn();
        UserAcc nguoidung2 = new UserAcc();
        nguoidung2 = modelUser.getUserByUsername(username2DoanhNghiep);
        String fullname2dn = nguoidung2.getHoten();
        m.addAttribute("fullname2dn", fullname2dn);
        m.addAttribute("ghichu2dn", p.getUser2PkhdnNote());

        // Phong Khach Hang Ca Nhan
        String username = p.getUser1Ptdbh();
//        UserAccModel modelUser = new UserAccModel();
//        UserAcc nguoidung = new UserAcc();
        nguoidung = modelUser.getUserByUsername(username);
        String fullname = nguoidung.getHoten();
        m.addAttribute("fullname", fullname);
        m.addAttribute("ghichu1", p.getUser1PtdbhNote());

        String username2 = p.getUser2Ptdbh();
//        UserAcc nguoidung2 = new UserAcc();
        nguoidung2 = modelUser.getUserByUsername(username2);
        String fullname2 = nguoidung2.getHoten();
        m.addAttribute("fullname2", fullname2);
        m.addAttribute("ghichu2", p.getUser2PtdbhNote());

        // lấy thông tin user ở phòng khách hàng doanh nghiệp
        if (p.getUser1PkhdnDate() != null && p.getUser1PkhdnDate() != 0) {
            long getUser1DnNgaynhap = p.getUser1PkhdnDate();
            String str_getUser1DnNgaynhap = String.valueOf(getUser1DnNgaynhap);
            String nam_getUser1CnNgaynhap = str_getUser1DnNgaynhap.substring(0, 4);
            String thang_getUser1CnNgaynhap = str_getUser1DnNgaynhap.substring(4, 6);
            String ngay_getUser1CnNgaynhap = str_getUser1DnNgaynhap.substring(6, 8);
            String gio_getUser1CnNgaynhap = str_getUser1DnNgaynhap.substring(8, 10);
            String phut_getUser1CnNgaynhap = str_getUser1DnNgaynhap.substring(10, 12);
            String giay_getUser1CnNgaynhap = str_getUser1DnNgaynhap.substring(12, 14);
            String _getUser1CnNgaynhap = ngay_getUser1CnNgaynhap + "/" + thang_getUser1CnNgaynhap + "/" + nam_getUser1CnNgaynhap + "   " + gio_getUser1CnNgaynhap + ":" + phut_getUser1CnNgaynhap + ":" + giay_getUser1CnNgaynhap;
            m.addAttribute("User1DoanhNghiepNgaynhap", _getUser1CnNgaynhap);
        }

        if (p.getUser2PkhdnDate() != null && p.getUser2PkhdnDate() != 0) {
            long getUser2DnNgaynhap = p.getUser2PkhdnDate();
            String str_getUser2DnNgaynhap = String.valueOf(getUser2DnNgaynhap);
            String nam_getUser2CnNgaynhap = str_getUser2DnNgaynhap.substring(0, 4);
            String thang_getUser2CnNgaynhap = str_getUser2DnNgaynhap.substring(4, 6);
            String ngay_getUser2CnNgaynhap = str_getUser2DnNgaynhap.substring(6, 8);
            String gio_getUser2CnNgaynhap = str_getUser2DnNgaynhap.substring(8, 10);
            String phut_getUser2CnNgaynhap = str_getUser2DnNgaynhap.substring(10, 12);
            String giay_getUser2CnNgaynhap = str_getUser2DnNgaynhap.substring(12, 14);
            String _getUser2CnNgaynhap = ngay_getUser2CnNgaynhap + "/" + thang_getUser2CnNgaynhap + "/" + nam_getUser2CnNgaynhap + "   " + gio_getUser2CnNgaynhap + ":" + phut_getUser2CnNgaynhap + ":" + giay_getUser2CnNgaynhap;
            m.addAttribute("User2DoanhNghiepNgaynhap", _getUser2CnNgaynhap);
        }

        // lấy thông tin user ở phòng khách hàng cá nhân
        if (p.getUser1PtdbhDate() != null && p.getUser1PtdbhDate() != 0) {
            long getUser1PtdbhDate = p.getUser1PtdbhDate();
            String str_getUser1PtdbhDate = String.valueOf(getUser1PtdbhDate);
            String nam_getUser1PtdbhDate = str_getUser1PtdbhDate.substring(0, 4);
            String thang_getUser1PtdbhDate = str_getUser1PtdbhDate.substring(4, 6);
            String ngay_getUser1PtdbhDate = str_getUser1PtdbhDate.substring(6, 8);
            String gio_getUser1PtdbhDate = str_getUser1PtdbhDate.substring(8, 10);
            String phut_getUser1PtdbhDate = str_getUser1PtdbhDate.substring(10, 12);
            String giay_getUser1PtdbhDate = str_getUser1PtdbhDate.substring(12, 14);
            String _getUser1PtdbhDate = ngay_getUser1PtdbhDate + "/" + thang_getUser1PtdbhDate + "/" + nam_getUser1PtdbhDate + "   "
                    + gio_getUser1PtdbhDate + ":" + phut_getUser1PtdbhDate + ":" + giay_getUser1PtdbhDate;
            m.addAttribute("User1CaNhanNgaynhap", _getUser1PtdbhDate);
        }

        //String str_User2PtdbhDate = String.valueOf(p.getUser2PtdbhDate());
        //long User2PtdbhDate = p.getUser2PtdbhDate();
        if (p.getUser2PtdbhDate() != null && p.getUser2PtdbhDate() != 0) {
            long getUser2CnNgaynhap = p.getUser2PtdbhDate();
            String str_getUser2CnNgaynhap = String.valueOf(getUser2CnNgaynhap);
            String nam_getUser2CnNgaynhap = str_getUser2CnNgaynhap.substring(0, 4);
            String thang_getUser2CnNgaynhap = str_getUser2CnNgaynhap.substring(4, 6);
            String ngay_getUser2CnNgaynhap = str_getUser2CnNgaynhap.substring(6, 8);
            String gio_getUser2CnNgaynhap = str_getUser2CnNgaynhap.substring(8, 10);
            String phut_getUser2CnNgaynhap = str_getUser2CnNgaynhap.substring(10, 12);
            String giay_getUser2CnNgaynhap = str_getUser2CnNgaynhap.substring(12, 14);
            String _getUser2CnNgaynhap = ngay_getUser2CnNgaynhap + "/" + thang_getUser2CnNgaynhap + "/" + nam_getUser2CnNgaynhap + "   " + gio_getUser2CnNgaynhap + ":" + phut_getUser2CnNgaynhap + ":" + giay_getUser2CnNgaynhap;
            m.addAttribute("User2CaNhanNgaynhap", _getUser2CnNgaynhap);
        }

        // Lay thong tin user nhap duyet        
        UserAcc userThaoTac = new UserAcc();

        String userNhapDonVi = p.getUser1Cn();
        userThaoTac = modelUser.getUserByUsername(userNhapDonVi);
        m.addAttribute("userNhapDonVi", userThaoTac.getHoten());

        String userDuyetDonVi = p.getUser2Cn();
        userThaoTac = modelUser.getUserByUsername(userDuyetDonVi);
        m.addAttribute("userDuyetDonVi", userThaoTac.getHoten());

        // Lay thong tin Hi-staff
        String get_direct_name = p.getDirectCode() + " - " + p.getDirectName();
        String get_direct_job = " - (" + p.getDirectJobtitleCode() + ") - " + p.getDirectJobtitleName();
        String get_direct_employee = get_direct_name + get_direct_job;
        m.addAttribute("get_direct_employee", get_direct_employee);

        if (p.getIndirectCode() != null) {
            String get_inDirect_name = p.getIndirectCode() + " - " + p.getIndirectName();
            String get_indirect_job = " - (" + p.getIndirectJobtitleCode() + ") - " + p.getIndirectJobtitleName();
            String get_inDirect_employee = get_inDirect_name + get_indirect_job;
            m.addAttribute("get_inDirect_employee", get_inDirect_employee);
        }

//        long phiMo = p.getTienkyquyMoto();
//        String _phiMo = formatter.format(phiMo);
//        m.addAttribute("phiMo", _phiMo);
        return "export2";
    }

    @RequestMapping(value = "exportpdf", method = RequestMethod.GET)
    public String exportpdf(HttpServletRequest request, Model m) throws FileNotFoundException {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        System.out.println("PDF Created!");

        return "redirect:dvcntdangxuly.html";
    }

    @RequestMapping(value = "uploadSingleFile", method = RequestMethod.GET)
    public String uploadSingleFile(HttpServletRequest request, Model m) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }
        return "fileUpload";
    }

    @RequestMapping(value = "undo", method = RequestMethod.GET)
    public String undo(HttpServletRequest request, Model m) {
        _session = request.getSession();
        String mid = (String) _session.getAttribute("_maDvcnt");
        return duyet(m, mid, request);
    }

    @RequestMapping(value = "exporteditinformation", method = RequestMethod.GET)
    public String exportEditInformation(Model m, HttpServletRequest request, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();
        String mid = id;

        // Lấy ngay/thang/nam hiện tại
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        m.addAttribute("day", day);
        m.addAttribute("month", month);
        m.addAttribute("year", year);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        // Thông tin DVCNT cũ
        boolean check = true;
//        String a = p.getedit1();
//        String aa = p.getedit2();
//        String aaa = p.getedit3();
//        String aaaa = p.getedit4();
        if (p.getedit1() != null) {
            m.addAttribute("tenDvcnt", p.getedit1());
        }
        if (p.getedit2() != null) {
            m.addAttribute("tenNguoiDaiDienGPKD", p.getedit2());
        }
        if (p.getedit3() != null) {
            m.addAttribute("CMNDnguoiDaiDienGPKD", p.getedit3());
        }
        if (p.getedit4() != null) {
            m.addAttribute("diachiDvcnt", p.getedit4());
        } else {
            check = false;
        }
        m.addAttribute("check", check);

        // Thông tin DVCNT mới
        m.addAttribute("_tenDvcnt", p.getTenDvcntVn());
        m.addAttribute("_tenNguoiDaiDienGPKD", p.getGpdkkdTennguoidaidien());
        m.addAttribute("_CMNDnguoiDaiDienGPKD", p.getGpdkkdCmnd());
        m.addAttribute("_diachiDvcnt", p.getDiachiDvcnt());

        // Thông tin edit POS
        TtPosTempModel modelTemp = new TtPosTempModel();
        int size = modelTemp.getDSPOSChinhSua1(mid).size();
        m.addAttribute("size", size);
        m.addAttribute("lst", modelTemp.getDSPOSChinhSua1(mid));

        List<TtPosTempLive> listTemp = new ArrayList<TtPosTempLive>();
        listTemp = modelTemp.getDSPOSChinhSua1(mid);
        TtPosTempLive posTemp = new TtPosTempLive();
        for (int i = 0; i < size; i++) {
            posTemp = listTemp.get(i);
            break;
        }
//        Byte a1 = posTemp.geteditGddb1();
//        Byte a2 = posTemp.geteditGddb2();
//        Byte a3 = posTemp.geteditGddb3();
//        Byte a4 = posTemp.geteditGddb4();

        return "exporteditinformation";
    }

    @RequestMapping(value = "sortstatus", method = RequestMethod.GET)
    public String sortSTATUS(Model m, HttpServletRequest request, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();
        _session.setAttribute("checkStatusSort", checkStatusSort);
        int _checkStatusSort = (int) _session.getAttribute("checkStatusSort");
        _checkStatusSort++;
        checkStatusSort++;
        _session.setAttribute("checkStatusSort", _checkStatusSort);

        TtDvcntModel model = new TtDvcntModel();

        if (_checkStatusSort % 2 == 0) {
            // Xếp STATUS duyet giảm dần
            m.addAttribute("lstThemMoi", model.getAll_sortStatus());
        }
        if (_checkStatusSort % 2 != 0) {
            // Xếp STATUS duyet tăng dần
            m.addAttribute("lstThemMoi", model.getAll());
        }
        return "dvcntdangxuly";
    }

    @RequestMapping(value = "sortname", method = RequestMethod.GET)
    public String sortNAME(Model m, HttpServletRequest request, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();
        _session.setAttribute("checkStatusSort", checkStatusSort);
        int _checkStatusSort = (int) _session.getAttribute("checkStatusSort");
        _checkStatusSort++;
        checkStatusSort++;
        _session.setAttribute("checkStatusSort", _checkStatusSort);

        TtDvcntModel model = new TtDvcntModel();

        if (_checkStatusSort % 2 == 0) {
            // Xếp TEN_DVCNTVN duyet tăng dần
            m.addAttribute("lstThemMoi", model.getAll_sortNameAsc());
        }
        if (_checkStatusSort % 2 != 0) {
            // Xếp TEN_DVCNTVN duyet giảm dần
            m.addAttribute("lstThemMoi", model.getAll_sortNameDesc());
        }
        return "dvcntdangxuly";
    }

    @RequestMapping(value = "sortnamedvcntdalap", method = RequestMethod.GET)
    public String sortNAME_dvcntdaplap(Model m, HttpServletRequest request, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();
        _session.setAttribute("checkStatusSort", checkStatusSort);
        int _checkStatusSort = (int) _session.getAttribute("checkStatusSort");
        _checkStatusSort++;
        checkStatusSort++;
        _session.setAttribute("checkStatusSort", _checkStatusSort);

        TtDvcntModel model = new TtDvcntModel();

        if (_checkStatusSort % 2 == 0) {
            // Xếp TEN_DVCNTVN duyet tăng dần
            m.addAttribute("lst", model.getAll_sortNameAsc());
        }
        if (_checkStatusSort % 2 != 0) {
            // Xếp TEN_DVCNTVN duyet giảm dần
            m.addAttribute("lst", model.getAll_sortNameDesc());
        }
        return "danhsachdvcnt";
    }

    @RequestMapping(value = "sortid", method = RequestMethod.GET)
    public String sortMaDvcnt(Model m, HttpServletRequest request, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();
        _session.setAttribute("checkStatusSort", checkStatusSort);
        int _checkStatusSort = (int) _session.getAttribute("checkStatusSort");
        _checkStatusSort++;
        checkStatusSort++;
        _session.setAttribute("checkStatusSort", _checkStatusSort);

        TtDvcntModel model = new TtDvcntModel();

        if (_checkStatusSort % 2 == 0) {
            // Xếp MA_DVCNT duyet tăng dần
            m.addAttribute("lstThemMoi", model.getAll_sortMaDvcntAsc());
        }
        if (_checkStatusSort % 2 != 0) {
            // Xếp MA_DVCNT duyet giảm dần
            m.addAttribute("lstThemMoi", model.getAll_sortMaDvcntDesc());
        }
        return "dvcntdangxuly";
    }

    @RequestMapping(value = "sortiddvcntdalap", method = RequestMethod.GET)
    public String sortMaDvcnt_dvcntDalap(Model m, HttpServletRequest request, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();
        _session.setAttribute("checkStatusSort", checkStatusSort);
        int _checkStatusSort = (int) _session.getAttribute("checkStatusSort");
        _checkStatusSort++;
        checkStatusSort++;
        _session.setAttribute("checkStatusSort", _checkStatusSort);

        TtDvcntModel model = new TtDvcntModel();

        if (_checkStatusSort % 2 == 0) {
            // Xếp MA_DVCNT duyet tăng dần
            m.addAttribute("lst", model.getAll_sortMaDvcntAsc());
        }
        if (_checkStatusSort % 2 != 0) {
            // Xếp MA_DVCNT duyet giảm dần
            m.addAttribute("lst", model.getAll_sortMaDvcntDesc());
        }
        return "danhsachdvcnt";
    }

    @RequestMapping(value = "pagekhoa", method = RequestMethod.GET)
    public String khoa(Model m, HttpServletRequest request, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        _session.setAttribute("_maDvcnt", id);
        _session.setAttribute("_id", id);
        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        m.addAttribute("maDvcnt", p.getMaDvcnt());
        _session.setAttribute("_maDvcnt", p.getMaDvcnt());
        _session.setAttribute("_id", p.getMaDvcnt());
        m.addAttribute("tenDvcntVn", p.getTenDvcntVn());
        _session.setAttribute("tenDvcntVn", p.getTenDvcntVn());
        m.addAttribute("tenDvcntEn", p.getTenDvcntEn());
        m.addAttribute("diachiDvcnt", p.getDiachiDvcnt());
        _session.setAttribute("diachiDvcnt", p.getDiachiDvcnt());
        m.addAttribute("sdtDvcnt", p.getSdtDvcnt());
        m.addAttribute("gpdkkdso", p.getGpdkkdso());

        int gpdkkdNgaycap = p.getGpdkkdNgaycap();
        String str_gpdkkdNgaycap = String.valueOf(gpdkkdNgaycap);
        String nam_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(0, 4);
        String thang_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(4, 6);
        String ngay_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(6, 8);
        String _GpdkkdNgaycap = ngay_gpdkkdNgaycap + "/" + thang_gpdkkdNgaycap + "/" + nam_gpdkkdNgaycap;
        m.addAttribute("_GpdkkdNgaycap", _GpdkkdNgaycap);
        _session.setAttribute("_sessionGpdkkdNgaycap", p.getGpdkkdNgaycap());

        m.addAttribute("gpdkkdNoicap", p.getGpdkkdNoicap());
        m.addAttribute("gpdkkdTennguoidaidien", p.getGpdkkdTennguoidaidien());
        _session.setAttribute("tenNguoiDaiDienGPKD", p.getGpdkkdTennguoidaidien());
        m.addAttribute("gpdkkdChucvu", p.getGpdkkdChucvu());
        m.addAttribute("gpdkkdCmnd", p.getGpdkkdCmnd());
        _session.setAttribute("CMNDnguoiDaiDienGPKD", p.getGpdkkdCmnd());

        int GpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        String str_GpdkkdNgaycapCmnd = String.valueOf(GpdkkdNgaycapCmnd);
        String nam_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(0, 4);
        String thang_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(4, 6);
        String ngay_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(6, 8);
        String _GpdkkdNgaycapCmnd = ngay_GpdkkdNgaycapCmnd + "/" + thang_GpdkkdNgaycapCmnd + "/" + nam_GpdkkdNgaycapCmnd;
        m.addAttribute("_GpdkkdNgaycapCmnd", _GpdkkdNgaycapCmnd);
        _session.setAttribute("_sessionGpdkkdNgaycapCmnd", p.getGpdkkdNgaycapCmnd());

        m.addAttribute("gpdkkdNoicapCmnd", p.getGpdkkdNoicapCmnd());
        m.addAttribute("masothue", p.getMasothue());
        m.addAttribute("tennguoiKyhopdong", p.getTennguoiKyhopdong());
        m.addAttribute("chucvuHopdong", p.getChucvuHopdong());
        m.addAttribute("cmndHopdong", p.getCmndHopdong());

        int NgaycapCmndHopdong = p.getNgaycapCmndHopdong();
        String str_NgaycapCmndHopdong = String.valueOf(NgaycapCmndHopdong);
        String nam_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(0, 4);
        String thang_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(4, 6);
        String ngay_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(6, 8);
        String _NgaycapCmndHopdong = ngay_NgaycapCmndHopdong + "/" + thang_NgaycapCmndHopdong + "/" + nam_NgaycapCmndHopdong;
        m.addAttribute("_NgaycapCmndHopdong", _NgaycapCmndHopdong);
        _session.setAttribute("_sessionNgaycapCmndHopdong", p.getNgaycapCmndHopdong());

        m.addAttribute("noicapCmndHopdong", p.getNoicapCmndHopdong());

        TtPosModel modelPos = new TtPosModel();
        m.addAttribute("lst", modelPos.getListPosById(id));

        List<TtPosLive> listPos = new ArrayList<TtPosLive>();
        listPos = modelPos.getListPosById(id);

        for (int i = 0; i < listPos.size(); i++) {
            TtPosLive pos = new TtPosLive();
            pos = listPos.get(i);
            String seri = pos.getSoseri();
            String xxx = request.getParameter(seri);
        }

        return "pagekhoa";
    }

    @RequestMapping(value = "/luuthongtinkhoa", method = RequestMethod.GET)
    public String luuthongtinkhoa(Model m, @ModelAttribute(value = "_dvcnt") TtDvcntLive p,
            HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        String id = String.valueOf(_session.getAttribute("_maDvcnt"));
        TtDvcntModel model = new TtDvcntModel();
        p = model.getTtDvcnt(id);

        TtPosTempModel modelPosTemp = new TtPosTempModel();
        TtPosModel modelPos = new TtPosModel();
        m.addAttribute("lst", modelPos.getListPosById(id));

        List<TtPosLive> listPos = new ArrayList<TtPosLive>();
        listPos = modelPos.getListPosById(id);

        // Lấy DS
        int soLuongPos = modelPos.countPOSByMid(id);
        String[] ArraySeri = new String[soLuongPos];
        int j = 0;
        for (int i = 0; i < listPos.size(); i++) {
            TtPosLive pos = new TtPosLive();
            pos = listPos.get(i);
            String seri = pos.getSoseri();
            String giaTriCuaCheckBox = request.getParameter(seri); // Nếu value là 1: POS được chọn để khóa.

            if (giaTriCuaCheckBox != null) {
                ArraySeri[j] = seri;
                j++;
            }
        }
        // Cập nhật cột TINHTRANG của TT_POS là 1 -> Đang tiến hành khóa TT_POS
        for (int i = 0; i < ArraySeri.length; i++) {
            String seri = ArraySeri[i];
            if (seri != null) {
                List<TtPosLive> lst = new ArrayList<TtPosLive>();
                lst = modelPos.getPosBySeri(seri);
                for (int k = 0; k < lst.size(); k++) {
                    TtPosLive pos = new TtPosLive();
                    pos = lst.get(k);
                    Byte tinhtrang = 1;
                    pos.setTinhtrang(tinhtrang);

                    String noiLuuPOS = String.valueOf(request.getParameter("noiLuuPos"));
                    if (noiLuuPOS.equals("DON VI")) {
                        noiLuuPOS = String.valueOf(_session.getAttribute("macn"));
                    }
                    pos.setNoiLuuPos(noiLuuPOS);
                    modelPos.update(pos);

                    // GHI LOG
                    TtLogDvcntModel modelLog = new TtLogDvcntModel();
                    TtLogDvcnt log = new TtLogDvcnt();
                    log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
                    log.setLogLevel((Byte) _session.getAttribute("groupuser"));
                    log.setLogTime(get_SystemTime());
                    log.setLogMid(p.getMaDvcnt());
                    String logContent = "(1)CN/PGD chọn khóa POS: " + pos.getSoseri() + ", DVCNT: " + pos.getMid();
                    log.setLogContent(logContent);
                    modelLog.create(log); // create log
                }
            }
        }
        // Cập nhật cột ISMAPPING của TT_POS_TEMP là 7 -> Đang tiến hành tạm khóa TT_POS_TEMP
//        for (int i = 0; i < ArraySeri.length; i++) {
//            String seri = ArraySeri[i];
//            if (seri != null) {
//                List<TtPosTemp> lstTemp = new ArrayList<TtPosTemp>();
//                lstTemp = modelPosTemp.getPosBySeriNo(seri);
//                for (int k = 0; k < lstTemp.size(); k++) {
//                    TtPos pos = new TtPos();
//                    pos = lstTemp.get(k);
//                    Byte tinhtrang = 1;
//                    pos.setTinhtrang(tinhtrang);
//                    modelPos.update(pos);
//                }
//            }
//        }

        m.addAttribute("error", "");
//        Byte statusDuyet = 3; // CHUYEN DEN (2)CN/PGD
//        p.setStatusDuyet(statusDuyet);
//        Byte statusDvcnt = 4;
//        p.setStatusDvcnt(statusDvcnt); // TAM KHOA

        String user2ChiNhanhPGD = p.getUser2Cn();
        if (user2ChiNhanhPGD == null) {
            user2ChiNhanhPGD = "";
        }

        Byte loaihinh = p.getLoaihinhDvcnt();

        String user1KhachHangCaNhan = "";
        String user2KhachHangCaNhan = "";
        if (loaihinh == 1) {
            user1KhachHangCaNhan = p.getUser1Ptdbh();
            if (user1KhachHangCaNhan == null) {
                user1KhachHangCaNhan = "";
            }
            String str_user1KhachHangCaNhan_Date = String.valueOf(p.getUser1PtdbhDate());
            if (!str_user1KhachHangCaNhan_Date.equals("null")) {
            }

            user2KhachHangCaNhan = p.getUser2Ptdbh();
            if (user2KhachHangCaNhan == null) {
                user2KhachHangCaNhan = "";
            }
        }

        String user1Ptnt = "";
        String user2Ptnt = "";
        user1Ptnt = p.getUser1Ptnt();
        if (user1Ptnt == null) {
            user1Ptnt = "";
        }

        user2Ptnt = p.getUser2Ptnt();
        if (user2Ptnt == null) {
            user2Ptnt = "";
        }

        String UserNhap = (String) _session.getAttribute("mauser");
        p.setUser1Cn(UserNhap);
        String cnQuanly = (String) _session.getAttribute("macn");
        p.setCnQuanly(cnQuanly);

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day)
                + _formatTime(hour) + _formatTime(minute) + _formatTime(second);
        long user1DonviNgaynhap = Long.parseLong(ngay_gio_nhap);
        p.setUser1CnNgaynhap(user1DonviNgaynhap);

        // Reset tat ca USER, NGAYDUYET, GHICHU về null
        p.setUser2Cn("");
        p.setUser2CnNote("");
        p.setUser2CnDate(null);

        p.setUser1Pkhdn("");
        p.setUser1PkhdnNote("");
        p.setUser1PkhdnDate(null);

        p.setUser2Pkhdn("");
        p.setUser2PkhdnNote("");
        p.setUser2PkhdnDate(null);

        p.setUser1Ptdbh("");
        p.setUser1PtdbhNote("");
        p.setUser1PtdbhDate(null);

        p.setUser2Ptdbh("");
        p.setUser2PtdbhNote("");
        p.setUser2PtdbhDate(null);

        p.setUser1Ptnt("");
        p.setUser1PtntNote("");
        p.setUser1PtntDate(null);

        p.setUser2Ptnt("");
        p.setUser2PtntNote("");
        p.setUser2PtntDate(null);

        String str = "Lưu thành công !";
        m.addAttribute("luuthanhcong", str);
        model.update(p);

        return khoa(m, request, id);
    }

    @RequestMapping(value = "pagetamkhoa", method = RequestMethod.GET)
    public String pagetamkhoa(Model m, HttpServletRequest request, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        _session.setAttribute("_maDvcnt", id);
        _session.setAttribute("_id", id);
        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        m.addAttribute("maDvcnt", p.getMaDvcnt());
        _session.setAttribute("_maDvcnt", p.getMaDvcnt());
        _session.setAttribute("_id", p.getMaDvcnt());
        m.addAttribute("tenDvcntVn", p.getTenDvcntVn());
        _session.setAttribute("tenDvcntVn", p.getTenDvcntVn());
        m.addAttribute("tenDvcntEn", p.getTenDvcntEn());
        m.addAttribute("diachiDvcnt", p.getDiachiDvcnt());
        _session.setAttribute("diachiDvcnt", p.getDiachiDvcnt());
        m.addAttribute("sdtDvcnt", p.getSdtDvcnt());
        m.addAttribute("gpdkkdso", p.getGpdkkdso());

        int gpdkkdNgaycap = p.getGpdkkdNgaycap();
        String str_gpdkkdNgaycap = String.valueOf(gpdkkdNgaycap);
        String nam_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(0, 4);
        String thang_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(4, 6);
        String ngay_gpdkkdNgaycap = str_gpdkkdNgaycap.substring(6, 8);
        String _GpdkkdNgaycap = ngay_gpdkkdNgaycap + "/" + thang_gpdkkdNgaycap + "/" + nam_gpdkkdNgaycap;
        m.addAttribute("_GpdkkdNgaycap", _GpdkkdNgaycap);
        _session.setAttribute("_sessionGpdkkdNgaycap", p.getGpdkkdNgaycap());

        m.addAttribute("gpdkkdNoicap", p.getGpdkkdNoicap());
        m.addAttribute("gpdkkdTennguoidaidien", p.getGpdkkdTennguoidaidien());
        _session.setAttribute("tenNguoiDaiDienGPKD", p.getGpdkkdTennguoidaidien());
        m.addAttribute("gpdkkdChucvu", p.getGpdkkdChucvu());
        m.addAttribute("gpdkkdCmnd", p.getGpdkkdCmnd());
        _session.setAttribute("CMNDnguoiDaiDienGPKD", p.getGpdkkdCmnd());

        int GpdkkdNgaycapCmnd = p.getGpdkkdNgaycapCmnd();
        String str_GpdkkdNgaycapCmnd = String.valueOf(GpdkkdNgaycapCmnd);
        String nam_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(0, 4);
        String thang_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(4, 6);
        String ngay_GpdkkdNgaycapCmnd = str_GpdkkdNgaycapCmnd.substring(6, 8);
        String _GpdkkdNgaycapCmnd = ngay_GpdkkdNgaycapCmnd + "/" + thang_GpdkkdNgaycapCmnd + "/" + nam_GpdkkdNgaycapCmnd;
        m.addAttribute("_GpdkkdNgaycapCmnd", _GpdkkdNgaycapCmnd);
        _session.setAttribute("_sessionGpdkkdNgaycapCmnd", p.getGpdkkdNgaycapCmnd());

        m.addAttribute("gpdkkdNoicapCmnd", p.getGpdkkdNoicapCmnd());
        m.addAttribute("masothue", p.getMasothue());
        m.addAttribute("tennguoiKyhopdong", p.getTennguoiKyhopdong());
        m.addAttribute("chucvuHopdong", p.getChucvuHopdong());
        m.addAttribute("cmndHopdong", p.getCmndHopdong());

        int NgaycapCmndHopdong = p.getNgaycapCmndHopdong();
        String str_NgaycapCmndHopdong = String.valueOf(NgaycapCmndHopdong);
        String nam_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(0, 4);
        String thang_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(4, 6);
        String ngay_NgaycapCmndHopdong = str_NgaycapCmndHopdong.substring(6, 8);
        String _NgaycapCmndHopdong = ngay_NgaycapCmndHopdong + "/" + thang_NgaycapCmndHopdong + "/" + nam_NgaycapCmndHopdong;
        m.addAttribute("_NgaycapCmndHopdong", _NgaycapCmndHopdong);
        _session.setAttribute("_sessionNgaycapCmndHopdong", p.getNgaycapCmndHopdong());

        m.addAttribute("noicapCmndHopdong", p.getNoicapCmndHopdong());

        TtPosModel modelPos = new TtPosModel();
        m.addAttribute("lst", modelPos.getListPosById(id));

        List<TtPosLive> listPos = new ArrayList<TtPosLive>();
        listPos = modelPos.getListPosById(id);

        for (int i = 0; i < listPos.size(); i++) {
            TtPosLive pos = new TtPosLive();
            pos = listPos.get(i);
            String seri = pos.getSoseri();
            String xxx = request.getParameter(seri);
        }

        return "pagetamkhoa";
    }

    @RequestMapping(value = "/luuthongtintamkhoa", method = RequestMethod.GET)
    public String luuthongtintamkhoa(Model m, @ModelAttribute(value = "_dvcnt") TtDvcntLive p, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        String id = String.valueOf(_session.getAttribute("_maDvcnt"));
        TtDvcntModel model = new TtDvcntModel();
        p = model.getTtDvcnt(id);

        TtPosModel modelPos = new TtPosModel();
        m.addAttribute("lst", modelPos.getListPosById(id));

        List<TtPosLive> listPos = new ArrayList<TtPosLive>();
        listPos = modelPos.getListPosById(id);

        // Lấy DS
        int soLuongPos = modelPos.countPOSByMid(id);
        String[] ArraySeri = new String[soLuongPos];
        int j = 0;
        for (int i = 0; i < listPos.size(); i++) {
            TtPosLive pos = new TtPosLive();
            pos = listPos.get(i);
            String seri = pos.getSoseri();
            String giaTriCuaCheckBox = request.getParameter(seri); // Nếu value tại checkbox là 1: POS được chọn để tạm khóa.

            if (giaTriCuaCheckBox != null) {
                ArraySeri[j] = seri;
                j++;
            }
        }
        // Cập nhật tình trạng của POS là 2 -> Đang tiến hành tạm khóa
        for (int i = 0; i < ArraySeri.length; i++) {
            String seri = ArraySeri[i];
            if (seri != null) {
                List<TtPosLive> lst = new ArrayList<TtPosLive>();
                lst = modelPos.getPosBySeri(seri);
                for (int k = 0; k < lst.size(); k++) {
                    TtPosLive pos = new TtPosLive();
                    pos = lst.get(k);
                    Byte tinhtrang = 2;
                    pos.setTinhtrang(tinhtrang);
                    modelPos.update(pos);
                }
            }
        }

        if (p.getFileuploadTamKhoa() == null || p.getFileuploadTamKhoa().equals("")) {
            String error = "Chưa upload file scan";
            m.addAttribute("error", error);
            return pagetamkhoa(m, request, id);
        } else {
            m.addAttribute("error", "");

            String user1ChiNhanhPGD = p.getUser1Cn();
            long user1ChiNhanhPGD_Date = p.getUser1CnNgaynhap();

            String user2ChiNhanhPGD = p.getUser2Cn();
            if (user2ChiNhanhPGD == null) {
                user2ChiNhanhPGD = "";
            }

            String str_user2ChiNhanhPGD_Date = String.valueOf(p.getUser2CnDate());
            long user2ChiNhanhPGD_Date = 0;
            if (str_user2ChiNhanhPGD_Date == "null") {
                user2ChiNhanhPGD_Date = 0;
            } else {
                user2ChiNhanhPGD_Date = p.getUser2CnDate();
            }

            Byte loaihinh = p.getLoaihinhDvcnt();

            String user1KhachHangCaNhan = "";
            long user1KhachHangCaNhan_Date = 0;
            String user2KhachHangCaNhan = "";
            long user2KhachHangCaNhan_Date = 0;
            if (loaihinh == 1) {
                user1KhachHangCaNhan = p.getUser1Ptdbh();
                if (user1KhachHangCaNhan == null) {
                    user1KhachHangCaNhan = "";
                }
                String str_user1KhachHangCaNhan_Date = String.valueOf(p.getUser1PtdbhDate());
                if (str_user1KhachHangCaNhan_Date != "null") {
                    user1KhachHangCaNhan_Date = p.getUser1PtdbhDate();
                }

                user2KhachHangCaNhan = p.getUser2Ptdbh();
                if (user2KhachHangCaNhan == null) {
                    user2KhachHangCaNhan = "";
                }
                String str_user2KhachHangCaNhan_Date = String.valueOf(p.getUser2PtdbhDate());
                if (str_user2KhachHangCaNhan_Date != "null") {
                    user2KhachHangCaNhan_Date = p.getUser2PtdbhDate();
                }
            }

            String user1_KHDN = "";
            long user1_KHDN_Date = 0;

            String User2Pkhdn = "";
            long getUser2Pkhdn_Date = 0;
            if (loaihinh == 2) {
                user1_KHDN = p.getUser1Pkhdn();
                user1_KHDN_Date = p.getUser1PkhdnDate();
                if (user1_KHDN == null) {
                    user1_KHDN = "";
                }
                String str_getUser1Pkhdn_Date = String.valueOf(p.getUser1Pkhdn());
                if (str_getUser1Pkhdn_Date != "null") {
                    user1_KHDN_Date = p.getUser1PkhdnDate();
                }

                User2Pkhdn = p.getUser2Pkhdn();
                if (User2Pkhdn == null) {
                    User2Pkhdn = "";
                }
                String str_getUser2Pkhdn_Date = String.valueOf(p.getUser2Pkhdn());
                if (str_getUser2Pkhdn_Date != "null") {
                    getUser2Pkhdn_Date = p.getUser2PkhdnDate();
                }
            }

            String user1Ptnt = "";
            long user1Ptnt_Date = 0;

            String user2Ptnt = "";
            long user2Ptnt_Date = 0;

            user1Ptnt = p.getUser1Ptnt();
            if (user1Ptnt == null) {
                user1Ptnt = "";
            }
            String str_getUser1Ptnt_Date = String.valueOf(p.getUser1PtntDate());
            if (str_getUser1Ptnt_Date != "null") {
                user1Ptnt_Date = p.getUser1PtntDate();
            }

            user2Ptnt = p.getUser2Ptnt();
            if (user2Ptnt == null) {
                user2Ptnt = "";
            }
            String str_getUser2Ptnt_Date = String.valueOf(p.getUser2Ptnt());
            if (str_getUser2Ptnt_Date != "null") {
                user2Ptnt_Date = p.getUser2PtntDate();
            }

            // Ghi nhận LOG_USER
            String _user1ChiNhanhPGD = "User1_CN/PGD: " + user1ChiNhanhPGD + ", ";
            String _user1ChiNhanhPGD_Date = "User1_CN/PGD_Date: " + String.valueOf(user1ChiNhanhPGD_Date) + ", ";
            String _user2ChiNhanhPGD = "User2_CN/PGD: " + user2ChiNhanhPGD + ", ";
            String _user2ChiNhanhPGD_Date = "User2_CN/PGD_Date: " + String.valueOf(user2ChiNhanhPGD_Date) + ", ";

            String _user1KhachHangCaNhan = "";
            String _user1KhachHangCaNhan_Date = "";
            String _user2KhachHangCaNhan = "";
            String _user2KhachHangCaNhan_Date = "";
            if (loaihinh == 1) {
                _user1KhachHangCaNhan = "User1_KHCN: " + user1KhachHangCaNhan + ", ";
                _user1KhachHangCaNhan_Date = "User1_KHCN_Date: " + user1KhachHangCaNhan_Date + ", ";
                _user2KhachHangCaNhan = "User2_KHCN: " + user2KhachHangCaNhan + ", ";
                _user2KhachHangCaNhan_Date = "User2_KHCN_Date: " + user2KhachHangCaNhan_Date + ", ";
            }

            String _user1_KHDN = "";
            String _user1_KHDN_Date = "";
            String _user2_KHDN = "";
            String _user2_KHDN_Date = "";
            if (loaihinh == 2) {
                _user1_KHDN = "User1_KHCN: " + user1_KHDN + ", ";
                _user1_KHDN_Date = "User1_KHCN_Date: " + user1_KHDN_Date + ", ";
                _user2_KHDN = "User1_KHCN: " + user1_KHDN + ", ";
                _user2_KHDN_Date = "User2_KHCN_Date: " + getUser2Pkhdn_Date + ", ";
            }

            String _user1Ptnt = "User1_TNT: " + user1Ptnt + ", ";
            String _user1Ptnt_Date = "User1_TNT_Date: " + user1Ptnt_Date + ", ";
            String _user2Ptnt = "User2_TNT: " + user2Ptnt + ", ";
            String _user2Ptnt_Date = "User2_TNT_Date: " + user2Ptnt_Date;

            String LOG_USER = p.getLogUser();
            String new_Log_User = "";

            if (loaihinh == 1) {
                new_Log_User = "[TAMKHOA_" + _user1ChiNhanhPGD.replaceAll(" ", "") + _user1ChiNhanhPGD_Date + _user2ChiNhanhPGD.replaceAll(" ", "") + _user2ChiNhanhPGD_Date.replaceAll(" ", "")
                        + _user1KhachHangCaNhan.replaceAll(" ", "") + _user1KhachHangCaNhan_Date + _user2KhachHangCaNhan.replaceAll(" ", "") + _user2KhachHangCaNhan_Date
                        + _user1Ptnt.replaceAll(" ", "") + _user1Ptnt_Date + _user2Ptnt.replaceAll(" ", "") + _user2_KHDN_Date + "]";
            }

            if (loaihinh == 2) {
                new_Log_User = "[TAMKHOA_" + _user1ChiNhanhPGD.replaceAll(" ", "") + _user1ChiNhanhPGD_Date + _user2ChiNhanhPGD.replaceAll(" ", "") + _user2ChiNhanhPGD_Date.replaceAll(" ", "")
                        + _user1_KHDN.replaceAll(" ", "") + _user1_KHDN_Date + _user2_KHDN.replaceAll(" ", "") + _user2_KHDN_Date
                        + _user1Ptnt.replaceAll(" ", "") + _user1Ptnt_Date + _user2Ptnt.replaceAll(" ", "") + _user2Ptnt_Date + "]";
            }

            LOG_USER = LOG_USER + new_Log_User + " ";
            p.setLogUser(LOG_USER);

            String UserNhap = (String) _session.getAttribute("mauser");
            p.setUser1Cn(UserNhap);
            String cnQuanly = (String) _session.getAttribute("macn");
            p.setCnQuanly(cnQuanly);

            LocalDateTime now = LocalDateTime.now();
            int year = now.getYear();
            int month = now.getMonthValue();
            int day = now.getDayOfMonth();
            int hour = now.getHour();
            int minute = now.getMinute();
            int second = now.getSecond();
            String ngay_gio_nhap = "";
            ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);
            long user1DonviNgaynhap = Long.parseLong(ngay_gio_nhap);
            p.setUser1CnNgaynhap(user1DonviNgaynhap);

            // Reset tat ca USER, NGAYDUYET, GHICHU về null
            p.setUser2Cn("");
            p.setUser2CnNote("");
            p.setUser2CnDate(null);

            p.setUser1Pkhdn("");
            p.setUser1PkhdnNote("");
            p.setUser1PkhdnDate(null);

            p.setUser2Pkhdn("");
            p.setUser2PkhdnNote("");
            p.setUser2PkhdnDate(null);

            p.setUser1Ptdbh("");
            p.setUser1PtdbhNote("");
            p.setUser1PtdbhDate(null);

            p.setUser2Ptdbh("");
            p.setUser2PtdbhNote("");
            p.setUser2PtdbhDate(null);

            p.setUser1Ptnt("");
            p.setUser1PtntNote("");
            p.setUser1PtntDate(null);

            p.setUser2Ptnt("");
            p.setUser2PtntNote("");
            p.setUser2PtntDate(null);

            String luthanhcongtamkhoa = "Đã lưu thành công thông tin POS tạm khóa !";
            _session.setAttribute("luthanhcongtamkhoa", luthanhcongtamkhoa);

            model.update(p);
        }

        return pagetamkhoa(m, request, id);
    }

    @RequestMapping(value = "guiduyettamkhoa", method = RequestMethod.GET)
    public String guiduyettamkhoa(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();
        m.addAttribute("_id", id);
        TtDvcntModel modelDvcnt = new TtDvcntModel();

        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = modelDvcnt.getTtDvcnt(id);

        if (ttdvcnt.getFileuploadTamKhoa() == null) {
            String error = "Chưa đính kèm hồ sơ pháp lý ĐVCNT";
            m.addAttribute("error", error);
            return pagetamkhoa(m, request, id);
        } else {
            Byte status = 3; // (1)CN/PGD Complete
            Byte statusDvcnt = 4;
            ttdvcnt.setStatusDvcnt(statusDvcnt); // TAM KHOA
            ttdvcnt.setStatusDuyet(status);
            modelDvcnt.update(ttdvcnt);
        }

        String confirm = "Đã gửi duyệt thu hồi POS, ĐVCNT: " + id;
        _session.setAttribute("confirm", confirm);

        return "redirect:dvcntdangxuly.html";
    }

    @RequestMapping(value = "guiduyetkhoa", method = RequestMethod.GET)
    public String guiduyetkhoa(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();
        m.addAttribute("_id", id);
        TtDvcntModel modelDvcnt = new TtDvcntModel();

        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = modelDvcnt.getTtDvcnt(id);

        if (ttdvcnt.getFileuploadKhoa() == null) {
            String error = "Chưa đính kèm hồ sơ pháp lý ĐVCNT";
            m.addAttribute("errorPagekhoa", error);
            return khoa(m, request, id);
        } else {
            Byte status = 3; // (1)CN/PGD Complete
            Byte statusDvcnt = 4;
            ttdvcnt.setStatusDvcnt(statusDvcnt); // KHOA
            ttdvcnt.setStatusDuyet(status);
            modelDvcnt.update(ttdvcnt);

            String str = "Đã gửi y/c thu hồi POS, ĐVCNT " + id;
            _session.setAttribute("confirm", str);

            // GHI LOG
            TtLogDvcntModel modelLog = new TtLogDvcntModel();
            TtLogDvcnt log = new TtLogDvcnt();
            log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
            log.setLogLevel((Byte) _session.getAttribute("groupuser"));
            log.setLogTime(get_SystemTime());
            log.setLogMid(ttdvcnt.getMaDvcnt());
            log.setLogContent("(1)CN/PGD gửi duyệt khóa POS, đvcnt: " + ttdvcnt.getTenDvcntVn());
            modelLog.create(log); // create log
        }
        return "redirect:dvcntdangxuly.html";
    }

    @RequestMapping(value = "quayvepagedvcntdangxuly", method = RequestMethod.GET)
    public String quayvepagedvcntdangxuly(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        m.addAttribute("lstThemMoi", model.getAll());
//        m.addAttribute("lstThemMoi", model.getListDvcntDangXuLyThemMoi());
        m.addAttribute("lstChinhSua1", model.getListDvcntDangChinhSua1()); // CHINH SUA KO CAN P.KTT&NHS DUYET
        m.addAttribute("lstChinhSua2", model.getListDvcntDangChinhSua2()); // CHINH SUA CAN P.KTT&NHS DUYET

        m.addAttribute("lstTamKhoa", model.getListDvcntTamKhoa()); // KHOA DVCNT
        m.addAttribute("soluongtamkhoa", model.getListDvcntTamKhoa().size());

        m.addAttribute("lstDong", model.getListDvcntDong()); // CLOSE DVCNT
        m.addAttribute("soluongDong", model.getListDvcntDong().size());

        m.addAttribute("lstLapThemPos", model.getListDvcntLapThemPos()); // DVCNT THEM MOI
        m.addAttribute("soluongDvcntLapthemPos", model.getListDvcntLapThemPos().size());
        return "dvcntdangxuly";
    }

    // Lây thời gian hệ thống
    long get_SystemTime() {
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        String ngay_gio_nhap = "";
        ngay_gio_nhap = String.valueOf(year) + _formatTime(month) + _formatTime(day) + _formatTime(hour) + _formatTime(minute) + _formatTime(second);
        return Long.parseLong(ngay_gio_nhap);
    }

    // Format phí: Sau dấu phẩy là 4 ký tự. Ví dụ: 0,1234
    String format_Fee(String fee) {
        int n = 0;
        for (int i = 0; i < fee.length(); i++) {
            if (fee.charAt(i) == ',') { // Lay vi tri cua dau phay
                n = i;
                break;
            }
        }
        String str = fee.substring(n + 1, fee.length()); // Lay cụm số sau dấu phẩy
        if (str.length() == 1) {
            fee += "000";
        } else if (str.length() == 2) {
            fee += "00";
        } else if (str.length() == 3) {
            fee += "0";
        }
        return fee;
    }

    void send_Email(String recipients, String content) throws AddressException {
        String result;

        //recipients = "phuoclh1@scb.com.vn";
        //Recipient's email ID needs to be mentioned.        
        InternetAddress[] parse = InternetAddress.parse(recipients, true);

        // Sender's email ID needs to be mentioned
        String from = "ct_qldvcnt@scb.com.vn";//
        final String username = "check_case_cw@scb.com.vn";//
        final String password = "1234!@#$Scb";//

        // Assuming you are sending email through relay.jangosmtp.net
        String host = "mail1.scb.com.vn";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        //Get the Session object.
        Session mailSession = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username,
                        password);
            }
        });

        try {
            // Create a default MimeMessage object.
            Message message = new MimeMessage(mailSession);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.setRecipients(Message.RecipientType.TO, parse);

            // Set Subject: header field
            message.setSubject("TEST: CHUONG TRINH QUAN LY DVCNT, POS");

            // Now set the actual message
            message.setText(content);

            // Send message
            Transport.send(message);

            System.out.println("Sent message successfully....");
            result = "Sent message successfully....";

        } catch (MessagingException e) {
            e.printStackTrace();
            result = "Error: unable to send message....";

        }
    }
}
