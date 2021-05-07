<#-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<!DOCTYPE html>
<html>
<head>
    <#include "../head.ftl">
    <link rel="stylesheet" href="${ctx}/static/css/fileinput.min.css"></link>
    <script type="text/javascript" src="${ctx}/static/js/fileinput.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/global.js"></script>
    <!-- 对中文的支持 -->
    <script type="text/javascript" src="${ctx}/static/js/fileinput_locale_zh.js"></script>
    <!-- 百度 ueditor -->
    <script type="text/javascript" charset="utf-8"
            src="${ctx}/static/plugins/Ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/static/plugins/Ueditor/ueditor.all.js">
    </script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/static/plugins/Ueditor/lang/zh-cn/zh-
cn.js"></script>
</head>
<body style="background-color:#ecf0f5;">


<!--物流配置 css -start-->
<style>
    ul.group-list {
        width: 96%;
        min-width: 1000px;
        margin: auto 5px;
        list-style: disc outside none;
    }

    ul.group-list li {
        white-space: nowrap;
        float: left;
        width: 150px;
        height: 25px;
        padding: 3px 5px;
        list-style-type: none;
        list-style-position: outside;
        border: 0px;
        margin: 0px;
    }
</style>
<div class="wrapper">
    <div class="breadcrumbs" id="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="javascript:void();"><i class="fa fa-home"></i>&nbsp;&nbsp;后台首页</a></li>

            <li><a href="javascript:void();">商品管理</a></li>
            <li><a href="javascript:void();">添加修改商品</a></li>
        </ol>
    </div>

    <section class="content">
        <!-- Main content -->
        <div class="container-fluid">
            <div class="pull-right">
                <a href="javascript:history.go(-1)" data-toggle="tooltip" title="" class="btn btn-default"
                   data-original-title="返回"><i class="fa fa-reply"></i></a>
                <a href="javascript:;" class="btn btn-default"
                   data-url="http://www.ego.cn/Doc/Index/article/id/1007/developer/user.html"
                   onclick="get_help(this)"><i class="fa fa-question-circle"></i> 帮助</a>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list"></i>商品详情</h3>
                </div>
                <div class="panel-body">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_tongyong" data-toggle="tab">通用信息</a></li>
                        <!-- <li><a href="#tab_goods_desc" data-toggle="tab">描述信息</a></li>-->
                        <li><a href="#tab_goods_images" data-toggle="tab" onclick="checkHasGoods();">商品相册</a></li>
                    </ul>
                    <!--表单数据-->
                    <form method="post" id="addEditGoodsForm">

                        <!--通用信息-->
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab_tongyong">

                                <table class="table table-bordered">
                                    <tbody>
                                    <tr>
                                        <td>商品名称:</td>
                                        <td>

                                            <input type="text" value="${(good.goodsName)!}" name="goodsName"
                                                   class="form-control"
                                                   style="width:550px;">
                                            <span id="err_goods_name" style="color:#F00; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>商品简介:</td>
                                        <td>
                                            <textarea rows="3" cols="80"
                                                      name="goodsRemark">${(good.goodsRemark)!}</textarea>
                                            <span id="err_goods_remark" style="color:#F00; display:none;"></span>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>商品货号</td>
                                        <td>
                                            <input type="text" value="${(good.goodsSn)!}" name="goodsSn"
                                                   class="form-control"
                                                   style="width:350px;"/>
                                            <span id="err_goods_sn" style="color:#F00; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>商品分类:</td>
                                        <td>
                                            <div class="col-xs-3">
                                                <input type="hidden" name="catId" id="catId" value="0">
                                                <#--                                                <input type="text" name="gcatId" id="gcatId" value="${good.}"-->
                                                <select name="cat_id" id="cat_id"
                                                        onchange="getCategory(this.value,'cat_id_2','0','catId');"
                                                        class="form-control" style="width:250px;margin-left:-15px;">
                                                    <option value="0">请选择商品分类</option>
                                                    <#list gcList as gc>
                                                        <option value="${gc.id}">${gc.name}</option>
                                                    </#list>
                                                </select>
                                            </div>
                                            <div class="col-xs-3">
                                                <select name="cat_id_2" id="cat_id_2"
                                                        onchange="getCategory(this.value,'cat_id_3','1','catId');"
                                                        class="form-control" style="width:250px;margin-left:-15px;">
                                                    <option value="0">请选择商品分类</option>
                                                </select>
                                            </div>
                                            <div class="col-xs-3">
                                                <select name="cat_id_3" id="cat_id_3"
                                                        onchange="setHiddenValue(this.value,'catId');"
                                                        class="form-control"
                                                        style="width:250px;margin-left:-15px;">
                                                    <option value="0">请选择商品分类</option>
                                                </select>
                                            </div>
                                            <span id="err_cat_id" style="color:#ff0000; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>商品品牌:</td>
                                        <td>

                                            <select name="brand_id" id="brandId" class="form-control"
                                                    style="width:250px;">
                                                <#if good??>
                                                    <option value="${good.brandId}">${good.goodsName}</option>
                                                    <#else>
                                                    <option value="0">所有品牌</option>
                                                    <#list brandList as brand>
                                                        <option value="${brand.id}">${brand.name}</option>
                                                    </#list>
                                                </#if>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>本店售价:</td>
                                        <td>
                                            <input type="text" value="${(good.shopPrice?c)!}" name="shopPrice" class="form-control"
                                                   style="width:150px;"
                                                   onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                                                   onpaste="this.value=this.value.replace(/[^\d.]/g,'')"/>
                                            <span id="err_shop_price" style="color:#F00; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>市场价:</td>
                                        <td>
                                            <input type="text" value="${(good.marketPrice?c)!}" name="marketPrice" class="form-control"
                                                   style="width:150px;"
                                                   onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                                                   onpaste="this.value=this.value.replace(/[^\d.]/g,'')"/>
                                            <span id="err_market_price" style="color:#F00; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>成本价:</td>
                                        <td>
                                            <input type="text" value="" name="${(good.costPrice?c)!}" class="form-control"
                                                   style="width:150px;"
                                                   onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                                                   onpaste="this.value=this.value.replace(/[^\d.]/g,'')"/>
                                            <span id="err_cost_price" style="color:#F00; display:none"></span>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>上传商品图片:</td>
                                        <td>
                                            <input type="text" name="originalImg" id="originalImg"/>
                                            <form enctype="multipart/form-data">
                                                <input id="file-product" class="file" name="file" type="file" multiple
                                                       data-min-file-count="1">
                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>商品重量:</td>
                                        <td>
                                            <input type="text" class="form-control" style="width:150px;" value="${(good.weight?c)!}"
                                                   name="weight" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                                                   onpaste="this.value=this.value.replace(/[^\d.]/g,'')"/>
                                            &nbsp;克 (以克为单位)
                                            <span id="err_weight" style="color:#F00; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>是否包邮:</td>
                                        <td>
                                            是:<input type="radio" value="1" name="isFreeShipping"/>
                                            否:<input type="radio" checked="checked" value="0" name="isFreeShipping"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>库存数量:</td>
                                        <td>
                                            <input type="text" value="${(good.storeCount?c)!}" class="form-control" style="width:150px;"
                                                   name="storeCount"
                                                   onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                                                   onpaste="this.value=this.value.replace(/[^\d.]/g,'')"/>
                                            <span id="err_store_count" style="color:#F00; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>商品详情描述:</td>
                                        <td width="85%">
                                            <textarea rows="6" cols="80" class="span12 ckeditor" id="goods_content"
                                                      name="goodsContent" title="">${(good.goodsContent)!}</textarea>
                                            <span id="err_goods_content" style="color:#ff0000; display:none;"></span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--其他信息-->

                            <!-- 商品相册-->
                            <div class="tab-pane" id="tab_goods_images">
                                <table class="table table-bordered">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <form enctype="multipart/form-data">
                                                <!--<input type="text" id="fileGroupName" name="fileGroupName"/><br>-->
                                                <input id="file-goods-images" class="file" name="file" type="file"
                                                       multiple
                                                       data-min-file-count="1">
                                            </form>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--商品相册-->
                        </div>
                        <div class="pull-right">
                            <input type="text" name="goodsId" id="goodsId" value="${(good.goodsId)!}">
                            <button class="btn btn-primary"
                                    onclick="ajax_submit_form('addEditGoodsForm','${ctx}/goods/save',
                                            '${ctx}/goods/add/${(good.goodsId)!'-1'}','${ctx}/goods/list','${(good.goodsId)!'-1'}');"
                                    title="" data-toggle="tooltip" type="button" data-original-title="保存">保存
                            </button>
                        </div>
                        <input type="hidden" name="__hash__"
                               value="4215372d5f63004790e1b9f4ed8df8b8_e74f2c0a9d3eff6e5b0e2ac8545e8177"/></form>
                    <!--表单数据-->
                </div>
            </div>
        </div>    <!-- /.content -->
    </section>
