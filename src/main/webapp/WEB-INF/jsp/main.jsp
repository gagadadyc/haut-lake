<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" import="java.util.*,com.imdyc.hautlake.entity.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>HAUT管理系统主页</title>
    <link rel="stylesheet" type="text/css" href="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        var url;

        function openTab(text,url,iconCls){
            if($("#tabs").tabs("exists",text)){
                $("#tabs").tabs("select",text);
            }else{
                var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/"+url+"'></iframe>";
                $("#tabs").tabs("add",{
                    title:text,
                    iconCls:iconCls,
                    closable:true,
                    content:content
                });
            }
        }

        function openPasswordModifyDialog(){
            $("#dlg").dialog("open").dialog("setTitle","修改密码");
            url="${pageContext.request.contextPath}/user/modifyPassword.do?id=${currentUser.id}";
        }

        function closePasswordModifyDialog(){
            $("#dlg").dialog("close");
            $("#oldPassword").val("");
            $("#newPassword").val("");
            $("#newPassword2").val("");
        }

        function modifyPassword(){
            $("#fm").form("submit",{
                url:url,
                onSubmit:function(){
                    var oldPassword=$("#oldPassword").val();
                    var newPassword=$("#newPassword").val();
                    var newPassword2=$("#newPassword2").val();
                    if(!$(this).form("validate")){
                        return false;
                    }
                    if(oldPassword!='${currentUser.password}'){
                        $.messager.alert("系统提示","用户密码输入错误！");
                        return false;
                    }
                    if(newPassword!=newPassword2){
                        $.messager.alert("系统提示","确认密码输入错误！");
                        return false;
                    }
                    return true;
                },
                success:function(result){
                    var result=eval('('+result+')');
                    if(result.success){
                        $.messager.alert("系统提示","密码修改成功，下一次登录生效！");
                        closePasswordModifyDialog();
                    }else{
                        $.messager.alert("系统提示","密码修改失败");
                        return;
                    }
                }
            });
        }

        function logout(){
            $.messager.confirm("系统提示","您确定要退出系统吗",function(r){
                if(r){
                    window.location.href="${pageContext.request.contextPath}/user/Logout.action";
                }
            });
        }



    </script>
</head>
<body class="easyui-layout">
<div region="north" style="height: 78px;background-color: #E0ECFF">
    <table style="padding: 5px" width="100%">
        <tr>
            <td width="50%">
                <img src="http://images-1252121815.cosgz.myqcloud.com/hautlake/images/bglogo.png"/>
            </td>
            <td valign="bottom" align="right" width="50%">
                <font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${user.username}</font>
                <font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${user.role.roleName}</font>
                <button onclick="logout();">注销</button>
            </td>

        </tr>
    </table>
</div>
<div region="center">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div title="首页" data-options="iconCls:'icon-home'">
            <div align="center" style="padding-top: 10px;padding-left:10px;">
                <div id="schedule-div" class="easyui-draggable" data-options="handle:'#myschedule'" style="width:48%;;height:300px;border:1px solid #ccc;float: left;">
                    <div id="myschedule" style="background:#ddd;padding:5px;">我的行程</div>
                    <div style="padding:20px" id="schresult">
                    </div>
                </div>

                <div id="info-div" class="easyui-draggable" data-options="handle:'#myinfo'" style="width:48%;;height:300px;border:1px solid #ccc;float: right;">
                    <div id="myinfo" style="background:#ddd;padding:5px;">我的消息</div>
                    <div style="padding:20px">Drag and Resize Me</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div region="west" style="width: 200px" title="导航菜单" split="true">
    <div class="easyui-accordion" data-options="fit:true,border:false">
        <div title="基础数据管理"  data-options="iconCls:'icon-jcsjgl'" style="padding:10px">
            <a href="javascript:openTab('菜单管理','menu/menumanage','icon-sjzdgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 150px;">菜单管理</a>
            <a href="javascript:openTab('角色管理','role/RoleManage.action','icon-cpxxgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cpxxgl'" style="width: 150px;">角色管理</a>
            <a href="javascript:openTab('用户管理','user/UserManage.action','icon-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user'" style="width: 150px;">用户管理</a>
            <a href="javascript:openTab('新闻管理','news/newsmanage','icon-fwgd')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwgd'" style="width: 150px;">新闻管理</a>

        </div>

        <div title="新闻管理"  data-options="iconCls:'icon-yxgl'" style="padding:10px">
            <a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">热点新闻</a>
            <a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">普通新闻</a>
        </div>

        <div title="景点管理"  data-options="iconCls:'icon-item'" style="padding:10px">
            <a href="javascript:openTab('景点管理','scenic/ScenicManage.action','icon-sjzdgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 150px;">景点管理</a>
        </div>

        <div title="团队管理"  data-options="iconCls:'icon-item'" style="padding:10px">
            <a href="javascript:openTab('团队管理','user/TeamManage.action','icon-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user'" style="width: 150px;">团队管理</a>
        </div>

        <div title="系统管理"  data-options="iconCls:'icon-item'" style="padding:10px">
            <a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
            <a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
        </div>
    </div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 400px;height:250px;padding: 10px 20px"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>用户名：</td>
                <td><input type="text" id="userName" name="userName" value="${currentUser.userName }" readonly="readonly" style="width: 200px"/></td>
            </tr>
            <tr>
                <td>原密码：</td>
                <td><input type="password" id="oldPassword" class="easyui-validatebox" required="true" style="width: 200px"/></td>
            </tr>
            <tr>
                <td>新密码：</td>
                <td><input type="password" id="newPassword" name="password" class="easyui-validatebox" required="true" style="width: 200px"/></td>
            </tr>
            <tr>
                <td>确认新密码：</td>
                <td><input type="password" id="newPassword2"  class="easyui-validatebox" required="true" style="width: 200px"/></td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>