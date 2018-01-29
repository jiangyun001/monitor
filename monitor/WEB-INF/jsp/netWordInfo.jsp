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
<title>关键词</title>
<script type="text/javascript" src="../css/jquery.min.js"></script>  
<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>  
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />  
<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />     
<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
<script type="text/javascript" src="../css/js/init-page.js"></script>
<style type="text/css">
#container {
	min-width: 310px;
	max-width: 800px;
	height: 250px;
	margin: 0 auto
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	//page_init('tt','../netWordManager/getNetWordPage/');
	//$("#quantity").click();
    
	$.extend($.fn.validatebox.defaults.rules, {
		wordAnd : {
			validator : function(value){
				return /^.*\|www\..+\..+\|(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]))$/.test(value);
					},
					message : '请安规定格式输入'
			},
		wordNet:{
			validator : function(value){
				return /^.*\|www\..+\..+\)$/.test(value);
					},
					message : '请安规定格式输入'
			}
	})
	//
	$.post('../netWordManager/getNetWordInfo');
	$("#quantity").bind("change",function(){
         var dataname = $(this).val();
       /*   if(dataname==""){
        	 page_init('tt','../netWordManager/getNetWordPage/');
         }
         if(dataname==null||dataname==""){
        	 $('#numbers').html("")
        	 return 
         }
         */
		 url='../netWordManager/getSelectNumbers?selected='+dataname
         $.post(url,function(data){
        	 $('#numbers').html(data)
         })
         page_init('tt','../netWordManager/getNetWordPage?selected='+dataname);
		 
      /*    $.post(url,function(data){
        	 $('#numbers').html(data)
         }) */
	 });
	$('#quantity').trigger('change');
	
	/* 
	取消鼠标事件
	$(document).bind('contextmenu',function(e){
		$('#mmMouse').menu('show', {
			left: e.pageX,
			top: e.pageY
		});
		return false;
	});  */
	
	$('#keyWord').textbox('textbox').bind(
			{ input: change, propertychange: change}
	);
	function change(){
	       submitSearchForm('serach','tt')
	}
	 initCombox("wordTeamCombox")
	 initCombox("wordDiffTeamCombox")
	 initCombox("choice")
	 initCombox("choiceDiff")
	 initCombox("choiceDiffCustmer")
    }
)

function refreshMenu(){
	submitForm('teamForm','tt','../netWordManager/getNetWordPage/');
	parent.location.reload()
	 
}

function Verification(oprator){
	var flags = [];
	var rows = $('#tt').datagrid('getSelections');
	for (var i = 0; i < rows.length; i++) {
		flags.push(rows[i].flag);
	}
	var i=0;
	for(;i<flags.length;i++){
		if(flags[i]!=oprator){
			$.messager.show({
				title : '您有新的消息',
				msg : '您选择的状态不是'+oprator,
				showType : 'show',
				style : {
					right : '',
					top : document.body.scrollTop
							+ document.documentElement.scrollTop,
					bottom : ''
				}

			})
			break;
		}
	}
	if(i<flags.length){
		return false
	}else{
		if(oprator=='优化中'){
			batchSubForm('tt','../netWordManager/setCancelWord','优化中(申请取消)',
		'../netWordManager/getNetWordPage/');
		}else if(oprator=='停止优化'){
		  batchSubForm('tt','../netWordManager/setCancelWord','停止优化(申请恢复)',
			'../netWordManager/getNetWordPage/');
		}
	}
}

function addWordTeam(wordTeam) {
	var ids = [];
	var rows = $('#tt').datagrid('getSelections');
	if(rows==""||rows==null) {
		$.messager.show({
			title : '您有新的消息',
			msg : '请选择一条记录',
			showType : 'show',
			timeout : 1,
			style : {
				right : '',
				top : document.body.scrollTop
						+ document.documentElement.scrollTop,
				bottom : ''
			}

		})
		return;
	}
	for (var i = 0; i < rows.length; i++) {
		ids.push(rows[i].id);
	}
	var idlist = ids.join(",")
	var url = "../netWordManager/addWrodTeam/?wordTeam=" + wordTeam
			+ "&idList=" + idlist
	$.ajax({
		url : url,
		type : "POST",
		success : function(data) {
			if (data > 0) {
				$.messager.show({
					title : '您有新的消息',
					msg : "已添加" + data + "条到分组["+wordTeam+"]",
					showType : 'show',
					style : {
						right : '',
						top : document.body.scrollTop
								+ document.documentElement.scrollTop,
						bottom : ''
					}
				});
			} else {
				$.messager.show({
					title : '您有新的消息',
					msg : '不通过',
					showType : 'show',
					style : {
						right : '',
						top : document.body.scrollTop
								+ document.documentElement.scrollTop,
						bottom : ''
					}
				});
			}
			page_init('tt','../netWordManager/getNetWordPage/');
			
		}

	})
}

