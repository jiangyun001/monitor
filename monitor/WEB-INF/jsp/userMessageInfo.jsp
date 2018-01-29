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
<title>用户消息</title>
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
	
	$.ajax({
		url:"../userMessageManager/getUserMessage",
		success:function(data){
			$('#userMessageForm').form("load",data)
		}
		
	})
	
})
function submitUserForm(){
	   $('#userMessageForm').form('submit',{
		   onSubmit:function(data){
		     return $(this).form('enableValidation').form('validate');
	     },
		 success:function(data) {
			 $.messager.show({
				title:'您有新的消息',
				msg:'设置成功',
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
		<form id="userMessageForm" class="easyui-form"  action="../userMessageManager/modifyUserMessage/" method="post" data-options="novalidate:true">
	     	 <input type="hidden" name="id">
	     	 <input type="hidden" name="userId">
		   <div style="margin-bottom:20px">
			 <input class="easyui-textbox" name="message" style="width: 80%" name="userId" label="充值消息" data-options="required:true">
			</div>
		</form>
			
		<div style="text-align:left;padding:5px 0">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUserForm()" style="width:80px ">提交</a>
		</div>
	   </div>
	</body>

</html>