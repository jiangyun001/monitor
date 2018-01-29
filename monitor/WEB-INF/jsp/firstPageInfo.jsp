<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fn"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../css/jquery.min.js"></script>  
<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>  
<script type="text/javascript" src="../css/js/uploadFile.js"></script>   

<script type="text/javascript" src="../css/code/highcharts.js"></script>
<script type="text/javascript" src="../css/code/modules/series-label.js"></script>
<script type="text/javascript" src="../css/code/modules/exporting.js"></script>

<!-- <link rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />   -->
<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
<!-- <link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" /> -->
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />     
<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
<script type="text/javascript" src="../css/js/init-page.js"></script> 
<script type="text/javascript">
$(document).ready(function(){
	page_init('tt','../firstManager/pageInfoData/');	
	initCombox("choice")
    initCombox("wordDiffTeamCombox")
    initCombox("wordTeamCombox")
})

$.post('../firstManager/pageInfoStatis',function(data){
	var jsondata=$.parseJSON(data);
	$('#statisWord').html(
			"<span> 累计总量："+jsondata.total+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 任务优化量："+jsondata.taskTotal+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 今日达标量："+jsondata.todayTotal+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 累计完成率："+jsondata.sumper+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 累计百度完成率："+jsondata.baiduper+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 客质率："+jsondata.custmerPer+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 用户量："+jsondata.userTotal+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 当月消费："+jsondata.mothTotal+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 当日消费："+jsondata.todaySale+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"
	);
});

function rechargeInfo(){
	$.ajax({
		url:'../userMessageManager/getUserMessage',
		type:'POST',
		success : function(data) {
			if(data!=null){
				$.messager.alert('操作提示',data.message,'success');
			}else{
				$.messager.alert('操作提示',"请联系您的客户代表进行充值'",'success');
			}
		},
		
	});
	
	
}	
function operation(value, row, index){
	 return "<a href='http://" + row.netAddress + "' target='_blank'>" + row.netAddress + "</a>";	
}	
function redNotice(id){
	url="../netNoticeManager/readNoticeBlankRead?id="+id 
	$.ajax({
		url:url,
		type:'POST',
		success : function(data) {
			$('#notice').html(data.notice);
			$('#readNotice').dialog('open');
		}
	})			
 }
 function formatOper(){
	 
	 return "<lable>百度pc</lable>"; 
	 
 }
