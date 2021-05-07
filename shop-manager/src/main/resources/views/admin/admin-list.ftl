<#-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html>
<head>
    <#include "../head.ftl">
<body style="background-color:#ecf0f5;">


<div class="wrapper">
    <div class="breadcrumbs" id="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="javascript:void();"><i class="fa fa-home"></i>&nbsp;&nbsp;后台首页</a></li>

            <li><a href="javascript:void();">权限管理</a></li>
            <li><a href="javascript:void();">管理员列表</a></li>
        </ol>
    </div>

    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                        <nav class="navbar navbar-default">
                            <div class="collapse navbar-collapse">
                                <form class="navbar-form form-inline" action="/index/Admin/Admin/index" method="post"
                                      onsubmit="return false">
                                    <button type="button" onclick="location.href='${ctx}/admin/add/-1'"
                                            class="btn btn-primary pull-right">
                                        <i class="fa fa-plus"></i>
<#--                                        <#if adminList.get(0).roleId==3>-->
<#--                                            添加管理员-->
<#--                                            <#else >-->
<#--                                            添加用户-->
<#--                                        </#if>-->
                                        添加管理员
                                    </button>
                                </form>
                            </div>
                        </nav>
                    </div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <table id="list-table" class="table table-bordered table-striped dataTable">
                                    <thead>
                                    <tr role="row">
                                        <th>ID</th>
                                        <th>用户名</th>
                                        <th>电话号码</th>
                                        <th>加入时间</th>
                                        <th>上次登录时间</th>
                                        <th>角色</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#list adminList as admin>
                                        <tr>
                                            <td>${admin.adminId}</td>
                                            <td>${admin.userName}</td>
                                            <td>${admin.email}</td>
                                            <td>${admin.addTime}</td>
                                            <td>${admin.lastLogin}</td>
                                            <td>${admin.role}</td>
                                            <td>
                                                <a class="btn btn-danger" href="${ctx}/admin/add/${admin.adminId}" title="编辑">
                                                    <i class="fa fa-pencil"></i>
                                                </a>
                                                <a class="btn btn-primary" href="javascript:void(0);" onclick="del(${admin.adminId})"><i
                                                            class="fa fa-trash-o"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </#list>
                                    </tbody>
                                    <tfoot>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 text-left"></div>
                            <div class="col-sm-6 text-right"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<script>
    $(document).ready(function () {
        // ajax 加载订单列表
        getUserPage();
    });

    function getAdminList() {
        $.ajax({
            url: "${ctx}/admin/list",
            type: "GET",

            dataType: "JSON",
        });
    }

    // 删除操作
    function del(id) {
        if (!confirm('确定要删除吗?'))
            return false;
        $.ajax({
            url: "${ctx}/admin/list/" + id,
            type: "DELETE",
            success: function (result) {
                if (result.code == 200) {
                    layer.msg("删除成功！");
                    location.reload();
                }
            }
        });
    }
</script>
</body>
</html>