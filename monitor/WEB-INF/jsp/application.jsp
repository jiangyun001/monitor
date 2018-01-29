<%@ page language="java" contentType="text/html; charset=utf-8"  
    pageEncoding="utf-8"%>  
<%@ include file="/WEB-INF/jsp/includ_css.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">  
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>监控系统</title>  
	<script type="text/javascript" src="../css/jquery.min.js"></script>  
	<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>     
	<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>   
	<script type="text/javascript" src="../css/js/left.js"></script>  
	<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>  
	<script type="text/javascript" src="../css/js/init-page.js"></script>   
	
	<script type="text/javascript">
		function proAll(){
			$.messager.alert('操作提示',"产品升级中，敬请期待",'success');
		}
		changeTheme = function(themeName) {  
		    var $easyuiTheme = $('#easyuiTheme');  
		    var url = $easyuiTheme.attr('href');  
		    var href = url.substring(0, url.indexOf('themes')) + 'themes/' + themeName + '/easyui.css';  
		    $easyuiTheme.attr('href', href);  
		    var $iframe = $('iframe');  
		    if ($iframe.length > 0) {  
		        for ( var i = 0; i < $iframe.length; i++) {  
		            var ifr = $iframe[i];  
		            $(ifr).contents().find('#easyuiTheme').attr('href', href);  
		        }  
		    } 
		    $.cookie('easyuiThemeName', themeName, {  
		        expires : 7 ,
		        path: '/' 
		    });  
		}  
		if($.cookie('easyuiThemeName')){  
		    changeTheme($.cookie('easyuiThemeName'));  
		}  
		
</script>
</head>  
<body class="easyui-layout">  
    <!--  页面上方区域     -->  
   
    <div region="north" split="true" style="height:80px;font-size: 26px;text-align: left;padding: 8px;position:relative;">
		<div region="west" style="width:180px;display:inline-block;"  >seo监系统后台</div>
		<div region="east" style="text-align: right; display:inline-block;width:1200px;font-size: 18px">您好:${user.userName}</div>
		<div region="east" style="text-align: right; display:inline-block;width:200px;font-size: 10px">
			<a href="#" onclick="proAll()">产品大全|</a>
			<a href="../index/loginOut">退出</a>
			<!-- <div style="position: absolute;right: 14px;top:42px;">  
	           <div class="easyui-panel" style="padding:5px;font-size: 20px;font-weight: 900;">   -->
	            <a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_pfMenu',iconCls:'icon-ok'">更换皮肤</a>  
	          <!--  </div>  --> 
	       </div>  
		</div>
		<div id="layout_north_pfMenu" style=" display: none;">  
	       <div onclick="changeTheme('default');">默认</div>  
	       <div onclick="changeTheme('black');">酷黑</div>  
	       <div onclick="changeTheme('bootstrap');">根站</div>  
	       <div onclick="changeTheme('gray');">银灰</div>  
	       <div onclick="changeTheme('metro');">地铁</div>  
	       <div onclick="changeTheme('material');">铁路</div>  
	       <div onclick="changeTheme('ui-cupertino');">苹果</div>  
	       <div onclick="changeTheme('ui-dark-hive');">雅黑</div>  
	       <div onclick="changeTheme('ui-pepper-grinder');">纸张</div>  
	       <div onclick="changeTheme('ui-sunny');">晴朗</div>  
  	 </div> 
		
    <!--  页面左边区域    -->  
    <div region="west" style="width:180px" title="监控系统功能" split="true">  
        <!-- 树形结构的功能列表 -->  
        <ul id="tree"></ul>  
    </div>  
      
    <!--  页面中间内容（主面板）区域     -->  
    <div region="center">  
        <div class="easyui-tabs" fit="true" border="false" id="tabs" style="position: relative;">  
	           <!-- <div title="监控网站库">欢迎来到监控系统</div> -->  
        </div>  
    </div>  
</body>  

</html>  