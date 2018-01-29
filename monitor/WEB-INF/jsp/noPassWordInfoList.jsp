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
	<title>异常词</title>
	
	<script type="text/javascript" src="../css/jquery.min.js"></script>  
	 
	<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>    
	<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" /> 
	<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />     
	<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="../css/js/init-page.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			page_init()
			
		})
		
		/* function updateForm() {
			var row = $('#tt').datagrid('getSelected');
			url="../net/updateNetInfoAction/?href="+row.href
			$("#update").attr("href",url);
		} */
		function page_init() {
			
		    $("#tt").datagrid({
		        url: "../netWordManager/getNetNoWordPage/", //actionName
		        queryParams:{pageNumber:1,pageSize:20},//查询参数
		        loadMsg:"正在加载数据...",
		        rownumbers:true,//查询结果在表格中显示行号
		        fitColumns:true,//列的宽度填满表格，防止下方出现滚动条。
		        pageNumber:1,   //初始页码，得在这设置才效果，pagination设置没效果。
		        pagination: true//分页控件
		        //如果后端返回的json的格式直接是data={total:xx,rows:{xx}},不需要设置loadFilter了，
		        //如果有多层封装，比如data.jsonMap = {total:xx,rows:{xx}}，则需要在loadFilter处理一下。
		        /*
		        loadFilter: function(data){
		            if(data.jsonMap) {
		                return data.jsonMap;
		            }
		        }*/
		    });
		
		    var p = $('#tt').datagrid('getPager');
		    $(p).pagination({
		        pageSize: 20,//每页显示的记录条数，默认为10
		        pageList: [20,30,40,50],//可以设置每页记录条数的列表
		        beforePageText: '第',//页数文本框前显示的汉字
		        afterPageText: '页    共 {pages} 页',
		        displayMsg: '共 {total} 条记录',
		        onSelectPage: function (pageNumber, pageSize) {//分页触发
		            find(pageNumber, pageSize);
		        }
		    });
		
		}
		
		function find(pageNumber, pageSize)
		{
		        $("#tt").datagrid('getPager').pagination({pageSize : pageSize, pageNumber : pageNumber});//重置
		        $("#tt").datagrid("loading"); //加屏蔽
		        $.ajax({
		            type : "POST",
		            dataType : "json",
		            url : "../netWordManager/getNetNoWordPage/",
		            data : {
		                pageNumber : pageNumber,
		                pageSize : pageSize
		            },
		            success : function(data) {
		                $("#tt").datagrid('loadData',data);
		                $("#tt").datagrid("loaded"); //移除屏蔽
		            },
		            error : function(err) {
		                $.messager.alert('操作提示', '获取信息失败...请联系管理员!', 'error');
		                $("#tt").datagrid("loaded"); //移除屏蔽
		            }
		        });
		
		}
function deleteNoPass(){
	var rows = $('#tt').datagrid('getSelections');
	if(rows==""||rows==null){
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
   var ids = [];
   var users=[]
   for(var i=0; i<rows.length; i++){
		ids.push(rows[i].id);
		users.push(rows[i].wordCustmer);
		//
   }
   var idarray=ids.join(',');
   var userarray=users.join(',');
   url="../netWordManager/deletePassWord"+"?ids="+idarray+"&users="+userarray;
   $.ajax({
	  url:url,
	  datatype:"json",
	  success : function(data) {
		  console.log(data)			//删除成功或者失败
		  $.messager.show({
   			title:'您有新的消息',
   			msg:data,
   				showType:'show',
   				style:{
   					right:'',
   					top:document.body.scrollTop+document.documentElement.scrollTop,
   					bottom:''
   				}
   				
   		 });
		  page_init()
	  }
		
	})		


}	

	
</script>
</head>
<body>
			<!-- url="../net/getNetInfoAllAction/" -->
		<c:if test="${user.roleId==2}">
		  <div id="tb" style="width: 100%">
			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" 
	                style="width:80px" onclick="deleteNoPass()">删除</a>
			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" 
	                style="width:170px" onclick="dataDailog('tt','modifyDlg','modifyForm','../netWordManager/getUpdatePage')">修改再提交</a>
		  </div>
		</c:if>
		<table id="tt" class="easyui-datagrid" style="width:100%;height:700px"
			rownumbers="true" 
			pagination="true"
			singleSelect="flase" 
			fitColumns="true"
			striped="true"
			title="工具栏" iconCls="icon-save"
			toolbar="#tb">
			<thead>
				<tr> 
					<th data-options="field:'check',checkbox:true"></th>
					<th hidden data-options="field:'id',width:550" align="center"></th>
					<th data-options="field:'keyWord',width:550" align="center" sortable="true">关键词</th>
					<th data-options="field:'netAddress',width:550" align="center" sortable="true">网址</th>
					<th data-options="field:'comfirmTime',width:550" align="center" sortable="true">不通过时间</th>
					<th data-options="field:'flag',width:550"  align="center">状态</th>
					<th data-options="field:'wordCustmer',width:550"  align="center">客户</th>
				</tr>
			</thead>
		</table>
		<div id="modifyDlg" class="easyui-dialog" title="修改关键词"
		data-options="iconCls:'icon-save'"
		style="width: 400px; height: 340px; padding: 10px">
		<form id="modifyForm" class="easyui-form"
			action="../netWordManager/updataWordNoPass/" method="post"
			data-options="novalidate:true">
			
			<input type="hidden" name="id" />
			<div style="margin-bottom: 20px">
				<input class="easyui-textbox" name="keyWord" style="width: 100%"
					data-options="label:'关键词',required:true" >
			</div>
			<div style="margin-bottom: 20px">
				<input class="easyui-textbox" name="netAddress" style="width: 100%"
					data-options="label:'网&nbsp;&nbsp;&nbsp;&nbsp;址',required:true" >
			</div>
			
			<div style="margin-bottom: 20px">
				<!-- <input class="easyui-textbox" name="userMoney" style="width: 100%"
					data-options="label:'金&nbsp;&nbsp;&nbsp;&nbsp;额',required:true"> -->
				<input  class="easyui-numberbox" name="userMoney"  
		 	 	  data-options="label:'金&nbsp;&nbsp;&nbsp;&nbsp;额',required:true,min:0,precision:2">
			</div>
			<div style="margin-bottom: 20px">
				<input class="easyui-textbox" name="flag" style="width: 100%"
					data-options="label:'状&nbsp;&nbsp;&nbsp;&nbsp;态',required:true" readonly="readonly">
			</div>
		</form>
		<div style="text-align: center; padding: 5px 0">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="submitForm('modifyForm','tt','../netWordManager/getNetNoWordPage/')" style="width: 80px">提交</a>
		</div>
	</div>
</body>
</html>