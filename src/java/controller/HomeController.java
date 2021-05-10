package controller;

import entity.*;
import java.util.Properties;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.TtDvcntModel;
import model.TtPosModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

@Controller
public class HomeController {

    private HttpSession _session;

    // Gọi trang chủ
    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String TrangChu(Model m, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        TtDvcntModel model = new TtDvcntModel();
        long dvcntdangxuly = 0;
        dvcntdangxuly = model.countDVCNTDangXuLy();
        m.addAttribute("so_dvcntdangxuly", dvcntdangxuly);

        TtPosModel modelPos = new TtPosModel();
        long posdangxuly = 0;
        posdangxuly = modelPos.countPOSDangXuLy();
        m.addAttribute("so_posdangxuly", posdangxuly);
        return "index";
    }

    // Gọi màn hình thêm mới ĐVCNT
    @RequestMapping(value = "themmoidvcnt", method = RequestMethod.GET)
    public String abc(HttpServletRequest request, Model m) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }
        return "themmoidvcnt";
    }

    // Gọi màn hình xem quá trình duyệt
    @RequestMapping(value = "quytrinhduyet", method = RequestMethod.GET)
    public String xemQuaTrinhDuyet(HttpServletRequest request, Model m, @RequestParam(value = "id", required = false) String id) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }

        m.addAttribute("id", id);
        TtDvcntModel model = new TtDvcntModel();
        TtDvcntLive p = new TtDvcntLive();
        p = model.getTtDvcnt(id);

        Byte statusDuyet = p.getStatusDuyet();
        Byte statusDvcnt = p.getStatusDvcnt();
        Byte loaiHinhDvcnt = p.getLoaihinhDvcnt();
        m.addAttribute("statusDuyet", statusDuyet);
        m.addAttribute("statusDvcnt", statusDvcnt);
        m.addAttribute("loaiHinhDvcnt", loaiHinhDvcnt);

        // (1) CN/PGD
        if (p.getUser1Cn() == null) {
            m.addAttribute("user1Donvi", "");
        } else {
            String user1Donvi = p.getUser1Cn();
            m.addAttribute("user1Donvi", user1Donvi);
        }

        if (p.getUser1CnNgaynhap() == null) {
            m.addAttribute("_user1Donvi_NgayNhap", "");
        } else {
            long user1Donvi_NgayNhap = p.getUser1CnNgaynhap();
            String str_user1Donvi_NgayNhap = String.valueOf(user1Donvi_NgayNhap);
            String nam_user1Donvi_NgayNhap = str_user1Donvi_NgayNhap.substring(0, 4);
            String thang_user1Donvi_NgayNhap = str_user1Donvi_NgayNhap.substring(4, 6);
            String ngay_user1Donvi_NgayNhap = str_user1Donvi_NgayNhap.substring(6, 8);
            String _str_user1Donvi_NgayNhap = ngay_user1Donvi_NgayNhap + "/" + thang_user1Donvi_NgayNhap + "/" + nam_user1Donvi_NgayNhap;
            m.addAttribute("_user1Donvi_NgayNhap", _str_user1Donvi_NgayNhap);
        }

        // (2) CN/PGD
        if (p.getUser2Cn() == null) {
            m.addAttribute("user2Donvi", "");
        } else {
            String user2Donvi = p.getUser2Cn();
            m.addAttribute("user2Donvi", user2Donvi);

        }
        if (p.getUser2CnNote() == null) {
            m.addAttribute("ghichu_user2Donvi", "");
        } else {
            String ghichu_user2Donvi = p.getUser2CnNote();
            m.addAttribute("ghichu_user2Donvi", ghichu_user2Donvi);
        }
        if (p.getUser2CnDate() == null || p.getUser2CnDate() == 0) {
            m.addAttribute("_str_user2Donvi_NgayDuyet", "");
        } else {
            long user2Donvi_NgayDuyet = p.getUser2CnDate();
            String str_user2Donvi_NgayDuyet = String.valueOf(user2Donvi_NgayDuyet);
            String nam_user2Donvi_NgayDuyet = str_user2Donvi_NgayDuyet.substring(0, 4);
            String thang_user2Donvi_NgayDuyet = str_user2Donvi_NgayDuyet.substring(4, 6);
            String ngay_user2Donvi_NgayDuyet = str_user2Donvi_NgayDuyet.substring(6, 8);
            String _str_user2Donvi_NgayDuyet = ngay_user2Donvi_NgayDuyet + "/" + thang_user2Donvi_NgayDuyet + "/" + nam_user2Donvi_NgayDuyet;
            m.addAttribute("_str_user2Donvi_NgayDuyet", _str_user2Donvi_NgayDuyet);
            m.addAttribute("_str_user2Donvi_NgayDuyet", _str_user2Donvi_NgayDuyet);
        }

        // (1) P.SP&CS KHDN
        if (p.getUser1Pkhdn() == null) {
            m.addAttribute("user1KHDN", "");
        } else {
            String user1KHDN = p.getUser1Pkhdn();
            m.addAttribute("user1KHDN", user1KHDN);
        }
        if (p.getUser1PkhdnNote() == null) {
            m.addAttribute("ghichu_user1KHDN", "");
        } else {
            String ghichu_user1KHDN = p.getUser1PkhdnNote();
            m.addAttribute("ghichu_user1KHDN", ghichu_user1KHDN);
        }
        if (p.getUser1PkhdnDate() == null || p.getUser1PkhdnDate() == 0) {
            m.addAttribute("_str_user1KHDN_NgayDuyet", "");
        } else {
            long user1KHDN_NgayDuyet = p.getUser1PkhdnDate();
            String str_user1KHDN_NgayDuyet = String.valueOf(user1KHDN_NgayDuyet);
            String nam_user1KHDN_NgayDuyet = str_user1KHDN_NgayDuyet.substring(0, 4);
            String thang_user1KHDN_NgayDuyet = str_user1KHDN_NgayDuyet.substring(4, 6);
            String ngay_user1KHDN_NgayDuyet = str_user1KHDN_NgayDuyet.substring(6, 8);
            String _str_user1KHDN_NgayDuyet = ngay_user1KHDN_NgayDuyet + "/" + thang_user1KHDN_NgayDuyet + "/" + nam_user1KHDN_NgayDuyet;
            m.addAttribute("_str_user1KHDN_NgayDuyet", _str_user1KHDN_NgayDuyet);
        }
        // (2) P.SP&CS KHDN
        if (p.getUser2Pkhdn() == null) {
            m.addAttribute("user2KHDN", "");
        } else {
            String user2KHDN = p.getUser2Pkhdn();
            m.addAttribute("user2KHDN", user2KHDN);
        }
        if (p.getUser2PkhdnNote() == null) {
            m.addAttribute("ghichu_user2KHDN", "");
        } else {
            String ghichu_user2KHDN = p.getUser2PkhdnNote();
            m.addAttribute("ghichu_user2KHDN", ghichu_user2KHDN);
        }
        if (p.getUser2PkhdnDate() == null || p.getUser2PkhdnDate() == 0) {
            m.addAttribute("_str_user2KHDN_NgayDuyet", "");
        } else {
            long user2KHDN_NgayDuyet = p.getUser2PkhdnDate();
            String str_user2KHDN_NgayDuyet = String.valueOf(user2KHDN_NgayDuyet);
            String nam_user2KHDN_NgayDuyet = str_user2KHDN_NgayDuyet.substring(0, 4);
            String thang_user2KHDN_NgayDuyet = str_user2KHDN_NgayDuyet.substring(4, 6);
            String ngay_user2KHDN_NgayDuyet = str_user2KHDN_NgayDuyet.substring(6, 8);
            String _str_user2KHDN_NgayDuyet = ngay_user2KHDN_NgayDuyet + "/" + thang_user2KHDN_NgayDuyet + "/" + nam_user2KHDN_NgayDuyet;
            m.addAttribute("_str_user2KHDN_NgayDuyet", _str_user2KHDN_NgayDuyet);
        }
        // (1) P.QLKDTD
        if (p.getUser1Ptdbh() == null) {
            m.addAttribute("user1KHCN", "");
        } else {
            String user1KHCN = p.getUser1Ptdbh();
            m.addAttribute("user1KHCN", user1KHCN);
        }
        if (p.getUser1PtdbhNote() == null) {
            m.addAttribute("ghichu_user1KHCN", "");
        } else {
            String ghichu_user1KHCN = p.getUser1PtdbhNote();
            m.addAttribute("ghichu_user1KHCN", ghichu_user1KHCN);
        }
        if (p.getUser1PtdbhDate() == null || p.getUser1PtdbhDate() == 0) {
            m.addAttribute("_str_user1KHCN_NgayDuyet", "");
        } else {
            long user1KHCN_NgayDuyet = p.getUser1PtdbhDate();
            String str_user1KHCN_NgayDuyet = String.valueOf(user1KHCN_NgayDuyet);
            String nam_user1KHCN_NgayDuyet = str_user1KHCN_NgayDuyet.substring(0, 4);
            String thang_user1KHCN_NgayDuyet = str_user1KHCN_NgayDuyet.substring(4, 6);
            String ngay_user1KHCN_NgayDuyet = str_user1KHCN_NgayDuyet.substring(6, 8);
            String _str_user1KHCN_NgayDuyet = ngay_user1KHCN_NgayDuyet + "/" + thang_user1KHCN_NgayDuyet + "/" + nam_user1KHCN_NgayDuyet;
            m.addAttribute("_str_user1KHCN_NgayDuyet", _str_user1KHCN_NgayDuyet);
        }
        // (2) P.QLKDTD
        if (p.getUser2Ptdbh() == null) {
            m.addAttribute("user2KHCN", "");
        } else {
            String user2KHCN = p.getUser2Ptdbh();
            m.addAttribute("user2KHCN", user2KHCN);
        }
        if (p.getUser2PtdbhNote() == null) {
            m.addAttribute("ghichu_user2KHCN", "");
        } else {
            String ghichu_user2KHCN = p.getUser2PtdbhNote();
            m.addAttribute("ghichu_user2KHCN", ghichu_user2KHCN);
        }
        if (p.getUser2PtdbhDate() == null || p.getUser2PtdbhDate() == 0) {
            m.addAttribute("_str_user2KHCN_NgayDuyet", "");
        } else {
            long user2KHCN_NgayDuyet = p.getUser2PtdbhDate();
            String str_user2KHCN_NgayDuyet = String.valueOf(user2KHCN_NgayDuyet);
            String nam_user2KHCN_NgayDuyet = str_user2KHCN_NgayDuyet.substring(0, 4);
            String thang_user2KHCN_NgayDuyet = str_user2KHCN_NgayDuyet.substring(4, 6);
            String ngay_user2KHCN_NgayDuyet = str_user2KHCN_NgayDuyet.substring(6, 8);
            String _str_user2KHCN_NgayDuyet = ngay_user2KHCN_NgayDuyet + "/" + thang_user2KHCN_NgayDuyet + "/" + nam_user2KHCN_NgayDuyet;
            m.addAttribute("_str_user2KHCN_NgayDuyet", _str_user2KHCN_NgayDuyet);
        }
        // (1) P.KTT&NHS
        if (p.getUser1Ptnt() == null) {
            m.addAttribute("user1TNT", "");
        } else {
            String user1TNT = p.getUser1Ptnt();
            m.addAttribute("user1TNT", user1TNT);
        }
        if (p.getUser1PtntNote() == null) {
            m.addAttribute("ghichu_user1TNT", "");
        } else {
            String ghichu_user1TNT = p.getUser1PtntNote();
            m.addAttribute("ghichu_user1TNT", ghichu_user1TNT);
        }
        if (p.getUser1PtntDate() == null || p.getUser1PtntDate() == 0) {
            m.addAttribute("_str_user1TNT_NgayDuyet", "");
        } else {
            long user1TNT_NgayDuyet = p.getUser1PtntDate();
            String str_user1TNT_NgayDuyet = String.valueOf(user1TNT_NgayDuyet);
            String nam_user1TNT_NgayDuyet = str_user1TNT_NgayDuyet.substring(0, 4);
            String thang_user1TNT_NgayDuyet = str_user1TNT_NgayDuyet.substring(4, 6);
            String ngay_user1TNT_NgayDuyet = str_user1TNT_NgayDuyet.substring(6, 8);
            String _str_user1TNT_NgayDuyet = ngay_user1TNT_NgayDuyet + "/" + thang_user1TNT_NgayDuyet + "/" + nam_user1TNT_NgayDuyet;
            m.addAttribute("_str_user1TNT_NgayDuyet", _str_user1TNT_NgayDuyet);
        }
        // (2) P.KTT&NHS
        if (p.getUser2Ptnt() == null) {
            m.addAttribute("user2TNT", "");
        } else {
            String user2TNT = p.getUser2Ptnt();
            m.addAttribute("user2TNT", user2TNT);
        }
        if (p.getUser2PtntNote() == null) {
            m.addAttribute("ghichu_user2TNT", "");
        } else {
            String ghichu_user2TNT = p.getUser2PtntNote();
            m.addAttribute("ghichu_user2TNT", ghichu_user2TNT);
        }
        if (p.getUser2PtntDate() == null || p.getUser2PtntDate() == 0) {
            m.addAttribute("_str_user2TNT_NgayDuyet", "");
        } else {
            long user2TNT_NgayDuyet = p.getUser2PtntDate();
            String str_user2TNT_NgayDuyet = String.valueOf(user2TNT_NgayDuyet);
            String nam_user2TNT_NgayDuyet = str_user2TNT_NgayDuyet.substring(0, 4);
            String thang_user2TNT_NgayDuyet = str_user2TNT_NgayDuyet.substring(4, 6);
            String ngay_user2TNT_NgayDuyet = str_user2TNT_NgayDuyet.substring(6, 8);
            String _str_user2TNT_NgayDuyet = ngay_user2TNT_NgayDuyet + "/" + thang_user2TNT_NgayDuyet + "/" + nam_user2TNT_NgayDuyet;
            m.addAttribute("_str_user2TNT_NgayDuyet", _str_user2TNT_NgayDuyet);
        }
        return "quytrinhduyet";
    }
    // Lấy danh sách tất cả ĐVCNT đã lắp => CN/PGD xem

    @RequestMapping(value = "tao_user", method = RequestMethod.GET)
    public String tao_user(Model m, HttpServletRequest request) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }
        return "tao_user";
    }

    @RequestMapping(value = "_email", method = RequestMethod.GET)
    public String _email(HttpServletRequest request, Model m) {
        _session = request.getSession();

        // Check login???
        String user = (String) _session.getAttribute("hoten");
        if (user == null || user.equals("")) {
            return "redirect:login.html";
        }
        return "_email";
    }    
}
