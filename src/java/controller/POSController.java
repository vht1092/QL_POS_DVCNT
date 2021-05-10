package controller;

import static controller.DVCNTController._formatTime;
import entity.*;
import entity.TtHistaff;
import entity.TtLogDvcnt;
import entity.TtPosLive;
import entity.TtPosTempLive;
import entity.UserAcc;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import static java.lang.System.in;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.HistaffModel;
import model.ListMccModel;
import model.TtDvcntModel;
import model.TtLogDvcntModel;
import model.TtPosModel;
import model.TtPosTempModel;
import model.UserAccModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

// Controller xử lý trên 2 TABLE: TT_POS & TT_POS_TEMP
@Controller
public class POSController {

    private HttpSession _session;
    private static String _id;
    private static long _stt;
    private static String _tenDvcnt;
    private static String _mapos;
    private static String _teninhoadon;
    private static String _diachilapdat;
    private static String _soTktgtt;
    private static String _tenchutk;
    private static String _ghichu;
    private static String _dongmay;
    private static String _dongmaythemmoi;
    private static String _dongmaydexuat;
    private static int _soluongPos;
    private static String _seri;
    private static String _mataisan;
    private static String _error;
    private static String _dongmayhople;
    private static String _checkError;

    // Gọi màn hình thêm mới ĐVCNT
    @RequestMapping(value = "themmoipos", method = RequestMethod.GET)
    public String DK_DVCNT(HttpServletRequest request) {

        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        return "themmoipos";
    }

    // Màn hình xem DS tất cả POS
    @RequestMapping(value = "danhsachpos", method = RequestMethod.GET)
    public String danhSachPos(Model m, HttpServletRequest request) {

        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtPosModel model = new TtPosModel();
        m.addAttribute("lst", model.getAll());
        return "danhsachpos";
    }

    // Nhập kho POS
    @RequestMapping(value = "/xulythemmoipos", method = RequestMethod.GET)
    public String xuLyThemPOS(Model m, @ModelAttribute(value = "_pos") TtPosLive p, HttpServletRequest request) {
        _session = request.getSession();

        String ngay_nhapkho = formatTime(request.getParameter("ngay_nhapkho"));
        String thang_nhapkho = formatTime(request.getParameter("thang_nhapkho"));
        String nam_nhapkho = formatTime(request.getParameter("nam_nhapkho"));
        String temp = nam_nhapkho + thang_nhapkho + ngay_nhapkho;
        int ngaynhapkho = Integer.parseInt(temp);
        p.setNgaynhapkho(ngaynhapkho);

        // Check trùng serial???
        TtPosModel model = new TtPosModel();

        String serial = request.getParameter("soseri");
        boolean checkTrungSoSeri = model.checkSerialNo(serial);

        String seri = "";
        String success = "";
        if (checkTrungSoSeri == false) {
            seri = "Error: Serial No " + serial + " đã tồn tại trong kho...";
            m.addAttribute("trungsoseri", seri);
            return "themmoipos";
        }

        String tinhtrang = "Ton kho";
        p.setTinhtrangPos(tinhtrang);

        p.setChinhanhQuanly("000");
        p.setUsernhap((String) _session.getAttribute("mauser"));

        long size = model.countAll();
        size = model.countAll() + 1;
        String maPos = "";
        if (size >= 1 && size <= 9) {
            maPos = "0000" + String.valueOf(size);
        } else if (size >= 10 && size <= 99) {
            maPos = "000" + String.valueOf(size);
        } else if (size >= 100 && size <= 999) {
            maPos = "00" + String.valueOf(size);
        } else if (size >= 1000 && size <= 1999) {
            maPos = "0" + String.valueOf(size);
        } else {
            maPos = String.valueOf(size);
        }
        String ma_pos = "P" + "001" + maPos;
        p.setMaPos(ma_pos);
        model.create(p);

        _dongmaythemmoi = request.getParameter("dongmay");
        success = "Đã nhập mới máy POS " + _dongmaythemmoi;
        m.addAttribute("successAddPos", success);
        return "themmoipos";
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

    /* Gọi link "quay trở về trang Thêm thông tin lắp đặt"    
     từ trang chinhsuattlapdat*/
    @RequestMapping(value = "trove_themttlapdat", method = RequestMethod.GET)
    public String trove_themTtLapDatPOS(Model m,
            @RequestParam(value = "id", required = false) String id,
            HttpServletRequest request,
            HttpServletResponse res) throws ServletException, IOException {
        _session = request.getSession();
        id = String.valueOf(_session.getAttribute("_id"));
        return themTtLapDatPOS(m, id, request, res);
    }

    // Gọi màn hình thêm thông tin lắp đặt POS.    
    @RequestMapping(value = "themthongtinlapdatpos", method = RequestMethod.GET)
    public String themTtLapDatPOS(Model m,
            @RequestParam(value = "id", required = false) String id,
            HttpServletRequest request,
            HttpServletResponse res) throws ServletException, IOException {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        // Only USER1_CN/PGD VÀ USER1_P.KTT&NHS duoc truy cap themthongsopos.html
        Byte groupuser = (Byte) _session.getAttribute("groupuser");
        if (groupuser > 1 && groupuser < 7) {
            return "redirect:index.html";
        }

        m.addAttribute("key", id); // id là MA_DVCNT
        _session.setAttribute("_id", id);
        _id = id;

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = model.getTtDvcnt(id);
        String tenDvcnt = ttdvcnt.getTenDvcntVn();
        Byte statusDuyet = ttdvcnt.getStatusDuyet();
        m.addAttribute("status", statusDuyet);
        _tenDvcnt = tenDvcnt;
        _session.setAttribute("tendvcnt", _tenDvcnt);

        /*Lay thong tin Sale Officer Code*/
        String getDirectCode = ttdvcnt.getDirectCode();
        if (getDirectCode != null) {
            String get_direct_employee = ttdvcnt.getDirectCode() + " - " + ttdvcnt.getDirectName();
            m.addAttribute("get_direct_employee", get_direct_employee);
        }

        String getIndirectCode = ttdvcnt.getIndirectCode();
        if (getIndirectCode != null) {
            String get_inDirect_employee = ttdvcnt.getIndirectCode() + " - " + ttdvcnt.getIndirectName();
            m.addAttribute("get_inDirect_employee", get_inDirect_employee);
        }

        // Lay thong tin HISTAFF
        HistaffModel staffModel = new HistaffModel();
        List<TtHistaff> lst = new ArrayList<TtHistaff>();
        List<TtHistaff> lstResult = new ArrayList<TtHistaff>();
        TtHistaff staff = new TtHistaff();
        lst = staffModel.getAll();
        Byte loaihinhDvcnt = ttdvcnt.getLoaihinhDvcnt();
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
                        || ma_chucdanh.equals("41-002")
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

        String emty = "";
        _session.setAttribute("_teninhoadon", emty);
        _session.setAttribute("_soTktgtt", emty);
        _session.setAttribute("_tenchutk", emty);
        _session.setAttribute("_diachiLapdat", emty);
        _session.setAttribute("_tenDvcnt", emty);
        _session.setAttribute("_ghiChu", emty);
        _session.setAttribute("path_themmoi", ttdvcnt.getFileUpload()); // File them moi DVCNT

        // Số lượng POS & DÒNG POS đã đăng ký
        _soluongPos = ttdvcnt.getSlpos();
        _session.setAttribute("soluongPos", _soluongPos);
        _dongmaydexuat = ttdvcnt.getDongmayDexuat();
        _session.setAttribute("dongmaydexuat", _dongmaydexuat);

        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(_id);
        m.addAttribute("soluongdagan", soluongdagan);

        // Lấy Danh sách đã gán cho ĐVCNT có MA_DVCNT = _id
        m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));