</div>
<script>
    $(document).ready(function () {
        $(":checkbox[cka]").click(function () {
            var $cks = $(":checkbox[ck='" + $(this).attr("cka") + "']");
            if ($(this).is(':checked')) {
                $cks.each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $cks.each(function () {
                    $(this).removeAttr('checked');
                });
            }
        });
    });

    function choosebox(o) {
        var vt = $(o).is(':checked');
        if (vt) {
            $('input[type=checkbox]').prop('checked', vt);
        } else {
            $('input[type=checkbox]').removeAttr('checked');
        }
    }

    /*
     * 以下是图片上传方法
     */
    // 上传商品图片成功回调函数
    function call_back(fileurl_tmp) {
        $("#original_img").val(fileurl_tmp);
        $("#original_img2").attr('href', fileurl_tmp);
    }

    // 上传商品相册回调函数
    function call_back2(paths) {

        var last_div = $(".goods_xc:last").prop("outerHTML");
        for (i = 0; i < paths.length; i++) {
            $(".goods_xc:eq(0)").before(last_div);	// 插入一个 新图片
            $(".goods_xc:eq(0)").find('a:eq(0)').attr('href', paths[i]).attr('onclick', '').attr('target', "_blank");// 修改他的链接地址
            $(".goods_xc:eq(0)").find('img').attr('src', paths[i]);// 修改他的图片路径
            $(".goods_xc:eq(0)").find('a:eq(1)').attr('onclick', "ClearPicArr2(this,'" + paths[i] + "')").text('删除');
            $(".goods_xc:eq(0)").find('input').val(paths[i]); // 设置隐藏域 要提交的值
        }
    }

    /*
     * 上传之后删除组图input     
     * @access   public
     * @val      string  删除的图片input
     */
    function ClearPicArr2(obj, path) {
        $.ajax({
            type: 'GET',
            url: "/index/Admin/Uploadify/delupload",
            data: {action: "del", filename: path},
            success: function () {
                $(obj).parent().remove(); // 删除完服务器的, 再删除 html上的图片
            }
        });
        // 删除数据库记录
        $.ajax({
            type: 'GET',
            url: "/index/Admin/Goods/del_goods_images",
            data: {filename: path},
            success: function () {
                //
            }
        });
    }


    /** 以下 商品属性相关 js*/

