<#-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html>
<head>
    <#include "head.ftl">
</head>
<body class="skin-green-light sidebar-mini" style="overflow-y:hidden;">
<div class="wrapper">
    <header class="main-header">
        <!-- Logo -->
        <a href="/index/Admin/Index/index" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b></b></span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><img src="${ctx}/static/images/ego_logo.png" width="40"
                                       height="30">&nbsp;&nbsp;<b>ego</b></span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <!--服务器升级-->
            <textarea id="textarea_upgrade" style="display:none;"></textarea>
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown user user-menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <!-- <img src="${ctx}/dist/img/user2-160x160.jpg" class="user-image" alt="User
Image">-->
                            <i class="glyphicon glyphicon-user"></i>
                            <span class="hidden-xs">欢迎：${user.userName}</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="/index/Admin/Index/index" data-url=""
                                       class="btn btn-default btn-flat model-map">后台首页</a>
                                    <a href="修改密码.html" target="rightContent" class="btn btn-default
btn-flat">修改密码</a>
                                    <a href="/index/Admin/Admin/logout" class="btn btn-default btn-flat">安
                                        全退出</a>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a href="${ctx}/user/logout">安全退出</a></li>
                    <!-- Control Sidebar Toggle Button -->
                    <li><a href="#" data-toggle="control-sidebar"><i class="fa fa-street-view"></i>换肤</a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <aside class="main-sidebar" style="overflow-y:auto;">
        <section class="sidebar">
            <!-- search form -->
            <form action="#" method="get" class="sidebar-form">
                <div class="input-group">
                    <input type="text" name="q" class="form-control" placeholder="Search...">
                    <span class="input-group-btn">
              <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i
                          class="fa fa-search"></i>
              </button>
            </span>
                </div>
                <input type="hidden" name="__hash__"
                       value="40390ff8c1de6e5b5f80bd80d3196959_8f39a041787ac9854b174964cdc80849"/>
            </form>
            <!-- /.search form -->
            <ul class="sidebar-menu">
                <li class="treeview">
                    <a href="javascript:void(0)">
                        <i class="fa fa-gears"></i><span>权限管理</span><i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li onclick="makecss(this)" data-id="index_Admin">
                            <a href="${ctx}/admin/list/managerUser" target='rightContent'><i class="fa fa-circle-o"></i>管理员列表</a>
                            <#--                            onclick="userList('managerUser')"-->
                        </li>
                        <li onclick="makecss(this)" data-id="role_Admin">
                            <a href='${ctx}/admin/list/portalUser' target='rightContent'><i class="fa fa-circle-o"></i>前台用户列表</a>
                        </li>
                        <li onclick="makecss(this)" data-id="supplier_Admin">
                            <a href='权限管理/供应商管理.html' target='rightContent'><i class="fa fa-circle-o"></i>供应商管理</a>
                        </li>
                        <li onclick="makecss(this)" data-id="log_Admin">
                            <a href='权限管理/管理员日志.html' target='rightContent'><i class="fa fa-circle-o"></i>管理员日志</a>
                        </li>
                    </ul>
                </li>
                <li class="treeview">
                    <a href="javascript:void(0)">
                        <i class="fa fa-book"></i><span>商品管理</span><i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li onclick="makecss(this)" data-id="categoryList_Goods">
                            <a href='${ctx}/goods/category/list' target='rightContent'><i class="fa fa-circle-o"></i>商品分类</a>
                        </li>
                        <li onclick="makecss(this)" data-id="goodsList_Goods">
                            <a href='${ctx}/goods/list' target='rightContent'><i class="fa fa-circle-o"></i>商品列表</a>
                        </li>
                        <li onclick="makecss(this)" data-id="stock_list_Goods">
                            <a href='商品管理/库存日志.html' target='rightContent'><i class="fa fa-circle-o"></i>库存日志</a>
                        </li>
                        <li onclick="makecss(this)" data-id="goodsTypeList_Goods">
                            <a href='商品管理/商品模型.html' target='rightContent'><i class="fa fa-circle-o"></i>商品模型</a>
                        </li>
                        <li onclick="makecss(this)" data-id="specList_Goods">
                            <a href='商品管理/商品模型-3-规格列表.html' target='rightContent'><i class="fa fa-circle-o"></i>商品规格</a>
                        </li>
                        <li onclick="makecss(this)" data-id="goodsAttributeList_Goods">
                            <a href='商品管理/商品模型-2-属性列表.html' target='rightContent'><i class="fa fa-circle-o"></i>商品属性</a>
                        </li>
                        <li onclick="makecss(this)" data-id="brandList_Goods">
                            <a href='商品管理/品牌列表.html' target='rightContent'><i class="fa fa-circle-o"></i>品牌列表</a>
                        </li>
                        <li onclick="makecss(this)" data-id="index_Comment">
                            <a href='商品管理/商品评论.html' target='rightContent'><i class="fa fa-circle-o"></i>商品评论</a>
                        </li>
                        <li onclick="makecss(this)" data-id="ask_list_Comment">
                            <a href='商品管理/商品咨询.html' target='rightContent'><i class="fa fa-circle-o"></i>商品咨询</a>
                        </li>
                    </ul>
                </li>
                <li class="treeview">
                    <a href="javascript:void(0)">
                        <i class="fa fa-money"></i><span>订单管理</span><i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li onclick="makecss(this)" data-id="index_Order">
                            <a href='${ctx}/orders/orderList' target='rightContent'><i
                                        class="fa fa-circle-o"></i>订单列表</a>
                        </li>
                        <li onclick="makecss(this)" data-id="delivery_list_Order">
                            <a href='${ctx}/orders/unDelivered' target='rightContent'><i class="fa fa-circle-o"></i>待发货列表</a>
                        </li>
                        <li onclick="makecss(this)" data-id="return_list_Order">
                            <a href='订单管理/退货单.html' target='rightContent'><i class="fa fa-circle-o"></i>退货单</a>
                        </li>
                        <li onclick="makecss(this)" data-id="add_order_Order">
                            <a href='订单管理/添加订单.html' target='rightContent'><i class="fa fa-circle-o"></i>添加订单</a>
                        </li>
                        <li onclick="makecss(this)" data-id="order_log_Order">
                            <a href='订单管理/订单日志.html' target='rightContent'><i class="fa fa-circle-o"></i>订单日志</a>
                        </li>
                    </ul>
                </li>
                <li class="treeview">
                    <a href="javascript:void(0)">
                        <i class="fa fa-flag"></i><span>广告管理</span><i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li onclick="makecss(this)" data-id="adList_Ad">
                            <a href='${ctx}/adManage/list' target='rightContent'><i class="fa fa-circle-o"></i>广告列表</a>
                        </li>
                        <li onclick="makecss(this)" data-id="positionList_Ad">
                            <a href='${ctx}/adManage/modifyShow' target='rightContent'><i class="fa fa-circle-o"></i>广告位置</a>
                        </li>
                    </ul>
                </li>
                <li class="treeview">
                    <a href="javascript:void(0)">
                        <i class="fa fa-signal"></i><span>统计报表</span><i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li onclick="makecss(this)" data-id="index_Report">
                            <a href='统计报表/销售概况.html' target='rightContent'><i class="fa fa-circle-o"></i>销售概况</a>
                        </li>
                        <li onclick="makecss(this)" data-id="saleTop_Report">
                            <a href='统计报表/销售排行.html' target='rightContent'><i class="fa fa-circle-o"></i>销售排行</a>
                        </li>
                        <li onclick="makecss(this)" data-id="userTop_Report">
                            <a href='统计报表/会员排行.html' target='rightContent'><i class="fa fa-circle-o"></i>会员排行</a>
                        </li>
                        <li onclick="makecss(this)" data-id="saleList_Report">
                            <a href='统计报表/销售明细.html' target='rightContent'><i class="fa fa-circle-o"></i>销售明细</a>
                        </li>
                        <li onclick="makecss(this)" data-id="user_Report">
                            <a href='统计报表/会员统计.html' target='rightContent'><i class="fa fa-circle-o"></i>会员统计</a>
                        </li>
                        <li onclick="makecss(this)" data-id="finance_Report">
                            <a href='统计报表/财务统计.html' target='rightContent'><i class="fa fa-circle-o"></i>财务统计</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </section>
    </aside>
    <section class="content-wrapper right-side" id="riframe" style="margin:0px;padding:0px;margin-left:230px;">
        <#--	修改点-->
        <iframe id='rightContent' name='rightContent' src="${ctx}/welcome" width='100%' frameborder="0"></iframe>
    </section>
    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Create the tabs -->
        <!--
        <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
          <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-at"></i></a></li>
          <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
        </ul>
        -->
        <!-- Tab panes -->
        <div class="tab-content">
            <!-- Home tab content -->
            <div class="tab-pane" id="control-sidebar-home-tab">
            </div><!-- /.tab-pane -->
            <!-- Stats tab content -->
            <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div><!-- /.tab-pane -->
            <!-- Settings tab content -->
            <div class="tab-pane" id="control-sidebar-settings-tab">
            </div>
        </div>
    </aside>
    <div class="control-sidebar-bg"></div>
