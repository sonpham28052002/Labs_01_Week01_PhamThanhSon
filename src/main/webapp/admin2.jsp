<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="vn.edu.iuh.fit.reponsitory.AccountReponsitory" %>
<%@ page import="vn.edu.iuh.fit.reponsitory.RoleReponsitory" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .containers {
            margin-top: 10px;
            width: 700px;
            border-radius: 10px;
            border: 1px solid black;
        }

        .submit {
            height: 30px;
            width: 100px;
            background-color: blue;
            border: 2px solid blue;
            border-radius: 5px;
            margin-right: 30px;
            color: #fff;
        }

        .center {
            display: flex;
            justify-items: center;
            align-items: center;
        }

        li {
            font-weight: bold;
        }
    </style>
    <link
            rel="stylesheet"
            href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script>


        function getValueAddTV() {
            var arr = []
            arr.push(document.getElementById("name_Add").value)
            arr.push(document.getElementById("email_Add").value)
            arr.push(document.getElementById("sdt_Add").value)
            console.log(arr)
            alert(arr)
            document.getElementById("AddTVNew").value = arr;

        }


        function handleClick(value, acc) {
            let option = ""
            for (let x of value) {
                if (x.roleName !== "admin") {
                    option += "<option value='" + x.roleId + "'>" + x.roleName + "</option>"
                }
            }
            document.getElementById("selectRole").innerHTML = option;
            document.getElementById("userRole").value = acc;
        }

        function getValuRole() {
            var arr = []
            arr.push(document.getElementById("userRole").value)
            arr.push(document.getElementById("selectRole").value)
            arr.push(document.getElementById("note").value + "")

            document.getElementById("add").value = arr;
        }

        function setValueFormEdit(acc) {

            console.log(acc)
            console.log(typeof acc)
            document.getElementById("id_edit").value = acc.accountId;
            document.getElementById("name_Edit").value = acc.fullName;
            document.getElementById("email_Edit").value = acc.email;
            document.getElementById("pass_Edit").value = acc.password;
            document.getElementById("sdt_Edit").value = acc.phone;
            document.getElementById("is_Status").checked = acc.status
        }

        function getValueEditTV() {
            var arr = []
            arr.push(document.getElementById("id_edit").value)
            arr.push(document.getElementById("name_Edit").value)
            arr.push(document.getElementById("email_Edit").value)
            arr.push(document.getElementById("pass_Edit").value)
            arr.push(document.getElementById("sdt_Edit").value)
            arr.push(document.getElementById("is_Status").checked)

            console.log(arr)
            alert(arr)
            document.getElementById("EditTVNew").value = arr;

        }

        function setValueFormEditRoleUser(role, id) {
            console.log(role)
            console.log(id)
            var arr = ""
            for (let x of role) {
                if (x.roleName !== "admin") {
                    arr += "<input type='checkbox' class='form-check-input role' value='" + x.roleId + "'>" +
                        "<label class='form-check-label mx-3' for='is_Status' >" + x.roleName + "</label><br>"
                }
            }
            document.getElementById("formEditRole").innerHTML = arr;
        }

        function getValueDeleteRole() {
            var option = []
            for (let x of document.getElementsByClassName("role")) {
                console.log(x.checked)
                if (x.checked) {
                    option.push(x.value)
                }
            }
            option.push(document.querySelector(".delete").id)
            document.getElementById("deleteRoleUser").value = option
        }

        function getValueAddRole() {
            var arr = []
            arr.push(document.getElementById("name_addRole").value)
            arr.push(document.getElementById("description_addRole").value)
            arr.push(document.getElementById("is_Status_addRole").checked)
            document.getElementById("btn_addRole").value = arr
        }

    </script>
</head>
<body>
<%
    Account account1 = (Account) request.getSession().getAttribute("user");
    List<Role> roleList1 = (List<Role>) request.getAttribute("list_gant");
    AccountReponsitory accountReponsitory = new AccountReponsitory();
    List<Account> accountList = accountReponsitory.getAll();
    String thongbao = request.getAttribute("thongbao") + "";
    boolean check = thongbao.equals("Thêm Thành Viên Mới Thành Công.") || thongbao.equals("Đã Xoá Thành Công") || thongbao.equals("Cấp Quyền Thành Công.") || thongbao.equals("Thêm Quyền Thành công") || thongbao.equals("Cập Nhật Thông Tin Thành Công") || thongbao.equals("Xoá quyền thành công");
