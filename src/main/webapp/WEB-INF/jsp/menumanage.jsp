<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>菜单管理界面</title>
    <link rel="stylesheet" type="text/css" href="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

    <script>
        //打开添加菜单的窗口
        function openAddMenuDlg(){
            //显示添加菜单窗口并且设置窗口标题
            $("#addMenuDlg").dialog("open").dialog("setTitle","添加新菜单");
        }

        //添加菜单的方法
        function addMenu(){
            var actionPath = "AddMenu.action";

            //提交添加菜单的表单addMenuForm
            //使用ajax进行提交
            $("#addMenuForm").form("submit",{
                url:actionPath,
                //当提交时执行表单数据的校验
                onSubmit:function(){
                    return $(this).form("validate");
                },
                //请求从后台成功返回后执行的方法
                //请求从后台成功返回并不代表后台执行结果一定是成功的
                success:function(result){
                    var res = eval("("+ result +")");//使用json解析result
                    //解析过后,res可以理解为一个json对象
                    if (res.success) {
                        $.messager.alert("系统提示","保存成功");
                        //清空表单输入框的值
                        resetInnput();
                        //关闭添加的窗口
                        $("#addMenuDlg").dialog("close");
                        //刷新数据表格
                        $("#menuListDlg").datagrid("reload");
                    } else{
                        $.messager.alert("系统提示","保存失败");
                    }
                }
            });
        }

        //打开修改菜单的窗口
        function openUpdateMenuDlg(){
            //选中一条待修改的数据
            var selectRows = $("#menuListDlg").datagrid("getSelections");
            //如果没有勾选，或者勾选了多行
            if (selectRows.length != 1) {
                $.messager.alert("系统提示","请选择一条要修改的数据!");
                return;//返回
            }

            var row = selectRows[0];//取出选中的数据行

            //将选中行的数据依次填充到修改菜单弹窗的各个输入框中
            $("#updateMenuForm").form("load",row);
            //显示修改菜单窗口并且设置窗口标题
            $("#updateMenuDlg").dialog("open").dialog("setTitle","编辑菜单");
        }

        //修改菜单的方法
        function updateMenu(){
            var actionPath = "/menu/update";

            //提交修改菜单的表单udpateMenuForm
            //使用ajax进行提交
            $("#updateMenuForm").form("submit",{
                url:actionPath,
                //当提交时执行表单数据的校验
                onSubmit:function(){
                    return $(this).form("validate");
                },
                //请求从后台成功返回后执行的方法
                //请求从后台成功返回并不代表后台执行结果一定是成功的
                success:function(result){
                    var res = eval("("+ result +")");//使用json解析result
                    //解析过后,res可以理解为一个json对象
                    if (res.success) {
                        $.messager.alert("系统提示","保存成功");
                        //清空表单输入框的值
                        resetInnput();
                        //关闭添加的窗口
                        $("#updateMenuDlg").dialog("close");
                        //刷新数据表格
                        $("#menuListDlg").datagrid("reload");
                    } else{
                        $.messager.alert("系统提示","保存失败");
                    }
                }
            });
        }

        //删除菜单
        function deleteMenu(){
            //选中要删除的行
            var selectRows =
                $("#menuListDlg").datagrid("getSelections");
            //如果选中的行数为0
            if (selectRows.length == 0) {
                $.messager.alert("系统提示","请选择要删除的记录");
                return;
            }

            //批量删除,需要拿到选中行的id数组
            var selectIds = [];//声明一个空数组
            //使用for循环依次读取选中的每一行的id值
            for (var i = 0;i<selectRows.length;i++) {
                //依次去除每一个对象的id属性
                selectIds.push(selectRows[i].id);
            }
            //将上面构造的数组转化为字符串,用","分割
            var ids = selectIds.join(",");

            //弹出删除操作确认的弹框
            $.messager.confirm("系统提示",
                "您确定要删除这些数据吗?",
                //menuSelect 是菜单选择的结果,
                //其值为true or false
                function(menuSelect){
                    //如果选择确定
                    if (menuSelect) {
                        //执行删除的action
                        var actionPath = "DeleteMenu.action";
                        //ajax提交请求
                        $.post(
                            actionPath,
                            {ids:ids},//json格式的参数
                            //请求返回后调用该方法处理返回的结果
                            function(result){
                                if (result.success) {
                                    $("#menuListDlg").datagrid("reload");
                                    $.messager.alert("系统提示","数据已经成功删除!");
                                } else{
                                    $.messager.alert("系统提示","数据删除失败!");
                                }
                            },
                            "json"//以json格式执行数据请求
                        );
                    }
                });

        }

        //根据搜索条件查询菜单
        function queryMenu(){
            var actionPath = "/menu/query";

            //提交查询表单
            $("#search-fm").form("submit",{
                url:actionPath,
                success:function(result){
                    //处理返回的结果result
                    var temp = eval("("+ result +")");
                    if (temp.total) {
                        //将返回的json格式数据
                        //加载到数据表表格"menuListDlg中"
                       $("#menuListDlg").datagrid("loadData",temp.rows);
                    } else{
                        $.messager.alert("系统提示","数据查询失败!!");
                    }

                }
            });
        }

        //清空表单输入框
        function resetInnput(){
            $("#menuName").val("");
            $("#menuNo").val("");
            $("#parentNo").val("");
            $("#menuDesc").val("");
            $("#action").val("");
        }
    </script>