</div>

<script src="${ctx}/static/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="${ctx}/static/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/fastclick/fastclick.min.js" type="text/javascript"></script>
<script src="${ctx}/static/dist/js/app.js" type="text/javascript"></script>
<script src="${ctx}/static/dist/js/demo.js" type="text/javascript"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#riframe").height($(window).height() - 50);// 浏览器当前窗口可视区域高度 静态页面下-100
        $("#rightContent").height($(window).height() - 39);// 静态页面下-100
        $('.main-sidebar').height($(window).height() - 50);

    });

    var tmpmenu = 'index_Index';

    function makecss(obj) {
        $('li[data-id="' + tmpmenu + '"]').removeClass('active');
        $(obj).addClass('active');
        tmpmenu = $(obj).attr('data-id');
    }

    function callUrl(url) {
        layer.closeAll('iframe');
        rightContent.location.href = url;
    }

    var now_num = 0; //现在的数量
    var is_close = 0;

    function ajaxOrderNotice() {
        var url = '/index/Admin/Order/ajaxOrderNotice';
        if (is_close > 0) return;
        $.get(url, function (data) {
            //有新订单且数量不跟上次相等 弹出提示
            if (data > 0 && data != now_num) {
                now_num = data;
                if (document.getElementById('ordfoo').style.display == 'none') {
                    $('#orderAmount').text(data);
                    $('#ordfoo').show();
                }
            }
        })
//        setTimeout('ajaxOrderNotice()',5000);
    }

    function userList(role) {
        var httpRequest = new XMLHttpRequest();
        var url = '${ctx}/admin/list?role=' + role;
        httpRequest.open('GET', url, true);
        httpRequest.send();
    }

    //setTimeout('ajaxOrderNotice()',5000);
