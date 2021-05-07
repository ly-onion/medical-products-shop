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
                <dt>交易管理</dt>
                <dd><a class="current" href="#">我的收藏</a></dd>
                <dd><a href="#">我的优惠券</a></dd>
                <dd><a href="#">我的到货通知</a></dd>
                <dd><a href="#">我的积分</a></dd>
                <dd><a href="#">我的站内信</a></dd>
                <dd><a href="#">我的反馈</a></dd>
                <dd><a href="#">我的咨询</a></dd>
                <dd><a href="#">我的价格举报</a></dd>
                <dd><a href="#">我的装机配置</a></dd>
            </dl>
            <dl>
                <dt>售后管理</dt>
                <dd><a href="#">在线报修申请</a></dd>
                <dd><a href="#">我的在线报修</a></dd>
            </dl>
            <dl>
                <dt>资料管理</dt>
                <dd><a href="#">个人资料</a></dd>
                <dd><a href="#">收货信息</a></dd>
                <dd><a href="#">登录密码</a></dd>
                <dd><a href="#">邮件订阅</a></dd>
            </dl>
        </div><!--presonalsort end-->

        <div class="f-r presonalinfo">
            <div id="app">
                <!-- Form -->
                <el-form ref="form" :model="form" label-width="80px">
                    <el-form-item label="用户名">
                        <el-input v-model="form.adminId"></el-input>
                    </el-form-item>
                    <el-form-item label="用户名">
                        <el-input v-model="form.address"></el-input>
                    </el-form-item>
                    <el-form-item label="用户名">
                        <el-input v-model="form.height"></el-input>
                    </el-form-item>
                    <el-form-item label="用户名">
                        <el-input v-model="form.weight"></el-input>
                    </el-form-item>
                    <el-form-item label="用户名">
                        <el-input v-model="form.sex"></el-input>
                    </el-form-item>
                    <el-form-item label="用户名">
                        <el-input v-model="form.birthday"></el-input>
                    </el-form-item>
<#--                    <el-form-item label="活动区域">-->
<#--                        <el-select v-model="form.region" placeholder="请选择活动区域">-->
<#--                            <el-option label="区域一" value="shanghai"></el-option>-->
<#--                            <el-option label="区域二" value="beijing"></el-option>-->
<#--                        </el-select>-->
<#--                    </el-form-item>-->
<#--                    <el-form-item label="活动时间">-->
<#--                        <el-col :span="11">-->
<#--                            <el-date-picker type="date" placeholder="选择日期" v-model="form.date1"-->
<#--                                            style="width: 100%;"></el-date-picker>-->
<#--                        </el-col>-->
<#--                        <el-col class="line" :span="2">-</el-col>-->
<#--                        <el-col :span="11">-->
<#--                            <el-time-picker placeholder="选择时间" v-model="form.date2"-->
<#--                                            style="width: 100%;"></el-time-picker>-->
<#--                        </el-col>-->
<#--                    </el-form-item>-->
<#--                    <el-form-item label="即时配送">-->
<#--                        <el-switch v-model="form.delivery"></el-switch>-->
<#--                    </el-form-item>-->
<#--                    <el-form-item label="活动性质">-->
<#--                        <el-checkbox-group v-model="form.type">-->
<#--                            <el-checkbox label="美食/餐厅线上活动" name="type"></el-checkbox>-->
<#--                            <el-checkbox label="地推活动" name="type"></el-checkbox>-->
<#--                            <el-checkbox label="线下主题活动" name="type"></el-checkbox>-->
<#--                            <el-checkbox label="单纯品牌曝光" name="type"></el-checkbox>-->
<#--                        </el-checkbox-group>-->
<#--                    </el-form-item>-->
<#--                    <el-form-item label="特殊资源">-->
<#--                        <el-radio-group v-model="form.resource">-->
<#--                            <el-radio label="线上品牌商赞助"></el-radio>-->
<#--                            <el-radio label="线下场地免费"></el-radio>-->
<#--                        </el-radio-group>-->
<#--                    </el-form-item>-->
<#--                    <el-form-item label="活动形式">-->
<#--                        <el-input type="textarea" v-model="form.desc"></el-input>-->
<#--                    </el-form-item>-->
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">立即创建</el-button>
                        <el-button>取消</el-button>
                    </el-form-item>
                </el-form>
            </div>

            <script>
                var Main = {
                    data() {
                        return {
                            form: {
                                adminId: '${admin.adminId}',
                                address: '咳咳咳呜呜呜',
                                height: '185',
                                weight: '55',
                                sex: '男',
                                birthday: '1254677887',
                                // resource: '',
                                // desc: ''
                            }
                        }
                    },
                    methods: {
                        onSubmit() {
                            $.ajax({
                                type: "POST",
                                url: "${ctx}/userInfo/info",
                                data: this.form,
                                success: function (result){
                                    if (result == 200){
                                        console.log("成功");
                                    }
                                },
                                error: function (result){
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