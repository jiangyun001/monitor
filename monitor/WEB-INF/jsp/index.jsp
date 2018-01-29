<%@ page language="java" contentType="text/html; charset=utf-8"  
    pageEncoding="utf-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">  
<title>监控系统</title>  
	<script type="text/javascript" src="../../css/jquery.min.js"></script>  
	<script type="text/javascript" src="../../css/jquery.easyui.min.js"></script>     
	<script type="text/javascript" src="../../css/locale/easyui-lang-zh_CN.js"></script>   
	<!-- <script type="text/javascript" src="../../css/js/left.js"></script>   -->
	<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../../css/themes/default/easyui.css" /> 
	<link rel="stylesheet" type="text/css" href="../../css/themes/icon.css" />     
</head>  
<body class="easyui-layout">  
    <!--  页面上方区域     -->  
    <div region="north" split="true" style="height:60px;font-size: 26px;text-align: center;padding: 8px;background-color: #D1EEEE">网站监控系统</div>  
      
    <!--  页面左边区域    -->  
    <div region="west" style="width:180px" title="监控系统功能" split="true">  
        <!-- 树形结构的功能列表 -->  
        <ul id="tree"></ul>  
    </div>  
      
    <!--  页面中间内容（主面板）区域     -->  
    <div region="center">  
        <div class="easyui-tabs" fit="true" border="false" id="tabs">  
           <!-- <div title="监控网站库">欢迎来到监控系统</div> -->  
        </div>  
    </div>  
</body>  
<script type="text/javascript">
	


</script>
</html>  