</script>
<title>首页</title>
</head>
<body>
	<div class="easyui-panel">
		<table>
		<tr>
			<td >
			<div class="easyui-panel" style="width:700px;height:150px;padding:30px 60px;overflow-y: hidden">
				<div style="margin-bottom:20px;">
					<label id="statisWord"></label>
				</div>
				<c:if test="${user.roleId == 2}">
				<div style="margin-bottom:20px">
					<a href="#" class="easyui-menubutton" data-options="menu:'#easyLook',iconCls:'icon-edit'">添加优化</a>
							<ul id="easyLook" style="width: 150px">
								<div data-options="iconCls:'icon-add'" onclick="opratorDailog('newPriceDiff','open')" >录入不同</div>
								<div data-options="iconCls:'icon-save'"  onclick="opratorDailog('newWordUnified','open')">录入统一</div>
								<div data-options="iconCls:'icon-print'"><a  href="../netWordManager/downloadAddWordExcel">下载Excel模板</a></div>
								<div data-options="iconCls:'icon-print'"><a  href="../netWordManager/downloadAddWordTxt">下载txt模板</a></div>
								<div data-options="iconCls:'icon-add'" onclick="opratorDailog('uploadFileDlg','open')">批量录入</div>
								<div data-options="iconCls:'icon-save'" onclick="ExportExcel()">批量导出</div>
							</ul>
					</div>
				</c:if>
					<a href="#" class="easyui-menubutton" onclick="rechargeInfo()">充值</a>
			 </div>
			</td>
     	 	<td width="100%" align="left">
			<div class="easyui-accordion" style="width:100%;height:150px;">
     	 		<div title="公告" data-options="iconCls:'icon-ok'" style="overflow:auto;padding:10px;">
     	 			<hr width="50%" align="left">
     	 				<c:forEach var="notices" items="${listNetNotice}" varStatus="status">
     	 				   <c:if test="${status.count<2}">
     	 						<li><a href="#"  onclick="redNotice(${notices.id})">${notices.title}</a></li>
     	 					</c:if>
     	 					<c:if test="${status.count>=2}">
     	 						<li class="showContent" style="display: none;"><a href="#"  onclick="redNotice(${notices.id})">${notices.title}</a></li>
     	 					</c:if>
     	 				</c:forEach>
     	 				<ul>
     	 					<li>
     	 						<a href="#" onclick="$('.showContent').show()" >更多&nbsp;&nbsp;</a>
     	 					</li>
	     	 				<ul>
	     	 					<li class="showContent" style="display: none;">
	     	 						<a href="#"  class="showContent"  onclick="$('.showContent').hide()" >更少</a>
	     	 					</li>
	     	 				</ul>
     	 				</ul>
     	 		</div>
     	 		<div title="产品用法" data-options="iconCls:'icon-ok'" style="overflow:auto;padding:10px;">
     	 			<c:forEach var="notices" items="${listNetNoticeProc}" varStatus="status">
     	 				   <c:if test="${status.count<2}">
     	 						<li><a href="#"  onclick="redNotice(${notices.id})">${notices.title}</a></li>
     	 					</c:if>
     	 					<c:if test="${status.count>=2}">
     	 						<li class="showContent" style="display: none;"><a href="#"  onclick="redNotice(${notices.id})">${notices.title}</a></li>
     	 					</c:if>
     	 				</c:forEach>
     	 				<ul>
     	 					<li>
     	 						<a href="#" onclick="$('.showContentProc').show()" >更多&nbsp;&nbsp;</a>
     	 					</li>
	     	 				<ul>
	     	 					<li class="showContent" style="display: none;">
	     	 						<a href="#"  class="showContentProc"  onclick="$('.showContent').hide()" >更少</a>
	     	 					</li>
	     	 				</ul>
     	 				</ul>
     	 		</div>
     	 		</div>
     	 	</td>
     	 </tr>
	   </table>
	</div>
	
	<div  class="easyui-panel"  style="width:100%;overflow-y: hidden" >
		<table id="tt" class="easyui-datagrid" style="width:100%;height:700px;padding:10px"
			rownumbers="true" 
			pagination="true"
			singleSelect="flase"
			fitColumns="true"
			striped="true"
			title="今日最新排名" iconCls="icon-save"
			toolbar="#tb">
			<thead>
				<tr> 
					<th data-options="field:'check',checkbox:true"></th>
					<th hidden data-options="field:'id',width:550" align="center"></th>
					<th data-options="field:'keyWord',width:550" align="center" sortable="true">关键词</th>
					<th data-options="field:'wordOrder',width:550" align="center" sortable="true">当前排名</th>
					<th data-options="field:'netAddress',width:550,formatter: operation"  align="center" sortable="true">网址</th>
					<c:if test="${user.roleId == 2}">
						<th data-options="field:'wordTeam',width:550" align="center" sortable="true">分组</th>
					</c:if>
					<th data-options="field:'wordEngin',width:550,formatter:formatOper" align="center" sortable="true">引擎</th>
					<th data-options="field:'wordCustmer',width:550"  align="center" sortable="true">客户</th>
				</tr>
			</thead>
		</table>
	
	</div>
	
	<div id="newWordUnified" class="easyui-dialog" title="录入统一" data-options="iconCls:'icon-save'" style="width:450px;height:550px;padding:10px">
		<div style="font: 17;font-style: oblique;color: red;">
		 <p>温馨提示：请勿录入违禁词，如枪支弹药，冰毒白粉，避免重复录入，如有不便尽请谅解
		</div>
		<form id="unifiedForm" action="../netWordManager/addNetWordNet/">
			<div style="margin-bottom:20px">
			  <input class="easyui-textbox" 
			  	name="wordHref"	
			  	label="关键词|网址:" labelPosition="left" multiline="true" 
			 	data-options="required:true,prompt:'关键词|网址\n关键词|网址'"
			 	style="width:100%;height:80px">
		    </div>
		    
		   <div style="margin-bottom:20px">
				<input id="wordTeamCombox" class="easyui-textbox" name="wordTeam"   style="width:100%"  data-options="label:'分&nbsp;&nbsp;&nbsp;&nbsp;组',valueField:'id',textField:'text',required:true"
					url="../netWordManager/getWordTeamCombox">
			</div>
			
		   <div style="margin-bottom:20px">
				<input  class="easyui-textbox" name="wordEngin"   style="width:100%"  data-options="label:'引&nbsp;&nbsp;&nbsp;&nbsp;擎',valueField:'id',textField:'text',required:true"
					value="百度PC" readonly="readonly">
			</div>
			
		   <div style="margin-bottom:20px">
				<input  class="easyui-textbox" name="targetOrder" value=10  style="width:100%"  data-options="label:'目标排名',valueField:'id',textField:'text',required:true"  readonly="readonly">
			</div>
			
		   <div style="margin-bottom:20px">
				<input  class="easyui-numberbox" name="keyMoney"  precision="2"   style="width:100%"  data-options="label:'元&nbsp;&nbsp;/&nbsp;&nbsp;天',valueField:'id',textField:'text',required:true,min:0,precision:2">
			</div>
			<c:if test="${user.roleId == 1}">
		    <div style="margin-bottom:20px">
				<input id="choice" class="easyui-textbox" url="../userManager/userCombox" 
				name="wordCustmer"   style="width:100%"  
				data-options="label:'选&nbsp;&nbsp;&nbsp;&nbsp;客',valueField:'id',textField:'text',required:false">
			 </div>
			 </c:if>
			<input type="hidden" class="easyui-textbox" name="flag" value="优化中(排队中)">
			
	 	</form>
	 	<div style="text-align:center;padding:5px 0">
			<a id="unifiedButton" href="#" class="easyui-linkbutton" 
			onclick="submitForm('unifiedForm','tt','../netWordManager/getNetWordPage/')" style="width:80px">录入</a>
			<a href="#" class="easyui-linkbutton" onclick="$('#newWordUnified').dialog('close')" style="width:80px">取消</a>
		</div>
	</div>
	
	<div id="newPriceDiff" class="easyui-dialog" title="录入不同" data-options="iconCls:'icon-save'" style="width:450px;height:550px;padding:10px">
		<div style="font: 17;font-style: oblique;color: red;">
		 <p>温馨提示：请勿录入违禁词，如枪支弹药，冰毒白粉，避免重复录入，如有不便尽请谅解
		</div>
		<form id="diffForm" action="../netWordManager/addNetWordNetDiff/">
			<div style="margin-bottom:20px">
			  <input class="easyui-textbox" 
			  	name="wordHref"	
			  	label="关键词|网址|元/天:" labelPosition="left" multiline="true" 
			 	data-options="required:true,prompt:'关键词|网址|10\n关键词|网址|10'"
			 	style="width:100%;height:80px">
		    </div>
		    
		   <div style="margin-bottom:20px">
				<input id="wordDiffTeamCombox" class="easyui-textbox" name="wordTeam"   style="width:100%"  data-options="label:'分&nbsp;&nbsp;&nbsp;&nbsp;组',valueField:'id',textField:'text',required:true"
					url="../netWordManager/getWordTeamCombox">
			</div>
			
		   <div style="margin-bottom:20px">
				<input  class="easyui-textbox" name="wordEngin"   style="width:100%"  data-options="label:'引&nbsp;&nbsp;&nbsp;&nbsp;擎',valueField:'id',textField:'text',required:true"
					value="百度PC" readonly="readonly">
			</div>
			<c:if test="${user.roleId == 1}">
		     <div style="margin-bottom:20px">
			   <input id="choiceDiff" class="easyui-textbox" url="../userManager/userCombox" 
				name="wordCustmer"   style="width:100%"  
				data-options="label:'选&nbsp;&nbsp;&nbsp;&nbsp;客',valueField:'id',textField:'text',required:false">
			</div>
			</c:if>
		   <div style="margin-bottom:20px">
				<input  class="easyui-textbox" name="targetOrder" value="10"   style="width:100%"  data-options="label:'目标排名',valueField:'id',textField:'text',required:false" readonly="readonly">
			</div>
			<input type="hidden" class="easyui-textbox" name="flag" value="优化中(排队中)">
	 	</form>
	 	<div style="text-align:center;padding:5px 0">
			<a id="unifiedButton" href="#" class="easyui-linkbutton" onclick="submitForm('diffForm','tt','../netWordManager/getNetWordPage/')" style="width:80px">录入</a>
			<a href="#" class="easyui-linkbutton" onclick="opratorDailog('newPriceDiff','close')" style="width:80px">取消</a>
		</div>
	</div>
	
	<div id="uploadFileDlg" class="easyui-dialog" title="批量录入" data-options="iconCls:'icon-save'" style="width:400px;height:240px;">
		<div style="margin-bottom:20px;padding:10px">
			<form id="importFileForm">
				<input name="fileImport" class="easyui-filebox"  label="文件:" labelPosition="left" data-options="prompt:'选择文件...'" style="width:80%">
			<div style="margin-bottom:20px;padding:10px" align="center">
				<a href="#" class="easyui-linkbutton"  onclick="importFileClick()" style="width:80px">上传</a>
				<a href="#" class="easyui-linkbutton"  onclick="opratorDailog('uploadFileDlg','close')" style="width:80px">取消</a>
			</div>
			<label id="showMsg"></label>			
			</form>
		</div>
	</div>
	
	<div id="newWordMove" class="easyui-dialog" title="客移" data-options="iconCls:'icon-save'" style="width:450px;height:800px;padding:10px">
		<form id="wordMoveForm" action="../netWordManager/moveCustmer/">
			<div style="margin-bottom:20px">
			  <input class="easyui-textbox" 
			  	name="wordHref"	
			  	label="关键词|网址|元/天:" title="关键词|网址|元/天:" labelPosition="left" multiline="true" 
			 	data-options="required:true" readonly="readonly"
			 	style="width:100%;height:200px">
		    </div>
		    
		   <div style="margin-bottom:20px">
				<input  class="easyui-textbox" name="wordEngin"   style="width:100%"  data-options="label:'引&nbsp;&nbsp;&nbsp;&nbsp;擎',valueField:'id',textField:'text',required:true"
					value="百度PC" readonly="readonly">
			</div>
			
		   <div style="margin-bottom:20px">
			 <input id="choiceDiffCustmer" class="easyui-textbox" url="../userManager/userCombox" 
			  name="wordCustmer"   style="width:100%"  
			  data-options="label:'选&nbsp;&nbsp;&nbsp;&nbsp;客',valueField:'id',textField:'text',required:false">
		   </div>
		   <!-- <div style="margin-bottom:20px">
				<input  class="easyui-textbox" name="targetOrder"   style="width:100%"  data-options="label:'目标排名',valueField:'id',textField:'text',required:false">
			</div> -->
			<input type="hidden" class="easyui-textbox" name="ids">
	 	</form>
	 	<div style="text-align:center;padding:5px 0">
			<a id="unifiedButton" href="#" class="easyui-linkbutton" onclick="submitForm('wordMoveForm','tt','../netWordManager/getNetWordPage/')" style="width:80px">录入</a>
			<a href="#" class="easyui-linkbutton" onclick="$('#newWordMove').dialog('close')" style="width:80px">取消</a>
		</div>
	</div>

	<div id="readNotice" class="easyui-dialog" title="发布消息"
		data-options="iconCls:'icon-save'"
		style="width: 600px; height: 360px; padding: 10px">
		<p id="notice"></p>
	</div>
</body>
</html>