        // If USER truy cap co groupuser = 7, cap nhat STATUS_DUYET = 10: (1)TNT đang map thông số
        if ((Byte) _session.getAttribute("groupuser") == 7) {
            TtDvcntModel modelDvcnt = new TtDvcntModel();
            TtDvcntLive p = new TtDvcntLive();
            p = modelDvcnt.getTtDvcnt(_id);
            Byte status = 10;
            p.setStatusDuyet(status);
            modelDvcnt.update(p);
        }
        if (_session.getAttribute("gddb1") != null) {
            _session.removeAttribute("gddb1");
        }
        if (_session.getAttribute("gddb2") != null) {
            _session.removeAttribute("gddb2");
        }
        if (_session.getAttribute("gddb3") != null) {
            _session.removeAttribute("gddb3");
        }
        if (_session.getAttribute("gddb4") != null) {
            _session.removeAttribute("gddb4");
        }
        if (_session.getAttribute("gddb5") != null) {
            _session.removeAttribute("gddb5");
        }
        if (_session.getAttribute("gddb6") != null) {
            _session.removeAttribute("gddb6");
        }
        if (_session.getAttribute("gddb7") != null) {
            _session.removeAttribute("gddb7");
        }
        if (_session.getAttribute("gddb8") != null) {
            _session.removeAttribute("gddb8");
        }
        if (_session.getAttribute("gddb9") != null) {
            _session.removeAttribute("gddb9");
        }
        ListMccModel mccModel = new ListMccModel();
        _session.setAttribute("listMcc", mccModel.getAll());
        return "themthongtinlapdatpos";
    }

    // Quay trở về màn hình tạo thông số
    @RequestMapping(value = "trove_taothongso", method = RequestMethod.GET)
    public String quayve_taothongso(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();
        id = String.valueOf(_session.getAttribute("_id"));
        return taothongso(m, id, request);
    }

    // Gọi màn hình tạo thông số POS  
    @RequestMapping(value = "taothongso", method = RequestMethod.GET)
    public String taothongso(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();
        //_session.removeAttribute("luthongsothanhcong");

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        // Only USER1_CN/PGD VÀ USER1_P.KTT&NHS duoc truy cap themthongsopos.html
        Byte groupuser = (Byte) _session.getAttribute("groupuser");
        if (groupuser > 1 && groupuser < 7) {
            return "redirect:index.html";
        }

        m.addAttribute("key", id);
        _id = id;
        _session.setAttribute("_id", _id);

        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = model.getTtDvcnt(_id);
        String tenDvcnt = ttdvcnt.getTenDvcntVn();
        Byte statusDuyet = ttdvcnt.getStatusDuyet();
        m.addAttribute("status", statusDuyet);
        _tenDvcnt = tenDvcnt;
        _session.setAttribute("tendvcnt", _tenDvcnt);

        // Số lượng POS & DÒNG POS đã đăng ký
        _soluongPos = ttdvcnt.getSlpos();
        _session.setAttribute("soluongPos", _soluongPos);
        _dongmaydexuat = ttdvcnt.getDongmayDexuat();
        _session.setAttribute("dongmaydexuat", _dongmaydexuat);

        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(_id);
        m.addAttribute("soluongdagan", soluongdagan);

        // Lấy Danh sách đã gán cho ĐVCNT có MA_DVCNT = _id
        m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));

        // If USER truy cap co groupuser = 7, cap nhat STATUS_DUYET = 10: (1)TNT đang map thông số
        if ((Byte) _session.getAttribute("groupuser") == 7) {
            TtDvcntModel modelDvcnt = new TtDvcntModel();
            TtDvcntLive p = new TtDvcntLive();
            p = modelDvcnt.getTtDvcnt(_id);
            Byte status = 10;
            p.setStatusDuyet(status);
            modelDvcnt.update(p);
        }

        return "taothongso";
    }

    // Gọi màn hình ERROR
    @RequestMapping(value = "errorlapdatpos", method = RequestMethod.GET)
    public String errorLapDatPos() {
        return "errorlapdatpos";
    }

    // Gọi màn hình ERROR2
    @RequestMapping(value = "errorlapdatpos2", method = RequestMethod.GET)
    public String errorLapDatPos2() {
        return "errorlapdatpos2";
    }

    @RequestMapping(value = "/checkserinumber", method = RequestMethod.GET)
    public String checkSerial(Model m, HttpServletRequest request) {
        _session = request.getSession();

        String maDvcnt = (String) _session.getAttribute("_id");
        _session.setAttribute("_id", maDvcnt);

        String seri = request.getParameter("soseri");
        if (request.getParameter("soseri") == null || seri.equals("")) {
            seri = "";
        }
        _seri = seri;
        m.addAttribute("_seri", _seri);
        _session.setAttribute("_seri", _seri);

        TtPosModel model = new TtPosModel();
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        lst = model.getPosBySeri(seri);
        TtPosLive pos = new TtPosLive();

        int size = 0;
        size = lst.size();
        String str = "";
        if (size == 0) {
            str = "Serial không tồn tại";
            _error = str;
            m.addAttribute("error", str);
            _checkError = str;
            _session.setAttribute("_checkError", _checkError);
        }
        if (size > 0) {
            for (int i = 0; i < lst.size(); i++) {
                pos = lst.get(i);
                break;
            }
            if (pos.getTinhtrangPos().equals("Sử dụng")) {
                str = "Serial đã sử dụng ";
                _error = str;
                m.addAttribute("error", str);
                _checkError = str;
                _session.setAttribute("_checkError", _checkError);
            }
            if (pos.getTinhtrangPos().equals("Ton kho")) {
                str = pos.getDongmay();
                _dongmay = str;
                _checkError = "";
                _session.setAttribute("_checkError", _checkError);
                _session.setAttribute("_dongmaytheoSeri", _dongmay);
                m.addAttribute("dongmayhople", str); // Hien thi len ten dong may
                m.addAttribute("_dongmay", str); // Hien thi len ten dong may
                _mataisan = pos.getMataisan();
                _dongmayhople = str;
                m.addAttribute("_mataisan", _mataisan);
            }
        }

        return themThongSoPos(m, _stt, request);
    }

    // Thêm thông tin lắp đặt POS <=> cập nhật thêm Mã ĐVCNT, Tên in trên hóa đơn,... cho TT_POS 
    @RequestMapping(value = "/xulythemthongtinlapdat", method = RequestMethod.POST)
    public String themThongTinLapDatPOS(Model m, @ModelAttribute(value = "_lapdatpos") TtPosTempLive p, HttpServletRequest request) {
        _session = request.getSession();

        String teninhoadon = request.getParameter("teninhoadon");
        String soTktgtt = request.getParameter("soTktgtt");
        String tenchutk = request.getParameter("tenchutk");
        String diachiLapdat = request.getParameter("diachiLapdat");
        String tenDvcnt = request.getParameter("tenDvcnt");
        String ghiChu = request.getParameter("ghichu");
        String soseriDukien = request.getParameter("soseridukienlapthem");

        String mccInfo = request.getParameter("mccCode");
        String mccDesc = mccInfo.substring(4, mccInfo.length());
        String mccCode = mccInfo.substring(0, 4);
        p.setMccCode(mccCode);
        p.setMerchantType(mccDesc);

        _teninhoadon = teninhoadon;
        _soTktgtt = soTktgtt;
        _tenchutk = tenchutk;
        _diachilapdat = diachiLapdat;
        _tenDvcnt = tenDvcnt;
        _ghichu = ghiChu;

        _session.setAttribute("_id", _id);
        _session.setAttribute("_teninhoadon", _teninhoadon);
        _session.setAttribute("_soTktgtt", _soTktgtt);
        _session.setAttribute("_tenchutk", _tenchutk);
        _session.setAttribute("_diachiLapdat", _diachilapdat);
        _session.setAttribute("_tenDvcnt", _tenDvcnt);
        _session.setAttribute("_ghiChu", _ghichu);

        TtPosTempModel model = new TtPosTempModel();
        p.setMid(_id);

        // Số lượng POS đã đăng ký
        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = modelDvcnt.getTtDvcnt(_id);
        _soluongPos = ttdvcnt.getSlpos();
        _session.setAttribute("soluongPos", _soluongPos);

        // Lay thong tin Hi-Staff
        HistaffModel staffModel = new HistaffModel();
        TtHistaff staff_Direct = new TtHistaff();
        TtHistaff staff_Indirect = new TtHistaff();

        // direct: bat buoc phai nhap
        // indirect : ko bat buoc nhap nen can phai check data
        String directEmployee = request.getParameter("direct_employee");
        String indirectEmployee = request.getParameter("inDirect_employee");

        // Ma NV
        String directCode = directEmployee.substring(0, 5);
        String indirectCode = "";
        if (!indirectEmployee.equals("") && indirectEmployee.length() >= 8) {
            indirectCode = indirectEmployee.substring(0, 5);
        }

        // check ma nhan vien co ton tai hay khong?
        staff_Direct = staffModel.getTtHistaff(directCode);
        if (!indirectEmployee.equals("") && indirectEmployee.length() >= 8) {
            staff_Indirect = staffModel.getTtHistaff(indirectCode);
        }

        if (staff_Direct == null || staff_Indirect == null) {
            String confirm = "Không thành công. Sai Direct hoặc InDirect !";
            _session.setAttribute("confirm", confirm);
            return "redirect:dvcntdangxuly.html";
        }

        // Ten NV
        String directName = directEmployee.substring(8, directEmployee.length());
        String indirectName = "";
        if (!indirectEmployee.equals("") && indirectEmployee.length() >= 8) {
            indirectName = indirectEmployee.substring(8, indirectEmployee.length());
        }

        staff_Direct = staffModel.getTtHistaff(directCode);

        if (!indirectEmployee.equals("") && indirectEmployee.length() >= 8) {
            staff_Indirect = staffModel.getTtHistaff(indirectCode);
        }

        // Ma chuc danh
        String maChucDanh_direct = staff_Direct.getJobtitleCode();
        String maChucDanh_indirect = staff_Indirect.getJobtitleCode();

        // Ten chuc danh
        String tenChucDanh_direct = staff_Direct.getJobtitleName();
        String tenChucDanh_indirect = staff_Indirect.getJobtitleName();

        // Ma don vi
        String tenDonvi_direct = staff_Direct.getBranchName();
        String tenDonvi_indirect = staff_Indirect.getBranchName();

        ttdvcnt.setDirectCode(directCode);
        ttdvcnt.setIndirectCode(indirectCode);
        ttdvcnt.setDirectName(directName);
        ttdvcnt.setIndirectName(indirectName);
        ttdvcnt.setDirectJobtitleCode(maChucDanh_direct);
        ttdvcnt.setIndirectJobtitleCode(maChucDanh_indirect);
        ttdvcnt.setDirectJobtitleName(tenChucDanh_direct);
        ttdvcnt.setIndirectJobtitleName(tenChucDanh_indirect);
        ttdvcnt.setDirectBranchName(tenDonvi_direct);
        ttdvcnt.setIndirectBranchName(tenDonvi_indirect);

        // GHI LOG thong tin gán Sale Officer Code
        TtLogDvcntModel modelLog = new TtLogDvcntModel();
        TtLogDvcnt log = new TtLogDvcnt();
        log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
        log.setLogLevel((Byte) _session.getAttribute("groupuser"));
        log.setLogTime(get_SystemTime());
        log.setLogMid(ttdvcnt.getMaDvcnt());

        try {
            modelDvcnt.update(ttdvcnt);
            String getDirectCode = ttdvcnt.getDirectCode();
            if (getDirectCode != null) {
                String get_direct_employee = ttdvcnt.getDirectCode() + " - " + ttdvcnt.getDirectName();
                m.addAttribute("get_direct_employee", get_direct_employee);
            }

            String getIndirectCode = ttdvcnt.getIndirectCode();
            if (getIndirectCode != null) {
                String get_inDirect_employee = ttdvcnt.getIndirectCode() + " - " + ttdvcnt.getIndirectName();
                m.addAttribute("get_inDirect_employee", get_inDirect_employee);
            }
            String logContent = "Gán Direct: " + directCode;
            if (!indirectEmployee.equals("") && indirectEmployee.length() >= 8) {
                logContent += ", Indirect: " + indirectCode;
            }
            log.setLogContent(logContent);
            modelLog.create(log); // create log
        } catch (Exception e) {
            log.setLogContent("Update không thành công(chitietdvcnt.html). Chi tiết: " + e.toString());
            modelLog.create(log); // create log
        }

        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(_id);
        m.addAttribute("soluongdagan", soluongdagan);

        String gpdkkdso = ttdvcnt.getGpdkkdso();
        String gpdkkdTennguoidaidien = ttdvcnt.getGpdkkdTennguoidaidien();
        String gpdkkdCmnd = ttdvcnt.getGpdkkdCmnd();
        String diachiDvcnt = ttdvcnt.getDiachiDvcnt();
        String loaitien = ttdvcnt.getLoaitien();

        String nganhnghekd = ttdvcnt.getNganhnghekd();
        p.setNganhnghekd(nganhnghekd);
        p.setLoaitien(loaitien);

        p.setGpdkkdso(gpdkkdso);
        p.setGpdkkdTennguoidaidien(gpdkkdTennguoidaidien);
        p.setGpdkkdCmnd(gpdkkdCmnd);
        p.setDiachiDvcnt(diachiDvcnt);

        Byte tinhtrang = -3; // Khong co y nghia
        p.setTinhtrang(tinhtrang);

        Byte gddb1, gddb2, gddb3, gddb4, gddb5, gddb6, gddb7, gddb8, gddb9;

        String tienkyquyMoto = request.getParameter("_tienkyquyMoto");
        String hanMucVND = request.getParameter("_hanmucVnd");
        String hanMucUSD = request.getParameter("_hanmucUsd");

        if (request.getParameter("gddb1") == null) {
            gddb1 = 0;
        } else {
            gddb1 = Byte.parseByte(request.getParameter("gddb1"));
        }

        if (gddb1 == 1 && (tienkyquyMoto.equals("") || hanMucVND.equals("") || hanMucUSD.equals(""))) {
//            String error = "Chưa nhập số tiền MOTO, hoặc hạn mức VND/USD";
//            m.addAttribute("error", error);
//            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
//            TtDvcntLive dvcnt = new TtDvcntLive();
//            dvcnt = modelDvcnt.getTtDvcnt(_id);
//            Byte status = 2; // Đang tạo hồ sơ: Xem thong tin lap dat
//            dvcnt.setStatusDuyet(status);
//            modelDvcnt.update(dvcnt);
//            return "themthongtinlapdatpos";
            tienkyquyMoto = "0";
            hanMucVND = "0";
            hanMucUSD = "0";
        }
        if (gddb1 == 0) {
            tienkyquyMoto = "";
            hanMucVND = "";
            hanMucUSD = "";
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

//        _session.setAttribute("gddb1", gddb1);
//        _session.setAttribute("gddb2", gddb2);
//        _session.setAttribute("gddb3", gddb3);
//        _session.setAttribute("gddb4", gddb4);
//        _session.setAttribute("gddb5", gddb5);
//        _session.setAttribute("gddb6", gddb6);
//        _session.setAttribute("gddb7", gddb7);
//        _session.setAttribute("gddb8", gddb8);
//        _session.setAttribute("gddb9", gddb9);
        if (request.getParameter("_tienkyquyMoto").equals("") || request.getParameter("_tienkyquyMoto") == null) {
            tienkyquyMoto = "0";
        }

        if (request.getParameter("_hanmucVnd").equals("") || request.getParameter("_hanmucVnd") == null) {
            hanMucVND = "0";
        }

        String _hanMucVND = hanMucVND.replaceAll(",", "");
        if (_hanMucVND.equals("") || _hanMucVND == null) {
            _hanMucVND = "0";
        }
        p.setHanmucVnd(Long.parseLong(_hanMucVND));

        String _tienkyquyMoto = tienkyquyMoto.replaceAll(",", "");
        if (_tienkyquyMoto.equals("") || _tienkyquyMoto == null) {
            _tienkyquyMoto = "0";
        }
        p.setPhimo(Long.parseLong(_tienkyquyMoto));

        if (request.getParameter("_hanmucUsd").equals("") || request.getParameter("_hanmucUsd") == null) {
            hanMucUSD = "0";
        }
        String _hanMucUSD = hanMucUSD.replaceAll(",", "");
        if (_hanMucUSD.equals("") || _hanMucUSD == null) {
            _hanMucUSD = "0";
        }
        p.setHanmucUsd(Long.parseLong(_hanMucUSD));

        if (tienkyquyMoto.equals("0")) {
            _session.setAttribute("tienkyquyMoto", "");
        }
        if (hanMucVND.equals("0")) {
            _session.setAttribute("hanmucVnd", "");
        }
        if (hanMucUSD.equals("0")) {
            _session.setAttribute("hanmucUsd", "");
        }

        p.setGddb1(gddb1);
        p.setGddb2(gddb2);
        p.setGddb3(gddb3);
        p.setGddb4(gddb4);
        p.setGddb5(gddb5);
        p.setGddb6(gddb6);
        p.setGddb7(gddb7);
        p.setGddb8(gddb8);
        p.setGddb9(gddb9);

        Byte ismapping = 0;
        p.setIsmapping(ismapping);
        p.setSoseriDukien(soseriDukien);

        if (_soluongPos == soluongdagan) {
            String error = "Đã gán đủ " + _soluongPos + " máy POS cho ĐVCNT " + _id;
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(_id);
            Byte status = 2; // Đang tạo hồ sơ: Xem thong tin lap dat
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);
            return "themthongtinlapdatpos";
        } else if (_soluongPos < soluongdagan) {
            String error = "Gán thừa thông tin lắp đặt. Xin kiểm tra lại !";
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(_id);
            Byte status = 2; // Đang tạo hồ sơ: Xem thong tin lap dat
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);
            return "themthongtinlapdatpos";
        } else {

            // GHI LOG thong tin POS vua tao
            log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
            log.setLogLevel((Byte) _session.getAttribute("groupuser"));
            log.setLogTime(get_SystemTime());
            log.setLogMid(_id);

            try {
                model.create(p);
                soluongdagan = modelTemp.countById(_id);
                m.addAttribute("soluongdagan", soluongdagan);
                log.setLogContent("Gán POS có tên in HĐ: " + teninhoadon);
                modelLog.create(log); // create log
            } catch (Exception e) {
                log.setLogContent("Gán POS không thành công(themthongtinlapdatpos.html). Chi tiết: " + e.toString());
                modelLog.create(log); // create log
            }

            if (_soluongPos == soluongdagan) {
                TtDvcntLive dvcnt = new TtDvcntLive();
                dvcnt = modelDvcnt.getTtDvcnt(_id);
                Byte status = 2; // Đang tạo hồ sơ: Xem thong tin lap dat
                dvcnt.setStatusDuyet(status);
                modelDvcnt.update(dvcnt);
            }
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
        }

        // Lay lại List thong tin HISTAFF để load vào trang themthongtinlapdatpos.jsp
        List<TtHistaff> lst = new ArrayList<TtHistaff>();
        List<TtHistaff> lstResult = new ArrayList<TtHistaff>();
        TtHistaff staff = new TtHistaff();
        lst = staffModel.getAll();
        Byte loaihinhDvcnt = ttdvcnt.getLoaihinhDvcnt();
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
                        || ma_chucdanh.equals("41-002")
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
        ListMccModel mccModel = new ListMccModel();
        _session.setAttribute("listMcc", mccModel.getAll());
        return "themthongtinlapdatpos";
    }

    // Lấy DS thông tin lắp đặt POS dựa theo mã ĐVCNT
    @RequestMapping(value = "xemthongtinlapdatpos", method = RequestMethod.GET)
    public String xemThongTinLapDatPos(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();
        TtPosModel model = new TtPosModel();
        m.addAttribute("lst", model.getListPosById(id));
        m.addAttribute("mid", id);
        return "xemthongtinlapdatpos";
    }

    // Xóa thông tin lắp đặt (Xóa trong TABLE TT_POS_TEMP)
    @RequestMapping(value = "xoathongtinlapdat", method = RequestMethod.GET)
    public String xoaThongTinLapDatPos(Model m, @RequestParam(value = "id", required = false) long id, HttpServletRequest request) {
        _session = request.getSession();
        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive pos = new TtPosTempLive();
        pos = model.getTtPosTemp(id);

        // GHI LOG
        TtLogDvcntModel modelLog = new TtLogDvcntModel();
        TtLogDvcnt log = new TtLogDvcnt();
        log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
        log.setLogLevel((Byte) _session.getAttribute("groupuser"));
        log.setLogTime(get_SystemTime());
        log.setLogMid(pos.getMid());

        try {
            log.setLogContent("Xóa POS có tên in HĐ: " + pos.getTeninhoadon() + "(themthongtinlapdatpos.html)");
            model.remove(pos);
            modelLog.create(log); // create log
        } catch (Exception e) {
            log.setLogContent("Xóa POS không thành công(themthongtinlapdatpos.html)" + e.toString());
            modelLog.create(log); // create log
        }

        m.addAttribute("lstPosTemp", model.getAllById(_id));
        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(_id);
        m.addAttribute("soluongdagan", soluongdagan);

        // Cập nhật Status_Duyet = 1: Đang tạo hồ sơ: Thiếu thông tin lắp đăjt
        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = modelDvcnt.getTtDvcnt(_id);
        Byte status = 1;
        dvcnt.setStatusDuyet(status);
        modelDvcnt.update(dvcnt);
        return "themthongtinlapdatpos";
    }

    // Edit thông tin lắp đặt (Edit trong TABLE TT_POS_TEMP)
    @RequestMapping(value = "chinhsuathongtinlapdat", method = RequestMethod.GET)
    public String editThongTinLapDatPos(Model m, @RequestParam(value = "id_edit", required = false) long id_edit, HttpServletRequest request) {
        _session = request.getSession();
        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive pos = new TtPosTempLive();
        pos = model.getTtPosTemp(id_edit);

        String dongmay = pos.getDongmay();
        String teninhoadon = pos.getTeninhoadon();
        String soTktgtt = pos.getSoTktgtt();
        String tenchutk = pos.getTenchutk();
        String diachiLapdat = pos.getDiachiLapdat();
        String tenDvcnt = pos.getTenDvcnt();
        String ghiChu = pos.getGhichu();
        String nganhNghePOs = pos.getTenNganhNghe();

        Byte gddb1 = pos.getGddb1();
        Byte gddb2 = pos.getGddb2();
        Byte gddb3 = pos.getGddb3();
        Byte gddb4 = pos.getGddb4();
        Byte gddb5 = pos.getGddb5();
        Byte gddb6 = pos.getGddb6();
        Byte gddb7 = pos.getGddb7();
        Byte gddb8 = pos.getGddb8();
        Byte gddb9 = pos.getGddb9();

        long tienkyquyMoto = pos.getPhimo();
        long hanMucVND = pos.getHanmucVnd();
        long hanMucUSD = pos.getHanmucUsd();

        _teninhoadon = teninhoadon;
        _soTktgtt = soTktgtt;
        _tenchutk = tenchutk;
        _diachilapdat = diachiLapdat;
        _tenDvcnt = tenDvcnt;
        _ghichu = ghiChu;
        _dongmay = dongmay;

        _session.setAttribute("_id", _id);
        _session.setAttribute("_idedit", id_edit);
        _session.setAttribute("_teninhoadon", _teninhoadon);
        _session.setAttribute("_soTktgtt", _soTktgtt);
        _session.setAttribute("_tenchutk", _tenchutk);
        _session.setAttribute("_diachiLapdat", _diachilapdat);
        _session.setAttribute("_tenDvcnt", _tenDvcnt);
        _session.setAttribute("_ghiChu", _ghichu);
        _session.setAttribute("_dongmay", _dongmay);

        _session.setAttribute("gddb1", gddb1);
        _session.setAttribute("gddb2", gddb2);
        _session.setAttribute("gddb3", gddb3);
        _session.setAttribute("gddb4", gddb4);
        _session.setAttribute("gddb5", gddb5);
        _session.setAttribute("gddb6", gddb6);
        _session.setAttribute("gddb7", gddb7);
        _session.setAttribute("gddb8", gddb8);
        _session.setAttribute("gddb9", gddb9);

        _session.setAttribute("tienkyquyMoto", tienkyquyMoto);
        _session.setAttribute("hanMucVND", hanMucVND);
        _session.setAttribute("hanMucUSD", hanMucUSD);
        _session.setAttribute("tenNganhNghe", nganhNghePOs);

        // DS TT_POS_TEMP của ĐVCNT
        m.addAttribute("lstPosTemp", model.getAllById(_id));

        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(_id);
        m.addAttribute("soluongdagan", soluongdagan);
        return "chinhsuattlapdat";
    }

    // Edit thông tin lắp đặt POS
    @RequestMapping(value = "/xulychinhsuathongtinlapdat", method = RequestMethod.GET)
    public String editThongTinLapDatPOS(Model m, @ModelAttribute(value = "_editlapdatpos") TtPosTempLive p,
            HttpServletRequest request,
            HttpServletResponse res) throws ServletException, IOException {
        _session = request.getSession();

        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive pos = new TtPosTempLive();
        int id = Integer.parseInt(request.getParameter("id_edit"));
        pos = model.getTtPosTemp(id);

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
        pos.setGddb1(gddb1);
        pos.setGddb2(gddb2);
        pos.setGddb3(gddb3);
        pos.setGddb4(gddb4);
        pos.setGddb5(gddb5);
        pos.setGddb6(gddb6);
        pos.setGddb7(gddb7);
        pos.setGddb8(gddb8);
        pos.setGddb9(gddb9);

        String tienkyquyMoto = request.getParameter("_tienkyquyMoto");
        String hanMucVND = request.getParameter("_hanmucVnd");
        String hanMucUSD = request.getParameter("_hanmucUsd");

        if (gddb1 == 1 && (tienkyquyMoto.equals("") || hanMucVND.equals("")
                || hanMucUSD.equals(""))) {
//            _session.setAttribute("idposedit", id);
//            _session.setAttribute("_id", maDvcnt);
//            String error = "Chưa nhập MOTO, hạn mức VNĐ hoặc USD !";
//            m.addAttribute("error", error);
//            return editThongTinLapDatPos(m, id, request);
            tienkyquyMoto = "0";
            hanMucVND = "0";
            hanMucUSD = "0";
        }

        if (request.getParameter("_tienkyquyMoto") == null || request.getParameter("_tienkyquyMoto").equals("")) {
            tienkyquyMoto = "0";
        }
        String _tienkyquyMoto = tienkyquyMoto.replaceAll(",", "");
        if (_tienkyquyMoto == null || _tienkyquyMoto.equals("")) {
            _tienkyquyMoto = "0";
        }

        if (request.getParameter("_hanmucVnd") == null || request.getParameter("_hanmucVnd").equals("")) {
            hanMucVND = "0";
        }
        String _hanMucVND = hanMucVND.replaceAll(",", "");
        if (_hanMucVND == null || _hanMucVND.equals("")) {
            _hanMucVND = "0";
        }
        pos.setHanmucVnd(Long.parseLong(_hanMucVND));

        pos.setPhimo(Long.parseLong(_tienkyquyMoto));

        if (request.getParameter("_hanmucUsd") == null || request.getParameter("_hanmucUsd").equals("")) {
            hanMucUSD = "0";
        }
        String _hanMucUSD = hanMucUSD.replaceAll(",", "");
        if (_hanMucUSD == null || _hanMucUSD.equals("")) {
            _hanMucUSD = "0";
        }
        pos.setHanmucUsd(Long.parseLong(_hanMucUSD));

        if (tienkyquyMoto.equals("0")) {
            _session.setAttribute("tienkyquyMoto", "");
        }
        if (hanMucVND.equals("0")) {
            _session.setAttribute("hanmucVnd", "");
        }
        if (hanMucUSD.equals("0")) {
            _session.setAttribute("hanmucUsd", "");
        }

        pos.setSoTktgtt(request.getParameter("soTktgtt"));
        pos.setTeninhoadon(request.getParameter("teninhoadon"));
        pos.setTenchutk(request.getParameter("tenchutk"));
        pos.setDiachiLapdat(request.getParameter("diachiLapdat"));
        pos.setGhichu(request.getParameter("ghichu"));
        pos.setDongmay(request.getParameter("dongmay"));
        pos.setTenNganhNghe(request.getParameter("tenNganhNghe"));
        model.update(pos);

        String error = "Đã cập nhật thông tin POS !";
        m.addAttribute("error", error);
        return themTtLapDatPOS(m, _id, request, res);
    }

    @RequestMapping(value = "themthongsopos", method = RequestMethod.GET)
    public String themThongSoPos(Model m, @RequestParam(value = "id_edit", required = false) long id_edit, HttpServletRequest request) {

        _session = request.getSession();
        _session.setAttribute("id_edit", id_edit);
        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }
        // Only USER1_P.KTT&NHS duoc truy cap themthongsopos.html
        Byte groupuser = (Byte) _session.getAttribute("groupuser");
        if (groupuser != 7) {
            return "redirect:index.html";
        }
        //_session.removeAttribute("_seri");

        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive pos = new TtPosTempLive();
        pos = model.getTtPosTemp(id_edit);

        String dongmay = pos.getDongmay();
        String teninhoadon = pos.getTeninhoadon();
        String soTktgtt = pos.getSoTktgtt();
        String tenchutk = pos.getTenchutk();
        String diachiLapdat = pos.getDiachiLapdat();
        String tenDvcnt = pos.getTenDvcnt();
        String ghiChu = pos.getGhichu();
        Byte gddb1 = pos.getGddb1();
        Byte gddb2 = pos.getGddb2();
        Byte gddb3 = pos.getGddb3();
        Byte gddb4 = pos.getGddb4();
        Byte gddb5 = pos.getGddb5();
        Byte gddb6 = pos.getGddb6();
        Byte gddb7 = pos.getGddb7();
        Byte gddb8 = pos.getGddb8();
        Byte gddb9 = pos.getGddb9();
        long hanmucUsd = pos.getHanmucUsd();
        long hanmucVnd = pos.getHanmucVnd();
        String tenNganhNghe = pos.getTenNganhNghe();

        _stt = id_edit;
        _teninhoadon = teninhoadon;
        _soTktgtt = soTktgtt;
        _tenchutk = tenchutk;
        _diachilapdat = diachiLapdat;
        _tenDvcnt = tenDvcnt;
        _ghichu = ghiChu;
        _dongmay = dongmay;

        _session.setAttribute("maDvcnt", _id);
        _session.setAttribute("_idedit", id_edit);
        _session.setAttribute("_teninhoadon", _teninhoadon);
        _session.setAttribute("_soTktgtt", _soTktgtt);
        _session.setAttribute("_tenchutk", _tenchutk);
        _session.setAttribute("_diachiLapdat", _diachilapdat);
        _session.setAttribute("_tenDvcnt", _tenDvcnt);
        _session.setAttribute("_ghiChu", _ghichu);
        _session.setAttribute("_dongmay", _dongmay);

        _session.setAttribute("_gddb1", gddb1);
        _session.setAttribute("_gddb2", gddb2);
        _session.setAttribute("_gddb3", gddb3);
        _session.setAttribute("_gddb4", gddb4);
        _session.setAttribute("_gddb5", gddb5);
        _session.setAttribute("_gddb6", gddb6);
        _session.setAttribute("_gddb7", gddb7);
        _session.setAttribute("_gddb8", gddb8);
        _session.setAttribute("_gddb9", gddb9);
        _session.setAttribute("_hanmucUsd", hanmucUsd);
        _session.setAttribute("_hanmucVnd", hanmucVnd);
        _session.setAttribute("tenNganhNghe", tenNganhNghe);

        // DS TT_POS_TEMP của ĐVCNT
        m.addAttribute("lstPosTemp", model.getAllById(_id));

        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(_id);
        m.addAttribute("soluongdagan", soluongdagan);

        TtPosModel modelPOS = new TtPosModel();
        m.addAttribute("listPOSTonKho", modelPOS.getListPosByTinhTrang("Ton kho"));
        return "themthongsopos";
    }

    @RequestMapping(value = "chinhsuathongsodagan", method = RequestMethod.GET)
    public String chinhsuathongsodagan(Model m, @RequestParam(value = "id_edit", required = false) long id_edit, HttpServletRequest request) {
        _session = request.getSession();
        _id = String.valueOf(_session.getAttribute("_id")); // maDvcnt
        _session.setAttribute("_id", _id); // maDvcnt
        _session.setAttribute("id_pos_temp", id_edit); // id_pos_temp

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }
        // Only USER1_P.KTT&NHS duoc truy cap themthongsopos.html
        Byte groupuser = (Byte) _session.getAttribute("groupuser");
        if (groupuser != 7) {
            return "redirect:index.html";
        }
        //_session.removeAttribute("_seri");

        TtPosTempModel model = new TtPosTempModel();
        TtPosTempLive pos = new TtPosTempLive();
        pos = model.getTtPosTemp(id_edit);

        String soseri = pos.getSoseri();
        _session.setAttribute("soseri", soseri);

        TtPosModel modelPos = new TtPosModel();
        String nganhang = modelPos.getNganHangThanhToanBySeriNumber(soseri);
        _session.setAttribute("nganhang", nganhang);

        String mataisan = modelPos.getMaTaiSanBySeriNumber(soseri);
        _session.setAttribute("mataisan", mataisan);

        String mcc = pos.getMcc();
        _session.setAttribute("mcc", mcc);

        String hanmucVND = String.valueOf(pos.getHanmucVnd());
        String hanmucUSD = String.valueOf(pos.getHanmucUsd());
        _session.setAttribute("hanmucVND", hanmucVND);
        _session.setAttribute("hanmucUsd", hanmucUSD);

        String tid1 = String.valueOf(pos.getTid1());
        String mid1 = String.valueOf(pos.getMid1());

        String tid2 = String.valueOf(pos.getTid2());
        String mid2 = String.valueOf(pos.getMid2());

        String tid3 = String.valueOf(pos.getTid3());
        String mid3 = String.valueOf(pos.getMid3());

        _session.setAttribute("tid1", tid1);
        _session.setAttribute("mid1", mid1);

        _session.setAttribute("tid2", tid2);
        _session.setAttribute("mid2", mid2);

        _session.setAttribute("tid3", tid3);
        _session.setAttribute("mid3", mid3);

        String dongmay = pos.getDongmay();
        String teninhoadon = pos.getTeninhoadon();
        String soTktgtt = pos.getSoTktgtt();
        String tenchutk = pos.getTenchutk();
        String diachiLapdat = pos.getDiachiLapdat();
        String tenDvcnt = pos.getTenDvcnt();
        String ghiChu = pos.getGhichu();
        Byte gddb1 = pos.getGddb1();
        Byte gddb2 = pos.getGddb2();
        Byte gddb3 = pos.getGddb3();
        Byte gddb4 = pos.getGddb4();
        Byte gddb5 = pos.getGddb5();
        Byte gddb6 = pos.getGddb6();
        Byte gddb7 = pos.getGddb7();
        Byte gddb8 = pos.getGddb8();
        Byte gddb9 = pos.getGddb9();
        long hanmucUsd = pos.getHanmucUsd();
        long hanmucVnd = pos.getHanmucVnd();

        _stt = id_edit;
        _teninhoadon = teninhoadon;
        _soTktgtt = soTktgtt;
        _tenchutk = tenchutk;
        _diachilapdat = diachiLapdat;
        _tenDvcnt = tenDvcnt;
        _ghichu = ghiChu;
        _dongmay = dongmay;

        _session.setAttribute("_id", _id);
        _session.setAttribute("_idedit", id_edit);
        _session.setAttribute("_teninhoadon", _teninhoadon);
        _session.setAttribute("_soTktgtt", _soTktgtt);
        _session.setAttribute("_tenchutk", _tenchutk);
        _session.setAttribute("_diachiLapdat", _diachilapdat);
        _session.setAttribute("_tenDvcnt", _tenDvcnt);
        _session.setAttribute("_ghiChu", _ghichu);
        _session.setAttribute("_dongmay", _dongmay);

        _session.setAttribute("_gddb1", gddb1);
        _session.setAttribute("_gddb2", gddb2);
        _session.setAttribute("_gddb3", gddb3);
        _session.setAttribute("_gddb4", gddb4);
        _session.setAttribute("_gddb5", gddb5);
        _session.setAttribute("_gddb6", gddb6);
        _session.setAttribute("_gddb7", gddb7);
        _session.setAttribute("_gddb8", gddb8);
        _session.setAttribute("_gddb9", gddb9);
        _session.setAttribute("hanmucUsd", hanmucUsd);
        _session.setAttribute("_hanmucVnd", hanmucVnd);

        // DS TT_POS_TEMP của ĐVCNT
        m.addAttribute("lstPosTemp", model.getAllById(_id));

        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(_id);
        m.addAttribute("soluongdagan", soluongdagan);

        TtPosModel modelPOS = new TtPosModel();
        m.addAttribute("listPOSTonKho", modelPOS.getListPosByTinhTrang("Ton kho"));
        return "chinhsuathongsodagan";
    }

    @RequestMapping(value = "hoantat_themttlapdatpos", method = RequestMethod.GET)
    public String hoanTatThemThongSoPos(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();
        // Số lượng POS đã gán
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countById(_id);
        m.addAttribute("soluongdagan", soluongdagan);

        // Số lượng POS đã đăng ký
        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = modelDvcnt.getTtDvcnt(_id);
        _soluongPos = ttdvcnt.getSlpos();

        if (_soluongPos > soluongdagan) {
            String error = "Chưa gán gán đủ " + _soluongPos + " máy POS cho ĐVCNT " + _id;
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(_id);
            Byte status = 1;
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);
            return "themthongtinlapdatpos";
        } else if (_soluongPos < soluongdagan) {
            String error = "Gán thừa thông tin lắp đặt. Xin kiểm tra lại !";
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(_id);
            Byte status = 1;
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);
            return "themthongtinlapdatpos";
        } else if (ttdvcnt.getFileUpload() == null) {
            String error = "Chưa đính kèm hồ sơ pháp lý ĐVCNT";
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
            return "themthongtinlapdatpos";
        } else if (ttdvcnt.getDirectCode() == null) {
            String error = "Chưa gán mã nhân viên quản lý !";
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
            return "themthongtinlapdatpos";
        } else {
            Byte status = 3; // (1)CN/PGD Complete
            ttdvcnt.setStatusDuyet(status);

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

            // GHI LOG
            TtLogDvcntModel modelLog = new TtLogDvcntModel();
            TtLogDvcnt log = new TtLogDvcnt();
            log.setLogUser(String.valueOf(_session.getAttribute("mauser")).replaceAll(" ", ""));
            log.setLogLevel((Byte) _session.getAttribute("groupuser"));
            log.setLogTime(get_SystemTime());
            log.setLogMid(_id);           

            try {
                modelDvcnt.update(ttdvcnt);
                log.setLogContent("(1)CN/PGD gửi duyệt(Thêm mới ĐVCNT: " + ttdvcnt.getTenDvcntVn() + ")");
                modelLog.create(log); // create log
            } catch (Exception e) {
                log.setLogContent("Gửi duyệt không thành công(themthongtinlapdatpos.html). Chi tiết: " + e.toString());
                modelLog.create(log); // create log
            }
            m.addAttribute("status", ttdvcnt.getStatusDuyet());
        }
        String confirm = "Đã gửi duyệt ĐVCNT " + _id;
        _session.setAttribute("confirm", confirm);

        return "redirect:dvcntdangxuly.html";
    }

    @RequestMapping(value = "guiduyetlapthempos", method = RequestMethod.GET)
    public String guiduyetlapthempos(Model m, @RequestParam(value = "id", required = false) String id, HttpServletRequest request) {
        _session = request.getSession();

        // Số lượng POS lắp thêm đã nhập trong bảng TT_POS_TEMP: có ismapping = 2
        _id = id;
        TtPosTempModel modelTemp = new TtPosTempModel();
        int soluongdagan = modelTemp.countPosThemMoi(_id);
        m.addAttribute("soluongdagan", id);

        // Số lượng POS đã đăng ký thêm mới
        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive ttdvcnt = new TtDvcntLive();
        ttdvcnt = modelDvcnt.getTtDvcnt(_id);
        _session.setAttribute("_id", _id);
        _soluongPos = ttdvcnt.getSllapthem();

        if (_soluongPos > soluongdagan) {
            String error = "Chưa gán gán đủ " + _soluongPos + " máy POS cho ĐVCNT " + _id;
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(_id);
            Byte status = 1;
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);

            DVCNTController dvcntController = new DVCNTController();
            return dvcntController.lapThemPos(request, m, _id);
        } else if (_soluongPos < soluongdagan) {
            String error = "Gán thừa thông tin lắp đặt. Xin kiểm tra lại !";
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(_id);
            Byte status = 1;
            dvcnt.setStatusDuyet(status);
            modelDvcnt.update(dvcnt);

            DVCNTController dvcntController = new DVCNTController();
            return dvcntController.lapThemPos(request, m, _id);
        } else if (ttdvcnt.getFileUpload2() == null) {
            String error = "Chưa đính kèm hồ sơ pháp lý ĐVCNT";
            m.addAttribute("error", error);
            m.addAttribute("lstPosTemp", modelTemp.getAllById(_id));

            DVCNTController dvcntController = new DVCNTController();
            return dvcntController.lapThemPos(request, m, _id);
        } // Kiem tra co upload file scan yeu cau lap them moi hay chua?
        else if (ttdvcnt.getStatusDvcnt() == 8 && ttdvcnt.getFileUpload2() == null) {
            String error = "Chưa đính kèm hồ sơ pháp lý ĐVCNT";
            m.addAttribute("error", error);
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
            m.addAttribute("soluonglapthem", soluonglapthem);

            // Load lên danh sách POS đã lắp
            TtPosModel modelPos = new TtPosModel();
            int soLuongPosDaLap = modelPos.countPOSByMid(id);
            m.addAttribute("soluongdalap", soLuongPosDaLap);
            m.addAttribute("listPosDaLap", modelPos.getListPosByIdDVCNT(id));

            // Load danh sach thông tin POS_TEMP vừa đc thêm mới.
            m.addAttribute("listPosThemMoi", modelTemp.getDSPOSThemMoi(id));

            DVCNTController dvcntController = new DVCNTController();
            return dvcntController.lapThemPos(request, m, _id);
        } else {
            Byte statusDuyet = 3; // (1)CN/PGD Complete
            ttdvcnt.setStatusDuyet(statusDuyet);

            String user1ChiNhanhPGD = ttdvcnt.getUser1Cn();
            long user1ChiNhanhPGD_Date = ttdvcnt.getUser1CnNgaynhap();

            String user2ChiNhanhPGD = ttdvcnt.getUser2Cn();
            if (user2ChiNhanhPGD == null) {
                user2ChiNhanhPGD = "";
            }

            String str_user2ChiNhanhPGD_Date = String.valueOf(ttdvcnt.getUser2CnDate());
            long user2ChiNhanhPGD_Date = 0;
            if (str_user2ChiNhanhPGD_Date == "null") {
                user2ChiNhanhPGD_Date = 0;
            } else {
                user2ChiNhanhPGD_Date = ttdvcnt.getUser2CnDate();
            }

            Byte loaihinh = ttdvcnt.getLoaihinhDvcnt();

            String user1KhachHangCaNhan = "";
            long user1KhachHangCaNhan_Date = 0;
            String user2KhachHangCaNhan = "";
            long user2KhachHangCaNhan_Date = 0;
            if (loaihinh == 1) {
                user1KhachHangCaNhan = ttdvcnt.getUser1Ptdbh();
                if (user1KhachHangCaNhan == null) {
                    user1KhachHangCaNhan = "";
                }
                String str_user1KhachHangCaNhan_Date = String.valueOf(ttdvcnt.getUser1PtdbhDate());
                if (str_user1KhachHangCaNhan_Date != "null") {
                    user1KhachHangCaNhan_Date = ttdvcnt.getUser1PtdbhDate();
                }

                user2KhachHangCaNhan = ttdvcnt.getUser2Ptdbh();
                if (user2KhachHangCaNhan == null) {
                    user2KhachHangCaNhan = "";
                }
                String str_user2KhachHangCaNhan_Date = String.valueOf(ttdvcnt.getUser2PtdbhDate());
                if (str_user2KhachHangCaNhan_Date != "null") {
                    user2KhachHangCaNhan_Date = ttdvcnt.getUser2PtdbhDate();
                }
            }

            String user1_KHDN = "";
            long user1_KHDN_Date = 0;
            String User2Pkhdn = "";
            long getUser2Pkhdn_Date = 0;
            if (loaihinh == 2) {
                user1_KHDN = ttdvcnt.getUser1Pkhdn();
                if (user1_KHDN == null) {
                    user1_KHDN = "";
                }
                String str_getUser1Pkhdn_Date = String.valueOf(ttdvcnt.getUser1PkhdnDate());
                if (str_getUser1Pkhdn_Date != "null") {
                    user1_KHDN_Date = ttdvcnt.getUser1PkhdnDate();
                }

                User2Pkhdn = ttdvcnt.getUser2Pkhdn();
                if (User2Pkhdn == null) {
                    User2Pkhdn = "";
                }
                String str_getUser2Pkhdn_Date = String.valueOf(ttdvcnt.getUser2PkhdnDate());
                if (str_getUser2Pkhdn_Date != "null") {
                    getUser2Pkhdn_Date = ttdvcnt.getUser2PkhdnDate();
                }
            }

            String user1Ptnt = "";
            long user1Ptnt_Date = 0;
            String user2Ptnt = "";
            long user2Ptnt_Date = 0;

            user1Ptnt = ttdvcnt.getUser1Ptnt();
            if (user1Ptnt == null) {
                user1Ptnt = "";
            }
            String str_user1Ptnt_Date = String.valueOf(ttdvcnt.getUser1PtntDate());
            if (str_user1Ptnt_Date != "null") {
                user1Ptnt_Date = ttdvcnt.getUser1PtntDate();
            }

            user2Ptnt = ttdvcnt.getUser2Ptnt();
            if (user2Ptnt == null) {
                user2Ptnt = "";
            }
            String str_user2Ptnt_Date = String.valueOf(ttdvcnt.getUser2PtntDate());
            if (str_user2Ptnt_Date != "null") {
                user2Ptnt_Date = ttdvcnt.getUser2PtntDate();
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

            String LOG_USER = ttdvcnt.getLogUser();
            String new_Log_User = "";

            if (loaihinh == 1) {
                new_Log_User = "[LapThem_" + _user1ChiNhanhPGD.replaceAll(" ", "") + _user1ChiNhanhPGD_Date + _user2ChiNhanhPGD.replaceAll(" ", "") + _user2ChiNhanhPGD_Date.replaceAll(" ", "")
                        + _user1KhachHangCaNhan.replaceAll(" ", "") + _user1KhachHangCaNhan_Date + _user2KhachHangCaNhan.replaceAll(" ", "") + _user2KhachHangCaNhan_Date
                        + _user1Ptnt.replaceAll(" ", "") + _user1Ptnt_Date + _user2Ptnt.replaceAll(" ", "") + _user2_KHDN_Date + "]";
            }

            if (loaihinh == 2) {
                new_Log_User = "[LapThem_" + _user1ChiNhanhPGD.replaceAll(" ", "") + _user1ChiNhanhPGD_Date + _user2ChiNhanhPGD.replaceAll(" ", "") + _user2ChiNhanhPGD_Date.replaceAll(" ", "")
                        + _user1_KHDN.replaceAll(" ", "") + _user1_KHDN_Date + _user2_KHDN.replaceAll(" ", "") + _user2_KHDN_Date
                        + _user1Ptnt.replaceAll(" ", "") + _user1Ptnt_Date + _user2Ptnt.replaceAll(" ", "") + _user2Ptnt_Date + "]";
            }

            LOG_USER = LOG_USER + new_Log_User + " ";
            ttdvcnt.setLogUser(LOG_USER);

            String UserNhap = (String) _session.getAttribute("mauser");
            ttdvcnt.setUser1Cn(UserNhap);
            String cnQuanly = (String) _session.getAttribute("macn");
            ttdvcnt.setCnQuanly(cnQuanly);

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
            ttdvcnt.setUser1CnNgaynhap(user1DonviNgaynhap);

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

            Byte statusDvcnt = 8;
            ttdvcnt.setStatusDvcnt(statusDvcnt);

            String confirm = "Đã gửi duyệt lắp thêm ĐVCNT " + _id;
            _session.setAttribute("confirm", confirm);
            modelDvcnt.update(ttdvcnt);
            m.addAttribute("status", ttdvcnt.getStatusDuyet());
        }
        return "redirect:dvcntdangxuly.html";
    }

    @RequestMapping(value = "/xulythemthongsopso", method = RequestMethod.POST)
    public String themThongSoPOS(Model m, @ModelAttribute(value = "_thongsopos") TtPosLive p, HttpServletRequest request) {
        _session = request.getSession();

        String soseri = (String) _session.getAttribute("_seri");
        String checkError = (String) _session.getAttribute("_checkError");
        if (soseri.equals("") || soseri == null || checkError != "") {
            String error = "Chưa chọn số seri hoặc serial không khả dụng !";
            m.addAttribute("error", error);
            return "themthongsopos";
        } else {
            String idpostemp = request.getParameter("id_edit");
            String maDvcnt = request.getParameter("maDvcnt");
            String tenDvcnt = request.getParameter("tenDvcnt");
            String tenInHoaDon = request.getParameter("teninhoadon");
            String soTktgtt = request.getParameter("soTktgtt");
            String tenchutk = request.getParameter("tenchutk");
            String diachiLapdat = request.getParameter("diachiLapdat");
            String nganhang = request.getParameter("nganhang");
            String dongmay = request.getParameter("dongmay");
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

            String dongmayTheoSoSeri = (String) _session.getAttribute("_dongmaytheoSeri");

            if (!dongmayTheoSoSeri.equals(dongmay)) {
                String error = "Dòng máy đã chọn & dòng máy dropdown phải giống nhau";
                m.addAttribute("error", error);
                return "themthongsopos";
            }

            String mcc = request.getParameter("mcc");
            String hanmucVnd = request.getParameter("hanmucVnd");
            String hanmucUsd = request.getParameter("hanmucUsd");

            if (request.getParameter("hanmucVnd") == null || hanmucVnd.equals("")) {
                hanmucVnd = "0";
            } else {
                hanmucVnd = request.getParameter("hanmucVnd");
            }

            if (request.getParameter("hanmucUsd") == null || hanmucUsd.equals("")) {
                hanmucUsd = "0";
            } else {
                hanmucUsd = request.getParameter("hanmucUsd");
            }

            String tid1 = request.getParameter("tid1");
            String mid1 = request.getParameter("mid1");

            String tid2 = request.getParameter("tid2");
            String mid2 = request.getParameter("mid2");

            String tid3 = request.getParameter("tid3");
            String mid3 = request.getParameter("mid3");

            // Lấy thông tin GDĐB từ TT_DVCNT.
            TtDvcntModel modelDvcnt = new TtDvcntModel();
            TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(maDvcnt);

            _session.setAttribute("_id", maDvcnt);

            Byte tinhtrangDvcnt = dvcnt.getStatusDvcnt();
            String loaitien = dvcnt.getLoaitien();

            if (tinhtrangDvcnt == 8) { // ĐVCNT lắp thêm POS
                TtPosTempModel modelTemp = new TtPosTempModel();
                TtPosTempLive pos = new TtPosTempLive();
                pos = modelTemp.getTtPosTemp(Long.parseLong(idpostemp));
            }

            // Map vào TABLE TT_POS
            TtPosTempModel modelPosTemp = new TtPosTempModel();
            TtPosTempLive posTemp = new TtPosTempLive();
            posTemp = modelPosTemp.getTtPosTemp(Long.parseLong(idpostemp));

            TtPosModel model = new TtPosModel();
            List<TtPosLive> lst = new ArrayList<TtPosLive>();
            lst = model.getPosBySeri(soseri);
            TtPosLive pos = new TtPosLive();
            for (int i = 0; i < lst.size(); i++) {
                pos = lst.get(i);
                break;
            }

            pos.setMccCode(posTemp.getMccCode());
            pos.setMerchantType(posTemp.getMerchantType());
            pos.setVungLapdat(posTemp.getVungLapdat());

            pos.setMid(maDvcnt);
            pos.setTenDvcnt(tenDvcnt);
            pos.setTeninhoadon(tenInHoaDon);
            pos.setSoTktgtt(soTktgtt);
            pos.setTenchutk(tenchutk);
            pos.setDiachiLapdat(diachiLapdat);
            pos.setNganhang(nganhang);
            pos.setLoaitien(loaitien);

            pos.setMcc(mcc);
            pos.setTid1(tid1);
            pos.setMid1(mid1);
            pos.setTid2(tid2);
            pos.setMid2(mid2);
            pos.setTid3(tid3);
            pos.setMid3(mid3);

            pos.setGddb1(gddb1);
            pos.setGddb2(gddb2);
            pos.setGddb3(gddb3);
            pos.setGddb4(gddb4);
            pos.setGddb5(gddb5);
            pos.setGddb6(gddb6);
            pos.setGddb7(gddb7);
            pos.setGddb8(gddb8);
            pos.setGddb9(gddb9);

            pos.setHanmucUsd(Long.parseLong(hanmucUsd));
            pos.setHanmucVnd(Long.parseLong(hanmucVnd));
            pos.setTenNganhNghe(String.valueOf(_session.getAttribute("tenNganhNghe")));

            // Set tinh trang = "Sử dụng"
            pos.setTinhtrangPos("Sử dụng");
            model.update(pos);

            // Map vào TABLE TT_POS_TEMP           
            posTemp.setTid1(tid1);
            posTemp.setMid1(mid1);
            posTemp.setTid2(tid2);
            posTemp.setMid2(mid2);
            posTemp.setTid3(tid3);
            posTemp.setMid3(mid3);
            posTemp.setHanmucUsd(Long.parseLong(hanmucUsd));
            posTemp.setHanmucVnd(Long.parseLong(hanmucVnd));
            posTemp.setDongmay(dongmay);
            posTemp.setSoseri(soseri);
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
            posTemp.setHanmucUsd(Long.parseLong(hanmucUsd));
            posTemp.setHanmucVnd(Long.parseLong(hanmucVnd));

            modelPosTemp.update(posTemp);

            // Set tinh trang = "Sử dụng"
            pos.setTinhtrangPos("Sử dụng");
            model.update(pos);

            // Cập nhật ISMAPPPING =  1 :  đã map
            TtPosTempModel modelTemp = new TtPosTempModel();
            TtPosTempLive postemp = new TtPosTempLive();
            postemp = modelTemp.getTtPosTemp(Integer.parseInt(idpostemp));

            // Nếu là POS thêm mới => Cập nhật ISMAPPING = 3(Đã map POS mới)
            if (postemp.getIsmapping() == 2 && dvcnt.getStatusDvcnt() != 0) {
                Byte status = 3;
                postemp.setIsmapping(status);
                modelTemp.update(postemp);
            }

            if (postemp.getIsmapping() == null) {
                Byte status = -1; // POS lắp lần đầu tiên, user 1 TNT chưa gửi duyệt
                postemp.setIsmapping(status);
                modelTemp.update(postemp);
            } else if (postemp.getIsmapping() == 3) {

            } else {
                Byte status = -1; // POS đăng ký lắp thêm mới, user 1 TNT chưa gửi duyệt
                postemp.setIsmapping(status);
                modelTemp.update(postemp);
            }

            // Số lượng POS đã map
            int soluongdamap = modelTemp.countByIsMapping(maDvcnt);

            // Số lượng POS đã gán
            int soluongdagan = modelTemp.countById(maDvcnt);

            if (soluongdamap == soluongdagan) {
                dvcnt = modelDvcnt.getTtDvcnt(maDvcnt);
                Byte tinhtrang = 12; // (1) Map xong thông số(chưa được duyệt)
                dvcnt.setStatusDuyet(tinhtrang);
                modelDvcnt.update(dvcnt);
            }
            String luthongsothanhcong = "Đã lưu thông số dòng máy " + dongmayTheoSoSeri + ". ĐVCNT: " + maDvcnt;
            _session.setAttribute("luthongsothanhcong", luthongsothanhcong);
            return taothongso(m, _id, request); //themTtLapDatPOS(m, maDvcnt, request);
        }
    }

    @RequestMapping(value = "/xulychinhsuathongsopos", method = RequestMethod.POST)
    public String xulychinhsuathongsopos(Model m, @ModelAttribute(value = "_thongsopos") TtPosLive p, HttpServletRequest request) {
        _session = request.getSession();
        _id = String.valueOf(_session.getAttribute("_id")); // ma_Dvcnt

        String soseri = (String) _session.getAttribute("soseri");
        String idpostemp = String.valueOf(_session.getAttribute("id_pos_temp"));

        String maDvcnt = request.getParameter("maDvcnt");
        String tenDvcnt = request.getParameter("tenDvcnt");
        String tenInHoaDon = request.getParameter("teninhoadon");
        String soTktgtt = request.getParameter("soTktgtt");
        String tenchutk = request.getParameter("tenchutk");
        String diachiLapdat = request.getParameter("diachiLapdat");
        String nganhang = request.getParameter("nganhang");
        String dongmay = request.getParameter("dongmay");

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

//
//        if (!dongmayTheoSoSeri.equals(dongmay)) {
//            String error = "Dòng máy đã chọn & dòng máy dropdown phải giống nhau";
//            m.addAttribute("error", error);
//            return "themthongsopos";
//        }
        String mcc = request.getParameter("mcc");
        String hanmucVnd = request.getParameter("hanmucVnd");
        String hanmucUsd = request.getParameter("hanmucUsd");

        if (hanmucVnd == null || hanmucVnd.equals("")) {
            hanmucVnd = "0";
        }

        if (hanmucUsd == null || hanmucUsd.equals("")) {
            hanmucUsd = "0";
        }

        String tid1 = request.getParameter("tid1");
        String mid1 = request.getParameter("mid1");

        String tid2 = request.getParameter("tid2");
        String mid2 = request.getParameter("mid2");

        String tid3 = request.getParameter("tid3");
        String mid3 = request.getParameter("mid3");

        // Lấy thông tin GDĐB từ TT_DVCNT.
        TtDvcntModel modelDvcnt = new TtDvcntModel();
        TtDvcntLive dvcnt = new TtDvcntLive();
        dvcnt = modelDvcnt.getTtDvcnt(maDvcnt);

        _session.setAttribute("_id", maDvcnt);

        String loaitien = dvcnt.getLoaitien();

//        if (tinhtrangDvcnt == 8) { // ĐVCNT lắp thêm POS
//            TtPosTempModel modelTemp = new TtPosTempModel();
//            TtPosTemp pos = new TtPosTemp();
//            pos = modelTemp.getTtPosTemp(Long.parseLong(idpostemp));
//        }
        // Map vào TABLE TT_POS
        TtPosModel model = new TtPosModel();
        List<TtPosLive> lst = new ArrayList<TtPosLive>();
        lst = model.getPosBySeri(soseri);
        TtPosLive pos = new TtPosLive();
        for (int i = 0; i < lst.size(); i++) {
            pos = lst.get(i);
            break;
        }

        pos.setMid(maDvcnt);
        pos.setTenDvcnt(tenDvcnt);
        pos.setTeninhoadon(tenInHoaDon);
        pos.setSoTktgtt(soTktgtt);
        pos.setTenchutk(tenchutk);
        pos.setDiachiLapdat(diachiLapdat);
        pos.setNganhang(nganhang);
        pos.setLoaitien(loaitien);

        pos.setMcc(mcc);
        pos.setTid1(tid1);
        pos.setMid1(mid1);
        pos.setTid2(tid2);
        pos.setMid2(mid2);
        pos.setTid3(tid3);
        pos.setMid3(mid3);

        pos.setGddb1(gddb1);
        pos.setGddb2(gddb2);
        pos.setGddb3(gddb3);
        pos.setGddb4(gddb4);
        pos.setGddb5(gddb5);
        pos.setGddb6(gddb6);
        pos.setGddb7(gddb7);
        pos.setGddb8(gddb8);
        pos.setGddb9(gddb9);

        pos.setHanmucUsd(Long.parseLong(hanmucUsd));
        pos.setHanmucVnd(Long.parseLong(hanmucVnd));

        // Set tinh trang = "Sử dụng"
        pos.setTinhtrangPos("Sử dụng");
        model.update(pos);

        // Map vào TABLE TT_POS_TEMP
        TtPosTempModel modelPosTemp = new TtPosTempModel();
        TtPosTempLive posTemp = new TtPosTempLive();
        posTemp = modelPosTemp.getTtPosTemp(Long.parseLong(idpostemp));

        posTemp.setTid1(tid1);
        posTemp.setMid1(mid1);
        posTemp.setTid2(tid2);
        posTemp.setMid2(mid2);
        posTemp.setTid3(tid3);
        posTemp.setMid3(mid3);
        posTemp.setHanmucUsd(Long.parseLong(hanmucUsd));
        posTemp.setHanmucVnd(Long.parseLong(hanmucVnd));
        posTemp.setDongmay(dongmay);
        posTemp.setSoseri(soseri);
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

        modelPosTemp.update(posTemp);

        // Set tinh trang = "Sử dụng"
        pos.setTinhtrangPos("Sử dụng");
        model.update(pos);

        // Cập nhật ISMAPPPING
        TtPosTempModel modelTemp = new TtPosTempModel();
        TtPosTempLive postemp = new TtPosTempLive();
        postemp = modelTemp.getTtPosTemp(Integer.parseInt(idpostemp));

        // Nếu là POS thêm mới => Cập nhật ISMAPPING = 3(Đã map POS mới)
        if (postemp.getIsmapping() == 2 && dvcnt.getStatusDvcnt() != 0) {
            Byte status = 3;
            postemp.setIsmapping(status);
            modelTemp.update(postemp);
        }

        if (postemp.getIsmapping() == null) {
            Byte status = -1; // POS lắp lần đầu tiên, user 1 TNT chưa gửi duyệt
            postemp.setIsmapping(status);
            modelTemp.update(postemp);
        } else if (postemp.getIsmapping() == 3) {

        } else {
            Byte status = -1; // POS đăng ký lắp thêm mới đã map xong, user 1 TNT chưa gửi duyệt
            postemp.setIsmapping(status);
            modelTemp.update(postemp);
        }

        // Số lượng POS đã map, có ismapping = -1 (1)P.KTT&NHS đã map, chưa gửi duyệt
        int soluongdamap = modelTemp.countByIsMappingBangTru1(maDvcnt);

        // Số lượng POS đã gán
        int soluongdagan = modelTemp.countById(maDvcnt);

        if (soluongdamap == soluongdagan) {
//                TtDvcntModel modelDvcnt = new TtDvcntModel();
//                TtDvcntLive dvcnt = new TtDvcntLive();
            dvcnt = modelDvcnt.getTtDvcnt(maDvcnt);
            Byte tinhtrang = 12; // (1) Map xong thông số(chưa được duyệt)
            dvcnt.setStatusDuyet(tinhtrang);
            modelDvcnt.update(dvcnt);
        }
        String luthongsothanhcong = "Đã lưu thông số dòng máy " + soseri + ". ĐVCNT: " + maDvcnt;
        _session.setAttribute("luthongsothanhcong", luthongsothanhcong);
        return taothongso(m, _id, request); //themTtLapDatPOS(m, maDvcnt, request);
    }

    @RequestMapping(value = "/search-pos-by-status", method = RequestMethod.GET)
    public String searchPOScombobox(Model m, HttpServletRequest request) {
        _session = request.getSession();
        String searchCbb = request.getParameter("key-search-status");
        m.addAttribute("keysearch", searchCbb);
        TtPosModel model = new TtPosModel();
        String tinhtrang;

        if (searchCbb.equals("1")) {
            return danhSachPos(m, request);
        }
        if (searchCbb.equals("2")) {
            tinhtrang = "Sử dụng";
            m.addAttribute("lst", model.getListPosByTinhTrang(tinhtrang));
        }
        if (searchCbb.equals("3")) {
            tinhtrang = "Ton kho";
            m.addAttribute("lst", model.getListPosByTinhTrang(tinhtrang));
        }
        return "danhsachpos";
    }

    @RequestMapping(value = "/search-pos-by-keyword", method = RequestMethod.GET)
    public String searchPOSByKeyWord(Model m, HttpServletRequest request) {
        _session = request.getSession();
        String searchCbb = request.getParameter("key-search");
        String txtsearchCbb = request.getParameter("txtsearch");
        m.addAttribute("keysearchbasic", searchCbb);
        m.addAttribute("txtsearchbasic", txtsearchCbb);
        TtPosModel model = new TtPosModel();

        if (!txtsearchCbb.equals("") || (request.getParameter("txtsearch") != null)) {
            if (searchCbb.equals("1")) {
                m.addAttribute("lst", model.getListPosByIdDVCNT(txtsearchCbb));
            }
            if (searchCbb.equals("2")) {
                m.addAttribute("lst", model.getListPosByDongMay(txtsearchCbb));
            }
            if (searchCbb.equals("3")) {
                m.addAttribute("lst", model.getListPosBySeriNo(txtsearchCbb));
            }
        }
        return "danhsachpos";
    }

    // Show ten dong may trong kho
    @RequestMapping(value = "dongmay", method = RequestMethod.GET)
    public String showTenDongMay(Model m) {
        TtPosModel model = new TtPosModel();
        List<TtPosLive> lst = model.getAll();
        List<TtPosLive> _lst = new ArrayList<TtPosLive>();
        TtPosLive pos = new TtPosLive();
        for (TtPosLive p : lst) {
            if (kiemTraXuatHien(_lst, p.getDongmay()) == true) {
                _lst.add(p);
            }
        }
        m.addAttribute("lst", _lst);
        int x = 8;
        m.addAttribute("size", x);
        return "dongmay";
    }

    // Kiem tra trung
    public boolean kiemTraXuatHien(List<TtPosLive> list, String str) {
        for (TtPosLive p : list) {
            if (p.getDongmay().equals(str)) {
                return false;
            }
        }
        return true;
    }

    @RequestMapping(value = "xuatphieuyeucau", method = RequestMethod.GET)
    public String xxuatphieuyeucau(HttpServletRequest request, Model m) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        // Lấy ngay/thang/nam hiện tại
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        m.addAttribute("day", day);
        m.addAttribute("month", month);
        m.addAttribute("year", year);

        TtPosTempModel model = new TtPosTempModel();
        m.addAttribute("lst", model.getDSPOSxuatPhieuYeuCau());
        int size = model.getDSPOSxuatPhieuYeuCau().size();
        return "xuatphieuyeucau";
    }

    @RequestMapping(value = "/thoigianxuatpyc", method = RequestMethod.GET)
    public String timKiemXuatPhieuYeuCauTheoThoiGian(Model m, @ModelAttribute(value = "TtPosTemp") TtPosTempLive p, HttpServletRequest request) {
        _session = request.getSession();
        String dayfrom = request.getParameter("dayfrom");
        String dayto = request.getParameter("dayto");

        TtPosTempModel model = new TtPosTempModel();

        m.addAttribute("lst", model.getlistTheoNgay_XuatPhieuYeuCau(dayfrom, dayto));
        int n = model.getlistTheoNgay_XuatPhieuYeuCau(dayfrom, dayto).size();

        m.addAttribute("dayfrom", dayfrom);
        m.addAttribute("dayto", dayto);

        // Lấy ngay/thang/nam hiện tại
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        m.addAttribute("day", day);
        m.addAttribute("month", month);
        m.addAttribute("year", year);

        return "xuatphieuyeucau";
    }

    @RequestMapping(value = "/phuoclh1", method = RequestMethod.POST)
    public String uploadxxx(Model m, @ModelAttribute(value = "_lapdatpos") TtPosTempLive p, HttpServletRequest request) {
        String saveFile = new String();
        String contentType = request.getContentType();

        if (contentType != null && contentType.indexOf("multipart/form-data") >= 0) {
            try {
                DataInputStream in = new DataInputStream(request.getInputStream());
            } catch (Exception e) {
            }

            int formDatalenght = request.getContentLength();

            byte dataBytes[] = new byte[formDatalenght];
            int byteRead = 0;
            int totalByteRead = 0;

            while (totalByteRead < formDatalenght) {
                try {
                    byteRead = in.read(dataBytes, totalByteRead, formDatalenght);
                } catch (Exception e) {
                }
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
        return "index";
    }

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
            message.setSubject("THONG BAO: CHUONG TRINH QUAN LY DVCNT, POS");

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