function getDataTables(){
   var ids = [];
   var wordNet="";
   
   var rows = $('#tt').datagrid('getSelections');
   if(rows==null||rows==""){
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
		wordNet+=rows[i].keyWord+"%7c"+rows[i].netAddress+"%7c"+rows[i].keyMoney+"%0d%0a"
	}
   var idarray=ids.join(',')
   url="../netWordManager/custmerRemove"+"?ids="+idarray+"&wordNet="+wordNet;
   
   $.ajax({
	   type : "POST",
       url : url,
       success : function(data) {
    	 
    	 $("#wordMoveForm").form('load',data);
    	 $("#newWordMove").dialog("open")
    	 
       },
       error : function(err) {
           $.messager.alert('操作提示', '获取信息失败...请联系管理员!', 'error');
           $("#tt").datagrid("loaded"); //移除屏蔽
       }
   })
}

function ExportExcel(){
	$.ajax({
		type : "POST",
		url:"../netWordManager/exportExcel",
		success : function(data) {
			$.messager.alert('操作提示',data+",稍后请在'用户中心->我的文档里下载'",'success');
		
		}
		
	})
}
function openDetail(){
	
	var row = $('#tt').datagrid('getSelected');
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
	url="../netWordHistroyManager/getNetWordHistory?keyWord="+row.keyWord+"&netAddress="+row.netAddress;
	urldata="../netWordHistroyManager/getHistoryList?keyWord="+row.keyWord+"&netAddress="+row.netAddress;
	
	$.ajax({
  	 url:url,
  	 type : "POST",
  	 success : function (data){
  		$('#showTitle').html(
  				"<span> 关键词："+data.keyWord+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
  				"<span> 单价："+data.userMoney+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
  				"<span> 扣费标准：排进前十名 </span>"
  		);
  		page_init('ttDetail',urldata);
  		//page_init('tt','../netWordManager/getNetWordPage/');
  		opratorDailog('detailDailog','open')
  	 }
    })
}
function closeImportClick(){
	  $('#fileImport').filebox('setValue','');
    document.getElementById('fileImport').value = null;
    document.getElementById('fileName').innerHTML = "";
    document.getElementById('uploadInfo').innerHTML = "";
    $('#dd').dialog('close');
}

//导入文件	
function importFileClick()
{   
    var file = $('input[name="fileImport"][type="file"]').prop('files')[0];
    if (file == null) { alert('错误，请选择文件'); return; }
    var fileName = file.name;
    var file_typename = fileName.substring(fileName.lastIndexOf('.'), fileName.length);
    //这里限定上传文件文件类型必须为.xlsx，如果文件类型不符，提示错误信息
    if (file_typename == '.xls'||file_typename == '.txt')
    {
        //计算文件大小
        var fileSize = 0;
        //如果文件大小大于1024字节X1024字1111节，则显示文件大小单位为MB，否则为KB
        if (file.size > 1024 * 1024) {
      	  fileSize = Math.round(file.size * 100 / (1024 * 1024)) / 100;
      	  	if (fileSize > 10) {
	                   alert('错误，文件超过10MB，请处理后上传！'); return;
	              }
      	  	fileSize = fileSize.toString() + 'MB';
	       }
	      else {
	              fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';
	       }
        $("#showMsg").html("<span style='color:Blue'>文件名: " + file.name + ',大小: ' + fileSize + "</span>");
        var formData = new FormData($("#importFileForm")[0]);
        $.ajax({
            url:'../netWordManager/parseFile',
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
          	  $.messager.show({
        			title:'您有新的消息',
        			msg:"您可以刷新关键词页面查看录入条数",
        				showType:'show',
        				style:{
        					right:'',
        					top:document.body.scrollTop+document.documentElement.scrollTop,
        					bottom:''
        				}
        		})
          	  $("#showMsg").html("<span style='color:Red'>" + data + "</span>");
          	  $(".easyui-dialog").dialog("close");
            },
            error: function (returnInfo) {
          	  $("#showMsg").html("<span style='color:Red'>" + data + "</span>");
            }
        });
    }
    else {
         alert("文件类型错误");
         $("#showMsg").html("<span style='color:Red'>错误提示:上传文件应该是.xls或.txt后缀而不应该是" + file_typename + ",请重新选择文件</span>")
    }
}
function operation(value, row, index){
	 return "<a href='http://" + row.netAddress + "' target='_blank'>" + row.netAddress + "</a>";	
}

