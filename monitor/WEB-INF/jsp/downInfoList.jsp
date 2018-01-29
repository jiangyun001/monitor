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
<title>我的文档</title>
<script type="text/javascript" src="../css/jquery.min.js"></script>  
<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
<script type="text/javascript" src="../css/js/init-page.js"></script>
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<!-- <script type="text/javascript" src="../css/media/jquery.js"></script> -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script type="text/javascript">
$(document).ready(function(){
   page_init('tt','../downlaodManager/getDownlaodInfoPage');
   /* 
   $('#keyWord').textbox('textbox').bind(
			{ input: change, propertychange: change}
	); */
   
   $("#fileName").textbox('textbox').bind({
	   input:change,propertychange: change
   });
   function change(){
       submitSearchForm('serach','tt')
	}
	
 })

function downLoadFile(){
	var row = $("#tt").datagrid('getSelected');
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
	url="../downlaodManager/downlaodExcel?fileName="+row.fileName
	//downLoad
	$("#downLoad").attr("href",url)
	
}
 
</script>
</head>
<body>
<div id="tb" style="border-bottom:0;padding:0px;">
  <table style="width:100%;">
  	  <tr>
  	  	<td style="width:70%;">
	     	<a  id="downLoad" class="easyui-linkbutton" 
	     	data-options="iconCls:'icon-add'" 
	     	onclick="downLoadFile()">下载</a>
	  	</td>
	  	<td style="white-space:nowrap;width: 370px">
  	  	   <form id="serach" style="text-align:left" action= "../downlaodManager/getDownlaodInfoPage"
  	  	      method="post" data-options="novalidate:true">
  	  	      <input type="hidden" name=id>
              <input id="fileName" name="fileName" class="easyui-textbox" name="title"  style="width:260px" 
                data-options="label:'文件名'">   
              <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" 
                style="width:80px" onclick="submitSearchForm('serach','tt')">查询</a>
           </form>
	  	</td>
   	 </tr>
   </table>
</div>
	<table id="tt"  class="easyui-datagrid" style="width:100%;height:700px;padding:10px"
		rownumbers="true"
		title="我的文档"
		pagination="true"
		singleSelect="true"
		fitColumns="true"
		striped="true"
		iconCls="icon-save"
		toolbar="#tb">
		<thead>
			<tr> 
				<th hidden data-options="field:'id',width:550" align="center"></th>
				<th data-options="field:'fileName',width:550" align="center">文件名</th>
				<th data-options="field:'productTime',width:550" align="center">文件生成时间</th>
				<th data-options="field:'sucFlag',width:550"  align="center">是否成功</th>
			</tr>
		</thead>
	</table>
</body>
</html>