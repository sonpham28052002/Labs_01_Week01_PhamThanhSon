package vn.edu.iuh.fit.conectionDB;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class ConecttionDB {
    private static ConecttionDB conecttionDB;
    private EntityManagerFactory managerFactory;

    public ConecttionDB() {
        managerFactory = Persistence.createEntityManagerFactory("default");
    }
    public static ConecttionDB getConecttionDB(){
        if (conecttionDB == null){
            conecttionDB = new ConecttionDB();
        }
        return conecttionDB;
    }

    public EntityManagerFactory getManagerFactory() {
        return managerFactory;
    }
}