</head>
<body>
<table id="menuListDlg" title="菜单管理" class="easyui-datagrid"
       fitColums="true" pagination="true" pageNumber="1" pageSize="10" pageList="[10,15,20,25,30]" rownumbers="false"
       url="/menu/menumanage" fit="true" toolbar="#menuListTb">

    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="50" align="center">编号</th>
        <th field="menuNo" width="100" align="center">菜单编号</th>
        <th field="menuName" width="50" align="center">菜单名</th>
        <th field="menuDesc" width="100" align="center">菜单描述</th>
        <th field="action" width="100" align="center">执行动作</th>
        <th field="parentNo" width="100" align="center">父节点编号</th>
    </tr>
    </thead>

</table>

<!-- 上面表格的工具栏 -->
<div id="menuListTb">
    <div>
        <a href="javascript:openAddMenuDlg()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openUpdateMenuDlg()" class="easyui-linkbutton"
           iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteMenu();" class="easyui-linkbutton"
           iconCls="icon-remove" plain="true">删除</a>

        <form id="search-fm" method="post">
            菜单名:<input type="text" name="menuName" size="15"
                       placeholder="输入查询条件">
            <a href="javascript:queryMenu();"
               class="easyui-linkbutton"
               iconCls="icon-ok" plain="true">查询</a>
        </form>
    </div>
</div>


<!-- 添加菜单的窗口 -->
<!-- closed="false" 表示该窗口不关闭
 buttons="#addMenuDlgBtn" 表示该窗口使用id="addMenuDlgBtn"
 的div作为它的按钮放置点-->
<div id="addMenuDlg" class="easyui-dialog"
     style="width:500px;height:400px;padding:10px 20px"
     closed="true" buttons="#addMenuDlgBtn">

    <form id="addMenuForm" method="post">
        <table cellspacing="10px">
            <tr>
                <td>菜单编号:</td>
                <td>
                    <input type="text" id="menuNo" name="menuNo"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>
            <tr>
                <td>菜单名:</td>
                <td>
                    <input type="text" id="menuName" name="menuName"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>

            <tr>
                <td>执行动作:</td>
                <td>
                    <input type="text" id="action" name="action"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>

            <tr>
                <td>菜单描述:</td>
                <td>
                    <input type="text" id="menuDesc" name="menuDesc"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>
            <tr>
                <td>父节点编号:</td>
                <td>
                    <input type="text" id="parentNo" name="parentNo"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>
        </table>
    </form>

</div>
<!-- 添加菜单的窗口 END -->

<!-- 添加菜单窗口的按钮 -->
<div id="addMenuDlgBtn">
    <a href="javascript:addMenu();" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>
<!-- 添加菜单窗口的按钮 END-->


<!-- 修改菜单的窗口 -->
<div id="updateMenuDlg" class="easyui-dialog"
     style="width:500px;height:300px;padding:10px 20px"
     closed="true" buttons="#updateMenuDlgBtn">
    <form id="updateMenuForm" method="post">
        <table cellspacing="10px">
            <input type="hidden" id="id" name="id">
            <tr>
                <td>菜单编号:</td>
                <td>
                    <input type="text" id="menuNo" name="menuNo"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>
            <tr>
                <td>菜单名:</td>
                <td>
                    <input type="text" id="menuName" name="menuName"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>

            <tr>
                <td>执行动作:</td>
                <td>
                    <input type="text" id="action" name="action"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>

            <tr>
                <td>菜单描述:</td>
                <td>
                    <input type="text" id="menuDesc" name="menuDesc"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>
            <tr>
                <td>父节点编号:</td>
                <td>
                    <input type="text" id="parentNo" name="parentNo"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 修改菜单的窗口 END-->

<!-- 修改菜单窗口所使用的按钮的放置点 -->
<div id="updateMenuDlgBtn">
    <a href="javascript:updateMenu();"
       class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:"
       class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
    <a></a>
</div>
</body>
</html>