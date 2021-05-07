<#-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html>
<head>
    <#include "../head.ftl">
    <!-- 引入doT.js -->
    <script type="text/javascript" src="${ctx}/static/js/doT.min.js"></script>
</head>
<body style="background-color:#ecf0f5;">


<div class="wrapper">
    <div class="breadcrumbs" id="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="javascript:void();"><i class="fa fa-home"></i>&nbsp;&nbsp;后台首页</a></li>

            <li><a href="javascript:void();">广告管理</a></li>
            <li><a href="javascript:void();">广告列表</a></li>
        </ol>
    </div>

    <style>#search-form > .form-group {
            margin-left: 10px;
        }</style>
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list"></i> 广告列表</h3>
                </div>
                <div class="panel-body">
                    <div class="navbar navbar-default">
                        <form action="" id="search-form2" class="navbar-form form-inline" method="post"
                              onsubmit="return false">
                            <div class="form-group">
                                <label class="control-label" for="input-order-id">广告名称</label>
                                <div class="input-group">
                                    <input name="adName" id="adName" value="" placeholder="广告名称" class="form-
control" type="text">
                                </div>
                            </div>
                            <!--排序规则-->
                            <button type="submit"
                                    onclick="getUsePageAndUserName(document.getElementById('adName').value,1)"
                                    id="button-filter search-order" class="btn btn-primary"><i class="fa fa-search">
                                </i>
                                搜索
                            </button>
                            <button type="button" onclick="location.href='${ctx}/adManage/add/-1'"
                                    class="btn btn-primary pull-right"><i class="fa fa-plus"></i>添加广告
                            </button>
                        </form>
                    </div>
                </div>
                <div id="ajax_return">
                    <form method="post" enctype="multipart/form-data" target="_blank" id="form-order">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <td class="text-left">
                                        <a href="javascript:sort('order_sn');">广告ID</a>
                                    </td>
                                    <td class="text-left">
                                        <a href="javascript:sort('user_id');">广告位置</a>
                                    </td>
                                    <td class="text-left">
                                        <a href="javascript:sort('order_status');">广告名称</a>
                                    </td>
                                    <td class="text-left">
                                        <a href="javascript:sort('pay_status');">广告图片地址</a>
                                    </td>
                                    <td class="text-left">
                                        <a href="javascript:sort('pay_status');">广告链接</a>
                                    </td>
                                    <td class="text-left">
                                        <a href="javascript:sort('goods_price');">投放时间</a>
                                    </td>
                                    <td class="text-left">
                                        <a href="javascript:sort('goods_price');">是否显示</a>
                                    </td>
                                    <td class="text-center">操作
                                    </td>
                                </tr>
                                </thead>
                                <tbody id="adsContent">
                                </tbody>
                            </table>
                        </div>
                    </form>
                    <div class="row">
                        <div class="col-sm-3 text-left"></div>
                        <div class="col-sm-9 text-right">
                            <div class="dataTables_paginate paging_simple_numbers">
                                <ul class="pagination" id="pageContent">
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>
<!-- /.row -->
</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<!-- 编写商品模板 -->
<script type="template" id="adsTemplate">
    {{ for(var i = 0; i < it.length; i++){ }}
    <tr>
        <td class="text-left">{{=it[i].adId}}</td>
        <td class="text-left">{{=it[i].adPosition}}</td>
        <td class="text-left">{{=it[i].adName}}</td>
        <td class="text-left">
            <a href="{{=it[i].adCode}}" target="_blank">
                {{=it[i].adCode}}
            </a>
        </td>
        <td class="text-left">
            <a href="{{=it[i].adLink}}" target="_blank">
                {{=it[i].adLink}}
            </a>
        </td>
        <td class="text-left" style="white-space:nowrap">{{=it[i].begin}}</td>
        <td class="text-left">{{=it[i].isShow}}</td>
        <td class="text-left">
            <a href="${ctx}/adManage/add/{{=it[i].adId}}" class="btn btn-primary" title="编辑"><i
                        class="fa fa-pencil"></i></a>
            <a href="javascript:void(0);" onclick="del('{{=it[i].adId}}')" class="btn btn-danger"
               title="删除"><i class="fa fa-trash-o"></i></a>
        </td>
    </tr>
    {{ } }}
</script>
<!-- 编写分页模板 -->
<script type="template" id="pageTemplate">
    {{ if(it.hasPreviousPage){ }}
    <li class="paginate_button prev">
        <a href="javascript:getUserPage('{{=it.prePage}}');">上一页</a>
    </li>
    {{ } }}
    {{ for(var i = 1; i <= it.pages; i++){ }}
    <li class="paginate_button
{{ if(i == it.pageNum){ }}
active
{{ } }}
">
        <a href="javascript:getUserPage('{{=i}}');">{{=i}}</a>
    </li>
    {{ } }}
    {{ if(it.hasNextPage){ }}
    <li class="paginate_button next">
        <a href="javascript:getUserPage('{{=it.nextPage}}');">下一页</a>
    </li>
    {{ } }}
</script>


<script>
    $(document).ready(function () {
        // ajax 加载订单列表
        getUserPage(1);
    });

    //ajax抓取页面 page为当前第几页
    function getUserPage(page) {
        $.ajax({
            url: "${ctx}/adManage/listForPage",
            type: "POST",
            data: {
                adName: null,
                pageNum: page
            },
            dataType: "JSON",
            success: function (result) {
                if (200 == result.code) {
                    if (result.pageInfo.list.length > 0) {
                        //获取商品列表模板
                        var adsTemp = doT.template($("#adsTemplate").text());
                        //填充数据
                        $("#adsContent").html(adsTemp(result.pageInfo.list));
                        //获取分页模板
                        var pageTemp = doT.template($("#pageTemplate").text());
                        //填充数据
                        $("#pageContent").html(pageTemp(result.pageInfo));
                    } else {
                        layer.msg("订单信息加载失败，请刷新！");
                    }
                } else {
                    layer.msg("订单信息加载失败，请刷新！！");
                }
            },
            error: function (result) {
                console.log(result)
            }
        });
    }

    function getUsePageAndUserName(adName, page) {
        $.ajax({
            url: "${ctx}/adManage/listForPage",
            type: "POST",
            data: {
                adName: adName,
                pageNum: page
            },
            dataType: "JSON",
            success: function (result) {
                if (200 == result.code) {
                    if (result.pageInfo.list.length > 0) {
                        //获取商品列表模板
                        var adsTemp = doT.template($("#adsTemplate").text());
                        //填充数据
                        $("#adsContent").html(adsTemp(result.pageInfo.list));
                        //获取分页模板
                        var pageTemp = doT.template($("#pageTemplate").text());
                        //填充数据
                        $("#pageContent").html(pageTemp(result.pageInfo));
                    } else {
                        layer.msg("订单信息加载失败，请刷新！");
                    }
                } else {
                    layer.msg("订单信息加载失败，请刷新！！");
                }
            },
            error: function (result) {
                console.log(result)
            }
        });

    }

    // 删除操作
    function del(id) {
        if (!confirm('确定要删除吗?'))
            return false;
        $.ajax({
            url: "${ctx}/adManage/list/" + id,
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