<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<#include "../head.ftl">
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
	
	<link type="text/css" href="css/detail.css" rel="stylesheet" />
	
	<div id="s_bdw">
		<div id="s_bd">
			<div class="zadv"><a href="#"><img src="images/3215wa.jpg" width="980" height="62" alt="" /></a></div>
			
			<div class="breadcrumbs">
				<div class="f-l"><a href="#">全部结果</a><span>»</span><a href="#">食品、饮料、酒水</a><span>»</span><a href="#">进口食品</a><span>»</span>进口米</div>
			</div>
			
			<div class="detail cf">
				
				<div class="f-l filmslide">

					<div id="vertical" class="bigImg">
						<img src="images/mid/12da.jpg" width="380" height="380" alt="" id="midimg" />
						<div style="display:none;" id="winSelector"></div>
					</div><!--bigImg end-->
					
					<div class="smallpic">
						<a title="左移" href="#left" class="abtn aleft agrayleft"></a>
						<div class="smallscroll" id="imageMenu">
							<ul>
								<li id="onlickImg"><img src="images/small/12da.jpg" /></li>
								<li><img src="images/small/12da.jpg" /></li>
								<li><img src="images/small/12da.jpg" /></li>
								<li><img src="images/small/12da.jpg" /></li>
								<li><img src="images/small/12da.jpg" /></li>
								<li><img src="images/small/12da.jpg" /></li>
								<li><img src="images/small/12da.jpg" /></li>
							</ul>
						</div>
						<a title="右移" href="#right" class="abtn aright"></a>
					</div>
					
					<div id="bigView" style="display: none;"><img width="600" height="600" alt="" src=""/></div>
					
					<div class="sharecon"><a class="kaixin" href="#">分享到开心网</a><a class="xinlang" href="#">分享到新浪微博</a><a class="tengxun" href="#">转播到微博</a></div>
					
				</div><!--filmslide end-->
				
				<script type="text/javascript" src="js/slider.js"></script>
				<script type="text/javascript">
				$(document).ready(function(){
					
					//点击到中图
					var midChangeHandler = null;
					$("#imageMenu li img").bind("click",
						function() {
				
							if ($(this).attr("id") != "onlickImg") {
								midChange($(this).attr("src").replace("small", "mid"));
								$("#imageMenu li").removeAttr("id");
								$(this).parent().attr("id", "onlickImg");
							}
						}).bind("mouseover",
						function() {
							if ($(this).attr("id") != "onlickImg") {
								window.clearTimeout(midChangeHandler);
								midChange($(this).attr("src").replace("small", "mid"));
							}
						}).bind("mouseout", function() {
							if ($(this).attr("id") != "onlickImg") {
								$(this).removeAttr("style");
								midChangeHandler = window.setTimeout(function() {
									midChange($("#onlickImg img").attr("src").replace("small", "mid"));
								}, 1000);
				
							}
						});
				
					function midChange(src) {
						$("#midimg").attr("src", src).load(function() {
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
						$("#bigView img").css({ "left": scrollX * -1, "top": scrollY * -1 });
				
				
						$("#bigView").css({ "top": 0, "left":$(".filmslide").width()+15 });
				
						return { left: X, top: Y };
					}
					
					$(".smallpic").xslider({
						unitdisplayed:5,
						movelength:1,
						unitlen:68
					});
				});
				</script>
				
				<div class="f-r desummary">
					<h1>九阳 营养王系列豆浆机 DJ14B-D06</h1>
					<div class="comtotal"><span class="starpoint"></span><a class="red" href="#">(已经有225人评价)</a></div>
					<div class="dl01"><span class="f-l">EGO价：<strong class="red">399</strong>元</span><a title="降价通知" class="downtip" href="#"></a><span class="f-l projf">购买该商品，可获得 <b class="red">310</b> 积分！ <a class="more" href="#">了解积分制度>></a></span></div>
					<div class="dl02">市场价：<del>559</del>元<br />提示：特价商品，不能使用优惠券</div>
					<div class="dl03">
						<div class="addnum">
							<span class="f-l">我要买</span>
							<div class="f-l numinput">
								<a class="reduce" onClick="setAmount.reduce('#qty_item_1')" href="javascript:void(0)"></a>
                        		<input type="text" name="qty_item_1" value="1" id="qty_item_1" onKeyUp="setAmount.modify('#qty_item_1')" class="stext"/>
                        		<a class="add" onClick="setAmount.add('#qty_item_1')" href="javascript:void(0)"></a>
							</div>
							<span class="f-l">限购1件</span>
						</div>
						<div class="addbtn">
							<input type="submit" name="" value="" id="" class="catbtnimg" /><span class="f-l"><a href="#">收藏</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">价格举报</a></span>
						</div>
					</div>
					<div class="dl04">
						<table>
							<tr>
								<th>批发数量</th><th>批发价格</th>
							</tr>
							<tr>
								<td>2-5</td><td><b class="yellow">140.59</b>(5%)</td>
							</tr>
							<tr>
								<td>2-5</td><td><b class="yellow">140.59</b>(5%)</td>
							</tr>
							<tr>
								<td>2-5</td><td><b class="yellow">140.59</b>(5%)</td>
							</tr>
						</table>
					</div>
					<ul class="dl05">
						<li><span class="f-l tit">商品编号：</span><span class="f-l">0009999706</span></li>
						<li><span class="f-l tit">品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</span><span class="f-l">九阳</span></li>
						<li><span class="f-l tit">规&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格：</span><span class="f-l">DJ12B-A11</span></li>
						<li><span class="f-l tit">库存状态：</span><span class="f-l">有货，可当日出货</span></li>
						<li><span class="f-l tit">配送限制：</span><span class="f-l">无限制 <a class="more" href="#">运费详情>></a></span></li>
					</ul>
					<div class="dl06">
						<dl class="hg"><dt></dt><dd>EGO(除服装鞋帽)全场单笔消费满1元，即可换购以下赠品，赠完为止，多买多享</dd></dl>
						<div class="hgscrollbox">
							<a title="左移" href="#left" class="abtn aleft agrayleft"></a>
							<div class="hgscrollpic">
								<ul>
									<li>
										<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
										<dl>
											<dt><a href="#">香港念庵堂西...</a></dt>
											<dd><del>￥23.8</del></dd>
											<dd><strong>数量:<span class="red">1</span>个</strong></dd>
											<dd><strong class="red">换购价：￥9.9</strong></dd>
											<dd><a class="ljbtn" href="#"></a></dd>
										</dl>
									</li>
									<li>
										<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
										<dl>
											<dt><a href="#">香港念庵堂西...</a></dt>
											<dd><del>￥23.8</del></dd>
											<dd><strong>数量:<span class="red">1</span>个</strong></dd>
											<dd><strong class="red">换购价：￥9.9</strong></dd>
											<dd><a class="ljbtn" href="#"></a></dd>
										</dl>
									</li>
									<li>
										<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
										<dl>
											<dt><a href="#">香港念庵堂西...</a></dt>
											<dd><del>￥23.8</del></dd>
											<dd><strong>数量:<span class="red">1</span>个</strong></dd>
											<dd><strong class="red">换购价：￥9.9</strong></dd>
											<dd><a class="ljbtn" href="#"></a></dd>
										</dl>
									</li>
								</ul>
							</div>
							<a title="右移" href="#right" class="abtn aright"></a>
						</div>
						
						<script type="text/javascript">
						$(function(){
							$(".hgscrollbox").xslider({
								unitdisplayed:2,
								movelength:1,
								unitlen:260
							});
						})
						</script>
						
					</div>
				</div><!--desummary end-->
				
				<script type="text/javascript">
				/* reduce_add */
				var setAmount = {
					min:1,
					max:999,
					reg:function(x) {
						return new RegExp("^[1-9]\\d*$").test(x);
					},
					amount:function(obj, mode) {
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
					reduce:function(obj) {
						var x = this.amount(obj, false);
						if (x >= this.min) {
							$(obj).val(x);
						} else {
							alert("商品数量最少为" + this.min);
							$(obj).val(1);
							$(obj).focus();
						}
					},
					add:function(obj) {
						var x = this.amount(obj, true);
						if (x <= this.max) {
							$(obj).val(x);
						} else {
							alert("商品数量最多为" + this.max);
							$(obj).val(999);
							$(obj).focus();
						}
					},
					modify:function(obj) {
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
				
				<div class="setmeal">
					<dl class="setmealtab">
						<dt><a class="current" href="javascript:void(0);">优惠套餐</a></dt>
						<dd class="cf">
							<div class="f-l setmeallist cf">
								<div class="setmeallistbox">
									<table>
										<tr>
											<td>
												<div class="setmealpic">
													<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
													<p><a href="#">九阳营养王系列豆浆机DJ14B-D06</a></p>
													<p>数量<strong class="red">1</strong></p>
												</div>
											</td>
											<td valign="top"><div class="addicon"></div></td>
											<td>
												<div class="setmealpic">
													<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
													<p><a href="#">九阳营养王系列豆浆机DJ14B-D06</a></p>
													<p>数量<strong class="red">1</strong></p>
												</div>
											</td>
											<td valign="top"><div class="addicon"></div></td>
											<td>
												<div class="setmealpic">
													<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
													<p><a href="#">九阳营养王系列豆浆机DJ14B-D06</a></p>
													<p>数量<strong class="red">1</strong></p>
												</div>
											</td>
											<td valign="top"><div class="addicon"></div></td>
											<td>
												<div class="setmealpic">
													<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
													<p><a href="#">九阳营养王系列豆浆机DJ14B-D06</a></p>
													<p>数量<strong class="red">1</strong></p>
												</div>
											</td>
											<td valign="top"><div class="addicon"></div></td>
											<td>
												<div class="setmealpic">
													<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
													<p><a href="#">九阳营养王系列豆浆机DJ14B-D06</a></p>
													<p>数量<strong class="red">1</strong></p>
												</div>
											</td>
											<td valign="top"><div class="addicon"></div></td>
											<td>
												<div class="setmealpic">
													<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
													<p><a href="#">九阳营养王系列豆浆机DJ14B-D06</a></p>
													<p>数量<strong class="red">1</strong></p>
												</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
							
							<div class="f-r setmealldis">
								<h3>优惠套餐1</h3>
								<p>套装价：<strong class="yellow">￥598</strong></p>
								<a class="setmeallbtn" href="#">购买优惠套餐</a>
							</div>
						</dd>
					</dl>
				</div><!--setmeal end-->
				
				<script type="text/javascript">
				$(function(){
					$(".dtsummary").switchTab({titCell: "dt a", trigger: "click", titOnClassName: "current", delayTime: 0});
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
								<img src="images/32asd.jpg" width="797" height="298" alt="" />
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
				$(function(){
					$("#mydiscuss").switchTab({titCell: "dt a", trigger: "click", mainCell: ".discusstabcon", titOnClassName: "current", delayTime: 0});
				})
				</script>
				
				<div class="discuss" id="mydiscuss">
					<h2>买家体验</h2>
					<dl>
						<dt class="discusstab"><a class="current" href="javascript:void(0);">全部评论</a><a href="javascript:void(0);">好评(100)</a><a href="javascript:void(0);">中评(100)</a><a href="javascript:void(0);">差评(100)</a></dt>
						<dd class="discusstabcon">
							<div class="discussnum cf">
								<div class="f-l disnum">
									<strong>100%</strong><span>好评</span>
								</div>
								<div class="f-l disbar">
									<dl class="cf">
										<dt>好评</dt><dd class="barbox"><div class="bar" style="width:97%;"></div></dd><dd>97%</dd>
									</dl>
									<dl class="cf">
										<dt>中评</dt><dd class="barbox"><div class="bar" style="width:1%;"></div></dd><dd>1%</dd>
									</dl>
									<dl class="cf">
										<dt>差评</dt><dd class="barbox"><div class="bar" style="width:2%;"></div></dd><dd>2%</dd>
									</dl>
								</div>
								<div class="f-l pl5">前5位评论用户：a35***,rur***,a35***,rur***,rur***</div>
								<div class="f-r plbtn">
									<span>我在EGO买过此产品</span>
									<a class="plbtnimg" href="#"></a>
								</div>
							</div>
							
							<div class="discusslist">
								<ul>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
								</ul>
							</div>
							
							<div class="afqpage">
								<div class="f-r pagination">
									<span class="disabled">&lt; 上一页</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a><a href="#?page=4">4</a><a href="#?page=5">5</a><a href="#?page=6">6</a><a href="#?page=7">7</a><span class="dian3">...</span><a href="#?page=199">199</a><a href="#?page=200">200</a><a href="#?page=2">下一页 &gt; </a><div class="yepage">到第<input class="stext" type="text" name="" id="" value="1" />页<input class="btnimg" type="submit" name="" id="" value="" /></div>
								</div><!--pagination end-->
							</div>
							
						</dd>
						<dd class="discusstabcon">
							<div class="discussnum cf">
								<div class="f-l disnum">
									<strong>100%</strong><span>好评</span>
								</div>
								<div class="f-l disbar">
									<dl class="cf">
										<dt>好评</dt><dd class="barbox"><div class="bar" style="width:97%;"></div></dd><dd>97%</dd>
									</dl>
									<dl class="cf">
										<dt>中评</dt><dd class="barbox"><div class="bar" style="width:1%;"></div></dd><dd>1%</dd>
									</dl>
									<dl class="cf">
										<dt>差评</dt><dd class="barbox"><div class="bar" style="width:2%;"></div></dd><dd>2%</dd>
									</dl>
								</div>
								<div class="f-l pl5">前5位评论用户：a35***,rur***,a35***,rur***,rur***</div>
								<div class="f-r plbtn">
									<span>我在EGO买过此产品</span>
									<a class="plbtnimg" href="#"></a>
								</div>
							</div>
							
							<div class="discusslist">
								<ul>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
								</ul>
							</div>
							
							<div class="afqpage">
								<div class="f-r pagination">
									<span class="disabled">&lt; 上一页</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a><a href="#?page=4">4</a><a href="#?page=5">5</a><a href="#?page=6">6</a><a href="#?page=7">7</a><span class="dian3">...</span><a href="#?page=199">199</a><a href="#?page=200">200</a><a href="#?page=2">下一页 &gt; </a><div class="yepage">到第<input class="stext" type="text" name="" id="" value="1" />页<input class="btnimg" type="submit" name="" id="" value="" /></div>
								</div><!--pagination end-->
							</div>
							
						</dd>
						<dd class="discusstabcon">
							<div class="discussnum cf">
								<div class="f-l disnum">
									<strong>100%</strong><span>好评</span>
								</div>
								<div class="f-l disbar">
									<dl class="cf">
										<dt>好评</dt><dd class="barbox"><div class="bar" style="width:97%;"></div></dd><dd>97%</dd>
									</dl>
									<dl class="cf">
										<dt>中评</dt><dd class="barbox"><div class="bar" style="width:1%;"></div></dd><dd>1%</dd>
									</dl>
									<dl class="cf">
										<dt>差评</dt><dd class="barbox"><div class="bar" style="width:2%;"></div></dd><dd>2%</dd>
									</dl>
								</div>
								<div class="f-l pl5">前5位评论用户：a35***,rur***,a35***,rur***,rur***</div>
								<div class="f-r plbtn">
									<span>我在EGO买过此产品</span>
									<a class="plbtnimg" href="#"></a>
								</div>
							</div>
							
							<div class="discusslist">
								<ul>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
								</ul>
							</div>
							
							<div class="afqpage">
								<div class="f-r pagination">
									<span class="disabled">&lt; 上一页</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a><a href="#?page=4">4</a><a href="#?page=5">5</a><a href="#?page=6">6</a><a href="#?page=7">7</a><span class="dian3">...</span><a href="#?page=199">199</a><a href="#?page=200">200</a><a href="#?page=2">下一页 &gt; </a><div class="yepage">到第<input class="stext" type="text" name="" id="" value="1" />页<input class="btnimg" type="submit" name="" id="" value="" /></div>
								</div><!--pagination end-->
							</div>
							
						</dd>
						<dd class="discusstabcon">
							<div class="discussnum cf">
								<div class="f-l disnum">
									<strong>100%</strong><span>好评</span>
								</div>
								<div class="f-l disbar">
									<dl class="cf">
										<dt>好评</dt><dd class="barbox"><div class="bar" style="width:97%;"></div></dd><dd>97%</dd>
									</dl>
									<dl class="cf">
										<dt>中评</dt><dd class="barbox"><div class="bar" style="width:1%;"></div></dd><dd>1%</dd>
									</dl>
									<dl class="cf">
										<dt>差评</dt><dd class="barbox"><div class="bar" style="width:2%;"></div></dd><dd>2%</dd>
									</dl>
								</div>
								<div class="f-l pl5">前5位评论用户：a35***,rur***,a35***,rur***,rur***</div>
								<div class="f-r plbtn">
									<span>我在EGO买过此产品</span>
									<a class="plbtnimg" href="#"></a>
								</div>
							</div>
							
							<div class="discusslist">
								<ul>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
									<li class="cf">
										<div class="f-l dislpic"><a href="#"><img src="images/qzx.gif" width="48" height="48" alt="" /></a><span>cho***</span></div>
										<div class="f-l disrdis">
											<div class="disdate"><span class="f-l">2011-10-28</span><span class="f-l">评论</span><span class="starpoint"></span></div>
											<div class="disinfo"><span class="f-l">评论：真的是李鬼还没仔细看要知道不是念慈庵才不会要！</span><div class="f-r withme"><span class="f-l">这个评论对我</span><a href="#">有用 <b class="red">0</b></a><a href="#">没用 <b class="red">0</b></a></div>
										</div>
									</li>
								</ul>
							</div>
							
							<div class="afqpage">
								<div class="f-r pagination">
									<span class="disabled">&lt; 上一页</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a><a href="#?page=4">4</a><a href="#?page=5">5</a><a href="#?page=6">6</a><a href="#?page=7">7</a><span class="dian3">...</span><a href="#?page=199">199</a><a href="#?page=200">200</a><a href="#?page=2">下一页 &gt; </a><div class="yepage">到第<input class="stext" type="text" name="" id="" value="1" />页<input class="btnimg" type="submit" name="" id="" value="" /></div>
								</div><!--pagination end-->
							</div>
							
						</dd>
					</dl>
				</div><!--discuss end-->
				
				<script type="text/javascript">
				$(function(){
					$(".afq").switchTab({titCell: "dt a", trigger: "click", mainCell: ".discusstabcon", titOnClassName: "current", delayTime: 0});
				})
				</script>
				
				<div class="discuss afq">
					<h2>商品问答</h2>
					<div class="afqtip">关于产品价格，保质期，促销活动的留言具有时效性，回复仅供参考只在一定时间内有效。</div>
					<dl>
						<dt class="discusstab"><a class="current" href="javascript:void(0);">商品</a><a href="javascript:void(0);">配送</a><a href="javascript:void(0);">支付</a><a href="javascript:void(0);">售后</a></dt>
						<dd class="discusstabcon">
							<div class="afqlist">
								<dl class="cf">
									<dt class="quiz"></dt><dd>这个瓶子里面，打开，没有塑封来密封的吗？</dd>
									<dd class="last">提问者：mildred.v*** 2011-10-25</dd>
								</dl>
								<dl class="cf">
									<dt class="answer"></dt><dd>您好，内有橡胶盖子，感谢您支持EGO！祝您购物愉快！</dd>
									<dd class="last">回答者：【管理员】 2011-11-01</dd>
								</dl>
								<div class="myanswer">
									<a class="f-r" href="#"><img src="images/myanswer.gif" width="60" height="22" alt="我来解答" align="baseline" /></a><span class="f-r">共有1条解答</span>
								</div>
							</div>
							<div class="afqlist">
								<dl class="cf">
									<dt class="quiz"></dt><dd>这个瓶子里面，打开，没有塑封来密封的吗？</dd>
									<dd class="last">提问者：mildred.v*** 2011-10-25</dd>
								</dl>
								<dl class="cf">
									<dt class="answer"></dt><dd>您好，内有橡胶盖子，感谢您支持EGO！祝您购物愉快！</dd>
									<dd class="last">回答者：【管理员】 2011-11-01</dd>
								</dl>
								<div class="myanswer">
									<a class="f-r" href="#"><img src="images/myanswer.gif" width="60" height="22" alt="我来解答" align="baseline" /></a><span class="f-r">共有1条解答</span>
								</div>
							</div>
							
							<div class="afqpage">
								<div class="f-r pagination">
									<span class="disabled">&lt; 上一页</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a><a href="#?page=4">4</a><a href="#?page=5">5</a><a href="#?page=6">6</a><a href="#?page=7">7</a><span class="dian3">...</span><a href="#?page=199">199</a><a href="#?page=200">200</a><a href="#?page=2">下一页 &gt; </a><div class="yepage">到第<input class="stext" type="text" name="" id="" value="1" />页<input class="btnimg" type="submit" name="" id="" value="" /></div>
								</div><!--pagination end-->
							</div>
						</dd>
						<dd class="discusstabcon">
							<div class="afqlist">
								<dl class="cf">
									<dt class="quiz"></dt><dd>这个瓶子里面，打开，没有塑封来密封的吗？</dd>
									<dd class="last">提问者：mildred.v*** 2011-10-25</dd>
								</dl>
								<dl class="cf">
									<dt class="answer"></dt><dd>您好，内有橡胶盖子，感谢您支持EGO！祝您购物愉快！</dd>
									<dd class="last">回答者：【管理员】 2011-11-01</dd>
								</dl>
								<div class="myanswer">
									<a class="f-r" href="#"><img src="images/myanswer.gif" width="60" height="22" alt="我来解答" align="baseline" /></a><span class="f-r">共有1条解答</span>
								</div>
							</div>
							<div class="afqlist">
								<dl class="cf">
									<dt class="quiz"></dt><dd>这个瓶子里面，打开，没有塑封来密封的吗？</dd>
									<dd class="last">提问者：mildred.v*** 2011-10-25</dd>
								</dl>
								<dl class="cf">
									<dt class="answer"></dt><dd>您好，内有橡胶盖子，感谢您支持EGO！祝您购物愉快！</dd>
									<dd class="last">回答者：【管理员】 2011-11-01</dd>
								</dl>
								<div class="myanswer">
									<a class="f-r" href="#"><img src="images/myanswer.gif" width="60" height="22" alt="我来解答" align="baseline" /></a><span class="f-r">共有1条解答</span>
								</div>
							</div>
							
							<div class="afqpage">
								<div class="f-r pagination">
									<span class="disabled">&lt; 上一页</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a><a href="#?page=4">4</a><a href="#?page=5">5</a><a href="#?page=6">6</a><a href="#?page=7">7</a><span class="dian3">...</span><a href="#?page=199">199</a><a href="#?page=200">200</a><a href="#?page=2">下一页 &gt; </a><div class="yepage">到第<input class="stext" type="text" name="" id="" value="1" />页<input class="btnimg" type="submit" name="" id="" value="" /></div>
								</div><!--pagination end-->
							</div>
						</dd>
						<dd class="discusstabcon">
							<div class="afqlist">
								<dl class="cf">
									<dt class="quiz"></dt><dd>这个瓶子里面，打开，没有塑封来密封的吗？</dd>
									<dd class="last">提问者：mildred.v*** 2011-10-25</dd>
								</dl>
								<dl class="cf">
									<dt class="answer"></dt><dd>您好，内有橡胶盖子，感谢您支持EGO！祝您购物愉快！</dd>
									<dd class="last">回答者：【管理员】 2011-11-01</dd>
								</dl>
								<div class="myanswer">
									<a class="f-r" href="#"><img src="images/myanswer.gif" width="60" height="22" alt="我来解答" align="baseline" /></a><span class="f-r">共有1条解答</span>
								</div>
							</div>
							<div class="afqlist">
								<dl class="cf">
									<dt class="quiz"></dt><dd>这个瓶子里面，打开，没有塑封来密封的吗？</dd>
									<dd class="last">提问者：mildred.v*** 2011-10-25</dd>
								</dl>
								<dl class="cf">
									<dt class="answer"></dt><dd>您好，内有橡胶盖子，感谢您支持EGO！祝您购物愉快！</dd>
									<dd class="last">回答者：【管理员】 2011-11-01</dd>
								</dl>
								<div class="myanswer">
									<a class="f-r" href="#"><img src="images/myanswer.gif" width="60" height="22" alt="我来解答" align="baseline" /></a><span class="f-r">共有1条解答</span>
								</div>
							</div>
							
							<div class="afqpage">
								<div class="f-r pagination">
									<span class="disabled">&lt; 上一页</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a><a href="#?page=4">4</a><a href="#?page=5">5</a><a href="#?page=6">6</a><a href="#?page=7">7</a><span class="dian3">...</span><a href="#?page=199">199</a><a href="#?page=200">200</a><a href="#?page=2">下一页 &gt; </a><div class="yepage">到第<input class="stext" type="text" name="" id="" value="1" />页<input class="btnimg" type="submit" name="" id="" value="" /></div>
								</div><!--pagination end-->
							</div>
						</dd>
						<dd class="discusstabcon">
							<div class="afqlist">
								<dl class="cf">
									<dt class="quiz"></dt><dd>这个瓶子里面，打开，没有塑封来密封的吗？</dd>
									<dd class="last">提问者：mildred.v*** 2011-10-25</dd>
								</dl>
								<dl class="cf">
									<dt class="answer"></dt><dd>您好，内有橡胶盖子，感谢您支持EGO！祝您购物愉快！</dd>
									<dd class="last">回答者：【管理员】 2011-11-01</dd>
								</dl>
								<div class="myanswer">
									<a class="f-r" href="#"><img src="images/myanswer.gif" width="60" height="22" alt="我来解答" align="baseline" /></a><span class="f-r">共有1条解答</span>
								</div>
							</div>
							<div class="afqlist">
								<dl class="cf">
									<dt class="quiz"></dt><dd>这个瓶子里面，打开，没有塑封来密封的吗？</dd>
									<dd class="last">提问者：mildred.v*** 2011-10-25</dd>
								</dl>
								<dl class="cf">
									<dt class="answer"></dt><dd>您好，内有橡胶盖子，感谢您支持EGO！祝您购物愉快！</dd>
									<dd class="last">回答者：【管理员】 2011-11-01</dd>
								</dl>
								<div class="myanswer">
									<a class="f-r" href="#"><img src="images/myanswer.gif" width="60" height="22" alt="我来解答" align="baseline" /></a><span class="f-r">共有1条解答</span>
								</div>
							</div>
							
							<div class="afqpage">
								<div class="f-r pagination">
									<span class="disabled">&lt; 上一页</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a><a href="#?page=4">4</a><a href="#?page=5">5</a><a href="#?page=6">6</a><a href="#?page=7">7</a><span class="dian3">...</span><a href="#?page=199">199</a><a href="#?page=200">200</a><a href="#?page=2">下一页 &gt; </a><div class="yepage">到第<input class="stext" type="text" name="" id="" value="1" />页<input class="btnimg" type="submit" name="" id="" value="" /></div>
								</div><!--pagination end-->
							</div>
						</dd>
					</dl>
				</div><!--discuss end-->
				
				<div class="recommend">
					<h2>看过本商品的人还看过</h2>
					<ul class="cf">
						<li>
							<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
							<dl>
								<dt><a href="#">九阳豆浆机DJ13B-D08</a></dt>
								<dd><del>￥599</del></dd>
								<dd><strong class="red">￥439.0</strong></dd>
								<dd><a class="addcat" href="#"></a></dd>
							</dl>
						</li>
						<li>
							<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
							<dl>
								<dt><a href="#">九阳豆浆机DJ13B-D08</a></dt>
								<dd><del>￥599</del></dd>
								<dd><strong class="red">￥439.0</strong></dd>
								<dd><a class="addcat" href="#"></a></dd>
							</dl>
						</li>
						<li>
							<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
							<dl>
								<dt><a href="#">九阳豆浆机DJ13B-D08</a></dt>
								<dd><del>￥599</del></dd>
								<dd><strong class="red">￥439.0</strong></dd>
								<dd><a class="addcat" href="#"></a></dd>
							</dl>
						</li>
						<li>
							<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
							<dl>
								<dt><a href="#">九阳豆浆机DJ13B-D08</a></dt>
								<dd><del>￥599</del></dd>
								<dd><strong class="red">￥439.0</strong></dd>
								<dd><a class="addcat" href="#"></a></dd>
							</dl>
						</li>
						<li>
							<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
							<dl>
								<dt><a href="#">九阳豆浆机DJ13B-D08</a></dt>
								<dd><del>￥599</del></dd>
								<dd><strong class="red">￥439.0</strong></dd>
								<dd><a class="addcat" href="#"></a></dd>
							</dl>
						</li>
						<li>
							<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
							<dl>
								<dt><a href="#">九阳豆浆机DJ13B-D08</a></dt>
								<dd><del>￥599</del></dd>
								<dd><strong class="red">￥439.0</strong></dd>
								<dd><a class="addcat" href="#"></a></dd>
							</dl>
						</li>
						<li>
							<a href="#"><img src="images/1119969_115x115.jpg" width="115" height="115" alt="" /></a>
							<dl>
								<dt><a href="#">九阳豆浆机DJ13B-D08</a></dt>
								<dd><del>￥599</del></dd>
								<dd><strong class="red">￥439.0</strong></dd>
								<dd><a class="addcat" href="#"></a></dd>
							</dl>
						</li>
					</ul>
				</div><!--recommend end-->
				
			</div><!--detail end-->
			
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
					<li><a href="#"><img src="images/ft_1.gif" border="0" /></a></li>
					<li><a href="#"><img src="images/ft_2.gif" border="0" /></a></li>
					<li><a href="#"><img src="images/ft_3.gif" border="0" /></a></li>
				</ul>
			</div>
			<div class="copyright tac pbt10">版权所有 Copyright&copy; EGO商城 All Rights Reserved 版权所有 </div>
			<div class="ft_banners2 tac">
				<ul>
					<li><a href="#"><img src="images/u255.png" border="0" /></a></li>
					<li><a href="#"><img src="images/u257.png" border="0" /></a></li>
					<li><a href="#"><img src="images/u259.png" border="0" /></a></li>
					<li><a href="#"><img src="images/u261.png" border="0" /></a></li>
				</ul>
			</div>
		</div>
		
	</div><!--s_ftw end-->

</div>
</body>
</html>
