<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fn"%>
<%@ page isELIgnored="false"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改材料</title>
<script type="text/javascript" src="../css/jquery.min.js"></script>  
<script type="text/javascript" src="../css/js/zhuzi.js"></script>  
<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script> 
<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
<script type="text/javascript" src="../css/js/init-page.js"></script> 
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />     
<script type="text/javascript">

$(document).ready(function(){
	$.extend($.fn.validatebox.defaults.rules, {  
	    equalTo: {
	        validator:function(value,param){
	            return $(param[0]).val() == value;
	        },
	        message:'字段不匹配'
	    }
	           
	});
	$.ajax({
		url:"../userManager/getUserInfo",
		success:function(data){
			$('#userInfoForm').form("load",data)
			
		}
		
	})
	
})
function submitUserForm(){
	   $('#userInfoForm').form('submit',{
		   onSubmit:function(data){
		     return $(this).form('enableValidation').form('validate');
	     },
		 success:function(data) {
			 $.messager.show({
				title:'您有新的消息',
				msg:'已提交'+data+"条,退出重新登陆后生效",
					showType:'show',
					style:{
						right:'',
						top:document.body.scrollTop+document.documentElement.scrollTop,
						bottom:''
					}
				
	    })
	   }
	})
}

</script>
</head>
<body>
			<!-- url="../net/getNetInfoAllAction/" -->
	<div class="easyui-panel" style="width:100%;padding:30px 60px;">
		<form id="userInfoForm" class="easyui-form"  action="../userManager/updateUserInfoMine/" method="post" data-options="novalidate:true">
	     	 <input type="hidden" name="id">
		   <div style="margin-bottom:20px">
			 <input class="easyui-textbox" name="userName" label="用户名" >
			</div>
		   <div style="margin-bottom:20px">
			 <input class="easyui-textbox" name="userEmail" label="用户邮箱"  >
			</div>
			
		    <div style="margin-bottom:20px">
			  <input class="easyui-textbox" name="userMobile" label="手机号码"  >
			</div>
			
		    <div style="margin-bottom:20px">
			  <input class="easyui-textbox" name="userQq" label="QQ"  >
			</div>
		    <div style="margin-bottom:20px">
			  <input class="easyui-textbox" name="userWechat" label="微信"  >
			</div>
			
		    <div style="margin-bottom:20px">
			新密码  
			  <input type="password" 
			  id="passwordold" name="passwordold" 
			  validType="length[4,32]" 
			  class="easyui-validatebox" 
			   label="新密码">
			</div>
			
		    <div style="margin-bottom:20px">
		    新密码  
			  <input type="password" name="repassword" id="repassword" class="easyui-validatebox"
				 validType="equalTo['#passwordold']" 
				 invalidMessage="两次输入密码不匹配"/>
			</div>
		</form>
			
		<div style="text-align:left;padding:5px 0">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUserForm()" style="width:80px ">修改</a>
		</div>
	   </div>
	</body>

</html>