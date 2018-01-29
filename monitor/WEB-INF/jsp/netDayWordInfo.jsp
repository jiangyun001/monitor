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
<title>每日单词</title>

<script type="text/javascript" src="../css/jquery.min.js"></script>
<script type="text/javascript" src="../css/js/zhuzi.js"></script>
<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript" src="../css/code/highcharts.js"></script>
<script type="text/javascript" src="../css/code/modules/series-label.js"></script>
<script type="text/javascript" src="../css//code/modules/exporting.js"></script>

<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"  href="../css/themes/icon.css" />
<script type="text/javascript" src="../css/js/uploadFile.js"></script>
<script type="text/javascript" src="../css/code/modules/exporting.js"></script>
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
	$(document).ready(function() {
		netDayTitle()
		page_init()
		brokenLineAjax()
		$.extend($.fn.validatebox.defaults.rules, {  
		       equaldDate: {  
		           validator: function (value, param) {  
		               var start = $(param[0]).datetimebox('getValue');  //获取开始时间
		               return value+1 > start;                             //有效范围为当前时间大于开始时间    
		           },  
		           message: '结束日期应大于开始日期!'                     //匹配失败消息  
		       }  
		   });  
	})
	
	function brokenLineAjax() {
		$.ajax({
			type : "POST",
			dataType : "json",
			url : "../netWordManager/getBrokenLine/",
			success : function(data) {
				brokenLine(data)
			},
		});
	}
	
	function netDayTitle(){
		$.ajax({
			type:"POST",
			url:"../netWordHistroyManager/getNetDayTitle",
			success : function(data) {
				console.log(data)
				var content ="<span>"
				var queuing="";
				var processing="";
				var canceing="";
				var becamceled="";
				var stopbeter="";
				var nopass="";
				var stopbeter="";
				var becaceing="";
				
				for(var i=0;i<data.length;i++){
					if(data[i].becaceing>0||data[i].becamceled>0||data[i].nopass>0||data[i].processing>0||data[i].queuing>0||data[i].stopbeter>0){
						content=content+data[i].date+"&nbsp;&nbsp;&nbsp;&nbsp;</span>";
					}
					if(data[i].queuing>0){
						queuing = "<span>排队中：&nbsp;&nbsp;"+'<a href="#" onclick="screenCondition('+"'"+data[i].date+"'"+",'优化中(排队中)')\""+">"+data[i].queuing+"</a>&nbsp;&nbsp;</a></span>";
					}else if(data[i].processing>0){
						processing="&nbsp;&nbsp;<span>优化中(处理中)：&nbsp;&nbsp;"+'<a href="#" onclick="screenCondition('+"'"+data[i].date+"'"+",'优化中(处理中)')\""+">"+data[i].processing+"</a>&nbsp;&nbsp;</a></span>";
					}else if(data[i].becaceing>0){
						becaceing="<span>优化中(申请取消)：&nbsp;&nbsp;"+'<a href="#" onclick="screenCondition('+"'"+data[i].date+"'"+",'优化中(申请取消)')\""+">"+data[i].becaceing+"</a>&nbsp;&nbsp;</a></span>"
						console.log(becaceing);
					}else if(data[i].becamceled>0){
						becamceled="&nbsp;&nbsp;<span>优化中(取消中)："+'<a href="#" onclick="screenCondition('+"'"+data[i].date+"'"+",'优化中(取消中)')\""+">"+data[i].becamceled+"</a>&nbsp;&nbsp;</a></span>";
					}else if(data[i].nopass>0){
						nopass="<span>不通过：&nbsp;&nbsp;"+'<a href="#" onclick="screenCondition('+"'"+data[i].date+"'"+",'不通过')\""+">"+data[i].nopass+"</a>&nbsp;&nbsp;</a></span>";
					}else if(data[i].stopbeter>0){
						stopbeter="<span>停止优化(申请恢复)：&nbsp;&nbsp;"+'<a href="#" onclick="screenCondition('+"'"+data[i].date+"'"+",'停止优化(申请恢复)')\""+">"+data[i].stopbeter+"</a>&nbsp;&nbsp;</a></span>"
					}
					if(data[i].becaceing>0||data[i].becamceled>0||data[i].nopass>0||data[i].processing>0||data[i].queuing>0||data[i].stopbeter>0){
						content=content+queuing+processing+becaceing+becamceled+nopass+stopbeter;
					}
					console.log(content)
				}
				$('#showDeatail').html(content);
			},
		})
	}
	
	function screenCondition(date,status){
		  var url = "../netWordManager/getDayNetWordInfoPage?status="+status+"&date="+date;//actionName+"?id="+id
		  console.log(url);
		  $.ajax({
		  	 url:url,
		  	 type : "POST",
		  	 success : function (data){
		  		$("#tt").datagrid("loadData",data);
		  	 }
		  })
	}
	
	
	function passCondition(oprator) {
		var ids = [];
		var oprators = [];
		var rows = $('#tt').datagrid('getSelections');
		if (rows == null) {
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
			oprators.push(oprator + "," + rows[i].flag);
		}
		var idlist = ids.join(",")
		var oprator = oprators.join("%7c")
		var url = "../netWordManager/passConditionWord/?oprator=" + oprator
				+ "&idList=" + idlist
		$.ajax({
			url : url,
			type : "POST",
			success : function(data) {
				if (data > 0) {
					$.messager.show({
						title : '您有新的消息',
						msg : oprator + data + "条",
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
				page_init();
				brokenLineAjax()
			}

		})

	}
	function updatePage() {
		var row = $('#tt').datagrid('getSelected')
		if (row == null) {
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
		var ids = row.id
		$.ajax({
			url : "../netWordManager/getUpdatePage/?id=" + ids,
			success : function(data) {
				$('#updateForm').form('load', data);
				$("#paddDlgMoney").dialog("open") // 打开dialog

			}
		});
	}
	
	function samePassPrice(){
		 var ids = [];
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
		   for(var i=0; i<rows.length; i++){
				ids.push(rows[i].id);
		   }
		   var idarray=ids.join(',')
		   console.log(idarray);
		   $("#idArrays").val(idarray);
		   opratorDailog('priceDlg','open')
		
			
	}
	
	function passConditionSubmit() {
		$('#updateForm').form('submit',
		{
			onSubmit:function(data){
				return $(this).form('enableValidation').form('validate');
			},
			url : "../netWordManager/updataWorManagerPass",
			success : function(data) {
				if (data > 0) {
					$.messager
							.show({
								title : '您有新的消息',
								msg : '审核通过',
								showType : 'show',
								timeout : 1,
								style : {
									right : '',
									top : document.body.scrollTop
											+ document.documentElement.scrollTop,
									bottom : ''
								}

							});
					$('#dlg').dialog("close");
					page_init();
					brokenLineAjax();
				} else {
					$.messager
							.show({
								title : '您有新的消息',
								msg : '审核失败',
								showType : 'show',
								timeout : 1,
								style : {
									right : '',
									top : document.body.scrollTop
											+ document.documentElement.scrollTop,
									bottom : ''
								}

							});

				}
			}

		});

	}

	function submitForm() {
		$("#serach").attr('action','../netWordManager/getDayNetWordInfoPage/');
		$('#serach').form('submit', {
			onSubmit : function() {
				return $(this).form('enableValidation').form('validate');
			},
			success : function(data) {
				$("#tt").datagrid("loadData", $.parseJSON(data));
			},

		});
	}


	function clearForm() {
		$('#serach').form('clear');
	}
	function clearAddForm() {
		$('#addForm').form('clear')
	}

	function page_init() {
		$("#tt").datagrid({
			url : "../netWordManager/getDayNetWordInfoPage/", //actionName
			queryParams : {
				pageNumber : 1,
				pageSize : 20
			},//查询参数
			loadMsg : "正在加载数据...",
			rownumbers : true,//查询结果在表格中显示行号
			fitColumns : true,//列的宽度填满表格，防止下方出现滚动条。
			pageNumber : 1, //初始页码，得在这设置才效果，pagination设置没效果。
			pagination : true
		//分页控件
		});

		var p = $('#tt').datagrid('getPager');
		$(p).pagination({
			pageSize : 20,//每页显示的记录条数，默认为10
			pageList : [ 20, 30, 40, 50 ],//可以设置每页记录条数的列表
			beforePageText : '第',//页数文本框前显示的汉字
			afterPageText : '页    共 {pages} 页',
			displayMsg : '共 {total} 条记录',
			onSelectPage : function(pageNumber, pageSize) {//分页触发
				find(pageNumber, pageSize);
			}
		});

	}

	function find(pageNumber, pageSize) {
		$("#tt").datagrid('getPager').pagination({
			pageSize : pageSize,
			pageNumber : pageNumber
		});//重置
		$("#tt").datagrid("loading"); //加屏蔽
		$.ajax({
			type : "POST",
			dataType : "json",
			url : "../netWordManager/getDayNetWordInfoPage/",
			data : {
				pageNumber : pageNumber,
				pageSize : pageSize
			},
			success : function(data) {
				$("#tt").datagrid('loadData', data);
				$("#tt").datagrid("loaded"); //移除屏蔽
			},
			error : function(err) {
				$.messager.alert('操作提示', '获取信息失败...请联系管理员!', 'error');
				$("#tt").datagrid("loaded"); //移除屏蔽
			}
		});

	}
   function exportSearchExcel(){
	   $("#exportExcel").form('submit', {
			onSubmit : function() {
				return $(this).form('enableValidation').form('validate');
			},
			success : function(data) {
				$.messager.alert('操作提示', '生成中，稍后在用户中心->我的文档里下载', 'succes');
			},

		});
   }
   
  function operation(value, row, index){
	 return "<a href='http://" + row.netAddress + "' target='_blank'>" + row.netAddress + "</a>";	
}	
  function submitFormTongyi(formId,dataId,url){
	   $('#'+formId).form('submit',{
		   onSubmit:function(data){
		     return $(this).form('enableValidation').form('validate');
	     },
		 success:function(data) {
			if(data>0){
			 $.messager.show({
				title:'您有新的消息',
				msg:'已提交'+data+"条",
					showType:'show',
					style:{
						right:'',
						top:document.body.scrollTop+document.documentElement.scrollTop,
						bottom:''
					}
				
			   });
			   $(".easyui-dialog").dialog("close")
		 }else{
			 $.messager.show({
					title:'您有新的消息',
					msg:'重复数据',
						showType:'show',
						style:{
							right:'',
							top:document.body.scrollTop+document.documentElement.scrollTop,
							bottom:''
						}
					
				   });
			 }
			netDayTitle()
		    page_init(dataId,url)
	    },
	   });
	}
</script>
</head>
<body>
	<div class="easyui-panel" title="概况"
		style="width: 100%; padding: 30px 60px;">
		<div id="container"></div>
		<label id="showDeatail"></label>
	</div>
	<div id="tb" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
				<c:if test="${user.roleId == 1}">
					<c:if test="${user.depId == 1}">
						<a id="add" href="#"
							class="easyui-linkbutton" data-options="iconCls:'icon-add'"
							onclick="passCondition('通过')">通过</a>
					 <a id="updatePass" href="#"
						class="easyui-linkbutton" iconCls="icon-save"
						onclick="updatePage()">改价通过</a>
					</c:if>
					<c:if test="${user.depId != 1}">
						<a id="add" href="#"
						class="easyui-linkbutton" data-options="iconCls:'icon-add'"
						onclick="updatePage()">通过</a> 
					</c:if>
					<a id="passTong" href="#"
						class="easyui-linkbutton" data-options="iconCls:'icon-add'"
						onclick="samePassPrice()">统一价通过</a> 
					<a id="updateNo" href="#"
						class="easyui-linkbutton" iconCls="icon-remove"
						onclick="passCondition('不通过')">不通过</a> 
					<a id="updateNo" href="#"
						class="easyui-linkbutton" iconCls="icon-print"
						onclick="opratorDailog('exportDlg','open')">按查询条件导出Excel</a> 
  			 	</c:if>
				</td>
				<td style="white-space: nowrap;">
					<form id="serach" style="text-align: left"
						 method="post"
						data-options="novalidate:true">
						<input id="startData" class="easyui-datebox" name="startData"
							style="width: 260px" data-options="label:'开始时间'">
							
						<input id="endData" class="easyui-datebox" name="endData"
							style="width: 260px" data-options="label:'结束时间',validType:'equaldDate[\'#startData\']'">
							
						<input id="serachKey" name="serachKey" class="easyui-textbox"  
							style="width: 260px" data-options="label:'搜索条件'">
							
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="submitForm()" style="width: 80px">查询</a>
					</form>
				</td>
			</tr>
		</table>
	</div>
	<table id="tt" class="easyui-datagrid"
			style="width: 100%; height: 500px"
			rownumbers="true" pagination="true"
			singleSelect="false" 
			fitColumns="true" striped="true" title="工具栏"
			iconCls: 'icon-edit'
		 	toolbar="#tb"
		 >
		<thead>
			<tr>
				<th data-options="field:'check',checkbox:true"></th>
				<th hidden data-options="field:'id',width:550" align="center"></th>
				<th data-options="field:'keyWord',width:550,editor:'text'" align="center">关键词</th>
				<th data-options="field:'netAddress',width:550,formatter:operation" align="center" sortable="true">网址</th>
				<th data-options="field:'wordTeam',width:550" align="center">分组</th>
				<th data-options="field:'userMoney',width:550" align="center">价格</th>
				<c:if test="${user.depId == 1&&user.roleId==1}">
					<th data-options="field:'proxyMoney',width:550,editor:'text'" align="center">代理商价格</th>
				</c:if>
				<th data-options="field:'flag',width:550" align="center">是否启用</th>
				<th data-options="field:'createTime',width:550" align="center">提交时间</th>
				<th data-options="field:'wordCustmer',width:550" align="center">客户</th>
			</tr>
		</thead>
	</table>
	<div id="dlg" class="easyui-dialog" title="改价通过"
		data-options="iconCls:'icon-save'"
		style="width: 400px; height: 340px; padding: 10px">
		<td style="white-space: nowrap;">
					<form id="serach" style="text-align: left"
						 method="post"
						data-options="novalidate:true">
						<input id="startData" class="easyui-datebox" name="startData"
							style="width: 260px" data-options="label:'开始时间'">
							
						<input id="endData" class="easyui-datebox" name="endData"
							style="width: 260px" data-options="label:'结束时间',validType:'equaldDate[\'#startData\']'">
							
						<input id="serachKey" name="serachKey" class="easyui-textbox"  
							style="width: 260px" data-options="label:'搜索条件'">
							
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="submitForm()" style="width: 80px">查询</a>
					</form>
				</td>
	</div>
	<div id="exportDlg" class="easyui-dialog" title="导出Excel"
		data-options="iconCls:'icon-save'"
		style="width: 400px; height: 340px; padding: 10px">
	
		<form id="exportExcel" style="text-align: left" action="../netWordHistroyManager/exportExcelInfo"
						 method="post"
						data-options="novalidate:true">
						<div style="margin-bottom: 20px">
							<input id="startData" class="easyui-datebox" name="startData"
							style="width: 260px" data-options="label:'开始时间'">
							</div>
						<div style="margin-bottom: 20px">
							<input id="endData" class="easyui-datebox" name="endData"
								style="width: 260px" data-options="label:'结束时间',validType:'equaldDate[\'#startData\']'">
							</div>
						<div style="margin-bottom: 20px">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="exportSearchExcel()" style="width: 80px">导出</a>
						</div>
		</form>
	</div>
	<div id="paddDlgMoney" class="easyui-dialog" title="通过"
		data-options="iconCls:'icon-save'"
		style="width: 400px; height: 340px; padding: 10px">
		<form id="updateForm" class="easyui-form"
			action="../netWordManager/updataWorManagerPass/" method="post"
			data-options="novalidate:true">
			
			<input type="hidden" name="id" />
			<div style="margin-bottom: 20px">
				<input class="easyui-textbox" name="keyWord" style="width: 100%"
					data-options="label:'关键词',required:true" readonly="readonly">
			</div>
			<div style="margin-bottom: 20px">
				<input class="easyui-textbox" name="netAddress" style="width: 100%"
					data-options="label:'网&nbsp;&nbsp;&nbsp;&nbsp;址',required:true" readonly="readonly">
			</div>
			
			<div style="margin-bottom: 20px">
				<!-- <input class="easyui-textbox" name="userMoney" style="width: 100%"
					data-options="label:'金&nbsp;&nbsp;&nbsp;&nbsp;额',required:true"> -->
				<input  class="easyui-numberbox" name="userMoney"  
		 	 	  data-options="label:'金&nbsp;&nbsp;&nbsp;&nbsp;额',required:true,min:0,precision:2">
			</div>
			
			<div style="margin-bottom: 20px">
				<input  class="easyui-numberbox" name="proxyMoney"  
		 	 	  data-options="label:'代理价格',required:true,min:0,precision:2">
			 	 	  
			</div>
			<div style="margin-bottom: 20px">
				<input class="easyui-textbox" name="flag" style="width: 100%"
					data-options="label:'状&nbsp;&nbsp;&nbsp;&nbsp;态',required:true" readonly="readonly">
			</div>
		</form>
		<div style="text-align: center; padding: 5px 0">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="passConditionSubmit()" style="width: 80px">通过</a>
		</div>
	</div>
	<div id="priceDlg" class="easyui-dialog">
		<form id="tongyPrice" action="../netWordManager/samePassPrice" action="post">
			<input type="hidden" id="idArrays" name="ids" >
			<div style="margin-bottom: 20px">
				<input class="easyui-textbox" name="priceUnite" style="width: 40%"
					data-options="label:'价格',required:true" >
			</div>
		 	<div style="text-align: center; padding: 5px 0">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="submitFormTongyi('tongyPrice','tt','../netWordManager/getDayNetWordInfoPage')" style="width: 80px">通过</a>
			</div>
		</form>
	</div>
</body>
</html>