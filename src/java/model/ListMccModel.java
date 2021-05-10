package model;

import entity.ListMcc;
import entity.UserAcc;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Order;

public class ListMccModel {

    public void create(ListMcc p) {
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

    public List<ListMcc> getAll() {
        List<ListMcc> lst = new ArrayList<ListMcc>();
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            s.beginTransaction();
            lst = s.createCriteria(ListMcc.class).addOrder(Order.asc("mccCode")).list();
            s.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Fail get all MCC_LIST: " + e.toString());
        }
        return lst;
    }
}
