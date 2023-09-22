package vn.edu.iuh.fit.controllers;


import jakarta.persistence.EntityTransaction;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.iuh.fit.conectionDB.ConecttionDB;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.GantAccess;
import vn.edu.iuh.fit.entities.Log;
import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.reponsitory.AccountReponsitory;
import vn.edu.iuh.fit.reponsitory.LogReponsitory;
import vn.edu.iuh.fit.reponsitory.RoleReponsitory;

import java.io.IOException;
import java.util.Date;

@WebServlet(urlPatterns = {"/controller", "/control"})
public class ControllerServlet extends HttpServlet {
    private final AccountReponsitory accountReponsitory = new AccountReponsitory();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String check = req.getParameter("submit");
        String logout = req.getParameter("logout");
        String add = req.getParameter("add");
        String delete = req.getParameter("delete");
        String addTV = req.getParameter("addTV");
        String edit = req.getParameter("EditTV");
        String deleteRoleUser = req.getParameter("deleteRoleUser");
        String btn_addRole = req.getParameter("btn_addRole");


        if (check != null) {
            handleLogin(req, resp);
        } else if (logout != null) {
            handleLogout(req, resp);
        } else if (add != null) {
            handleAddQuyen(req, resp, add);
        } else if (delete != null) {
            handleDelete(req, resp, delete);

        } else if (addTV != null) {
            handleAddAccount(req, resp, addTV);
        } else if (edit != null) {
            handleEditInfo(req, resp, edit);
        } else if (deleteRoleUser != null) {
            handleDeleteRoleUser(req, resp, deleteRoleUser);
        } else if (btn_addRole != null) {
            handleAddRoleNew(req, resp, btn_addRole);
        }
    }

    public void handleAddRoleNew(HttpServletRequest req, HttpServletResponse resp, String btn_addRole) throws ServletException, IOException {
        String NOTI = "";
        Role role = new Role(createRoleId(), btn_addRole.split(",")[0], btn_addRole.split(",")[1], Boolean.parseBoolean(btn_addRole.split(",")[2]));
        if (new RoleReponsitory().insertRole(role)) {
            NOTI = "Thêm Quyền Thành công";
        } else {
            NOTI = "Thêm Quyền Thất Bại!";
        }
        req.setAttribute("thongbao", NOTI);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin2.jsp");
        dispatcher.forward(req, resp);
    }

    public void handleDeleteRoleUser(HttpServletRequest req, HttpServletResponse resp, String deleteRoleUser) throws ServletException, IOException {
        String NOTI = "";
        String userId = deleteRoleUser.split(",")[deleteRoleUser.split(",").length - 1];
        RoleReponsitory roleReponsitory = new RoleReponsitory();
        for (int i = 0; i < deleteRoleUser.split(",").length - 1; i++) {
            if (!roleReponsitory.deleteGrantAccess(roleReponsitory.getOneGrantAccess(deleteRoleUser.split(",")[i], userId))) {
                NOTI += roleReponsitory.getOne(deleteRoleUser.split(",")[i]).getRoleName() + " \n";
            }
        }
        if (NOTI.equals("")) {
            NOTI = "Xoá quyền thành công";
        } else {
            NOTI += "=> Xoá Không Thành Công";
        }
        req.setAttribute("thongbao", NOTI);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin2.jsp");
        dispatcher.forward(req, resp);
    }

    public void handleEditInfo(HttpServletRequest req, HttpServletResponse resp, String edit) throws ServletException, IOException {
        String NOTI = "";
        String id = edit.split(",")[0];
        String name = edit.split(",")[1];
        String email = edit.split(",")[2];
        String sdt = edit.split(",")[3];
        String pass = edit.split(",")[4];
        boolean isStatus = Boolean.parseBoolean(edit.split(",")[5]);
        Account account = new Account(id, name, pass, email, sdt, isStatus);
        if (accountReponsitory.updateAccount(account)) {
            NOTI = "Cập Nhật Thông Tin Thành Công";
        } else {
            NOTI = "Cập Nhật Thông Tin Thất Bại!";
        }
        req.setAttribute("thongbao", NOTI);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin2.jsp");
        dispatcher.forward(req, resp);
    }

    public String createAccountID() {
        String id = accountReponsitory.getAccountFinal();
        int num = Integer.parseInt(id.substring(4));
        num++;
        return "user" + num;
    }

    public boolean checkAdmin(Account account) {
        RoleReponsitory roleReponsitory = new RoleReponsitory();
        for (Role role : roleReponsitory.getRole(account.getAccountId())) {
            if (role.getRoleName().equalsIgnoreCase("admin")) {
                return true;
            }
        }
        return false;
    }

    public void handleDelete(HttpServletRequest req, HttpServletResponse resp, String delete) throws ServletException, IOException {
        String NOTI = "";
        Account account = accountReponsitory.getAll().get(Integer.parseInt(delete) - 1);
        if (accountReponsitory.deleteAccount(account)) {
            NOTI = "Đã Xoá Thành Công";
        } else {
            NOTI = "Xoá Thành Viên Thất Bại!";
        }
        req.setAttribute("thongbao", NOTI);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin2.jsp");
        dispatcher.forward(req, resp);
    }

    public void handleAddAccount(HttpServletRequest req, HttpServletResponse resp, String addTV) throws ServletException, IOException {

        String[] addTVArr = addTV.split(",");
        String nameAdd = addTVArr[0];
        String emailAdd = addTVArr[1];
        String sdtAdd = addTVArr[2];
        Account account = new Account(createAccountID(), nameAdd, "4444", emailAdd, sdtAdd, true);
        String NOTI = "";
        if (nameAdd.isEmpty() || emailAdd.isEmpty() || sdtAdd.isEmpty()) {
            NOTI = "Thông Tin không Được Bỏ Trống!";
        } else {
            if (accountReponsitory.insertAccount(account)) {
                NOTI = "Thêm Thành Viên Mới Thành Công.";
            } else {
                NOTI = "Thêm Thành Viên Mới Thất Bại.";
            }
        }
        req.setAttribute("thongbao", NOTI);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin2.jsp");
        dispatcher.forward(req, resp);
    }

    public void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Log log = (Log) req.getSession().getAttribute("log");

        log.setLogOutTime(new Date());
        LogReponsitory logReponsitory = new LogReponsitory();
        logReponsitory.readLog(log);
        req.getSession().removeAttribute("log");
        req.getSession().removeAttribute("user");
        req.removeAttribute("list_gant");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
        dispatcher.forward(req, resp);
    }

    public void handleAddQuyen(HttpServletRequest req, HttpServletResponse resp, String add) throws ServletException, IOException {
        String NOTI = "";
        RoleReponsitory roleReponsitory = new RoleReponsitory();
        String userID = add.split(",")[0];
        String roleID = add.split(",")[1];
        String note = add.split(",")[2];
        Role role = roleReponsitory.getOne(roleID);
        Account account = accountReponsitory.getOne(userID);
        if (accountReponsitory.addGantAccess(new GantAccess(role, account, true, note))) {
            NOTI = "Cấp Quyền Thành Công.";
        } else {
            NOTI = "Cấp quyền Không Thành Công!";
        }
        req.setAttribute("thongbao", NOTI);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin2.jsp");
        dispatcher.forward(req, resp);
    }

    public void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        if (email != null && password != null) {
            Account user01 = accountReponsitory.getAccountByEmailAndPassword(email, password);
            if (user01 != null) {
                Log log = new Log(user01, new Date(), null, user01.getFullName());
                HttpSession session = req.getSession();
                session.setAttribute("log", log);
                session.setAttribute("user", user01);
                RoleReponsitory roleReponsitory = new RoleReponsitory();
                req.setAttribute("list_gant", roleReponsitory.getRole(user01.getAccountId()));

                if (!checkAdmin(user01)) {
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user.jsp");
                    dispatcher.forward(req, resp);
                } else {
                    req.setAttribute("thongbao", null);
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin2.jsp");
                    dispatcher.forward(req, resp);
                }
            } else {
                req.setAttribute("noti", "Tài khoản mật khẩu không chính xác!");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
                dispatcher.forward(req, resp);
            }
        } else {
            req.setAttribute("noti", "Tài khoản mật khẩu không bỏ trống");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            dispatcher.forward(req, resp);
        }
    }

    public String createRoleId() {
        RoleReponsitory roleReponsitory = new RoleReponsitory();
        String id = roleReponsitory.getRoleLast();
        int num = Integer.parseInt(id.substring(4));
        num++;
        return "role" + num;
    }
}
