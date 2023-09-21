package vn.edu.iuh.fit.entities;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.Date;
@Entity(name = "log")
public class Log {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long logID;

    @Id
    @ManyToOne
    @JoinColumn(name = "account_id")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Account account;
    @Column(name = "login_time")
    private Date logInTime;
    @Column(name = "logout_time")
    private Date logOutTime;
    @Column(columnDefinition = "nvarchar(255)")
    private String notes;

    public Log() {
    }

    public Log(Account account, Date logInTime, Date logOutTime, String notes) {
        this.account = account;
        this.logInTime = logInTime;
        this.logOutTime = logOutTime;
        this.notes = notes;
    }

    public long getLogID() {
        return logID;
    }

    public void setLogID(long logID) {
        this.logID = logID;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Date getLogInTime() {
        return logInTime;
    }

    public void setLogInTime(Date logInTime) {
        this.logInTime = logInTime;
    }

    public Date getLogOutTime() {
        return logOutTime;
    }

    public void setLogOutTime(Date logOutTime) {
        this.logOutTime = logOutTime;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "Log{" +
                "logID=" + logID +
                ", account=" + account +
                ", logInTime=" + logInTime +
                ", logOutTime=" + logOutTime +
                ", notes='" + notes + '\'' +
                '}';
    }
}
