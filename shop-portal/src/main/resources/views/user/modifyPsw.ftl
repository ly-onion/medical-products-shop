<#-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <#include "../head.ftl">

</head>
<body class="skin-green-light sidebar-mini" style="overflow-y:hidden;">
<div>
    <#include "../common/welcome.ftl">
    <div class="s_hd nav">
        <div id="s_logo"><a href="#"><img src="${ctx}/static/images/logo.png" border="0"/></a></div>
    </div><!--s_hd end-->
    <div class="mmenu">
        <div class="s_hd">

            <#include "../common/search.ftl">

            <#include "../common/cart.ftl">

            <div id="s_cartbox" class="s_cartbox">您的购物车中暂无商品，赶快选择心爱的商品吧！</div>

            <script type="text/javascript">
                $(document).ready(function () {
                    $("#s_cats").hoverClass("current");
                });
            </script>
            <#include "../common/goodsCategory.ftl">

            <div id="s_cats">
                <div class="cat_hd"><h3><a href="#">所有商品分类</a></h3></div>
                <div class="cat_bd">
                    <ul id="goodsCategoryContent">

                    </ul>
                    <!--<div class="all_cats"><a href="#" class="more">全部商品分类</a></div>-->
                </div>
            </div>
        </div>
    </div><!--mmenu end-->
</div>
<link type="text/css" href="${ctx}/static/css/my.css" rel="stylesheet"/>

<div id="s_bdw">
    <div id="s_bd">

        <div style="margin:10px 0 0 0;"></div>

        <div class="breadcrumbs">
            <div class="f-l"><a href="${ctx}">首页</a><span>»</span><a href="#">我的EGO</a><span>»</span>我的订单</div>
        </div>

        <div class="f-l presonalsort">
            <dl>
                <dt>资料管理</dt>
                <dd><a href="${ctx}/userInfo/user">个人资料</a></dd>
                <dd><a href="${ctx}/myOrder">我的订单</a></dd>
                <dd><a href="${ctx}/userInfo/modifyPsw">修改密码</a></dd>
                <dd><a href="#">邮件订阅</a></dd>
            </dl>
        </div><!--presonalsort end-->

        <div class="f-r presonalinfo">
            <div id="app">
                <!-- Form -->
                <el-form ref="form" :model="form" label-width="80px">
                    <el-form-item label="旧密码">
                        <el-input type="password" v-model="form.oldPassword"></el-input>
                    </el-form-item>
                    <el-form-item label="新密码">
                        <el-input type="password" v-model="form.newPassword"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">立即创建</el-button>
                    </el-form-item>
                </el-form>
            </div>

            <script>
                var Main = {
                    data() {
                        return {
                            form: {
                                oldPassword: '',
                                newPassword: '',
                            }
                        }
                    },
                    methods: {

                        onSubmit() {
                            var mess = this;
                            $.ajax({
                                type: "POST",
                                url: "${ctx}/userInfo/savePsw",
                                data: this.form,
                                success: function (result) {
                                    if (result.code == 200){
                                        mess.$message('修改成功，请重新登录');
                                        let xhr = new XMLHttpRequest();
                                        xhr.open('GET', '${ctx}/user/logout', true);
                                        xhr.send();
                                        window.location.href="${ctx}/login";
                                    }else {
                                        mess.$message('旧密码输入错误，请重新输入');
                                    }
                                },
                                error: function (result) {
                                    console.log(result);
                                }
                            });
                        }
                    }
                };
                var Ctor = Vue.extend(Main)
                new Ctor().$mount('#app')
            </script>

        </div>
    </div><!--presonalinfo end-->

    <div class="clear"></div>

</div><!--s_bd end-->
</div><!--s_bdw end-->

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