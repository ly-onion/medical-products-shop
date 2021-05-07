<#-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <#include "../head.ftl">
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

    <link type="text/css" href="${ctx}/static/css/info.css" rel="stylesheet"/>

    <div id="s_bdw">
        <div id="s_bd">

            <div class="stepflow"><img src="${ctx}/static/images/step01.gif" width="980" height="32" alt=""/></div>

            <div class="addinfo">
                <a href="javascript:history.go(-1);">返回继续购物</a>
            </div><!--addinfo end-->

            <script type="text/javascript">
                function clearCart(){
                    $.ajax({
                        url: "${ctx}/cart/clearCart",
                        type: "Get",
                        dataType: "JSON",
                        success: function (result) {
                            location.reload();
                        },
                        error: function (result) {
                            layer.alert("亲，系统正在升级中，请稍后再试！");
                        }
                    });
                }

                function deleteGoods(goodsId){
                    $.ajax({
                        url: "${ctx}/cart/deleteCartGood",
                        type: "Get",
                        data: {
                            goodsId: goodsId
                        },
                        dataType: "JSON",
                        success: function (result){
                            if (200 == result.code) {
                                location.reload();
                        }
                        },
                        error: function (result) {
                            console.log(result);
                            // status=200 statusText="OK"说明请求正常，无返回结果
                            if (200 == result.status) {
                                // 跳转登录页面
                                location.href = "${ctx}/login";
                            } else {
                                // 系统真的出错了
                                layer.alert("亲，系统正在升级中，请稍后再试！");
                            }
                        }
                    });
                }
            </script>

            <div class="cartlist">
                <form method="post" action="${ctx}/order/toPreOrder">
                    <table width="100%">
                        <tr>
                            <th>购物车中的商品</th>
                            <th>EGO价</th>
                            <th>购买数量</th>
                            <th>订单时间</th>
                            <th>操作</th>
                        </tr>
                        <#if (cartResult.cartList)??>
                            <#list cartResult.cartList as cart>
                                <tr bgcolor="#fffaf1">
                                    <td>
                                        <a href="#"><img class="smallpic" src="${cart.originalImg}" width="80"
                                                         height="80"/></a>
                                        <a href="#">${cart.goodsName}</a>
                                    </td>
                                    <td><strong class="red">￥${cart.marketPrice}</strong></td>
                                    <td>
                                        <div class="addinput">
                                            <input type="text" name="qty_item_${cart_index}" value="${cart.goodsNum}" id="qty_item_${cart_index}"
                                                   onKeyUp="setAmount.modify('#qty_item_${cart_index}')" class="stext"/>
                                            <a class="add" onClick="setAmount.add('#qty_item_${cart_index}');addToCart('${cart.goodsId}','${cart.goodsName}'
                                                    ,'${cart.marketPrice?c}','${cart.originalImg}','1');"
                                               href="javascript:void(0)"></a>
                                            <a class="reduce" onClick="setAmount.reduce('#qty_item_${cart_index}');addToCart('${cart.goodsId}','${cart.goodsName}'
                                                    ,'${cart.marketPrice?c}','${cart.originalImg}','-1')"
                                               href="javascript:void(0)"></a>
                                        </div>
                                    </td>

                                    <td>${cart.addTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                                    <td><a href="javascript:void(0)" onclick="deleteGoods(${cart.goodsId})" class="blue">删除</a></td>
                                </tr>
                            </#list>
                        </#if>


                        <tr>
                            <td valign="top"><a onclick="clearCart()" href="javascript:void(0)"><img src="${ctx}/static/images/deleteicon.gif"/> 清空购物车</a></td>
                            <td align="right" colspan="5">
                                <p>共<span id="cart_num" style="color: red"><#if (cartResult.cartList)??>${cartResult
                                        .cartList?size}</#if></span>件商品</p>
                                <p style="margin-top:10px;font-size:14px;">
                                    <strong style="font-size:18px;color:#d80000;">￥<span
                                                id="total_price">${(cartResult.totalPrice)!'0.00'}</span></strong></p>
                            </td>
                        </tr>
                        <tr>
                            <td style="border:none;padding-top:20px;" colspan="6">
                                <input type="submit" value="" id="" class="btnimg f-r"/>
                                <a class="f-r goonbtn" href="javascript:history.go(-1);">
                                    <img src="${ctx}/static/images/gooncat.gif" width="86" height="24" alt=""/>
                                </a>
                            </td>
                        </tr>
                    </table>
                </form>
            </div><!--cartlist end-->

            <script type="text/javascript">
                /* reduce_add */
                var setAmount = {
                    min: 1,
                    max: 999,
                    reg: function (x) {
                        return new RegExp("^[1-9]\\d*$").test(x);
                    },
                    amount: function (obj, mode) {
                        var x = $(obj).val();
                        if (this.reg(x)) {
                            if (mode) {
                                x++;
                            } else {
                                x--;
                            }
                        } else {
                            alert("请输入正确的数量！");
                            $(obj).val(1);
                            $(obj).focus();
                        }
                        return x;
                    },
                    reduce: function (obj) {
                        var x = this.amount(obj, false);
                        if (x >= this.min) {
                            $(obj).val(x);
                        } else {
                            alert("商品数量最少为" + this.min);
                            $(obj).val(1);
                            $(obj).focus();
                        }
                    },
                    add: function (obj, ) {
                        var x = this.amount(obj, true);
                        if (x <= this.max) {
                            $(obj).val(x);
                        } else {
                            alert("商品数量最多为" + this.max);
                            $(obj).val(999);
                            $(obj).focus();
                        }
                    },
                    modify: function (obj) {
                        var x = $(obj).val();
                        if (x < this.min || x > this.max || !this.reg(x)) {
                            alert("请输入正确的数量！");
                            $(obj).val(1);
                            $(obj).focus();
                        }
                    }
                }
            </script>

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
<!-- 编写模板 -->
<script type="template" id="goodsCategoryTemplate">
    {{ for(var i = 0; i < it.length; i++){ }}
    <li class="cat_item">
        <h4 class="cat_tit"><a href="#" class="cat_tit_link">{{=it[i].name}}</a><span
                    class="s_arrow">></span></h4>
        <div class="cat_cont">
            <div class="cat_cont_lft">
                {{ for(var j = 0; j < it[i].children.length; j++){ }}
                <dl class="cf">
                    <dt><a href="#">{{=it[i].children[j].name}}</a></dt>
                    <dd>
                        <ul>
                            {{ for(var k = 0; k < it[i].children[j].children.length; k++){
                            }}
                            <li class="first"><a href="#">
                                    {{=it[i].children[j].children[k].name}}</a></li>
                            {{ } }}
                        </ul>
                    </dd>
                </dl>
                {{ } }}
                <dl class="cf">
                    <dt><a href="#">进入该频道</a></dt>
                    <dd></dd>
                </dl>
            </div>
            <div class="cat_cont_rgt">
                <dl>
                    <dt>推荐品牌</dt>
                    <dd>
                        <ul>
                            <li><a href="#">奥利奥</a></li>
                            <li><a href="#">光明</a></li>
                            <li><a href="#">金龙鱼</a></li>
                            <li><a href="#">立顿</a></li>
                            <li><a href="#">咏萄 Everwines</a></li>
                            <li><a href="#">阿明</a></li>
                            <li><a href="#">康师傅</a></li>
                            <li><a href="#">蒙牛</a></li>
                            <li><a href="#">伊利</a></li>
                            <li><a href="#">可口可乐</a></li>
                            <li><a href="#">雀巢</a></li>
                            <li><a href="#">统一</a></li>
                            <li><a href="#">福临门</a></li>
                        </ul>
                    </dd>
                </dl>
                <dl>
                    <dt>促销专题</dt>
                    <dd>
                        <ul>
                            <li><a href="#">饼干糕点10.8元任选3</a></li>
                            <li><a href="#">阳澄湖大闸蟹立省百元</a></li>
                            <li><a href="#">清新水果季 全场上海</a></li>
                        </ul>
                    </dd>
                </dl>
            </div>
        </div>
    </li>
    {{ } }}
