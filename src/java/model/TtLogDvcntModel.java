package model;

import entity.TtLogDvcnt;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class TtLogDvcntModel {

    public void create(TtLogDvcnt p) {
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

    public TtLogDvcnt getTtPosTemp(long logId) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        TtLogDvcnt p = new TtLogDvcnt();
        try {
            s.beginTransaction();
            p = (TtLogDvcnt) s.get(TtLogDvcnt.class, logId);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
        return p;
    }

//    public List<TtLogDvcnt> getAll_TheoMaDvcnt(String mid) {
//        List<TtLogDvcnt> lst = new ArrayList<TtLogDvcnt>();
//        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
//        try {
//            TtLogDvcnt p = new TtLogDvcnt();
//            p.setLogMid(mid);
//            s.beginTransaction();
//            lst = s.createCriteria(TtLogDvcnt.class).add(Example.create(p)).addOrder(Order.asc("logTime")).list();
//            s.getTransaction().commit();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return lst;
//    }
    public List<TtLogDvcnt> getAll_TheoMaDvcnt(String mid) {
        List<TtLogDvcnt> lstResult = new ArrayList<TtLogDvcnt>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        s.beginTransaction();
        Criteria cr = s.createCriteria(TtLogDvcnt.class);
        cr.add(Restrictions.eq("logMid", mid)).addOrder(Order.asc("logTime"));

        lstResult = cr.list();
        s.getTransaction().commit();
        return lstResult;
    }
}
