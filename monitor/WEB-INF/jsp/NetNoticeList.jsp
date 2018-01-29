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
<title>公告信息</title>
<script type="text/javascript" src="../css/jquery.min.js"></script>  
<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
<script type="text/javascript" src="../css/js/init-page.js"></script>
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />  
<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"> 
<!-- <link href="../css/wenbe/bootstrap.css" rel="stylesheet">
<link href="../css/wenbe/bootstrap.js" rel="stylesheet">
<link href="../css/wenbe/summernote.css" rel="stylesheet"> -->
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- <script type="text/javascript" src="../css/media/jquery.js"></script> -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script type="text/javascript">
$(document).ready(function(){
   page_init('tt','../netNoticeManager/getNetNoticeDataList');
   $('#userTree').tree({cascadeCheck:$(this).is(':checked')});
   $('#summernote').summernote({
	   height: 400,
   })
   $('#summernoteModify').summernote({
	   height: 400,
   })
 })
function abc(){
	$('#accepthidden').val($('#summernote').summernote('code'))
	submitForm('noticeForm','tt','../netNoticeManager/getNetNoticeDataList')
}

function getChecked(){
	var nodes = $('#userTree').tree('getChecked');
	var s = '';
	for(var i=0; i<nodes.length; i++){
		if (s != '') s += ',';
		s += nodes[i].text;
	}
	//$('#accepters').val(s.toString());
	$("#accepters").textbox("setValue",s.toString());
	//$('#accepters').val(s.toString());
	//console.log($('#accepters').val(s.toString()));
	
	
}

function dataDailogs(dataId,idDailog,formId,url){
	   var row = $('#'+dataId).datagrid('getSelected');
	   if(row==null){
			$.messager.show({
				title:'您有新的消息',
				msg:'请选择一条记录',
					showType:'show',
					style:{
						right:'',
						top:document.body.scrollTop+document.documentElement.scrollTop,
						bottom:''
		    }
		 })
			return ;
	   }
	   var id=row.id;
	   var url = url+"?id="+id
	   $.ajax({
	  	 url:url,
	  	 type : "POST",
	  	 success : function (data){
	  		 $('#'+idDailog).dialog("open");
	  		 $('#notice').html(data.notice);
	  	 
	  	 }
	})
}

function dataDailogModify(dataId,idDailog,formId,url){
	   var row = $('#'+dataId).datagrid('getSelected');
	   if(row==null){
			$.messager.show({
				title:'您有新的消息',
				msg:'请选择一条记录',
					showType:'show',
					style:{
						right:'',
						top:document.body.scrollTop+document.documentElement.scrollTop,
						bottom:''
		    }
		 })
			return ;
	   }
	   var id=row.id;
	   var url = url+"?id="+id
	   $.ajax({
	  	 url:url,
	  	 type : "POST",
	  	 success : function (data){
	  		 $('#'+formId).form('load',data);
	   		//$('#summernoteModify').summernote('editor.insertText',data.strcontent)
	   		$('#summernoteModify').summernote('code', data.strcontent);;
	  		 $('#'+idDailog).dialog("open")
	  	 }
	    })
	}
function abcModify(){
	
	$('#accepthiddenModify').val($('#summernoteModify').summernote('code'))
	submitForm('modifyNoticeForm','tt','../netNoticeManager/getNetNoticeDataList')
	
}
</script>
</head>
<body>
<div id="tb">
  <table style="width:100%;">
  	  <tr>
  	  	<td style="width:70%;">
	     	<c:if test="${user.depId == 1}"><a  id="add" class="easyui-linkbutton" 
	     		data-options="iconCls:'icon-add'" 
	     		onclick="$('#dlg').dialog('open')">发布消息</a>
	     	</c:if>
	     	<a href="#" class="easyui-linkbutton" 
		     	onclick="dataDailogs('tt','readNotice','readForm','../netNoticeManager/readNotice/')"
		     	style="width:80px" iconCls="icon-search">查看</a>
	     	<c:if test="${user.depId == 1}">
	     		<a href="#" class="easyui-linkbutton" 
		     		onclick="dataDailogModify('tt','modifyNotice','modifyNoticeForm','../netNoticeManager/selectNoticeInfo/')"
		     		style="width:80px" iconCls="icon-cut">修改</a>
     		</c:if>
     		<a href="#" class="easyui-linkbutton" 
		     		onclick="deleteForm('','tt','../netNoticeManager/deleteNoticeMessage','../netNoticeManager/getNetNoticeDataList')"
		     		style="width:80px" iconCls="icon-remove">删除</a>
	  	</td>
   	 </tr>
   </table>
