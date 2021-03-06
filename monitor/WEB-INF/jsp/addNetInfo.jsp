<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="../../css/jquery.min.js"></script>  
<script type="text/javascript" src="../../css/jquery.easyui.min.js"></script> 
<script type="text/javascript" src="../../css/locale/easyui-lang-zh_CN.js"></script>      
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../../css/themes/icon.css" />     

<title>添加网址</title>
<script type="text/javascript">
		function submitForm(){
			$('#add').form('submit',{
				url:"../addNetInfoAction/",
				
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},
				success:function(data){
					if(data.indexOf("repeat") > 0 )
					{
						$.messager.show({
							title:'您有新的消息',
							msg:'添加失败，网址重复',
							showType:'show',
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:''
							}
						});
					}else{
						$.messager.show({
							title:'您有新的消息',
							msg:'添加成功',
							showType:'show',
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:''
							}
						});
					}
	    	    }
			});
		}
		function clearForm(){
			$('#add').form('clear');
		}
	</script>
</head>
<body>
	<div class="easyui-panel" title="添加网址" style="width:100%;max-width:400px;padding:30px 60px;">
		<form id="add" class="easyui-form"  action="../addNetInfoAction/" method="post" data-options="novalidate:true">
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="href"  style="width:100%"  data-options="label:'网址',required:true,validType:'url'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="empName"   style="width:100%"  data-options="label:'企业名称',required:true">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="empEmai"  style="width:100%"  data-options="label:'邮箱',required:true,validType:'email'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="cls"  style="width:100%"  data-options="label:'类别',required:true">
			</div>
		</form>
		<div style="text-align:center;padding:5px 0">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">Submit</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">Clear</a>
		</div>
	</div>
</body>
</html>