%>

<div class="containers" style="align-items: center;">
    <div class="containers" style="justify-content: center;align-items: center;margin-top: 0">
        <h1 style="text-align: center;">Thông Tin Người Dùng</h1>
        <div style="margin-left: 20px">
            <p>
                <span style="font-weight: bold">Họ Tên:</span>
                <span><%=account1.getFullName()%></span>
            </p>
            <p>
                <span style="font-weight: bold">Email:</span>
                <span><%=account1.getEmail()%></span>
            </p>
            <p>
                <span style="font-weight: bold">SĐT:</span>
                <span><%=account1.getPhone()%></span>
            </p>
            <p>
                <span>Quyền:</span>
                <ul>
                    <%for (Role role : roleList1) {%>
                    <li><%=role.getRoleName()%></li>
                    <%}%>
                </ul>
            </p>

        </div>
    </div>
    <h2 style="text-align: center; font-weight: bold;">
        Danh sách thành viên
    </h2>
    <div class="center" style="width: 100%; height: 50px; justify-content: center;flex-direction: row;">
        <button class="submit" style=" width: 200px;" data-toggle="modal" data-target="#AddTV">Thêm Thành Viên mới
        </button>
        <form action="controller" method="post">
            <input type="submit" name="logout" class="submit" style=" width: 200px; text-align: center;"
                   value="Đăng xuất"/>
        </form>
        <button class="submit" style=" width: 200px; margin-right:0" data-toggle="modal" data-target="#addRole">Thêm
            Quền mới
        </button>
    </div>
    <div style="display: flex; flex-direction: row; justify-content: center;">
        <%if (!thongbao.equals("null")) {%>
        <p style="font-size: 20px; font-weight: bold; color: <%if (check){%>rgb(82, 186, 82)<%}else{%>rgb(255, 0, 0)<%}%>;"><%=thongbao%>
        </p>
        <%}%>
    </div>
    <div>
        <%
            int index = 0;
            for (Account account : accountList) {
                if (new RoleReponsitory().checkAdmin(account.getAccountId())) {
                    continue;
                }
        %>
        <div class="center" style="margin: 10px; border-radius:10px;height: 100%; border: 2px solid black;">
            <div class="stt" style="float: left;height: 100%; width: 5%;">
                <h3 style="text-align: center;"><%=index++%>
                </h3>
            </div>
            <div style="float:left;width: 75%;border-right: 2px solid black;border-left: 2px solid black;">
                <div class="info">
                    <span style="font-weight: bold; font-size: 15px;">Tên: </span>
                    <span><%=account.getFullName()%></span>
                    <span style="font-weight: bold; font-size: 15px;">Email: </span>
                    <span><%=account.getEmail()%></span>
                </div>
                <div>
                    <span style="font-weight: bold; font-size: 15px;">Quyền hạn:</span>
                    <ul>
                        <%
                            List<Role> roleList = new RoleReponsitory().getRole(account.getAccountId());
                            for (Role role : roleList) { %>
                        <li><%=role.getRoleName()%>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
            <div style="float: right;width: 20%; ">
                <form action="controller" method="post" style="margin-left: 20px;">
                    <input type="button" data-target="#PhanQuyen" name="PhanQuyen" value="Thêm Quyền"
                           data-toggle="modal" class="submit" style="margin-top: 10px;"
                           id="<%=account.getAccountId()%>"
                           onclick="handleClick(<%=new RoleReponsitory().getRoleNoBelongAccount(account.getAccountId())%>,id)">
                    <button type="button" data-target="#EditTV"
                            data-toggle="modal" class="submit " style="margin-top: 10px;"
                            onclick="setValueFormEdit(<%=account+""%>)">Sửa
                    </button>
                    <button value="<%=index%>" type="submit" class="submit" name="delete"
                            style="margin-top: 10px;margin-bottom: 10px;background-color: red;border-color: red">Xoá
                    </button>
                    <button type="button" data-target="#EditRole"
                            id="<%=account.getAccountId()%>"
                            data-toggle="modal" class="submit delete" style="margin-bottom: 10px;"
                            onclick="setValueFormEditRoleUser(<%=new RoleReponsitory().getRoleofAccount(account.getAccountId())%>,id)">
                        Sửa Quyền
                    </button>
                </form>
            </div>
        </div>
        <%}%>

    </div>
    <div class="modal fade" id="PhanQuyen" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Phân Quyền</h4>
                </div>
                <div class="modal-body">
                    <form action="controller" method="post">
                        <input type="hidden" id="userRole">
                        <label for="selectRole">Quyền:</label>
                        <select id="selectRole" name="selectRole" class="form-control">

                        </select>
                        <label for="note">Notes:</label>
                        <input type="text" name="note" class="form-control" id="note">
                    </form>
                </div>
                <div class="modal-footer">
                    <form action="controller" method="post">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="add" name="add" value="son" class="btn btn-default"
                                onclick="getValuRole()">Lưu
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="AddTV" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Thêm Thành Viên Mới</h4>
                </div>
                <div class="modal-body">
                    <form action="controller" method="post">
                        <label for="name_Add">Họ Tên:</label>
                        <input type="text" name="name_Add" class="form-control" id="name_Add">
                        <label for="email_Add">Email:</label>
                        <input type="text" name="email_Add" class="form-control" id="email_Add">
                        <label for="sdt_Add">SĐT:</label>
                        <input type="text" name="sdt_Add" class="form-control" id="sdt_Add">
                    </form>
                </div>
                <div class="modal-footer">
                    <form action="controller" method="post">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="AddTVNew" value="" name="addTV" onclick="getValueAddTV()"
                                class="btn btn-default">Lưu
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="EditTV" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Sửa Thông Tin Thành Viên</h4>
                </div>
                <div class="modal-body">
                    <form action="controller" method="post">
                        <input type="hidden" id="id_edit">
                        <label for="name_Edit">Họ Tên:</label>
                        <input type="text" name="name_Edit" class="form-control" id="name_Edit">
                        <label for="email_Edit">Email:</label>
                        <input type="text" name="email_Edit" class="form-control" id="email_Edit">
                        <label for="sdt_Edit">SĐT:</label>
                        <input type="text" name="sdt_Edit" class="form-control" id="sdt_Edit">
                        <label for="pass_Edit">Password:</label>
                        <input type="text" name="pass_Edit" class="form-control" id="pass_Edit">
                        <label class="form-check-label" for="is_Status">Status:</label>
                        <input type="checkbox" class="form-check-input" id="is_Status">
                    </form>
                </div>
                <div class="modal-footer">
                    <form action="controller" method="post">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="EditTVNew" value="" name="EditTV" onclick="getValueEditTV()"
                                class="btn btn-default">Lưu
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="EditRole" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Sửa Quyền của Thành Viên</h4>
                </div>
                <div class="modal-body">
                    <form action="controller" method="post" id="formEditRole">

                    </form>
                </div>
                <div class="modal-footer">
                    <form action="controller" method="post">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="deleteRoleUser" value="" name="deleteRoleUser"
                                onclick="getValueDeleteRole()"
                                class="btn btn-default">Xoá Quyền
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addRole" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Sửa Thông Tin Thành Viên</h4>
                </div>
                <div class="modal-body">
                    <form action="controller" method="post">
                        <input type="hidden" id="id_addRole">
                        <label for="name_addRole">Tên: </label>
                        <input type="text" name="name_Edit" class="form-control" id="name_addRole">
                        <label for="description_addRole">Description:</label>
                        <input type="text" name="email_Edit" class="form-control" id="description_addRole">
                        <label class="form-check-label" for="is_Status">Status:</label>
                        <input type="checkbox" class="form-check-input" id="is_Status_addRole">
                    </form>
                </div>
                <div class="modal-footer">
                    <form action="controller" method="post">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" id="btn_addRole" value="" name="btn_addRole" onclick="getValueAddRole()"
                                class="btn btn-default">Thêm Role
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
