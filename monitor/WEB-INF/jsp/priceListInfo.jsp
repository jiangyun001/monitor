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
<title>价格查询</title>
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
	page_init("tt","../priceManager/priceCheck/")
})

function findPageList(dataId,url,formId,dlgId){
	var ids = [];
	var words = [];
	var moneys = [];
    var rows = $('#'+dataId).datagrid('getSelections');
    if(rows==null||rows.length == 0){
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
    
    for(var i=0; i<rows.length; i++){
		ids.push(rows[i].id);
		words.push(rows[i].keyWord);
		moneys.push(rows[i].keyMoney);
	 }
	
    var ids=ids.join(',')
    var keyWords=words.join(',')
    var keyMoneys=moneys.join(',')
	$.ajax({
	   url:url+"?ids="+ids+"&keyWords="+keyWords+"&keyMoneys="+keyMoneys,
	   success: function(data){
		  $('#'+formId).form('load',data);
		  $('#'+dlgId).dialog("open") // 打开dialog
		 }
	});
}

function updatePage(){
	var row=$('#tt').datagrid('getSelected')
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
    var ids=row.id
	$.ajax({
	   url:"../netWordManager/getUpdatePage/?id="+ids,
	   success: function(data){
			  $('#updateForm').form('load',data);
			  $("#updlg").dialog("open") // 打开dialog
			  
		  }
	});
}
	
function showTd(){
	$('#yc').show()
	page_init("ttProxy","../priceManager/PorxyPriceCheck/")
}	

</script>
</head>
<body>
			<!-- url="../net/getNetInfoAllAction/" -->
	<div  class="easyui-panel" style="width:100%;padding:30px 60px;text-align: center;display: table-cell;" >
		<table style="margin:auto;">
		 <tr>
		 <td >
		<div id="tb"style="border-bottom:0;padding:0px;"> 
		 <table style="width:100%;">
		  <tr>
	         <td style="width:100%;">
			 </td>
			 <td style="white-space:nowrap;">
			 	<form id="serach" action="../priceManager/priceCheck">
	               <input id="key" class="easyui-textbox" name="keyWord" data-options="label:'关键词',iconCls:'icon-search'"  style="width: 300px"/>   
	               <a class="easyui-linkbutton" iconCls="icon-search"  onclick="submitSearchForm('serach','tt')">查询</a>
	             </form>
	         </td>
	         </tr>
	        </table>
        </div>
		<table id="tt" class="easyui-datagrid" style="width:700px;height:760px"
			rownumbers="true" 
			pagination="true"
			singleSelect="flase" 
			fitColumns="true"
			striped="true"
			title="标准价格" iconCls="icon-save"
			toolbar="#tb">
			<thead>
				<tr> 
					<th data-options="field:'check',checkbox:true"></th>
					<th hidden data-options="field:'id',width:550" align="center"></th>
					<th data-options="field:'keyWord',width:550" align="center">关键词</th>
					<th data-options="field:'keyMoney',width:550" align="center">金额</th>
				</tr>
			</thead>
		</table>
		</td>
			<td>
			    <a id="update" href="#"  class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="opratorDailog('adddlg','open');showTd()">参考报价</a>
			    <br/>
			    <br/>
				<a  id="update" href="#"  class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="dataDailog('tt','updlg','updateForm','../priceManager/getUpdatePricePage');showTd()">修改价格</a>
				<br/>
				<br/>
				<a id="updateNo" href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="findPageList('tt','../priceManager/getRateDate','insertProxyForm','batchdlg');showTd()">批量倍率</a>
			</td>
		<td id="yc" style="display: none;">
		
		<div id="tbProxy"style="border-bottom:0;padding:0px;"> 
		 <table style="width:100%;">
		  <tr>
	         <td style="width:100%;">
				<a  href="#" class="easyui-linkbutton" iconCls="icon-cut" onclick="dataDailog('ttProxy','updlgProxy','updateProxyForm','../priceManager/getUpdatePricePage')"> 修改</a>
				<a id="deletId" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="deleteForm('deletId','ttProxy','../priceManager/delteWordBatch','../priceManager/PorxyPriceCheck')">删除</a>
			 </td>
			 <td style="white-space:nowrap;">
			 	<form id="serachProxy" action="../priceManager/PorxyPriceCheck">
	               <input class="easyui-textbox" name="keyWord" data-options="label:'关键词',iconCls:'icon-search'"  style="width: 300px"/>   
	               <a class="easyui-linkbutton" iconCls="icon-search"  onclick="submitSearchForm('serachProxy','ttProxy')">查询</a>
	             </form>
	         </td>
	         </tr>
	        </table>
        </div>
        
		<table  id="ttProxy" class="easyui-datagrid" style="width:700px;height:760px;"
			rownumbers="true" 
			pagination="true"
			singleSelect="flase" 
			fitColumns="true"
			striped="true"
			title="我的标准" iconCls="icon-save"
			toolbar="#tbProxy">
			<thead>
				<tr> 
					<th data-options="field:'check',checkbox:true"></th>
					<th hidden data-options="field:'id',width:550" align="center"></th>
					<th data-options="field:'keyWord',width:550" align="center">关键词</th>
					<th data-options="field:'keyMoney',width:550" align="center">金额</th>
					<th data-options="field:'wordCustmer',width:550"  align="center">客户</th>
				</tr>
			</thead>
		   </table>
		 </td>
		</tr>
		</table>
	  </div>
		
		<div id="updlg" class="easyui-dialog" title="修改报价" data-options="iconCls:'icon-save'" style="width:400px;height:280px;padding:10px">
			<form id="updateForm" class="easyui-form"  action="../priceManager/MyUpdatePrice/" method="post" data-options="novalidate:true">
				<input type="hidden" name="id"/>
				<div style="margin-bottom:20px">
					<input class="easyui-textbox" name="keyWord"  style="width:100%"  data-options="label:'关键词',required:true">
				</div>
				<div style="margin-bottom:20px">
					<input class="easyui-textbox" name="keyMoney"   style="width:100%"  data-options="label:'金&nbsp;&nbsp;&nbsp;&nbsp;额',required:true">
				</div>
				<input type="hidden" name="id">
			</form>
			<div style="text-align:center;padding:5px 0">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateVaildFormPrice('updateForm','updlg','ttProxy','../priceManager/PorxyPriceCheck/')" style="width:80px">报价</a>
			</div>
	    </div>
	    
		<div id="adddlg" class="easyui-dialog" title="参考报价" data-options="iconCls:'icon-save'" style="width:400px;height:280px;padding:10px">
			<form id="addForm" class="easyui-form"  action="../priceManager/addNetWordPrice/" method="post" data-options="novalidate:true">
				<input type="hidden" name="id"/>
				<div style="margin-bottom:20px">
					<input class="easyui-textbox" name="keyWord"  style="width:100%"  data-options="label:'关键词',required:true">
				</div>
				<div style="margin-bottom:20px">
					<input class="easyui-textbox" name="keyMoney"   style="width:100%"  data-options="label:'金&nbsp;&nbsp;&nbsp;&nbsp;额',required:true">
				</div>
					<input type="hidden" name="flag" value="报价">
			</form>
			<div style="text-align:center;padding:5px 0">
				<a href="javascript:void(0)" class="easyui-linkbutton" " style="width:80px">报价</a>
			</div>
	    </div>
	    
		<div id="updlgProxy" class="easyui-dialog" title="修改参考报价" data-options="iconCls:'icon-save'" style="width:400px;height:280px;padding:10px">
			<form id="updateProxyForm" class="easyui-form"  action="../priceManager/updatePrice/" method="post" data-options="novalidate:true">
				<input type="hidden" name="id"/>
				<div style="margin-bottom:20px">
					<input class="easyui-textbox" name="keyWord"  style="width:100%"  data-options="label:'关键词',required:true">
				</div>
				<div style="margin-bottom:20px">
					<input class="easyui-textbox" name="keyMoney"   style="width:100%"  data-options="label:'金&nbsp;&nbsp;&nbsp;&nbsp;额',required:true">
				</div>
					<input type="hidden" name="flag" value="报价">
			</form>
			<div style="text-align:center;padding:5px 0">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateVaildFormPrice('updateProxyForm','updlgProxy','ttProxy','../priceManager/PorxyPriceCheck/')" style="width:80px">报价</a>
			</div>
	    </div>
	    
		<div id="batchdlg" class="easyui-dialog" title="批量倍率" data-options="iconCls:'icon-save'" style="width:400px;height:280px;padding:10px">

			<form id="insertProxyForm" class="easyui-form"  action="../priceManager/insertProxyForm/" method="post" data-options="novalidate:true">
			   <div style="margin-bottom:20px">
				 <input class="easyui-textbox" name="keyWords" label="已选词" readonly="readonly" labelPosition="top" multiline="true" style="width:100%" >
				 <input type="hidden" name="ids">
				 <input type="hidden" name="keyMoneys">
				</div>
				<div style="margin-bottom:20px">
					<input class="easyui-numberbox" name="rate" labelPosition="top"  data-options="label:'倍&nbsp;&nbsp;&nbsp;&nbsp;率',required:true,min:0,precision:2" name="rate"  labelPosition="top"  style="width:100%"  data-options="label:'倍&nbsp;&nbsp;&nbsp;&nbsp;率',required:true">
					
				</div>
			</form>
			
			<div style="text-align:center;padding:5px 0">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm('insertProxyForm','ttProxy','../priceManager/PorxyPriceCheck/')" style="width:80px">报价</a>
			</div>
	    </div>
	</body>

</html>