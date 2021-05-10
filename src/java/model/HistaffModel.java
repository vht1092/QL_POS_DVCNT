package model;

import entity.TtHistaff;
import entity.TtPosLive;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;

public class HistaffModel {

    // SelectAll TtPos
    public List<TtHistaff> getAll() {
        List<TtHistaff> lst = new ArrayList<TtHistaff>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(TtHistaff.class).addOrder(Order.desc("empCode")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    public TtHistaff getTtHistaff(String id) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        TtHistaff p = new TtHistaff();
        try {
            s.beginTransaction();
            p = (TtHistaff) s.get(TtHistaff.class, id);
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            s.getTransaction().rollback();
        }
        return p;
    }
}
