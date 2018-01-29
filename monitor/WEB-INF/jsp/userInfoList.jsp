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
	<title>用户维护</title>

	<script type="text/javascript" src="../css/jquery.min.js"></script>  
	<script type="text/javascript" src="../css/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../css/locale/easyui-lang-zh_CN.js"></script>
	<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />     
	<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="../css/js/init-page.js"></script>    
	
	<script type="text/javascript">
		$(document).ready(function(){
		/* 	$('#keyWord').textbox('textbox').bind(
			{ input: change, propertychange: change}
	); */
			initCombox("cc")
			initCombox("ccRole")
			page_init()
			$('#serachUserId').textbox('textbox').bind(
			  {input:change, propertychange: change}
			)
			function change(){
				submitSearchForm('serach','tt')
			}
			
		})
		
		function submitForm(){
			$('#serach').form('submit',{
				onSubmit:function(){
					page_init()
				},
				 success : function(data) {
	            	$("#tt").datagrid("loadData",$.parseJSON(data)); 
	            },
				
			});
		}
		
		function submitAddForm(){
			var nodes = $('#funcTreeProxy').tree('getChecked');
			var s = '';
			for(var i=0; i<nodes.length; i++){
				if(parseInt(nodes[i].id)>100){
					s += nodes[i].id+','
				}
			}
			s=s.substr(0,s.length-1)
			url="../userManager/insertUserSubmit?funcIds="+s
			$('#addForm').form('submit',{
				url:url,
			onSubmit:function(){
				return $(this).form('enableValidation').form('validate');
			},
			success:function(data){
				 if(data>0){
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
				
			   }else{
				   $.messager.show({
						title:'您有新的消息',
						msg:'添加失败，用户ID重复',
						showType:'show',
						style:{
							right:'',
							top:document.body.scrollTop+document.documentElement.scrollTop,
							bottom:''
						}
					 });
			  	 }
				 page_init();
				}
			}
			);
			
			
		}
		function submitAddFormUser(){
			var nodes = $('#funcUserTreeProxy').tree('getChecked');
			var s = '';
			for(var i=0; i<nodes.length; i++){
				if(parseInt(nodes[i].id)>100){
					s += nodes[i].id+','
				}
			}
			s=s.substr(0,s.length-1)
			url="../userManager/insertUserSubmit?funcIds="+s
			$('#addUserForm').form('submit',{
				url:url,
			onSubmit:function(){
				return $(this).form('enableValidation').form('validate');
			},
			success:function(data){
				 if(data>0){
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
				
			   }else{
				   $.messager.show({
						title:'您有新的消息',
						msg:'添加失败，用户ID重复',
						showType:'show',
						style:{
							right:'',
							top:document.body.scrollTop+document.documentElement.scrollTop,
							bottom:''
						}
					 });
			  	 }
				 page_init();
				}
			}
			);
			
			
		}
		
		function clearAddForm(){
			$('#addForm').form('clear')
		}
		function clearForm(){
			$('#serach').form('clear');
		}
		function updatePage() {
			var row = $('#tt').datagrid('getSelected');
			var userid=row.userId
			$.ajax({
		      url:"../userManager/getPager/?userId="+userid,
			  success: function(data){
				  $('#upForm').form('load',data);
				  $("#updlg").dialog("open"); // 打开dialog
				  $('#ccUpdata').combobox({
						formatter:function(row){
							return '<span class="item-text">'+row.text+'</span>';
							/* return '<span class="item-text">'+row.text+'</span>'; */
						}
					});
					$('#ccRoleUpdata').combobox({
						formatter:function(row){
							return '<span class="item-text">'+row.text+'</span>';
						}
					});
			  }
			  	
			});
		}
		
		function reset(){
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
			var userid=row.userId
			$.messager.confirm('重置密码','确定重置密码?',function(r){
			    if (r){
			    	$.ajax({
					      url:"../userManager/resetPwd/?userId="+userid,
						  success: function(data){
							$.messager.show({
					    		title:'您有新的消息',
								msg:'密码重置成功,初始密码为888888，请尽快修改密码',
								style:{
									right:'',
									top:document.body.scrollTop+document.documentElement.scrollTop,
									bottom:''
								}
					    	})
						  }
					  })
			    }
			});
			
		}
		
		function selectPageAll(){
			var row = $('#tt').datagrid('getSelected');
			var depId=row.depId
			$("#ttUser").datagrid({
				url: "../userManager/getInfoUserPage/?depId="+depId+"&flagsub="+"y", //actionName
				queryParams:{pageNumber:1,pageSize:20},//查询参数
				loadMsg:"正在加载数据...",
				rownumbers:true,//查询结果在表格中显示行号
				fitColumns:true,//列的宽度填满表格，防止下方出现滚动条。
				pageNumber:1,   //初始页码，得在这设置才效果，pagination设置没效果。
				pagination: true//分页控件
			});
			var p = $('#ttUser').datagrid('getPager');
		    $(p).pagination({
		        pageSize: 20,//每页显示的记录条数，默认为10
		        pageList: [20,30,40,50],//可以设置每页记录条数的列表
		        beforePageText: '第',//页数文本框前显示的汉字
		        afterPageText: '页    共 {pages} 页',
		        displayMsg: '共 {total} 条记录',
		        onSelectPage: function (pageNumber, pageSize) {
		        	//分页触发
		    	    findSub(pageNumber, pageSize,depId);
		        }
		    });
			//flagsub
		    $('#showUserLag').dialog('open');
			
			
		}
		
		function findSub(pageNumber, pageSize,depId)
		{
		        $("#ttUser").datagrid('getPager').pagination({pageSize : pageSize, pageNumber : pageNumber});//重置
		        $("#ttUser").datagrid("loading"); //加屏蔽
		        $.ajax({
		            type : "POST",
		            dataType : "json",
		            url: "../userManager/getInfoUserPage/?depId="+depId, 
		            data : {
		                pageNumber : pageNumber,
		                pageSize : pageSize
		            },
		            success : function(data) {
		                $("#ttUser").datagrid('loadData',data);
		                $("#ttUser").datagrid("loaded"); //移除屏蔽
		            },
		            error : function(err) {
		                $.messager.alert('操作提示', '获取信息失败...请联系管理员!', 'error');
		                $("#ttUser").datagrid("loaded"); //移除屏蔽
		            }
		        });
		
		}		
		
		
		function submitUpForm(){
			$('#upForm').form('submit',{
			url:"../userManager/updateUserInfo/",
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},
			success:function(data){
				if(data>0){
				 $.messager.show({
					 title:'您有新的消息',
					 msg:'修改成功',
					 showType:'show',
					 style:{
							right:'',
							top:document.body.scrollTop+document.documentElement.scrollTop,
							bottom:''
						}
				   }
				 )
				}else{
					$.messager.show({
						 title:'您有新的消息',
						 msg:'修改失败',
						 showType:'show',
						 style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:''
							}
						})
					}
				  }
				});
			
		}
		
		function clearUpForm(){
			$('#upForm').form('clear')
			
		}
		
		function page_init() {
			
		    $("#tt").datagrid({
 		        url: "../userManager/getInfoUserPage/", //actionName
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
		            url : "../userManager/getInfoUserPage/",
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
</head>
<body>
	<div id="tb"style="border-bottom:0;padding:0px;"> 
	 <table style="width:100%;">
	  <tr>
         <td style="width:50%;">
			<div style="margin-bottom:20px">
				<a href="#" class="easyui-menubutton" data-options="menu:'#easyLook',iconCls:'icon-edit'">增加</a>
				<ul id="easyLook" style="width: 150px">
					<c:if test="${user.depId==1}"><div data-options="iconCls:'icon-add'"  onclick="$('#dlg').dialog('open')">增加代理商</div></c:if>
					<div data-options="iconCls:'icon-add'"  onclick="$('#userdlg').dialog('open')">增加用户</div>
				</ul>
			
			
			<!-- <a  id="add" href="#"  class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#dlg').dialog('open')">增加</a> -->
			
			
			<a id="update" href="#" class="easyui-linkbutton" iconCls="icon-cut" onclick="updatePage()"> 修改</a>
			<a id="resetPwd" href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="reset()"> 重置密码</a>
			<c:if test="${user.depId==1}">
			  <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="selectPageAll()">全部用户</a>
			</c:if>
			<!-- <input class="easyui-textbox" name=userId  style="width:100%"  data-options="label:'用户Id',required:true"> -->
			</div>
			</td>
			<td style="width:100%;" align="right">
			  <form id="serach" action="../userManager/getInfoUserPage/">
				<input id="serachUserId" class="easyui-textbox" name="userId"  style="width:260px"
                	 data-options="label:'用户Id'">   
			 	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" 
                		style="width:80px" onclick="submitSearchForm('serach','tt')">查询</a>
              </form>
            </td>
         </tr>
         </table>
		<!-- <a id="delete" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" plain="true" onclick="deleteForm()">删除</a> -->
	</div>
		<table id="tt" class="easyui-datagrid" style="width:100%;height:700px"
			rownumbers="true" 
			pagination="true"
			singleSelect="true" 
			fitColumns="true"
			title="用户列表" iconCls="icon-save"
			toolbar="#tb">
			<thead>
				<tr> 
					<th data-options="field:'userId',width:550" align="center">用户ID</th>
					<th data-options="field:'userName',width:550" align="center">用户昵称</th>
					<th data-options="field:'userEmail',width:550" align="center">用户邮箱</th>
					<th data-options="field:'userMobile',width:550" align="center">用户手机号码</th>
					<th data-options="field:'depName',width:550" align="center">类别</th>
					<th data-options="field:'roleName',width:550" align="center">角色</th>
					<th data-options="field:'userLoginTime',width:550" align="center">登陆时间</th>
					<th data-options="field:'userLoginNumber',width:550" align="center">登陆次数</th>
					<th hidden data-options="field:'depId',width:550" align="center"></th>
					<th hidden data-options="field:'roleId',width:550" align="center"></th>
				</tr>
			</thead>
		</table>
	
	<div id="dlg" class="easyui-dialog" title="添加代理" data-options="iconCls:'icon-save'" style="width:400px;height:500px;padding:10px">
		<form id="addForm" class="easyui-form"  action="../userManager/insertUserSubmit/" method="post" data-options="novalidate:true">
			<input type="hidden" name="userFrozen" value="激活">
			<div style="margin-bottom:20px">
				<label style="color: red;">温馨提示:初始化密码为888888</label>
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userId"  style="width:100%"  data-options="label:'用户Id',required:true">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userName" style="width:100%"  data-options="label:'用户名',required:true">
			</div>
			
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="depName" style="width:100%"  data-options="label:'代理商名称',required:true">
			</div>
			
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userEmail"   style="width:100%"  data-options="label:'邮&nbsp;&nbsp;&nbsp;&nbsp;箱',validType:'mail'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userMobile"   style="width:100%"  data-options="label:'手&nbsp;&nbsp;&nbsp;&nbsp;机'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userQq"   style="width:100%"  data-options="label:'QQ'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userWechat"   style="width:100%"  data-options="label:'微信'">
			</div>
			
			<div class="easyui-panel" style="padding:5px">
			<div style="margin-bottom:20px">
			  <p>功能区
			  <hr/>
			  <table>
			  <tr>
			  
			  <td style="width:60%;height:200px">
			  	代理商功能:
				<ul id="funcTreeProxy" class="easyui-tree" 
				  url="../funcManager/getTreeFunc"
				  checkbox="true" name="function"  
				  style="width:100%"
				  data-options="label:'功能区',required:true">
				</ul>
				</td>
				</tr>
				</table>
			</div>
			</div>
			<input type="hidden" name="flag" value="proxy">
		</form>
		<div style="text-align:center;padding:5px 0">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddForm()" style="width:80px">提交</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('close')" style="width:80px">取消</a>
		</div>
	</div>
	
	<div id="userdlg" class="easyui-dialog" title="添加用户" data-options="iconCls:'icon-save'" style="width:400px;height:500px;padding:10px">
		<form id="addUserForm" class="easyui-form"  action="../userManager/insertUserSubmit/" method="post" data-options="novalidate:true">
			<input type="hidden" name="userFrozen" value="激活">
			<label style="color: red;">温馨提示:初始化密码为888888</label>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userId"  style="width:100%"  data-options="label:'用户Id',required:true">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userName" style="width:100%"  data-options="label:'用户名',required:true">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userEmail"   style="width:100%"  data-options="label:'邮&nbsp;&nbsp;&nbsp;&nbsp;箱',validType:'mail'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userMobile"   style="width:100%"  data-options="label:'手&nbsp;&nbsp;&nbsp;&nbsp;机'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userQq"   style="width:100%"  data-options="label:'QQ'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userWechat"   style="width:100%"  data-options="label:'微信'">
			</div>
			<c:if test="${user.depId==1}">
			   <div style="margin-bottom:20px">
				 <input id="cc" class="easyui-textbox" url="../depManager/getDepSelect/"" 
				  name="depIdName"   style="width:100%"  
				  data-options="label:'选代理',valueField:'id',textField:'text',required:true">
			   </div>
			</c:if>
			<c:if test="${user.depId>1}">
				 <div style="margin-bottom:20px">
				 <input id="cc" class="easyui-textbox" url="../depManager/getDepSelect/"" 
				  name="depIdName"   style="width:100%"  
				  data-options="label:'选代理',valueField:'id',textField:'text',required:true" readonly="readonly">
			   </div>
				
			</c:if>
			
			
			
		  <div class="easyui-panel" style="padding:5px">
			<div style="margin-bottom:20px">
			  <p>功能区
			  <hr/>
			  <table>
			  <tr>
			  
			  <td style="width:60%;height:200px">
			  	用户功能:
				<ul id="funcUserTreeProxy" class="easyui-tree" 
				  url="../funcManager/getTreeFunc"
				  checkbox="true" name="function"  
				  style="width:100%"
				  data-options="label:'功能区',required:true">
				</ul>
				</td>
				</tr>
				</table>
			</div>
			</div>
			<input type="hidden" name="flag" value="usr">
		</form>
		<div style="text-align:center;padding:5px 0">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddFormUser()" style="width:80px">提交</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#userdlg').dialog('close')" style="width:80px">取消</a>
		</div>
	</div>
	
	
	
	
	<div id="updlg" class="easyui-dialog" title="修改用户" data-options="iconCls:'icon-save'" style="width:400px;height:500px;padding:10px">
		<form id="upForm" class="easyui-form"  action="../userManager/updateUserInfo/" method="post" data-options="novalidate:true">
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userId"  field="userId" value="${userId}"  style="width:100%"  data-options="label:'用户Id',required:true" readonly="readonly">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userName"  field="userName" value="${userName}"   style="width:100%"  data-options="label:'用户名',required:true">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userEmail"   value="${userEmail}"  style="width:100%"  data-options="label:'邮&nbsp;&nbsp;&nbsp;&nbsp;箱',required:true,validType:'mail'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userMobile"  value="${userMobile}" style="width:100%"  data-options="label:'手&nbsp;&nbsp;&nbsp;&nbsp;机',required:true">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userQq"  value="${userQq}" style="width:100%"  data-options="label:'QQ'">
			</div>
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userWechat"  value="${userWechat}" style="width:100%"  data-options="label:'微信'">
			</div>
		</form>
		<div style="text-align:center;padding:5px 0">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitUpForm()" style="width:80px">提交</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#updlg').dialog('close');" style="width:80px">取消</a>
		</div>
	</div>
	<div id="showUserLag" class="easyui-dialog" title="所属用户" style="width:800px;padding:0px;height:740px"">
	<table id="ttUser" class="easyui-datagrid" 
				rownumbers="true" 
				pagination="true"
				singleSelect="flase" 
				fitColumns="true"
				style="width:100%;height:700px"
				>
				<thead>
					<tr> 
						<th data-options="field:'check',checkbox:true"></th>
						<th data-options="field:'userId',width:120" align="center">用户ID</th>
						<th data-options="field:'userName',width:120" align="center">用户名</th>
						<th data-options="field:'userEmail',width:120" align="center">用户邮箱</th>
						<th data-options="field:'userMobile',width:120" align="center">用户手机号码</th>
						<th data-options="field:'depName',width:120" align="center">类别</th>
						<th data-options="field:'roleName',width:120" align="center">角色</th>
					</tr>
				</thead>
			</table>
	</div>
	
</body>
</html>