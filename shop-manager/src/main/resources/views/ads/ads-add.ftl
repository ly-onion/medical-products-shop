<html>
<head>
    <#include "../head.ftl">
    <link rel="stylesheet" href="${ctx}/static/css/fileinput.min.css"></link>
    <script type="text/javascript" src="${ctx}/static/js/fileinput.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/global.js"></script>
    <!-- 对中文的支持 -->
    <script type="text/javascript" src="${ctx}/static/js/fileinput_locale_zh.js"></script>
</head>
<body style="background-color:#ecf0f5;">
<link href="${ctx}/static/plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css">
<script src="${ctx}/static/plugins/daterangepicker/moment.min.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
<div class="wrapper">
    <div class="breadcrumbs" id="breadcrumbs">
        <ol class="breadcrumb">

            <li><a href="javascript:void();"><i class="fa fa-home"></i>&nbsp;&nbsp;后台首页</a></li>

            <li><a href="javascript:void();">广告管理</a></li>

            <li><a href="javascript:void();">新增广告</a></li>

        </ol>
    </div>

    <section class="content ">
        <!-- Main content -->
        <div class="container-fluid">
            <div class="pull-right">
                <a href="javascript:history.go(-1)" data-toggle="tooltip" title="" class="btn btn-default"
                   data-original-title="返回"><i class="fa fa-reply"></i></a>
                <a href="javascript:;" class="btn btn-default"
                   data-url="http://www.ego.cn/Doc/Index/article/id/1012/developer/user.html"
                   onclick="get_help(this)"><i class="fa fa-question-circle"></i> 帮助</a>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list"></i> 添加广告</h3>
                </div>
                <div class="panel-body ">
                    <!--表单数据-->
                    <form method="post" id="handleposition">
                        <!--通用信息-->
                        <div class="tab-content col-md-10">
                            <div class="tab-pane active" id="tab_tongyong">
                                <table class="table table-bordered">
                                    <tbody>
                                    <tr>
                                        <td class="col-sm-2">广告名称：</td>
                                        <td class="col-sm-8">
                                            <input class="form-control" name="adName" type="text"
                                                   value="${(ad.adName)!}">
                                            <span id="err_attr_name" style="color:#F00; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>广告位置：</td>
                                        <td>
                                            <select name="pid" class="input-sm">
                                                <option value="1">1号</option>
                                                <option value="2">2号</option>
                                                <option value="3">3号</option>
                                                <option value="4">4号</option>
                                                <option value="5">5号</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-sm-2">添加人：</td>
                                        <td class="col-sm-8">
                                            <input class="form-control" name="linkMan" type="text"
                                                   value="${(ad.linkMan)!}">
                                            <span id="err_attr_name" style="color:#F00; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-sm-2">添加人号码：</td>
                                        <td class="col-sm-8">
                                            <input class="form-control" name="linkPhone" type="text"
                                                   value="${(ad.linkPhone)!}">
                                            <span id="err_attr_name" style="color:#F00; display:none;"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>开始日期：</td>
                                        <td>
                                            <fieldset>
                                                <div class="control-group">
                                                    <div class="controls">
                                                        <div class="input-prepend input-group">
                                                                <span class="add-on input-group-addon">
                                                                        <i class="glyphicon glyphicon-calendar fa fa-calendar">
                                                                        </i>
                                                                </span>
                                                            <input style="width: 300px" name="begin" id="begin"
                                                                   class="form-control"
                                                                   value="${(ad.begin)!'2021-05-06'}" type="text">
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>结束时间：</td>
                                        <td>
                                            <fieldset>
                                                <div class="control-group">
                                                    <div class="controls">
                                                        <div class="input-prepend input-group">
                                                                    <span class="add-on input-group-addon">
                                                                            <i class="glyphicon glyphicon-calendar fa fa-calendar">
                                                                            </i>
                                                                    </span>
                                                            <input style="width: 300px" name="end" id="end"
                                                                   class="form-control" value="${(ad.end)!'2021-05-07'}"
                                                                   type="text">
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>广告链接：</td>
                                        <td>
                                            <input class="form-control" name="adLink" value="${(ad.adLink)!}" type="text">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>是否展示：</td>
                                        <td>
                                            <input class="form-control" name="isShow" value="${(ad.isShow)!}" type="text"
                                            onchange="checkAmount()">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>上传图片:</td>
                                        <td>
                                            <label> 图片地址：</label>
                                            <input type="text" name="adCode" id="adCode" value="${(ad.adCode)!}"/>
                                            <form enctype="multipart/form-data">
                                                <input id="file-product" class="file" name="file" type="file" multiple
                                                       data-min-file-count="1">
                                            </form>
                                        </td>
                                    </tr>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td>
                                            <input name="adId" value="${(ad.adId)!}" type="hidden">
                                        </td>
                                        <td class="text-right"><input class="btn btn-primary" onclick="adsubmit()"
                                                                      value="保存" type="button"></td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </form><!--表单数据-->
                </div>
            </div>
        </div>
    </section>
