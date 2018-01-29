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
	<title>邮件统计</title>
	
	<script type="text/javascript" src="../css/jquery.min.js"></script>  
	<script type="text/javascript" src="../css/jquery.easyui.min.js"></script> 
	<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>      
	<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />     

	 <script type="text/javascript">
		function submitForm(){
			$('#serach').form('submit',{
				onSubmit:function(){
					page_init()
				}
			});
		}
		function clearForm(){
			$('#serach').form('clear');
		}
		function updateForm() {
			var row = $('#tt').datagrid('getSelected');
			url="../net/updateNetInfoAction/?href="+row.href
			$("#update").attr("href",url);
		}
		function deleteForm(){
			var row = $('#tt').datagrid('getSelected');
			url="../net/deleteNetInfoAction/?href="+row.href
			$("#delete").attr("href",url);
		}
		
	</script>
</head>
<body>
	  <div  class="easyui-panel" title="收索" style="width:100%;padding:30px 60px;">
		<form id="serach" action="../netInfoMail/getNetInfoAllMail/" style="text-align:left" class="easyui-form" method="post" data-options="novalidate:true">
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" name="href" style="width:100%;max-width:400px" data-options="label:'网址',required:false">
			</div>
			<div style="text-align:center;padding:5px 0">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">收索</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">清除</a>
			</div>
		</form>
		</div>
		
		
			<!-- url="../netInfoMail/getNetInfoAllMail/" -->
		<table id="tt" class="easyui-datagrid" style="width:100%;height:700px"
			rownumbers="true" 
			pagination="true"
			singleSelect="true" 
			fitColumns="true"
			title="DataGrid with Toolbar" iconCls="icon-save"
			toolbar="#tb">
			<thead>
				<tr> 
					<th data-options="field:'href',width:550" align="center">网址</th>
					<th data-options="field:'empName',width:550" align="center">公司名称</th>
					<th data-options="field:'empEmai',width:550" align="center">邮箱地址</th>
					<th data-options="field:'errCode',width:550" align="center">错误码</th>
					<th data-options="field:'errMsg',width:550" align="center">错误消息</th>
					<th data-options="field:'sendTime',width:550" align="center">发送时间</th>
				</tr>
			</thead>
			<%-- <tbody>
				<c:forEach items="${listnet}" var="netInfo"> 
					<tr>
						<td width="550" align="center"><c:out value="${netInfo.href}" /></td>
						<td width="550" align="center"><c:out value="${netInfo.num}"/></td>
						<td width="550" align="center"><c:out value="${netInfo.createTime}"/></td>
					</tr>			
				</c:forEach>
			 </tbody> --%>
		</table>
	
	<!-- <div id="tb">
		<a  href="../net/addNetInfoAction/" class="easyui-linkbutton" iconCls="icon-add" onclick="$('#dlg').dialog('open')">Add</a>
		<a  href="../net/addNetInfoAction/" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#dlg').dialog('open')">发送邮件</a>
		<a id="update" href="#" class="easyui-linkbutton" iconCls="icon-cut" onclick="updateForm()"> 修改</a>
		<a id="delete" href="delete" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" plain="true" onclick="deleteForm()">Remove</a>
	</div> -->
		
</body>
	<script type="text/javascript">
	/* $(document).ready(function() {
	    page_init();
	}); */
	function page_init() {
	
	    $("#tt").datagrid({
	        url: "../netInfoMail/getNetInfoAllMail", //actionName
	        queryParams:{pageNumber:1,pageSize:10},//查询参数
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
	        pageSize: 10,//每页显示的记录条数，默认为10
	        pageList: [10,20,30,40],//可以设置每页记录条数的列表
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
	            url : "../netInfoMail/getNetInfoAllMail/",
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
	</script>
</html>