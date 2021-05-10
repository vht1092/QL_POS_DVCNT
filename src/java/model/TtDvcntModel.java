package model;

import entity.*;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class TtDvcntModel {

    // SelectAll TtDvcnt: tăng dần STATUS_DVCNT
    public List<TtDvcntLive> getAll() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).addOrder(Order.asc("statusDuyet")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt: Lọc theo mã chi nhánh quản lý, xếp tăng dần STATUS_DVCNT
    public List<TtDvcntLive> getAll_TheoMaCN(String macnQuanLy) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            p.setCnQuanly(macnQuanLy);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).addOrder(Order.asc("statusDuyet")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt: Lọc theo Loại Hình Khach hàng doanh nghiệp xếp tăng dần STATUS_DVCNT
    public List<TtDvcntLive> getAll_PhongKHDN() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte loaihinhDvcnt = 2; // Khách hàng doanh nghiệp
            p.setLoaihinhDvcnt(loaihinhDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).addOrder(Order.asc("statusDuyet")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt: Lọc theo Loại Hình KHACH HANG CA NHAN xếp tăng dần STATUS_DVCNT
    public List<TtDvcntLive> getAll_PKHCN() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte loaihinhDvcnt = 1; // Khách hàng cá nhân
            p.setLoaihinhDvcnt(loaihinhDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).addOrder(Order.asc("statusDuyet")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt: giảm dần STATUS_DVCNT
    public List<TtDvcntLive> getAll_sortStatus() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).addOrder(Order.desc("statusDuyet")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
//------------------------SORT TEN_DVCNT_VN------------------------------
    // SelectAll TtDvcnt: giảm dần TEN_DVCNT_VN

    public List<TtDvcntLive> getAll_sortNameAsc() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).addOrder(Order.asc("tenDvcntVn")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt: giảm dần TEN_DVCNT_VN
    public List<TtDvcntLive> getAll_sortNameDesc() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).addOrder(Order.desc("tenDvcntVn")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
//------------------------SORT MA_DVCNT------------------------------
    // SelectAll TtDvcnt: giảm dần TEN_DVCNT_VN

    public List<TtDvcntLive> getAll_sortMaDvcntAsc() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).addOrder(Order.asc("maDvcnt")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt: giảm dần TEN_DVCNT_VN
    public List<TtDvcntLive> getAll_sortMaDvcntDesc() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).addOrder(Order.desc("maDvcnt")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
//================================================================================
    // SelectAll TtDvcnt  có STATUS_DVCNT khác 1

    public List<TtDvcntLive> getAllStatusDuyetKhac1() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        List<TtDvcntLive> lstResult = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();

        TtDvcntModel model = new TtDvcntModel();

        try {
            s.beginTransaction();
            Criteria cr = s.createCriteria(TtDvcntLive.class);

            //cr.add(Restrictions.or(Restrictions.gt("statusDvcnt", 1), Restrictions.eq("statusDvcnt", 0)));
            cr.add(Restrictions.gt("statusDvcnt", 0));

            lstResult = cr.list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        int size = lstResult.size();
        return lstResult;
    }

    // Count All DVCNT
    public long countAll() {
        long count = 0;
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).list();
            count = lst.size();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // SelectAll TtDvcnt by TINHTRANG_DVCNT = 0 => DVCNT dang xu ly thêm mới
    public List<TtDvcntLive> getListDvcntDangXuLyThemMoi() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 0;
            p.setStatusDvcnt(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).addOrder(Order.asc("statusDuyet")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt by TINHTRANG_DVCNT = 2 => DVCNT dang xu ly CHỈNH SỬA KHÔNG CẦN P.KTT&NHS DUYỆT
    public List<TtDvcntLive> getListDvcntDangChinhSua1() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 2;
            p.setStatusDvcnt(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt by setStatusDuyet  = 9 //  P.KTT&NHS da nhan
    public List<TtDvcntLive> getListDvcntDeXuatPhieuYeuCau() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 9;
            p.setStatusDuyet(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt by TINHTRANG_DVCNT = 3 => DVCNT dang xu ly CHỈNH SỬA  CẦN P.KTT&NHS DUYỆT
    public List<TtDvcntLive> getListDvcntDangChinhSua2() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 3;
            p.setStatusDvcnt(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt by TINHTRANG_DVCNT = 4 => TAM KHOA DVCNT
    public List<TtDvcntLive> getListDvcntTamKhoa() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 4;
            p.setStatusDvcnt(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt by TINHTRANG_DVCNT = 5 => ĐÓNG DVCNT
    public List<TtDvcntLive> getListDvcntDong() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 5;
            p.setStatusDvcnt(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // SelectAll TtDvcnt by TINHTRANG_DVCNT = 8 => DVCNT YEU CAU LAP THEM POS
    public List<TtDvcntLive> getListDvcntLapThemPos() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 8;
            p.setStatusDvcnt(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy Danh sách hồ sơ xử lý theo MA_DVCNT
    public List<TtDvcntLive> getListDsDvctDaLap_byMaDvcnt(String maDvcnt) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        List<TtDvcntLive> lstResult = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();

        s.beginTransaction();
        Criteria cr = s.createCriteria(TtDvcntLive.class);

        cr.add(Restrictions.eq("maDvcnt", maDvcnt));

        lstResult = cr.list();
        s.getTransaction().commit();

        return lstResult;
    }

    // Lấy DS ĐVCNT đang xử lý theo số GPĐKKD
    public List<TtDvcntLive> getListBySoGpkd(String soDKKD) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 0;
            p.setGpdkkdso(soDKKD);
            //p.setStatusDvcnt(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
    
     // Lấy DS ĐVCNT đang xử lý theo số GPĐKKD => Check ko cho nhap trung DVCNT
    public List<TtDvcntLive> getListBySoGpkd2(String soDKKD) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 0;
            p.setGpdkkdso(soDKKD);
            //p.setStatusDvcnt(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy DS ĐVCNT đã lắp theo số GPDKKD
    public List<TtDvcntLive> getListDsDvctDaLap_bySoGPDKKD(String soDKKD) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        List<TtDvcntLive> lstResult = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();

        s.beginTransaction();
        Criteria cr = s.createCriteria(TtDvcntLive.class);

        cr.add(Restrictions.eq("gpdkkdso", soDKKD));

        lstResult = cr.list();
        s.getTransaction().commit();

        return lstResult;
    }

    // Lấy DS ĐVCNT đã lắp theo Chi nhánh quản lý
    public List<TtDvcntLive> getListDsDvctDaLap_byCNQuanLy(String cnQuanly) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        List<TtDvcntLive> lstResult = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();

        s.beginTransaction();
        Criteria cr = s.createCriteria(TtDvcntLive.class);

        cr.add(Restrictions.eq("cnQuanly", cnQuanly));

        lstResult = cr.list();
        s.getTransaction().commit();

        return lstResult;
    }

    // Lấy DS ĐVCNT đã lắp: Lấy ds DOANH NGHIEP
    public List<TtDvcntLive> getListDsDvctDaLap_loaihinhDvcnt(Byte loaihinhDvcnt) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        List<TtDvcntLive> lstResult = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();

        s.beginTransaction();
        Criteria cr = s.createCriteria(TtDvcntLive.class);

        cr.add(Restrictions.eq("loaihinhDvcnt", loaihinhDvcnt));

        lstResult = cr.list();
        s.getTransaction().commit();

        return lstResult;
    }

    // Lấy DS ĐVCNT đang xử lý theo CN Quản lý.
    public List<TtDvcntLive> getListByCNQuanLy(String cnQuanly) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            p.setCnQuanly(cnQuanly);
            Byte status = 0;
            p.setStatusDvcnt(status);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy DS ĐVCNT là DOANH NGHIỆP
    public List<TtDvcntLive> getListDoanhNghiep() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte loaiHinhDvcnt = 2;
            p.setLoaihinhDvcnt(loaiHinhDvcnt);
            Byte status = 0;
            p.setStatusDvcnt(status);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy DS ĐVCNT là HỘ KINH DOANH
    public List<TtDvcntLive> getListHoKinhDoanh() {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte loaiHinhDvcnt = 1;
            p.setLoaihinhDvcnt(loaiHinhDvcnt);
            Byte status = 0;
            p.setStatusDvcnt(status);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    // Lấy DS ĐVCNT THEO TÊN ĐVCNT
    public List<TtDvcntLive> getListTheoTenDvcnt(String tenDvcntVn) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        List<TtDvcntLive> lstResult = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();

        s.beginTransaction();
        Criteria cr = s.createCriteria(TtDvcntLive.class);

        String str = "%" + tenDvcntVn + "%";
        cr.add(Restrictions.like("tenDvcntVn", str));

        lstResult = cr.list();
        s.getTransaction().commit();

        return lstResult;
    }

    // Trả về số lượng ĐVCNT đang xử lý
    public long countDVCNTDangXuLy() {
        long size = 0;
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            Byte tinhtrangDvcnt = 0;
            p.setStatusDvcnt(tinhtrangDvcnt);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            size = lst.size();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return size;
    }

    // Create TtDDvcnt
    public void create(TtDvcntLive p) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            s.save(p);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
    }

    // Remove TtDDvcnt
    public void remove(TtDvcntLive p) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            s.delete(p);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
    }

    // Update TtDDvcnt
    public void update(TtDvcntLive p) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            s.update(p);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Loi update DVCNT: " + e.toString());
            s.getTransaction().rollback();
        }
    }

    // Get a TtDDvcnt
    public TtDvcntLive getTtDvcnt(String id) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        TtDvcntLive p = new TtDvcntLive();
        try {
            s.beginTransaction();
            p = (TtDvcntLive) s.get(TtDvcntLive.class, id);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
        return p;
    }

    // Get LIST ĐVCNT by CHI NHANH QUẢN LÝ
    public List<TtDvcntLive> getListDvcntTheoChiNhanhQuanLy(String ChiNhanhQuanLy) {
        List<TtDvcntLive> lst = new ArrayList<TtDvcntLive>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            TtDvcntLive p = new TtDvcntLive();
            p.setCnQuanly(ChiNhanhQuanLy);
            s.beginTransaction();
            lst = s.createCriteria(TtDvcntLive.class).add(Example.create(p)).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
}
