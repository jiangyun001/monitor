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
<title>财务明细</title>

<script type="text/javascript" src="../css/jquery.min.js"></script>  
<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" id="easyuiTheme" type="text/css" href="../css/themes/default/easyui.css" />  
<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />     
<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
<script type="text/javascript" src="../css/js/init-page.js"></script>    
	
<script type="text/javascript">
  $(document).ready(function(){
	page_init("tt","../netFinanceManager/getFinanceInfoPageList");
	$('#userids').textbox('textbox').bind(
	 	{input:change,propertychange:change}
	);
	function change(){
	   submitSearchForm('serchForm','tt')
	}
   })
   
 function getDetailDataTables(url){
	 var rows = $('#tt').datagrid('getSelected');
	 url=url+"?fuserId="+rows.fuserId;
   $.ajax({
	   type : "POST",
       url : url,
       success : function(data) {
    	   /* $('#'+dataId).datagrid("loadData",$.parseJSON(data));  */
    	   $('#detailFinancel').datagrid("loadData",data);
       },
       error : function(err) {
           $.messager.alert('操作提示', '获取信息失败...请联系管理员!', 'error');
           $("#detailFinancel").datagrid("loaded"); //移除屏蔽
       }
   })
 }
   function formatOper(val,row,index){  
	    return '<a href="#" iconCls="icon-search"  class="easyui-linkbutton"  onclick="lookDetail()">查看明细</a>';  
	}
   
   function lookDetail(){
	  getDetailDataTables('../netFinanceManager/getSeachDetail');opratorDailog('detailId','open')	   
   }
</script>
</head>
<body>
	<div id="tb" style="border-bottom:0;padding:0px;"> 
	 <table style="width:100%;">
	   <tr>
	   	<td style="white-space:nowrap;">
	   		<a class="easyui-linkbutton" iconCls='icon-search' onclick="getDetailDataTables('../netFinanceManager/getSeachDetail');opratorDailog('detailId','open')">查看明细</a>
   		</td>
    	 <td style="white-space:nowrap;" align="right">
               <!-- <input id="key" class="mini-textbox" data-options="iconCls:'icon-search'" />   
               <a class="easyui-linkbutton" onclick="search()">查询</a> -->
             <form id="serchForm" action="../netFinanceManager/getUserFinanceDetail">
               <input id="userids" name="searchfiled" class="easyui-textbox" data-options="label:'用户名'" />   
               <a class="easyui-linkbutton" iconCls='icon-search' onclick="submitSearchForm('serchForm','tt')">查询</a>
             </form>
         </td>
       </tr>
      </table>
	</div>
	
	<table id="tt" class="easyui-datagrid" style="width:100%;height:700px"
		rownumbers="true" 
		pagination="true"
		singleSelect="true" 
		fitColumns="true"
		title="财务明细" iconCls="icon-save"
		toolbar="#tb">
	  <thead>
		 <tr> 
			<th hidden data-options="field:'id'" ></th>
			<th data-options="field:'fuserId',width:550" align="center">用户ID</th>
			<th data-options="field:'fuserName',width:550" align="center">用户名</th>
			<th data-options="field:'moneyBalance',width:550" align="center">余额</th>
			<th data-options="field:'dateFee',width:550" align="center">当日消费</th>
			<th data-options="field:'_operate',width:80,align:'center',formatter:formatOper">操作</th>
		  </tr>
	   </thead>
	</table>

	<div id="detailId" class="easyui-dialog" title="财务明细" style="width:800px;padding:0px;height:740px">
		<table id="detailFinancel" class="easyui-datagrid" 
				rownumbers="true" 
				pagination="true"
				singleSelect="true" 
				fitColumns="true"
				style="width:100%;height:700px"
				>
				<thead>
					<tr> 
						<th data-options="field:'userId',width:120" align="center">用户ID</th>
						<th data-options="field:'moneyBalance',width:550" align="center">余额</th>
						<th data-options="field:'moneyAmonut',width:550" align="center">金额变动</th>
						<th data-options="field:'amonutTime',width:550" align="center">充值日期</th>
						<th data-options="field:'moneyDebit',width:550" align="center">扣费金额</th>
						<th data-options="field:'debitTime',width:550" align="center">扣费时间</th>
						<th data-options="field:'debitReason',width:550" align="center">变动原因</th>
						<th data-options="field:'debitWordId',width:550" align="center">扣费单词</th>
					</tr>
				</thead>
		</table>
	</div>
</body>
</html>