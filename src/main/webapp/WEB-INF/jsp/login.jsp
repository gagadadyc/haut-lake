<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>HAUTCMS管理系统登录</title>
    <link rel="stylesheet" type="text/css" href="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

    <STYLE type=text/css>
        BODY {
            TEXT-ALIGN: center;
            PADDING-BOTTOM: 0px;
            BACKGROUND-COLOR: #ddeef2;
            MARGIN: 0px;
            PADDING-LEFT: 0px;
            PADDING-RIGHT: 0px;
            PADDING-TOP: 0px
        }

        A:link {
            COLOR: #000000;
            TEXT-DECORATION: none
        }

        A:visited {
            COLOR: #000000;
            TEXT-DECORATION: none
        }

        A:hover {
            COLOR: #ff0000;
            TEXT-DECORATION: underline
        }

        A:active {
            TEXT-DECORATION: none
        }

        .input {
            BORDER-BOTTOM: #ccc 1px solid;
            BORDER-LEFT: #ccc 1px solid;
            LINE-HEIGHT: 20px;
            WIDTH: 182px;
            HEIGHT: 20px;
            BORDER-TOP: #ccc 1px solid;
            BORDER-RIGHT: #ccc 1px solid
        }

        .input1 {
            BORDER-BOTTOM: #ccc 1px solid;
            BORDER-LEFT: #ccc 1px solid;
            LINE-HEIGHT: 20px;
            WIDTH: 120px;
            HEIGHT: 20px;
            BORDER-TOP: #ccc 1px solid;
            BORDER-RIGHT: #ccc 1px solid;
        }
    </STYLE>
    <script type="text/javascript">
        function login(){
            //相当于document.getElementById("username").value;
            var username=$("#username").val();
            var password=$("#password").val();
            var imageCode=$("#imageCode").val();

            if(username==null||username==""){
                alert("用户名不能为空！");
                return;
            }
            if(password==null||password==""){
                alert("密码不能为空！");
                return;
            }
            if(imageCode==null||imageCode==""){
                alert("验证码不能为空");
                return;
            }

            //提交表单
            $("#adminlogin").submit();

        }
        //点击刷新验证码
        function changeCode(){
            //生成新验证码的地址
            var src='imageCode.do?temp='+(
                    new Date().getTime().toString(16));

            //调用jquery的attr方法改变id是imageCode的img的src属性
            $("#imageCode").attr("src",src);
            return false;
        }

        var url;//全局url,用来控制发送请求的地址

    </script>
</head>
<body>
<FORM id=adminlogin  method=post
      name=adminlogin action="/admin/main"  >
    <DIV></DIV>
    <TABLE style="MARGIN: auto; WIDTH: 100%; HEIGHT: 100%" border=0
           cellSpacing=0 cellPadding=0>
        <TBODY>
        <TR>
            <TD height=150>&nbsp;</TD>
        </TR>
        <TR style="HEIGHT: 254px">
            <TD>
                <DIV style="MARGIN: 0px auto; WIDTH: 936px"><IMG
                        style="DISPLAY: block" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/images/body_03.jpg"></DIV>
                <DIV style="BACKGROUND-COLOR: #278296">
                    <DIV style="MARGIN: 0px auto; WIDTH: 936px">
                        <DIV
                                style="BACKGROUND: url(http://images-1252121815.cosgz.myqcloud.com/hautlake/images/body_05.jpg) no-repeat; HEIGHT: 155px">
                            <DIV
                                    style="TEXT-ALIGN: left; WIDTH: 265px; FLOAT: right; HEIGHT: 125px; _height: 95px">
                                <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
                                    <TBODY>
                                    <TR>
                                        <TD style="HEIGHT: 45px"><INPUT type="text" class=input value="${user.username }" name="username" id="username"></TD>
                                    </TR>
                                    <TR>
                                        <TD><INPUT type="password" class=input value="${user.password }" name="password" id="password"/></TD>
                                    </TR>
                                    <TR><td>&nbsp;</td></TR>
                                    <TR>
                                        <td>
                                            <input id="imageCode" type="text" class="input" value="haut" name="imageCode"/>
                                        </td>
                                    </TR>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                            <DIV style="HEIGHT: 1px; CLEAR: both"></DIV>
                            <DIV style="WIDTH: 380px; FLOAT: right; CLEAR: both">
                                <TABLE border=0 cellSpacing=0 cellPadding=0 width=300>
                                    <TBODY>

                                    <TR>
                                        <TD width=100 align=right><INPUT
                                                style="BORDER-RIGHT-WIDTH: 0px; BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px"
                                                id=btnLogin src="http://images-1252121815.cosgz.myqcloud.com/hautlake/images/btn1.jpg" type=image name=btnLogin onclick="javascript:login();return false;"></TD>
                                        <TD width=100 align=middle><INPUT
                                                style="BORDER-RIGHT-WIDTH: 0px; BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px"
                                                id=btnReset src="http://images-1252121815.cosgz.myqcloud.com/hautlake/images/btn2.jpg" type=image name=btnReset onclick="javascript:adminlogin.reset();return false;"></TD>


                                    </TR>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </DIV>
                    </DIV>
                </DIV>
                <DIV style="MARGIN: 0px auto; WIDTH: 936px"><IMG
                        src="http://images-1252121815.cosgz.myqcloud.com/hautlake/images/body_06.jpg"></DIV>
            </TD>
        </TR>
        <TR style="HEIGHT: 30%">
            <TD>&nbsp;</TD>
        </TR>
        </TBODY>
    </TABLE>
</FORM>

</body>
</html>
