<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
            crossorigin="anonymous">
    <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
            crossorigin="anonymous"></script>
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
            integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
            crossorigin="anonymous"></script>
</head>
<body style="display: flex;align-items: center;justify-content: center; margin-top: 100px">
<%
    String noti = request.getAttribute("noti")+"";
%>
<div class="container" style="width: 700px">

    <form action="controller" method="post">
        <h1>Sign In</h1>
        <div class="form-group w-50 " >
            <label for="exampleInputEmail1">Email address</label>
            <input value="sonpham28052002@gmail.com" type="email" class="form-control" name="email" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
        </div>
        <div class="form-group w-50">
            <label for="exampleInputPassword1" >Password</label>
            <input value="sonpham123" type="password" class="form-control" id="exampleInputPassword1" name="password" placeholder="Password">
        </div>

            <%
                if (!noti.equals("null")){
            %>
            <div> <%=noti%></div>
            <%}%>

        <button type="submit" class="mt-2 btn btn-primary" name="submit" value="form02">Submit</button>
    </form>
</div>
</body>
</html>