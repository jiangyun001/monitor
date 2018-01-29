<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String path = request.getContextPath();
String requestSchema = application.getInitParameter("requestSchema");
String proxyServer = application.getInitParameter("proxyServer");
String basePath = (requestSchema == null ? request.getScheme() : requestSchema) +"://"+ (proxyServer == null ? (request.getServerName()+":"+request.getServerPort()) : proxyServer) +path+"/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>监控系统</title>
<script type="text/javascript" src="../../css/jquery.min.js"></script>  
<script type="text/javascript" src="../../css/jquery.easyui.min.js"></script>     
<script type="text/javascript" src="../../css/locale/easyui-lang-zh_CN.js"></script>   
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../../css/themes/default/easyui.css" />  
<link rel="stylesheet" type="text/css" href="../../css/themes/icon.css" />
<style>
#center {
    width: 500px;
    height: 300px;
    margin: auto;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
}
#centerbg {
    width: 1024px;
    height: 632px;
    background-image:url("../../css/themes/black/images/login.jpg");
    margin: auto;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
}
</style>
</head>
<body >
<div id="centerbg">
<div id="center">
	<div id="loginWin" 
		style="width:100%;height:300px;max-width:500px;padding:30px 60px;background-image: background-image:../../css/themes/black/images/login.jpg"
 	  minimizable="false" maximizable="false" resizable="false" collapsible="false">
    <!-- <div class="easyui-layout" fit="true">
    <div region="center" border="false" style="padding:5px;background:#fff;border:1px solid #ccc;"> -->
        <form id="loginForm" method="post">
            <div style="padding:5px 0;">
                <input class="easyui-textbox" name="userId" prompt="帐号:"  value="adminMonitor"
							data-options="label:'帐号:',iconCls:'icon-man',iconWidth:38" 
							iconWidth="28" style="width: 100%; height: 34px; padding: 10px;">
            </div>
            <div style="padding:5px 0;">
                <input class="easyui-passwordbox" value="888888" data-options="label:'密码:',iconCls:'icon-lock',iconWidth:38"
                  name="password"  prompt="Password" iconWidth="28" 
                  style="width:100%;height:34px;padding:10px">
           </div>
             
       	   </form>
            <p/>
          <div>
             <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding:5px 0px;width:100%;" onclick="login()">
				<span style="font-size:14px;">登陆</span>
			</a>
			<p/>
        </div>
        	<div style="padding:5px ;text-align: center;color: red;" id="showMsg"></div>
        </div>
       </div>
    </div>
</body>
<script type="text/javascript">
document.onkeydown = function(e){
    var event = e || window.event;  
    var code = event.keyCode || event.which || event.charCode;
    if (code == 13) {
        login();
    }
}

$(function(){
    $("input[name='login']").focus();
});

function cleardata(){
    $('#loginForm').form('clear');
}
function login(){
     if($("input[name='login']").val()=="" || $("input[name='password']").val()==""){
         $("#showMsg").html("用户名或密码为空，请输入");
         $("input[name='login']").focus();
    }else{
            //ajax异步提交  
           $.ajax({            
                  type:"POST",   
                  url:"../../index/app", 
                  data:$("#loginForm").serialize(),   //序列化               
                  error:function(request){      // 设置表单提交出错
                	  if(request.responseText.indexOf("用户被冻结")>0){
                		  $("#showMsg").html("用户被冻结");  
                	  }else{
                      	$("#showMsg").html("用户名或密码错");  //登录错误提示信息
                	   } 
                	  },
                  success:function(data) {
                      document.location = "../../index/forwaeCreateApp";
                  }            
            });       
        } 
}
</script>
</html>