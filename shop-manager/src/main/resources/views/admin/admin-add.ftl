<!DOCTYPE html>
<html>
<head>
    <#include "../head.ftl">
</head>
<body style="background-color:#ecf0f5;">


<div class="wrapper">
    <div class="breadcrumbs" id="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="javascript:void();"><i class="fa fa-home"></i>&nbsp;&nbsp;后台首页</a></li>

            <li><a href="javascript:void();">权限管理</a></li>
            <li><a href="javascript:void();">编辑管理员</a></li>
        </ol>
    </div>

    <section class="content ">
        <!-- Main content -->
        <div class="container-fluid">
            <div class="pull-right">
                <a href="javascript:history.go(-1)" data-toggle="tooltip" title="" class="btn btn-default"
                   data-original-title="返回管理员列表"><i class="fa fa-reply"></i></a>
                <a href="javascript:;" class="btn btn-default"
                   data-url="http://www.ego.cn/Doc/Index/article/id/1001/developer/user.html"
                   onclick="get_help(this)"><i class="fa fa-question-circle"></i> 帮助</a>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list"></i> 添加管理员</h3>
                </div>
                <div class="panel-body ">
                    <!--表单数据-->
                    <form method="post" id="adminHandle" action="/index/Admin/Admin/adminHandle">
                        <!--通用信息-->
                        <div class="tab-content col-md-10">
                            <div class="tab-pane active" id="tab_tongyong">
                                <table class="table table-bordered">
                                    <tbody>
                                    <tr>
                                        <td class="col-sm-2">用户名：</td>
                                        <td class="col-sm-8">
                                            <input type="text" class="form-control" name="userName"
                                                   value="${(admin.userName)!}">

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Email地址：</td>
                                        <td>
                                            <input type="text" class="form-control" name="email"
                                                   value="${(admin.email)!}">

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>登陆密码：</td>
                                        <td>
                                            <input type="password" class="form-control" name="password"
                                                   value="${(admin.password)!}">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>所属角色：</td>
                                        <td>
                                            <select name="roleId">
                                                <option value="${(admin.roleId)!-1}">${(adminVo.role)!"请设置"}</option>
                                                <option value="0">管理员</option>
                                                <option value="1">管理员</option>
                                                <option value="2">商家</option>
                                                <option value="3">商城用户</option>
                                            </select>
                                        </td>
                                    </tr>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td><input type="hidden" name="act" value="add">
                                            <input type="text" name="adminId" value="${(admin.adminId)!}">
                                        </td>
                                        <td class="text-right"><input class="btn btn-primary" type="button"
                                                                      onclick="adsubmit()" value="保存"></td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <input type="hidden" name="__hash__"
                               value="3f60d1f070956e3df811769cfab519d3_859a05842ed117ca71360f475fb19b7f"/>
                    </form>
                    <!--表单数据-->
                </div>
            </div>
        </div>
    </section>
</div>
<script>
    function adsubmit() {
        $.ajax({
            type: "POST",
            url: "${ctx}/admin/save",
            data: $('#adminHandle').serialize(),// 你的formid
            dataType: "JSON",
            error: function (request) {
                alert("服务器繁忙, 请联系管理员!");
            },
            success: function (result) {
                if (result.code == 200){
                    layer.confirm("保存成功");
                }else {
                    alert("服务器繁忙, 请联系管理员!");
                }
            }
        });
    }
</script>
</body>
</html>