// 属性输入框的加减事件
    function addAttr(a) {
        var attr = $(a).parent().parent().prop("outerHTML");
        attr = attr.replace('addAttr', 'delAttr').replace('+', '-');
        $(a).parent().parent().after(attr);
    }

    // 属性输入框的加减事件
    function delAttr(a) {
        $(a).parent().parent().remove();
    }


    /** 以下 商品规格相关 js*/
    $(document).ready(function () {
        // 商品模型切换时 ajax 调用  返回不同的属性输入框
        $("#spec_type").change(function () {
            var goods_id = '';
            var spec_type = $(this).val();
            $.ajax({
                type: 'GET',
                data: {goods_id: goods_id, spec_type: spec_type},
                url: "/index/admin/Goods/ajaxGetSpecSelect",
                success: function (data) {
                    $("#ajax_spec_data").html('')
                    $("#ajax_spec_data").append(data);
                    ajaxGetSpecInput();	// 触发完  马上触发 规格输入框
                }
            });
            //商品类型切换时 ajax 调用  返回不同的属性输入框     
            $.ajax({
                type: 'GET',
                data: {goods_id: goods_id, type_id: spec_type},
                url: "/index/admin/Goods/ajaxGetAttrInput",
                success: function (data) {
                    $("#goods_attr_table tr:gt(0)").remove()
                    $("#goods_attr_table").append(data);
                }
            });
        });
        // 触发商品规格
        $("#spec_type").trigger('change');

        $("input[name='exchange_integral']").blur(function () {
            var shop_price = parseInt($("input[name='shop_price']").val());
            var exchange_integral = parseInt($(this).val());
            if (shop_price * 100 < exchange_integral) {

            }
        });
    });

    /** 以下是编辑时默认选中某个商品分类*/
    $(document).ready(function () {


        //  扩展分类

    });

    /**
     * 设置商品分类的隐藏域的值
     */
    function setHiddenValue(value, hiddenId) {
        $("#" + hiddenId).val(value);
    }

    //============商品—上传图片======================
    /**
     * 初始设置
     * language指定语言
     * uploadUrl指定文件上传的后台地址
     * allowedPreviewTypes允许上传文件的类型
     */
    $('#file-product').fileinput({
        language: 'zh',
        uploadUrl: '${ctx}/fileUpload/save',
        allowedPreviewTypes: ['image', 'html', 'text', 'video', 'audio', 'flash']
    });
    /**
     * 上传文件失败后 调用方法（回调函数）
     */
    $('#file-product').on('fileuploaderror', function (event, data, previewId, index) {
        var form = data.form,
            files = data.files,
            extra = data.extra,
            response = data.response,
            reader = data.reader;
        console.log(data);
        console.log('File upload error');
    });
    /**
     * 文件错误 比如文件类型错误 调用方法（回调函数）
     */
    $('#file-product').on('fileerror', function (event, data) {
        console.log(data.id);
        console.log(data.index);
        console.log(data.file);
        console.log(data.reader);
        console.log(data.files);
    });
    /**
     * 文件上传成功后 调用方法（回调函数）
     */
    $('#file-product').on('fileuploaded', function (event, data, previewId, index) {
        var form = data.form,
            files = data.files,
            extra = data.extra,
            response = data.response,
            reader = data.reader;
        // 服务器文件地址
        // alert(data.response.fileUrl);
        // 将服务器文件地址设置至隐藏域
        $("#originalImg").val(data.response.fileUrl);
        console.log('File uploaded triggered');
    });
    //============商品—上传图片======================


    //---------------------------商品相册begin-------------------
    /**
     * 初始设置
     * language指定语言
     * uploadUrl指定文件上传的后台地址
     * allowedPreviewTypes允许上传文件的类型
     */
    $('#file-goods-images').fileinput({
        language: 'zh',
        uploadUrl: '${ctx}/goods/images/save',
        allowedPreviewTypes: ['image', 'html', 'text', 'video', 'audio', 'flash'],
        //文件上传插件提交额外参数
        uploadExtraData: function () {
            var goodsId = {"goodsId": $("#goodsId").val()};
            return goodsId;
        }
    });
    /**
     * 上传文件失败后 调用方法（回调函数）
     */
    $('#file-goods-images').on('fileuploaderror', function (event, data, previewId, index) {
        var form = data.form,
            files = data.files,
            extra = data.extra,
            response = data.response,
            reader = data.reader;
        console.log(data);
        console.log('File upload error');
    });
    /**
     * 文件错误 比如文件类型错误 调用方法（回调函数）
     * */
    $('#file-goods-images').on('fileerror', function (event, data) {
        console.log(data.id);
        console.log(data.index);
        console.log(data.file);
        console.log(data.reader);
        console.log(data.files);
    });
    /**
     * 文件上传成功后 调用方法（回调函数）
     */
    $('#file-goods-images').on('fileuploaded', function (event, data, previewId, index) {
        var form = data.form,
            files = data.files,
            extra = data.extra,
            response = data.response,
            reader = data.reader;
        console.log('File uploaded triggered');
    });

    //---------------------------商品相册end------------------------

    /**
     * 检查是否保存商品通用信息
     */
    function checkHasGoods() {
        if (!$("#goodsId").val()) {
            layer.msg("清先保存商品【通用信息】");
            $("#file-goods-images").attr("disabled", true);
        } else {
            $("#file-goods-images").attr("disabled", false);
        }
    }