</script>
<!-- 新订单提醒-s -->
<style type="text/css">
    .fl {
        float: left;
        margin-left: 10px;
        margin-top: 4px
    }

    .fr {
        float: right;
        margin-right: 10px;
        margin-top: 3px
    }

    /* 静态页面下right:10px; */
    .orderfoods {
        width: 200px;
        border: 1px solid #dedede;
        position: absolute;
        bottom: 50px;
        z-index: 999;
        right: 14px;
        background-color: #00A65A;
        opacity: 0.8;
        -webkit-opacity: 0.8;
        filter: alpha(opacity=80);
        -moz-opacity: 0.8;
    }

    .dor_head {
        border-bottom: 1px solid #dedede;
        height: 28px;
        color: #FFF;
        font-size: 12px
    }

    .dor_head:after {
        content: "";
        clear: both;
        display: block
    }

    .dor_foot {
        margin-top: 6px;
        color: #FFF
    }

    .dor_foot p {
        padding: 0 12px
    }

    .te-in {
        text-indent: 2em;
    }

    .dor_foot p span {
        color: red
    }

    .te-al-ce {
        text-align: center
    }
</style>
<div id="ordfoo" class="orderfoods" style="">
    <div class="dor_head">
        <p class="fl">新订单通知</p>
        <p onClick="closes();" id="close" class="fr" style="cursor:pointer">x</p>
    </div>
    <div class="dor_foot">
        <p class="te-in">您有<span id="orderAmount">139</span>个订单待处理</p>
        <p class="te-al-ce"><a href="/index/Admin/Order/index" target='rightContent'><span>点击查看</span></a></p>
    </div>
</div>
<script type="text/javascript">
    function closes() {
        is_close = 1;
        document.getElementById('ordfoo').style.display = 'none';
    }

    // 没有点击收货确定的按钮让他自己收货确定
    var timestamp = Date.parse(new Date());
    $.ajax({
        type: 'post',
        url: "/index/Admin/System/login_task",
        data: {timestamp: timestamp},
        timeout: 100000000, //超时时间设置，单位毫秒
        success: function () {
            // 执行定时任务
        }
    });
</script>
<!-- 新订单提醒-e -->
</body>
</html>