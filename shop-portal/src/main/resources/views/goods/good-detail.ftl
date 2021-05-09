<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

    <link type="text/css" href="${ctx}/static/css/detail.css" rel="stylesheet"/>

    <div id="s_bdw">
        <div id="s_bd">
            <div class="zadv"><a href="#"><img src="images/3215wa.jpg" width="980" height="62" alt=""/></a></div>

            <div class="breadcrumbs">
                <div class="f-l"><a href="#">全部结果</a><span>»</span><a href="#">食品、饮料、酒水</a><span>»</span><a href="#">进口食品</a><span>»</span>进口米
                </div>
            </div>

            <div class="detail cf">

                <div class="f-l filmslide">

                    <div id="vertical" class="bigImg">
                        <img src="${good.originalImg}" width="380" height="380" alt="" id="midimg"/>
                        <div style="display:none;" id="winSelector"></div>
                    </div><!--bigImg end-->

                    <div class="smallpic">
                        <a title="左移" href="#left" class="abtn aleft agrayleft"></a>
                        <div class="smallscroll" id="imageMenu">
                            <ul>
                                <li id="onlickImg"><img src="${good.originalImg}" width="55" height="55"/></li>
                                <#list imgList as img>
                                <li><img src="${img.imageUrl}" width="55" height="55"/></li>
                                </#list>
                                <#--                                <#list goodImgList as goodImg>-->
                                <#--                                    <li><img src="${goodImg.imgUrl}" width="55" height="55"/></li>-->
                                <#--                                </#list>-->
                            </ul>
                        </div>
                        <a title="右移" href="#right" class="abtn aright"></a>
                    </div>

                    <div id="bigView" style="display: none;"><img width="600" height="600" alt="" src=""/></div>

                </div><!--filmslide end-->

                <script type="text/javascript" src="js/slider.js"></script>
                <script type="text/javascript">
                    $(document).ready(function () {

                        //点击到中图
                        var midChangeHandler = null;
                        $("#imageMenu li img").bind("click",
                            function () {

                                if ($(this).attr("id") != "onlickImg") {
                                    midChange($(this).attr("src").replace("small", "mid"));
                                    $("#imageMenu li").removeAttr("id");
                                    $(this).parent().attr("id", "onlickImg");
                                }
                            }).bind("mouseover",
                            function () {
                                if ($(this).attr("id") != "onlickImg") {
                                    window.clearTimeout(midChangeHandler);
                                    midChange($(this).attr("src").replace("small", "mid"));
                                }
                            }).bind("mouseout", function () {
                            if ($(this).attr("id") != "onlickImg") {
                                $(this).removeAttr("style");
                                midChangeHandler = window.setTimeout(function () {
                                    midChange($("#onlickImg img").attr("src").replace("small", "mid"));
                                }, 1000);

                            }
                        });

                        function midChange(src) {
                            $("#midimg").attr("src", src).load(function () {
                                changeViewImg();
                            });
                        }

                        //大视窗看图
                        function mouseover(e) {
                            if ($("#winSelector").css("display") == "none") {
                                $("#winSelector,#bigView").show();
                            }

                            $("#winSelector").css(fixedPosition(e));
                            e.stopPropagation();
                        }


                        function mouseOut(e) {
                            if ($("#winSelector").css("display") != "none") {
                                $("#winSelector,#bigView").hide();
                            }
                            e.stopPropagation();
                        }


                        $("#midimg").mouseover(mouseover); //中图事件
                        $("#midimg,#winSelector").mousemove(mouseover).mouseout(mouseOut); //选择器事件

                        var $divWidth = $("#winSelector").width(); //选择器宽度
                        var $divHeight = $("#winSelector").height(); //选择器高度
                        var $imgWidth = $("#midimg").width(); //中图宽度
                        var $imgHeight = $("#midimg").height(); //中图高度
                        var $viewImgWidth = $viewImgHeight = $height = null; //IE加载后才能得到 大图宽度 大图高度 大图视窗高度

                        function changeViewImg() {
                            $("#bigView img").attr("src", $("#midimg").attr("src").replace("mid", "big"));
                        }

                        changeViewImg();

                        $("#bigView").scrollLeft(0).scrollTop(0);

                        function fixedPosition(e) {
                            if (e == null) {
                                return;
                            }
                            var $imgLeft = $("#midimg").offset().left; //中图左边距
                            var $imgTop = $("#midimg").offset().top; //中图上边距
                            X = e.pageX - $imgLeft - $divWidth / 2; //selector顶点坐标 X
                            Y = e.pageY - $imgTop - $divHeight / 2; //selector顶点坐标 Y
                            X = X < 0 ? 0 : X;
                            Y = Y < 0 ? 0 : Y;
                            X = X + $divWidth > $imgWidth ? $imgWidth - $divWidth : X;
                            Y = Y + $divHeight > $imgHeight ? $imgHeight - $divHeight : Y;

                            if ($viewImgWidth == null) {
                                $viewImgWidth = $("#bigView img").outerWidth();
                                $viewImgHeight = $("#bigView img").height();
                                if ($viewImgWidth < 200 || $viewImgHeight < 200) {
                                    $viewImgWidth = $viewImgHeight = 800;
                                }
                                $height = $divHeight * $viewImgHeight / $imgHeight;
                                $("#bigView").width($divWidth * $viewImgWidth / $imgWidth);
                                $("#bigView").height($height);
                            }

                            var scrollX = X * $viewImgWidth / $imgWidth;
                            var scrollY = Y * $viewImgHeight / $imgHeight;
                            $("#bigView img").css({"left": scrollX * -1, "top": scrollY * -1});


                            $("#bigView").css({"top": 0, "left": $(".filmslide").width() + 15});

                            return {left: X, top: Y};
                        }

                        $(".smallpic").xslider({
                            unitdisplayed: 5,
                            movelength: 1,
                            unitlen: 68
                        });
                    });
                </script>

                <div class="f-r desummary">
                    <h1>${good.goodsName}</h1>
                    <div class="comtotal"><span class="starpoint"></span><a class="red" href="#">(已经有225人评价)</a></div>
                    <div class="dl01">
                        <span class="f-l">特惠价：<strong class="red">${good.shopPrice}</strong>元</span>
                    </div>
                    <div class="dl02">市场价：
                        <del>${good.marketPrice}</del>
                        元
                    </div>
                    <div>

                        <div id="app" style="margin-top: 50px">
                            <el-input type="hidden" v-model="form.goodsId"></el-input>
                            <el-input-number v-model="form.goodsNum" controls-position="right" @change="handleChange"
                                             :min="1" :max="10"></el-input-number>
                            <br/>
                            <el-button type="success" round @click="addToCart">加入购物车</el-button>
                        </div>
                        <script>
                            var Main = {
                                data() {
                                    return {
                                        form: {
                                            goodsId: '${good.goodsId}',
                                            goodsNum: 1,
                                        }
                                    }
                                },
                                methods: {
                                    addToCart() {
                                        $.ajax({
                                            type: "POST",
                                            url: "${ctx}/cart/addCart",
                                            data: this.form,
                                            success: function (result) {
                                                if (result.code == 200) {
                                                    console.log(result);
                                                } else {
                                                    console.log(result);
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
                    <ul class="dl05">
                        <li><span class="f-l tit">商品编号：</span><span class="f-l">${good.goodsSn}</span></li>
                        <li><span class="f-l tit">品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</span><span
                                    class="f-l">${good.brandId}</span></li>
                        <li><span class="f-l tit">库存数量：</span><span class="f-l">${good.storeCount}</span></li>
                    </ul>
                </div><!--desummary end-->

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
                        add: function (obj) {
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

                <div class="clear"></div>

                <script type="text/javascript">
                    $(function () {
                        $(".dtsummary").switchTab({
                            titCell: "dt a",
                            trigger: "click",
                            titOnClassName: "current",
                            delayTime: 0
                        });
                    })
                </script>
                <div class="dtsummary">
                    <dl>
                        <dt>
                            <a class="current" href="javascript:void(0);"><span>产品介绍</span></a>
                            <a href="javascript:void(0);"><span>规格参数</span></a>
                            <a href="javascript:void(0);"><span>保修条款</span></a>
                            <a href="javascript:void(0);"><span>包装清单</span></a>
                        </dt>
                        <dd>
                            <ul class="dtpro cf">
                                <li>商品名称：九阳营养王系列豆浆机 DJ14B-D06</li>
                                <li>品牌：九阳</li>
                                <li>规格：DJ14B-D06</li>
                                <li>重量：3.3kg</li>
                                <li>上架时间：2010-06-13</li>
                            </ul>
                            <div class="dtprodis">
                                <img src="images/32asd.jpg" width="797" height="298" alt=""/>
                            </div>
                            <div class="dtbq">
                                <h3>品牌介绍</h3>
                                <p>九阳公司在健康饮食电器领域不断发展九阳公司在健康饮食电器领域不断发展九阳公司在健康饮食电器领域不断发展</p>
                            </div>
                            <div class="dtbq">
                                <h3>服务承诺：</h3>
                                <p>九阳公司在健康饮食电器领域不断发展九阳公司在健康饮食电器领域不断发展九阳公司在健康饮食电器领域不断发展</p>
                            </div>
                            <div class="dtbq">
                                <h3>温馨提示：</h3>
                                <p>九阳公司在健康饮食电器领域不断发展九阳公司在健康饮食电器领域不断发展九阳公司在健康饮食电器领域不断发展</p>
                            </div>
                        </dd>
                        <dd>
                            暂无规格参数，我们将尽快联系厂商提供进一步的明细信息。
                        </dd>
                        <dd>
                            由于厂商产品批次不同，具体包装清单可能各有不同，请以实物为准 ！
                        </dd>
                        <dd>
                            我们保证商品的进货渠道和质量，如果客户在使用时遭遇质量问题，我们会按照国家法律规定予以处理。
                        </dd>
                    </dl>
                </div><!--dtsummary end-->
                <script type="text/javascript">
                    $(function () {
                        $("#mydiscuss").switchTab({
                            titCell: "dt a",
                            trigger: "click",
                            mainCell: ".discusstabcon",
                            titOnClassName: "current",
                            delayTime: 0
                        });
                    })
                </script>
                <script type="text/javascript">
                    $(function () {
                        $(".afq").switchTab({
                            titCell: "dt a",
                            trigger: "click",
                            mainCell: ".discusstabcon",
                            titOnClassName: "current",
                            delayTime: 0
                        });
                    })
                </script>
            </div><!--detail end-->
        </div><!--s_bd end-->
    </div><!--s_bdw end-->

</div>
</body>
</html>
