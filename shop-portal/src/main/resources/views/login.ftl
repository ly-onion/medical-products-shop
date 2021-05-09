<#-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <#include "head.ftl">
    <script type="text/javascript">
        var timeout = 500;
        var closetimer = 0;
        var ddmenuitem = 0;

        $(document).ready(function () {
            $('.cat_item').mousemove(function () {
                $(this).addClass('cat_item_on');
            });
            $('.cat_item').mouseleave(function () {
                $(this).removeClass('cat_item_on');
            });
            $('#slideshow').imgSlideShow({itemclass: 'i'})
            $("#slide-qg").switchTab({titCell: "dt a", trigger: "mouseover", delayTime: 0});
            $("#s_cart_nums1").hover(function () {
                mcancelclosetime();
                if (ddmenuitem) ddmenuitem.hide();
                ddmenuitem = $(document).find("#s_cartbox");
                ddmenuitem.fadeIn();
            }, function () {
                mclosetime();
            });
            $("#s_cart_nums2").hover(function () {
                mcancelclosetime();
                if (ddmenuitem) ddmenuitem.hide();
                ddmenuitem = $(document).find("#s_cartbox");
                ddmenuitem.fadeIn();
            }, function () {
                mclosetime();
            });
            $("#s_cartbox").hover(function () {
                mcancelclosetime();
            }, function () {
                mclosetime();
            });
            var $cur = 1;
            var $i = 4;
            var $len = $('.hot_list>ul>li').length;
            var $pages = Math.ceil($len / $i);
            var $w = $('.hotp').width() - 66;

            var $showbox = $('.hot_list');

            var $pre = $('div.left_icon');
            var $next = $('div.rgt_icon');

            $pre.click(function () {
                if (!$showbox.is(':animated')) {
                    if ($cur == 1) {
                        $showbox.animate({
                            left: '-=' + $w * ($pages - 1)
                        }, 500);
                        $cur = $pages;
                    } else {
                        $showbox.animate({
                            left: '+=' + $w
                        }, 500);
                        $cur--;
                    }

                }
            });

            $next.click(function () {
                if (!$showbox.is(':animated')) {
                    if ($cur == $pages) {
                        $showbox.animate({
                            left: 0
                        }, 500);
                        $cur = 1;
                    } else {
                        $showbox.animate({
                            left: '-=' + $w
                        }, 500);
                        $cur++;
                    }

                }
            });

        });

        function mclose() {
            if (ddmenuitem) ddmenuitem.hide();
        }

        function mclosetime() {
            closetimer = window.setTimeout(mclose, timeout);
        }

        function mcancelclosetime() {
            if (closetimer) {
                window.clearTimeout(closetimer);
                closetimer = null;
            }
        }
    </script>
</head>