</div>
<script>
    function adsubmit() {
        $.ajax({
            type: "POST",
            url: "${ctx}/adManage/save",
            data: $('#handleposition').serialize(),// 你的formid
            dataType: "JSON",
            error: function (request) {
                alert("服务器繁忙, 请联系管理员!");
            },
            success: function (result) {
                console.log(result);
                if (result.code == 200){
                    layer.confirm("保存成功");
                }else {
                    layer.alert("保存失败");
                }
            }
        });
    }

    $(document).ready(function () {

        $('#begin').daterangepicker({
            format: "YYYY-MM-DD",
            singleDatePicker: true,
            showDropdowns: true,
            minDate: '2016-01-01',
            maxDate: '2030-01-01',
            startDate: '2016-01-01',
            locale: {
                applyLabel: '确定',
                cancelLabel: '取消',
                fromLabel: '起始时间',
                toLabel: '结束时间',
                customRangeLabel: '自定义',
                daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
                monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
                firstDay: 1
            }
        });

        $('#end').daterangepicker({
            format: "YYYY-MM-DD",
            singleDatePicker: true,
            showDropdowns: true,
            minDate: '2016-01-01',
            maxDate: '2030-01-01',
            startDate: '2016-01-01',
            /*
            startDate: moment().startOf('day'),
            endDate: moment(),
            minDate: '01/01/2014',    //最小时间
            maxDate : moment(), //最大时间
            dateLimit : {
                days : 30
            }, //起止时间的最大间隔
            showDropdowns : true,
            showWeekNumbers : false, //是否显示第几周
            timePicker : true, //是否显示小时和分钟
            timePickerIncrement : 60, //时间的增量，单位为分钟
            timePicker12Hour : false, //是否使用12小时制来显示时间
            ranges : {
                '最近1小时': [moment().subtract('hours',1), moment()],
                '今日': [moment().startOf('day'), moment()],
                '昨日': [moment().subtract('days', 1).startOf('day'), moment().subtract('days', 1).endOf('day')],
                '最近7日': [moment().subtract('days', 6), moment()],
                '最近30日': [moment().subtract('days', 29), moment()]
            },
            opens : 'right', //日期选择框的弹出位置
            buttonClasses : [ 'btn btn-default' ],
            applyClass : 'btn-small btn-primary blue',
            cancelClass : 'btn-small',
            format : 'YYYY-MM-DD HH:mm:ss', //控件中from和to 显示的日期格式
            separator : ' to ',
            */
            locale: {
                applyLabel: '确定',
                cancelLabel: '取消',
                fromLabel: '起始时间',
                toLabel: '结束时间',
                customRangeLabel: '自定义',
                daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
                monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
                firstDay: 1
            }
        });

    });

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
        $("#adCode").val(data.response.fileUrl);
        console.log('File uploaded triggered');
    });
    //============商品—上传图片======================

    function checkAmount(){

    }

</script>