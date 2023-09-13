package vn.edu.iuh.fit.reponsitory;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Lob;
import vn.edu.iuh.fit.conectionDB.ConecttionDB;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.Log;

import java.util.Date;

public class LogReponsitory {
    private EntityManager entityManager;

    public LogReponsitory() {
        entityManager = ConecttionDB.getConecttionDB().getManagerFactory().createEntityManager();
    }

    public boolean readLog(Log log ){
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try {

            entityManager.persist(log);
            transaction.commit();
            return true;
        }catch (Exception ex){
            ex.printStackTrace();
            transaction.rollback();
        }
        return false;
    }

}