function formatOper(val,row,index){
	str='<a href="#"  style="text-decoration:none;" onclick="requestParamer('+"'"+row.keyWord+"',"+"'"+row.netAddress+"')\""+'>明细&nbsp;&nbsp;</a>';
	return str
}
	
function requestParamer(keyWord,netAddress){
	url="../netWordHistroyManager/getNetWordHistory?keyWord="+keyWord+"&netAddress="+netAddress;
	urldata="../netWordHistroyManager/getHistoryList?keyWord="+keyWord+"&netAddress="+netAddress;
	$.ajax({
	  	 url:url,
	  	 type : "POST",
	  	 success : function (data){
	  		 if(data!=null){
		  		$('#showTitle').html(
		  				"<span> 关键词："+data.keyWord+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
		  				"<span> 单价："+data.userMoney+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
		  				"<span> 扣费标准：排进前十名 </span>"
		  		);
	  		 }
	  		page_init('ttDetail',urldata);
	  		//page_init('tt','../netWordManager/getNetWordPage/');
	  		opratorDailog('detailDailog','open');
	  	 }
	   })
}

function delData(status){
	 var ids = [];
	 var rows = $("#tt").datagrid('getSelections');
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
	   for(var i=0; i<rows.length; i++){
			ids.push(rows[i].id);
			if(rows[i].flag!=status){
				   $.messager.show({
						title:'您有新的消息',
						msg:'请选择：'+status+" 进行删除",
							showType:'show',
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:''
							}
						
					})
					return ;
			   }
	   }
	   var idarray=ids.join(',')
	   url="../netWordManager/deleteNetWordNet?ids="+idarray;
	   $.messager.confirm('删除关键词','确定删除吗?',function(r){
	    if (r){
	    	 $.ajax({
	  		   url:url,
	  		   type:"post",
	  		   success : function(data) {
	  			   page_init('tt','../netWordManager/getNetWordPage/');
	  		   }
	  		   
	  	   });
	    }
	});
	   
	  
	
	
}
</script>
</head>
<body>
	  <div id="tb">
	  	 <table style="width:100%;">
	  	  <tr>
	  	  	<td style="width:70%;">
		     	<!-- <a id="add" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#dlg').dialog('open')">申请优化</a> -->
		     	<a href="#" class="easyui-menubutton" data-options="menu:'#mm1',iconCls:'icon-edit'">添加优化</a>
				  	<div id="mm1" style="width:150px;">
						<c:if test="${user.roleId == 2}">
							<div data-options="iconCls:'icon-add'" onclick="opratorDailog('newPriceDiff','open')" >录入不同</div>
							<div data-options="iconCls:'icon-save'"  onclick="opratorDailog('newWordUnified','open')">录入统一</div>
							<div data-options="iconCls:'icon-print'"><a  href="../netWordManager/downloadAddWordExcel">下载Excel模板</a></div>
							<div data-options="iconCls:'icon-print'"><a  href="../netWordManager/downloadAddWordTxt">下载txt模板</a></div>
							<div data-options="iconCls:'icon-add'" onclick="opratorDailog('uploadFileDlg','open')">批量录入</div>
							<div data-options="iconCls:'icon-save'" onclick="ExportExcel()">批量导出</div>
						</c:if>
						<c:if test="${user.roleId == 1}"><div data-options="iconCls:'icon-cut'" onclick="getDataTables()">客移</div></c:if>
				    </div>
					<select id="quantity">
					   <option value="">所有</option>
					   <option value="all">全部</option>
					   <option value="better">优化中</option>
					   <option value="stop">停止优化</option>
					</select>&nbsp;&nbsp;<b id='numbers'></b>&nbsp;条数
		  	</td>
		  	
		  	<td style="white-space:nowrap;width: 370px">
	  	  	  <form id="serach" style="text-align:left" action= "../netWordManager/getNetWordPage/"  method="post" data-options="novalidate:true">
                <input id="keyWord" class="easyui-textbox" name="serachFeild"  style="width:260px" 
                 data-options="label:'关键词'">   
                <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" 
                 style="width:80px" onclick="submitSearchForm('serach','tt')">查询</a>
              </form>
		  	</td>
		  	<td>
		  		<a href="#" class="easyui-menubutton" data-options="menu:'#mm2'">更多</a>
		  		<div id="mm2" style="width:100px;">
		  			<div>
					<span>添加到分组</span>
						<div style="width:150px;">
							<div onclick="opratorDailog('newTeam','open')" data-options="iconCls:'icon-add'"><b>新建分组</b></div>
							<div class="menu-sep"></div>
							<c:forEach var="string" items="${listString}"  varStatus="status">
							  <div onclick="addWordTeam('${string}')">${string}</div> 
							</c:forEach>
						</div>
					</div>
					<c:if test="${user.roleId == 1}">
					   <div icon="icon-save"
					  		onclick="dataDailog('tt','changeDlg','changeForm','../netWordManager/getNetWordPrice/')">调整价格</div>
    					<div icon="icon-remove" onclick="delData('优化中(处理中)')">删除</div>
    				</c:if>
					<div class="menu-sep"></div>
					<c:if test="${user.roleId == 2}">
						<div id="cancelOptimization" 
							onclick="Verification('优化中')">申请取消
						</div>
						<div icon="icon-save"
						  onclick="Verification('停止优化')">恢复优化</div>
						<div icon="icon-remove" onclick="delData('优化中(排队中)')">删除</div>
					</c:if> 
					<!-- <div icon="icon-search" onclick="openDetail()">明细</div> -->
				</div>
    		    <div style="display:none">
				  <div id="toolbar">
				     <a href="#" class="easyui-linkbutton easyui-tooltip" title="申请取消" 
				  		data-options="iconCls:'icon-remove',plain:true"
				  		onclick="batchSubForm('tt','../netWordManager/setCancelWord','优化中(申请取消)','../netWordManager/getNetWordPage/')">
				    </a>
				    <br>
				  	  <a href="#" class="easyui-linkbutton easyui-tooltip" title="设置分组" data-options="iconCls:'icon-add',plain:true"></a>
				    <br>
				  </div>
	            </div>
		  	</td>
		  </tr>
		 </table>
	   </div>
	   
		<table id="tt" class="easyui-datagrid" style="width:100%;height:700px;padding:10px"
			rownumbers="true" 
			pagination="true"
			singleSelect="flase"
			fitColumns="true"
			striped="true"
			title="关键词" iconCls="icon-save"
			toolbar="#tb">
			<thead>
				<tr> 
					<th data-options="field:'check',checkbox:true"></th>
					<th hidden data-options="field:'id',width:550" align="center"></th>
					<th data-options="field:'keyWord',width:550" align="center" sortable="true">关键词</th>
					<th data-options="field:'netAddress',width:550,formatter:operation" align="center" sortable="true">网址</th>
					<c:if test="${user.roleId == 2}"><th data-options="field:'wordTeam',width:550" align="center" sortable="true">分组</th></c:if>
					<c:if test="${user.roleId == 2}"><th data-options="field:'wordEngin',width:550" align="center" sortable="true">引擎</th></c:if>
					<th data-options="field:'createTime',width:550" align="center" sortable="true">提交时间</th>
					<th data-options="field:'originalOrder',width:550"  align="center" sortable="true">原排名</th>
					<th data-options="field:'wordOrder',width:550"  align="center" sortable="true">当前排名</th>
					<th data-options="field:'flag',width:550"  align="center" sortable="true">状态</th>
					<th data-options="field:'wordCustmer',width:550"  align="center" sortable="true">客户</th>
					<!-- <th data-options="field:'wordCustmer',width:550"  align="center" sortable="true">操作</th> -->
					<th data-options="field:'_operate',width:550,align:'center',formatter:formatOper">操作</th>
				</tr>
			</thead>
		</table>
	
	<div id="changeDlg" class="easyui-dialog" title="修改价格" data-options="iconCls:'icon-save'" style="width:450px;height:380px;padding:10px">
		<form id="changeForm" action="../netWordManager/changeUnitPrice/">
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="keyWord"  style="width:100%"  data-options="label:'关键词',required:true" readonly="readonly">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="netAddress"   style="width:100%"  data-options="label:'网&nbsp;&nbsp;&nbsp;&nbsp;址',required:true" readonly="readonly">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userMoney"   style="width:100%"  data-options="label:'用户价格',required:true">
			</div>
			<div style="margin-bottom:20px">
				<c:if test="${user.depId == 1}">
					<input class="easyui-textbox" name="proxyMoney"   style="width:100%"  data-options="label:'代理价格',required:true">
				</c:if>
				<%-- <c:if test="${user.depId != 1}">
					<input class="easyui-textbox" name="proxyMoney"   style="width:100%"  data-options="label:'代理价格'" readonly="readonly">
				</c:if> --%>
			</div>
				<input type="hidden"  name="id"   style="width:100%">
	 		<div style="text-align:center;padding:5px 0">
				<a href="#" class="easyui-linkbutton"  onclick="submitForm('changeForm','tt','../netWordManager/getNetWordPage/')" style="width:80px">修改</a>
			</div>
	 	</form>
	</div>
	
	<div id="newTeam" class="easyui-dialog" title="新建分组" data-options="iconCls:'icon-save'" style="width:400px;height:180px;padding:10px">
		<form id="teamForm" action="../netWordManager/modifyWordTeam/">
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="wordTeam"  style="width:100%"  data-options="label:'分组名称',required:true">
			</div>
	 	</form>
	 	<div style="text-align:center;padding:5px 0">
			<a id="freshButton" href="#" class="easyui-linkbutton" onclick="refreshMenu()" style="width:80px">新增分组</a>
		</div>
	</div>
	
	<div id="newWordUnified" class="easyui-dialog" title="录入统一" data-options="iconCls:'icon-save'" style="width:450px;height:550px;padding:10px">
		<div style="font: 17;font-style: oblique;color: red;">
		 <p>温馨提示：请勿录入违禁词，如枪支弹药，冰毒白粉，避免重复录入，请各位用户确认清楚再提交，谢谢
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
				<input  class="easyui-textbox" name="targetOrder" value=10  style="width:100%"  data-options="label:'目标排名',valueField:'id',textField:'text',required:true" readonly="readonly">
			</div>
			
		   <div style="margin-bottom:20px">
				<input  class="easyui-numberbox" name="userMoney"  precision="2"   style="width:100%"  data-options="label:'元&nbsp;&nbsp;/&nbsp;&nbsp;天',valueField:'id',textField:'text',required:true,min:0,precision:2">
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
	
	<div id="newPriceDiff" class="easyui-dialog" title="录入不同" data-options="iconCls:'icon-save'" style="width:450px;height:500px;padding:10px">
		<div style="font: 17;font-style: oblique;color: red;">
		 <p>温馨提示：请勿录入违禁词，如枪支弹药，冰毒白粉，避免重复录入，请各位用户确认清楚再提交，谢谢
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
				<input  class="easyui-textbox" name="targetOrder"  value=10   style="width:100%"  data-options="label:'目标排名',valueField:'id',textField:'text',required:false" readonly="readonly">
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
	
	<div id="newWordMove" class="easyui-dialog" title="客移" data-options="iconCls:'icon-save'" style="width:450px;height:500px;padding:10px">
		<form id="wordMoveForm" action="../netWordManager/moveCustmer/">
			<div style="margin-bottom:20px">
			  <input class="easyui-textbox" 
			  	name="wordHref"	
			  	label="关键词|网址|元/天:" title="关键词|网址|元/天:" labelPosition="left" multiline="true" 
			 	data-options="required:true" readonly="readonly"
			 	style="width:100%;height:80px">
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
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" 
                 style="width:80px" onclick="submitSearchForm('serach','tt')">查询</a> -->
			<a id="unifiedButton" href="#" class="easyui-linkbutton" onclick="submitForm('wordMoveForm','tt','../netWordManager/getNetWordPage/')" style="width:80px">录入</a>
			<a href="#" class="easyui-linkbutton" onclick="$('#newWordMove').dialog('close')" style="width:80px">取消</a>
		</div>
	</div>
	
	<div id="detailDailog" class="easyui-dialog" title="关键词明细" style="width:600px;height:300px;padding:10px"
			data-options="
				iconCls: 'icon-save',
				toolbar: '#dlg-toolbar',
				buttons: '#dlg-buttons'
			">
			<label id="showTitle"></label>
			<hr>
			<table id="ttDetail" class="easyui-datagrid" style="width:100%;height:200px;padding:10px"
			rownumbers="true" 
			pagination="true"
			singleSelect="true"
			fitColumns="true"
			striped="true"
			title="明细" iconCls="icon-save"
			>
			<thead>
				<tr> 
					<th data-options="field:'check',checkbox:true"></th>
					<th hidden data-options="field:'id',width:550" align="center"></th>
					<th data-options="field:'keyWord',width:550" align="center" sortable="true">关键词</th>
					<th data-options="field:'netAddress',width:550" align="center" sortable="true">网址</th>
					<th data-options="field:'wordOrder',width:550" align="center" sortable="true">排名</th>
					<th data-options="field:'curFee',width:550" align="center" sortable="true">是否扣费</th>
					<th data-options="field:'orderTime',width:550" align="center" sortable="true">日期</th>
				</tr>
			</thead>
		</table>
	  </div>
	</body>
</html>