</div>

<table id="tt"  class="easyui-datagrid" style="width:100%;height:700px"
	rownumbers="true" 
	pagination="true"
	singleSelect="true" 
	fitColumns="true"
	striped="true"
	title="公告" iconCls="icon-save"
	toolbar="#tb">
	<thead>
		<tr> 
			<th hidden data-options="field:'id',width:550" align="center"></th>
			<th data-options="field:'title',width:550" align="center">标题</th>
			<th data-options="field:'userTeam',width:550"  align="center">用户组</th>
			<th data-options="field:'userVisual',width:550"  align="center">类别</th>
			<th data-options="field:'sendTime',width:550"  align="center">发送时间</th>
		</tr>
	</thead>
</table>
<div id="dlg" class="easyui-dialog" title="发布消息"
		data-options="iconCls:'icon-save'"
		style="width: 1000px; height: 700px; padding: 10px">
	<table>	
	<tr>
	<td width="80%">
		<form id="noticeForm" action="../netNoticeManager/submitNotice/">
		 <div style="margin-bottom:20px">
		   <input id="title" class="easyui-textbox" name="title"  style="width:80%" 
	               data-options="label:'标题',required:true">   
		 </div>
		 <div style="margin-bottom:20px">
		 	<label style="width: 80px">选择联系人</label>
     		<input type="checkbox" name="userTeam" value="1" id="in1" checked="checked" /><label for="in1">代理组</label>
            <input type="checkbox" name="userTeam" value="2" id="in8" /><label for="in8">用户组</label>
		 </div>
		 <div style="margin-bottom:20px">
		 	<label style="width: 80px">选择消息组</label>
		 	<input type="radio" name="userVisual" value="0">公告</input>
		 	<input type="radio" name="userVisual" value="1">产品用法</input>
		 
		 </div>
		 
		 <div id="summernote"><p>Hello </p></div>
			  <input type="text" hidden name="accepthidden" id="accepthidden">
	 	 <div style="text-align:center;padding:5px">
			<a href="#" class="easyui-linkbutton" onclick="abc()" style="width:80px">推送</a>
		 </div>
		 </form>
    </td>
	</tr>
	</table>
</div>

<div id="readNotice" class="easyui-dialog" title="发布消息"
		data-options="iconCls:'icon-save'"
		style="width: 1200px; height: 700px; padding: 10px">
		<p id="notice"></p>
</div>

<div id="modifyNotice" class="easyui-dialog" title="修改消息"
	data-options="iconCls:'icon-save'"
	style="width: 1000px; height: 700px; padding: 10px">
	<table>	
	<tr>
		<td width="80%">
			<form id="modifyNoticeForm" action="../netNoticeManager/modyfyNoticeMessage/">
			<input type="hidden" name="id">
			 <div style="margin-bottom:20px">
			   <input id="title" class="easyui-textbox" name="title"  style="width:80%" 
		               data-options="label:'标题',required:true">   
			 </div>
			 <div style="margin-bottom:20px">
				 	<label style="width: 80px">选择联系人</label>
						<input type="checkbox" id="proxyChecked" name="userTeam" value="1" id="in1" checked="checked" /><label for="in1">代理组</label>
		            	<input type="checkbox" id="userChecked" name="userTeam" value="2" id="in8" /><label for="in8">用户组</label>
		            <input type="checkbox" id="userChecked" name="userTeam" value="1,2" id="in8" /><label for="in8">用户组和代理组</label>
		          <!-- <input id="accepters" class="easyui-textbox" 
		          name="accepter" style="width:80%"  
		          name="user" readonly="readonly" data-options="label:'收件人',prompt:'请选择右边的联系人，并确定',required:true"/> -->
			 </div>
			 
			 <div id="summernoteModify"></div>
				  <input type="text" hidden name="accepthiddenModify" id="accepthiddenModify">
		 	 <div style="text-align:center;padding:5px">
				<a href="#" class="easyui-linkbutton" onclick="abcModify()" style="width:80px">修改</a>
			 </div>
			 </form>
	    </td>
	</tr>
	</table>
</div>
</body>
</html>