<body>
<div id="doc">
    <div id="s_hdw">

        <#include "common/welcome.ftl">

        <div class="s_hd nav">
            <div id="s_logo"><a href="#"><img src="${ctx}/static/images/logo.png" border="0"/></a></div>
            <div id="s_nav">
                <ul>
                    <li class="first cur"><a href="#">首页</a><span></span></li>
                    <li><a href="#">积分兑换</a><span></span></li>
                    <li><a href="#">抢购</a><span></span></li>
                    <li class="last"><a href="#">礼品</a><span></span></li>
                </ul>
            </div>
        </div><!--s_hd end-->

        <div class="mmenu">
            <div class="s_hd">
                <#include "common/search.ftl">

                <div id="s_cartbox" class="s_cartbox">您的购物车中暂无商品，赶快选择心爱的商品吧！</div>

                <script type="text/javascript">
                    $(document).ready(function () {
                        $("#s_cats").hoverClass("current");
                    });
                </script>

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

    </div><!--s_hdw end-->

    <link type="text/css" href="${ctx}/static/css/lr.css" rel="stylesheet"/>

    <div id="s_bdw">
        <div id="s_bd">

            <div class="dl_zc">
                <div class="dl_zc_title">
                    <h2 class="f_l">用户登录</h2>
                    <div class="rt_bg f_r"></div>
                </div>
                <div class="dl-con cf" id="entry">
                    <form id="formlogin" method="post" onsubmit="return false;">

                        <div class="form" style="width:600px;">
                            <div class="item">
                                <span class="label">用户名：</span>

                                <div class="fl">
                                    <input type="text" id="loginname" name="userName" class="text" tabindex="1"
                                           value=""/>
                                    <label id="loginname_succeed" class="blank invisible"></label>
                                    <span class="clear"></span>
                                    <label id="loginname_error"></label>

                                </div>
                            </div>
                            <!--item end-->
                            <div class="item">
                                <span class="label">密码：</span>

                                <div class="fl">
                                    <input type="password" id="loginpwd" name="password" class="text" tabindex="2"/>
                                    <label id="loginpwd_succeed" class="blank invisible"></label>

                                    <label><a href="forgot-password.html" class="blue">忘记密码?</a></label>
                                    <span class="clear"></span>
                                    <label id="loginpwd_error"></label>
                                </div>
                            </div>
                            <!--item end-->
                            <div class="item">
                                <span class="label">&nbsp;</span>
                                <div class="fl">
                                    <input type="checkbox" name="dl" id="jz" value=""/><label for="jz">记住用户名</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
                                            type="checkbox" name="dl" id="zd" value=""/><label for="zd">自动登录</label>
                                </div>
                            </div><!--item end-->
                            <div class="item">
                                <span class="label">&nbsp;</span>
                                <input type="button" onclick="userLogin();" class="btnimg" id="loginsubmit" value=""
                                       tabindex="8"/>
                            </div>
                        </div>
                        <!--form end-->
                        <div id="guide">
                            <h5>还不是Ego商城用户？</h5>

                            <div class="content">现在免费注册成为Ego商城用户，便能立刻享受便宜又放心的购物乐趣。</div>
                            <a href="register.php" class="btn-personal">注册新用户</a>

                        </div>
                        <!--guide end-->
                        <div class="clear"></div>
                    </form>
                </div><!--regist end-->
            </div> <!--dl_zc end-->

            <script type="text/javascript" src="${ctx}/static/js/Validate.js"></script>
            <script type="text/javascript" src="${ctx}/static/js/Validate.entry.js"></script>

        </div><!--s_bd end-->
    </div><!--s_bdw end-->

    <div id="s_ftw">

        <div class="ft_quicklinks">
            <div class="ftql cf">
                <ul>
                    <li class="ftql_s">
                        <h3>购物指南</h3>
                        <ul>
                            <li><a href="">怎样购物</a></li>
                            <li><a href="">会员制</a></li>
                            <li><a href="">积分制度</a></li>
                            <li><a href="">优惠券介绍</a></li>
                            <li><a href="">订单状态说明</a></li>
                        </ul>
                    </li>
                    <li class="ftql_s">
                        <h3>服务条款</h3>
                        <ul>
                            <li><a href="">售后条款</a></li>
                            <li><a href="">退换货说明</a></li>
                            <li><a href="">联系客服</a></li>
                        </ul>
                    </li>
                    <li class="ftql_s">
                        <h3>配送方式</h3>
                        <ul>
                            <li><a href="">上门自提</a></li>
                            <li><a href="">快递运输</a></li>
                            <li><a href="">特快专递（EMS）</a></li>
                            <li><a href="">如何送礼</a></li>
                        </ul>
                    </li>
                    <li class="ftql_s">
                        <h3>支付帮助</h3>
                        <ul>
                            <li><a href="">货到付款</a></li>
                            <li><a href="">在线支付</a></li>
                            <li><a href="">邮政汇款</a></li>
                            <li><a href="">银行转账</a></li>
                            <li><a href="">发票说明</a></li>
                        </ul>
                    </li>
                    <li class="ftql_s">
                        <h3>关于EGO商城</h3>
                        <ul>
                            <li><a href="">EGO商城介绍</a></li>
                            <li><a href="">团队</a></li>
                            <li><a href="">媒体报道</a></li>
                            <li><a href="">招纳贤士</a></li>
                            <li><a href="">公告</a></li>
                        </ul>
                    </li>
                    <li class="ftql_s">
                        <div class="ftql_d">
                            <div class="str">客服中心信箱：</div>
                            <div class="val"><a href="mailto:service@shunkelong.com">sxt@bjsxt.com</a></div>
                        </div>
                        <div class="ftql_d">
                            <div class="str">客服中心热线：</div>
                            <div class="val stel">400-009-1906</div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <div id="s_ft">
            <div class="ft_suggest pt100">请帮助我们提高！<a href="#">商城首页意见反馈</a></div>
            <div class="ft_banners1 tac pbt10">
                <ul>
                    <li><a href="#"><img src="${ctx}/static/images/ft_1.gif" border="0"/></a></li>
                    <li><a href="#"><img src="${ctx}/static/images/ft_2.gif" border="0"/></a></li>
                    <li><a href="#"><img src="${ctx}/static/images/ft_3.gif" border="0"/></a></li>
                </ul>
            </div>
            <div class="copyright tac pbt10">版权所有 Copyright&copy; EGO商城 All Rights Reserved 版权所有</div>
            <div class="ft_banners2 tac">
                <ul>
                    <li><a href="#"><img src="${ctx}/static/images/u255.png" border="0"/></a></li>
                    <li><a href="#"><img src="${ctx}/static/images/u257.png" border="0"/></a></li>
                    <li><a href="#"><img src="${ctx}/static/images/u259.png" border="0"/></a></li>
                    <li><a href="#"><img src="${ctx}/static/images/u261.png" border="0"/></a></li>
                </ul>
            </div>
        </div>

    </div><!--s_ftw end-->

</div>
<script type="text/javascript">
    // 用户登录
    function userLogin() {
        $.ajax({
            url: "${ctx}/user/login",
            type: "POST",
            data: $("#formlogin").serialize(),
            dataType: "JSON",
            success: function (result) {
                if (200 == result.code) {
                    location.href = "${ctx}/index";
                } else {
                    layer.msg("用户名或密码错误，请重新输入！");
                }
            },
            error: function () {
                layer.alert("login POST 亲，系统正在升级中，请稍后再试！");
            }
        });
    }
</script>
<#include "common/goodsCategory.ftl">
</body>
</html>
