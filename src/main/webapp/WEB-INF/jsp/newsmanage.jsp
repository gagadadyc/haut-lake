<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>新闻管理界面</title>
    <link rel="stylesheet" type="text/css" href="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="http://images-1252121815.cosgz.myqcloud.com/hautlake/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

    <script>
        //打开添加新闻的窗口
        function openAddNewsDlg(){
            //显示添加新闻窗口并且设置窗口标题
            $("#addNewsDlg").dialog("open").dialog("setTitle","添加新闻");
        }

        //添加新闻的方法
        function addNews(){
            var actionPath = "/news/add";

            //读取文本框的值
            var newstext = $("#newstextarea").val();
            //将文本值赋予表单变量中提交
            document.getElementById('newsContent').value= newstext;


            //提交添加新闻的表单addNewsForm
            //使用ajax进行提交
            $("#addNewsForm").form("submit",{
                url:actionPath,
                //当提交时执行表单数据的校验
                onSubmit:function(){
                    return $(this).form("validate");
                },
                //请求从后台成功返回后执行的方法
                //请求从后台成功返回并不代表后台执行结果一定是成功的
                success:function(result){
                    $.messager.alert(result);
                    var res = eval("("+ result +")");//使用json解析result
                    //解析过后,res可以理解为一个json对象
                    if (res.success) {
                        $.messager.alert("系统提示","保存成功");
                        //清空表单输入框的值
                        resetInnput();
                        //关闭添加的窗口
                        $("#addNewsDlg").dialog("close");
                        //刷新数据表格
                        $("#NewsListDlg").datagrid("reload");
                    } else{
                        $.messager.alert("系统提示","保存失败");
                    }
                }
            });
        }

        //打开修改新闻的窗口
        function openUpdateNewsDlg(){
            //选中一条待修改的数据
            var selectRows = $("#NewsListDlg").datagrid("getSelections");
            //如果没有勾选，或者勾选了多行
            if (selectRows.length != 1) {
                $.messager.alert("系统提示","请选择一条要修改的数据!");
                return;//返回
            }

            var row = selectRows[0];//取出选中的数据行

            //将选中行的数据依次填充到修改新闻弹窗的各个输入框中
            $("#updateNewsForm").form("load",row);
            //显示修改新闻窗口并且设置窗口标题
            $("#updateNewsDlg").dialog("open").dialog("setTitle","编辑新闻");
        }

        //修改新闻的方法
        function updateNews(){
            var actionPath = "/News/update";

            //提交修改新闻的表单udpateNewsForm
            //使用ajax进行提交
            $("#updateNewsForm").form("submit",{
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
                        $("#updateNewsDlg").dialog("close");
                        //刷新数据表格
                        $("#NewsListDlg").datagrid("reload");
                    } else{
                        $.messager.alert("系统提示","保存失败");
                    }
                }
            });
        }

        //删除新闻
        function deleteNews(){
            //选中要删除的行
            var selectRows =
                $("#NewsListDlg").datagrid("getSelections");
            //如果选中的行数为0
            if (selectRows.length == 0) {
                $.messager.alert("系统提示","请选择要删除的记录");
                return;
            }

            //批量删除,需要拿到选中行的id数组
            var selectIds = [];//声明一个空数组
            //使用for循环依次读取选中的每一行的id值
            for (var i = 0;i<selectRows.length;i++) {
                ////依次去除每一个对象的id属性
                //依次放入每个对象的id属性
                selectIds.push(selectRows[i].newsId);
            }
            //将上面构造的数组转化为字符串,用","分割
            var ids = selectIds.join(",");

            //弹出删除操作确认的弹框
            $.messager.confirm("系统提示",
                "您确定要删除这些数据吗?",
                //NewsSelect 是新闻选择的结果,
                //其值为true or false
                function(NewsSelect){
                    //如果选择确定
                    if (NewsSelect) {
                        //执行删除的action
                        var actionPath = "/news/delete";
                        //ajax提交请求
                        $.post(
                            actionPath,
                            {ids:ids},//json格式的参数
                            //请求返回后调用该方法处理返回的结果
                            function(result){
                                if (result.success) {
                                    $("#NewsListDlg").datagrid("reload");
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

        //根据搜索条件查询新闻
        function queryNews(){
            var actionPath = "/News/query";

            //提交查询表单
            $("#search-fm").form("submit",{
                url:actionPath,
                success:function(result){
                    //处理返回的结果result
                    var temp = eval("("+ result +")");
                    if (temp.total) {
                        //将返回的json格式数据
                        //加载到数据表表格"NewsListDlg中"
                        $("#NewsListDlg").datagrid("loadData",temp.rows);
                    } else{
                        $.messager.alert("系统提示","数据查询失败!!");
                    }

                }
            });
        }

        //清空表单输入框
        function resetInnput(){
            $("#NewsName").val("");
            $("#NewsNo").val("");
            $("#parentNo").val("");
            $("#NewsDesc").val("");
            $("#action").val("");
        }
    </script>

</head>
<body>
<table id="NewsListDlg" title="新闻管理" class="easyui-datagrid"
       fitColums="true" pagination="true" pageNumber="1" pageSize="10" pageList="[10,15,20,25,30]" rownumbers="false"
       url="/news/newsmanage" fit="true" toolbar="#NewsListTb">

    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="newsId" width="120" align="center">新闻编号</th>
        <th field="newsTitle" width="120" align="center">新闻标题</th>
        <th field="newsContent" width="60" align="center">内容</th>
        <th field="newsAuthor" width="90" align="center">发布者</th>
        <th field="newsHeat" width="120" align="center">文章热度</th>
        <th field="newsRelease" width="120" align="center">发布时间</th>
    </tr>
    </thead>

</table>

<!-- 上面表格的工具栏 -->
<div id="NewsListTb">
    <div>
        <a href="javascript:openAddNewsDlg()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openUpdateNewsDlg()" class="easyui-linkbutton"
           iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteNews();" class="easyui-linkbutton"
           iconCls="icon-remove" plain="true">删除</a>

        <form id="search-fm" method="post">
            新闻名:<input type="text" name="NewsName" size="15"
                       placeholder="输入查询条件">
            <a href="javascript:queryNews();"
               class="easyui-linkbutton"
               iconCls="icon-ok" plain="true">查询</a>
        </form>
    </div>
</div>


<!-- 添加新闻的窗口 -->
<!-- closed="false" 表示该窗口不关闭
 buttons="#addNewsDlgBtn" 表示该窗口使用id="addNewsDlgBtn"
 的div作为它的按钮放置点-->
<div id="addNewsDlg" class="easyui-dialog"
     style="width:500px;height:400px;padding:10px 20px"
     closed="true" buttons="#addNewsDlgBtn">


        <table cellspacing="10px">
            <form id="addNewsForm" method="post">
            <tr>
                <td>新闻标题:</td>
                <td>
                    <input type="text" id="newsTitle" name="newsTitle" size="35"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>

            <%--隐藏输入框，<textarea>文本框中的值通过js放入此输入中进行提交--%>
            <input type="hidden" id="newsContent" name="newsContent">
            <br/>
            <tr>
                <td>新闻内容:</td>
                <td>

                </td>
            </tr>
            </form>

            <tr>
                <td colspan="2"> <%--大文本输入框--%>
                    <textarea id="newstextarea"  rows="20" cols="50"></textarea></td>
            <tr>
        </table>


</div>
<!-- 添加新闻的窗口 END -->

<!-- 添加新闻窗口的按钮 -->
<div id="addNewsDlgBtn">
    <a href="javascript:addNews();" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>
<!-- 添加新闻窗口的按钮 END-->


<!-- 修改新闻的窗口 -->
<div id="updateNewsDlg" class="easyui-dialog"
     style="width:500px;height:300px;padding:10px 20px"
     closed="true" buttons="#updateNewsDlgBtn">
    <form id="updateNewsForm" method="post">
        <table cellspacing="10px">

            <%--&lt;%&ndash;隐藏输入框，提交id值作为修改参数&ndash;%&gt;--%>
            <%--<input type="hidden" id="newsId" name="newsId" required="required">--%>

            <tr>
                <td>新闻编号:</td>
                <td>
                    <input type="text" id="NewsNo" name="NewsNo"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>
            <tr>
                <td>新闻标题:</td>
                <td>
                    <input type="text" id="NewsName" name="NewsName"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>

            <tr>
                <td>新闻内容:</td>
                <td>
                    <input type="text" id="action" name="action"
                           class="easyui-validatebox" required="required">
                    &nbsp;<font color="red">*</font>
                </td>
            </tr>

            <tr>
                <td>新闻描述:</td>
                <td>
                    <input type="text" id="NewsDesc" name="NewsDesc"
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
<!-- 修改新闻的窗口 END-->

<!-- 修改新闻窗口所使用的按钮的放置点 -->
<div id="updateNewsDlgBtn">
    <a href="javascript:updateNews();"
       class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:"
       class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
    <a></a>
</div>
</body>
</html>