</script>
<script type="text/javascript">
    // 进入页面获取商品分类列表
    $(function () {
        selectGoodsCategoryList();
    });

    // 获取商品分类列表
    function selectGoodsCategoryList() {
        $.ajax({
            url: "${ctx}/goodsCategory/list",
            type: "GET",
            dataType: "JSON",
            success: function (result) {
                if (result.length > 0) {
// 调用模板
                    var templ = doT.template($("#goodsCategoryTemplate").text());
// 填充内容
                    $("#goodsCategoryContent").html(templ(result));
                    /* ----------鼠标移入移出事件---begin------- */
                    $('.cat_item').mousemove(function () {
                        $(this).addClass('cat_item_on');
                    });
                    $('.cat_item').mouseleave(function () {
                        $(this).removeClass('cat_item_on');
                    });
                    /* ----------鼠标移入移出事件-----end------- */
                } else {
                    layer.msg("亲，系统正在升级中，请稍后再试！");
                }
            },
            error: function (result) {
                console.log(result);
                layer.msg("亲，系统正在升级中，请稍后再试！");
            }
        });
    }
</script>
<#--<script>-->
<#--    function addToCart(goodsId, goodsName, marketPrice, originalImg, goodsNum=1) {-->
<#--        $.ajax({-->
<#--            url: "${ctx}/cart/addCart",-->
<#--            type: "POST",-->
<#--            data: {-->
<#--                goodsId: goodsId,-->
<#--                goodsName: goodsName,-->
<#--                marketPrice: marketPrice,-->
<#--                originalImg: originalImg,-->
<#--                goodsNum: goodsNum-->
<#--            },-->
<#--            // contentType: 'application/json',-->
<#--            dataType: "JSON",-->
<#--            success: function (result) {-->
<#--                if (200 == result.code) {-->
<#--                    var num = parseInt($("#s_cart_nums1").text());-->
<#--                    $("#s_cart_nums1").text(num + 1);-->
<#--                    // layer.msg("添加至购物车成功");-->
<#--                }-->
<#--            },-->
<#--            error: function (result) {-->
<#--                console.log(result);-->
<#--                // status=200 statusText="OK"说明请求正常，无返回结果-->
<#--                if (200 == result.status) {-->
<#--                    // 跳转登录页面-->
<#--                    location.href = "${ctx}/login";-->
<#--                } else {-->
<#--                    // 系统真的出错了-->
<#--                    layer.alert("亲，系统正在升级中，请稍后再试！");-->
<#--                }-->
<#--            }-->
<#--        });-->
<#--    }-->
<#--</script>-->

</body>
</html>
