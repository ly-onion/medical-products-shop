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

            <li><a href="javascript:void();">订单管理</a></li>
            <li><a href="javascript:void();">订单首页</a></li>
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
                    <h3 class="panel-title"><i class="fa fa-list"></i> 订单列表</h3>
                </div>
                <div class="panel-body">
                    <div class="navbar navbar-default">
                        <form action="" id="search-form2" class="navbar-form form-inline" method="post"
                              onsubmit="return false">
                            <div class="form-group">
                                <label class="control-label" for="input-order-id">用户名</label>
                                <div class="input-group">
                                    <input name="userName" id="userName" value="" placeholder="用户名" class="form-
control" type="text">
                                </div>
                            </div>
                            <!--排序规则-->
                            <input name="orderby1" value="order_id" type="hidden">
                            <button type="submit"
                                    onclick="getUsePageAndUserName(document.getElementById('userName').value,1)"
                                    id="button-filter search-order" class="btn btn-primary"><i class="fa fa-search">
                                </i>
                                搜索
                            </button>
                    </div>
                    <div id="ajax_return">
                        <form method="post" enctype="multipart/form-data" target="_blank" id="form-order">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <td class="text-left">
                                            <a href="javascript:sort('order_sn');">订单编号</a>
                                        </td>
                                        <td class="text-left">
                                            <a href="javascript:sort('user_id');">订单用户</a>
                                        </td>
                                        <td class="text-left">
                                            <a href="javascript:sort('order_status');">订单状态</a>
                                        </td>
                                        <td class="text-left">
                                            <a href="javascript:sort('pay_status');">支付状态</a>
                                        </td>
                                        <td class="text-left">
                                            <a href="javascript:sort('goods_price');">订单价格</a>
                                        </td>
                                    </tr>
                                    </thead>
                                    <tbody id="ordersContent">
                                    </tbody>
                                </table>
                            </div>
                            <input name="__hash__"
                                   value="00ea0d70ce1e0760a8bf5d90b5e30971_699560bd02bf6cad1be4e51b170eb190"
                                   type="hidden"></form>
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
<script type="template" id="ordersTemplate">
    {{ for(var i = 0; i < it.length; i++){ }}
    <tr>
        <td class="text-left">{{=it[i].orderSn}}</td>
        <td class="text-left">{{=it[i].userName}}</td>
        <td class="text-left">{{=it[i].orderStatus}}</td>
        <td class="text-left">{{=it[i].payStatus}}</td>
        <td class="text-left">{{=it[i].totalAmount}}</td>
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
            url: "${ctx}/orders/listForPage",
            type: "POST",
            data: {
                userName: null,
                pageNum: page
            },
            dataType: "JSON",
            success: function (result) {
                if (200 == result.code) {
                    if (result.pageInfo.list.length > 0) {
                        //获取商品列表模板
                        var ordersTemp = doT.template($("#ordersTemplate").text());
                        //填充数据
                        $("#ordersContent").html(ordersTemp(result.pageInfo.list));
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

    function getUsePageAndUserName(userName, page) {
        $.ajax({
            url: "${ctx}/orders/listForPage",
            type: "POST",
            data: {
                userName: userName,
                pageNum: page
            },
            dataType: "JSON",
            success: function (result) {
                if (200 == result.code) {
                    if (result.pageInfo.list.length > 0) {
                        //获取商品列表模板
                        var ordersTemp = doT.template($("#ordersTemplate").text());
                        //填充数据
                        $("#ordersContent").html(ordersTemp(result.pageInfo.list));
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

    // 点击排序
    function sort(field) {
        $("input[name='orderby1']").val(field);
        var v = $("input[name='orderby2']").val() == 'desc' ? 'asc' : 'desc';
        $("input[name='orderby2']").val(v);
        ajax_get_table('search-form2', cur_page);
    }

</script>

</body>
</html>