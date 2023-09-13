package vn.edu.iuh.fit.controllers;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.GantAccess;
import vn.edu.iuh.fit.entities.Log;
import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.reponsitory.AccountReponsitory;
import vn.edu.iuh.fit.reponsitory.LogReponsitory;
import vn.edu.iuh.fit.reponsitory.RoleReponsitory;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet( urlPatterns = {"/controller","/control"})
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String check = req.getParameter("submit");
        String logout =req.getParameter("logout");
        String add = req.getParameter("add");
        String email = req.getParameter("email")+"";
        String password = req.getParameter("password")+"";
        AccountReponsitory accountReponsitory = new AccountReponsitory();
        if (check!=null){
            if (!email.equalsIgnoreCase("") && !password.equalsIgnoreCase("")){
                Account user01 = accountReponsitory.getAccountByEmailAndPassword(email,password);
                System.out.println(user01);
                if (user01 != null){
                    Log log = new Log(user01,new Date(),null,user01.getFullName());
                    HttpSession session = req.getSession();
                    session.setAttribute("log",log);
                    session.setAttribute("user",user01);

                    if (!checkAdmin(user01)){
                        RoleReponsitory roleReponsitory = new RoleReponsitory();
                        req.setAttribute("list_gant",roleReponsitory.getRole(user01.getAccountId()));
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user.jsp");
                        dispatcher.forward(req,resp);
                    }else {

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
                        dispatcher.forward(req,resp);
                    }
                }else {
                    req.setAttribute("noti","Tài khoản mật khẩu không chính xác!");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
                    dispatcher.forward(req,resp);
                }
            }else {
                req.setAttribute("noti","Tài khoản mật khẩu không bỏ trống");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
                dispatcher.forward(req,resp);
            }
        } else if (logout!=null) {
            Log log = (Log) req.getSession().getAttribute("log");
            
            log.setLogOutTime(new Date());
            LogReponsitory logReponsitory = new LogReponsitory();
            logReponsitory.readLog(log);
            req.getSession().removeAttribute("log");
            req.getSession().removeAttribute("user");
            req.removeAttribute("list_gant");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            dispatcher.forward(req,resp);

        } else if (add !=null) {
            String role = req.getParameter("role");
            String user = req.getParameter("user");
            String notes = req.getParameter("note");

            Account account = accountReponsitory.getOne(user);
            System.out.println(account);
            Role role1 = new RoleReponsitory().getOne(role);
            System.out.println(role1);

            GantAccess gantAccess = new GantAccess(role1,account,true,notes);

            if (accountReponsitory.addGantAccess(gantAccess)) {
                req.setAttribute("notifi", "Thêm Thành Công");
            } else {
                req.setAttribute("notifi", "Thêm Thất Bại");
            }
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
            dispatcher.forward(req,resp);

        }
    }
    public boolean checkAdmin(Account account){
        RoleReponsitory roleReponsitory = new RoleReponsitory();
        for (Role role: roleReponsitory.getRole(account.getAccountId())) {
            if (role.getRoleName().equalsIgnoreCase("admin")) {
                System.out.println(role.getRoleName());
                return true;
            }
        }
        return false;
    }
}
