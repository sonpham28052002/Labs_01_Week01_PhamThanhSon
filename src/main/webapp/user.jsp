<%@ page import="vn.edu.iuh.fit.entities.Log" %>
<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body{
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container{
            width: 500px;
            border: 1px solid black;
            border-radius: 10px;
        }
        .container *{
            margin-left: 40px;
        }
        .h1{
            font-size: 25px;
            font-weight: bold;
        }
        .h2{
            font-size: 20px;
            font-weight: bold;
        }
        .submit{
            height: 30px;
            width: 80px;
            background-color: blue;
            border: 2px solid blue;
            border-radius: 5px;
            margin-right: 30px;
            color: #fff;
        }
    </style>
</head>
<body>
<%
     Account account= (Account) request.getSession().getAttribute("user");
     List<Role> roleList = (List<Role>) request.getAttribute("list_gant");
%>
<div class="container">
    <h1 style="text-align: center;">Người Dùng</h1>
    <span class="h1">Họ Tên:</span>
    <span class="h2"><%=account.getFullName()%></span>
    <br>
    <span class="h1">Email:</span>
    <span class="h2"><%=account.getEmail()%></span>
    <br>
    <span class="h1">SĐT:</span>
    <span class="h2"><%=account.getPhone()%></span>
    <br>
    <span class="h1">Quyền:</span>
    <ul>
        <%for (Role role:roleList) {%>
                <li><%=role.getRoleName()%></li>
            <%}%>
    </ul>
    <br>
    <div style="margin-left: 0; margin-bottom: 10px;display: flex; justify-content: center; align-items: center;">
        <form action="controller" method="post">
            <input type="submit" class="submit" name="logout" value="logout">
        </form>

    </div>
</div>

</body>
</html>