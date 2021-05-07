<!-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>shop商城</title>
<!-- 禁止浏览器发起 favicon.ico 请求 -->
<link rel="icon" href="data:image/ico;base64,aWNv">
<link href="${ctx}/static/css/main.css" rel="stylesheet" type="text/css"/>
<!--[if IE 6]>
<link href="${ctx}/static/css/main.ie6.css" rel="stylesheet" type="text/css"/>
<![endif]-->
<!--[if IE 7] -->
<link href="${ctx}/static/css/main.ie7.css" rel="stylesheet" type="text/css"/>
<!-- 引入 element-ui 的样式，-->
<link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
<!-- 必须先引入vue，  后使用element-ui -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.17/dist/vue.js"></script>
<!-- 引入element 的组件库-->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<![endif]-->
<script type="text/javascript" src="${ctx}/static/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-imgslideshow.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ks-switch.js"></script>
<script type="text/javascript" src="${ctx}/static/js/lib.js"></script>
<script type="text/javascript" src="${ctx}/static/js/layer/layer.js"></script>
<script type="text/javascript" src="${ctx}/static/js/doT.min.js"></script>