</script>
<!--以下是在线编辑器 代码 -->
<script type="text/javascript">
    /*
    * 在线编辑器相 关配置 js
    * 参考 地址 http://fex.baidu.com/ueditor/
    */
    window.UEDITOR_Admin_URL = "${ctx}/static/plugins/Ueditor/";
    var URL_upload = "/index/Admin/Ueditor/imageUp/savepath/goods";
    var URL_fileUp = "/index/Admin/Ueditor/fileUp/savepath/article";
    var URL_scrawlUp = "/index/Admin/Ueditor/scrawlUp/savepath/article";
    var URL_getRemoteImage = "/index/Admin/Ueditor/getRemoteImage/savepath/article";
    var URL_imageManager = "/index/Admin/Ueditor/imageManager/savepath/article";
    var URL_imageUp = "/index/Admin/Ueditor/imageUp/savepath/article";
    var URL_getMovie = "/index/Admin/Ueditor/getMovie/savepath/article";
    var URL_home = "";
</script>
<script type="text/javascript">
    var editor;
    $(function () {
        //具体参数配置在 editor_config.js 中
        var options = {
            zIndex: 999,
            initialFrameWidth: "95%", //初化宽度
            initialFrameHeight: 400, //初化高度
            focus: false, //初始化时，是否让编辑器获得焦点true或false
            maximumWords: 99999,
            removeFormatAttributes: 'class,style,lang,width,height,align,hspace,valign', //允许的最大字符数 'fullscreen',
            pasteplain: false, //是否默认为纯文本粘贴。false为不使用纯文本粘贴，true为使用纯文本粘贴
            autoHeightEnabled: true
            /* autotypeset: {
            mergeEmptyline: true, //合并空行
            removeClass: true, //去掉冗余的class
            removeEmptyline: false, //去掉空行
            textAlign: "left", //段落的排版方式，可以是
            left,right,center,justify 去掉这个属性表示不执行排版
            imageBlockLine: 'center', //图片的浮动方式，独占一行剧中,左右浮动，默认:
            center,left,right,none 去掉这个属性表示不执行排版
            pasteFilter: false, //根据规则过滤没事粘贴进来的内容
            clearFontSize: false, //去掉所有的内嵌字号，使用编辑器默认的字号
            clearFontFamily: false, //去掉所有的内嵌字体，使用编辑器默认的字体
            removeEmptyNode: false, //去掉空节点
        //可以去掉的标签
        removeTagNames: {"font": 1},
        indent: false, // 行首缩进
        indentValue: '0em' //行首缩进的大小
        }*/,
            toolbars: [
                ['fullscreen', 'source', '|', 'undo', 'redo',
                    '|', 'bold', 'italic', 'underline', 'fontborder',
                    'strikethrough', 'superscript', 'subscript',
                    'removeformat', 'formatmatch', 'autotypeset',
                    'blockquote', 'pasteplain', '|', 'forecolor',
                    'backcolor', 'insertorderedlist',
                    'insertunorderedlist', 'selectall', 'cleardoc', '|',
                    'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
                    'customstyle', 'paragraph', 'fontfamily', 'fontsize',
                    '|', 'directionalityltr', 'directionalityrtl',
                    'indent', '|', 'justifyleft', 'justifycenter',
                    'justifyright', 'justifyjustify', '|', 'touppercase',
                    'tolowercase', '|', 'link', 'unlink', 'anchor', '|',
                    'imagenone', 'imageleft', 'imageright', 'imagecenter',
                    '|', 'insertimage', 'emotion', 'insertvideo',
                    'attachment', 'map', 'gmap', 'insertframe',
                    'insertcode', 'webapp', 'pagebreak', 'template',
                    'background', '|', 'horizontal', 'date', 'time',
                    'spechars', 'wordimage', '|',
                    'inserttable', 'deletetable',
                    'insertparagraphbeforetable', 'insertrow', 'deleterow',
                    'insertcol', 'deletecol', 'mergecells', 'mergeright',
                    'mergedown', 'splittocells', 'splittorows',
                    'splittocols', '|', 'print', 'preview', 'searchreplace']
            ]
        };
        editor = new UE.ui.Editor(options);
        editor.render("goods_content"); // 指定 textarea 的 id 为 goods_content
    });
</script>
<!--以上是在线编辑器 代码 end-->
</body>
</html>