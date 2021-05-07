<!-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
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