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
<script type="text/javascript" src="../css/js/jquery.cookie.js"></script>
<script type="text/javascript" src="../css/code/highcharts.js"></script>
<script type="text/javascript" src="../css/code/modules/series-label.js"></script>
<script type="text/javascript" src="../css/code/modules/exporting.js"></script>
<script type="text/javascript" src="../css/js/init-page.js"></script>

<link id="easyuiTheme" rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../css/themes/icon.css" />     
<script type="text/javascript">
$(document).ready(function(){
	//page_init('tt','../firstManager/pageInfoData/');
	page_init("tt","../netFinanceManager/selectPageFinacelUserInfo");
	$('#userids').textbox('textbox').bind(
			{input:change,propertychange:change}
		);
		function change(){
			submitSearchForm('serchForm','tt')
		}
})

$.post('../netAllUserManager/getAllUserTitle',function(data){
	//var jsondata=$.parseJSON(data);
	$('#statisWord').html(
			"<span> 今日增加："+data.dayIncrease+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 上月增加："+data.upIncrease+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 本月增加："+data.monthIncrease+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 客质率："+data.custper+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"+
			"<span> 共计："+data.dayIncrease+"&nbsp;&nbsp;&nbsp;&nbsp;</span>"
	);
});

function rechargeInfo(){
	$.messager.alert('操作提示',"请联系您的客户代表进行充值'",'success');
}

function rechargMoney(id){
	   var url = "../netFinanceManager/rechargMoneyInfo"+"?id="+id
	   $.ajax({
	  	 url:url,
	  	 type : "POST",
	  	 success : function (data){
	  		 $('#rechargeForm').form('load',data);
	  		 $('#rechargeId').dialog("open")
	  	 }
	})
}

function refundMoney(id){
	   var url = "../netFinanceManager/rechargMoneyInfo"+"?id="+id
	   $.ajax({
	  	 url:url,
	  	 type : "POST",
	  	 success : function (data){
	  		 $('#refundForm').form('load',data);
	  		 $('#refundId').dialog("open");
	  	 }
	})
}


function userFrozen(id){
	$.messager.confirm('冻结用户','确定冻结吗?',function(r){
	    if (r){
	    	$.ajax({
			      url:"../userManager/frozenUserInfo/?frozenUser=冻结&id="+id,
				  success: function(data){
					$.messager.show({
			    		title:'您有新的消息',
						msg:'用户已被冻结',
						style:{
							right:'',
							top:document.body.scrollTop+document.documentElement.scrollTop,
							bottom:''
						}
			    	})
			    	page_init("tt","../netFinanceManager/selectPageFinacelUserInfo");
				  }
			  })
	    }
	});
	
}
function userHot(id){
	$.messager.confirm('解冻用户','确定解冻吗?',function(r){
	    if (r){
	    	$.ajax({
			      url:"../userManager/frozenUserInfo/?frozenUser=激活&id="+id,
				  success: function(data){
					$.messager.show({
			    		title:'您有新的消息',
						msg:'用户已解冻',
						style:{
							right:'',
							top:document.body.scrollTop+document.documentElement.scrollTop,
							bottom:''
						}
			    	})
			    	page_init("tt","../netFinanceManager/selectPageFinacelUserInfo");
				  }
			  })
	    }
	});
}

function formatOper(val,row,index){  
	var str='<a href="#" style="text-decoration:none;" iconCls="icon-search"  class="easyui-linkbutton"  onclick="rechargMoney('+row.id+')">充值&nbsp;&nbsp;</a>';
	str=str+'<a href="#" style="text-decoration:none;" iconCls="icon-search"  class="easyui-linkbutton" onclick="refundMoney('+row.id+')" >退款&nbsp;&nbsp;</a>';
	if(row.userFrozen=='激活'){
		str=str+'<a href="#" style="text-decoration:none;" iconCls="icon-search"  class="easyui-linkbutton"  onclick="userFrozen('+row.id+')">资料冻结&nbsp;&nbsp;</a>';
	}else if(row.userFrozen=='冻结'){
		str=str+'<a href="#" style="text-decoration:none;" iconCls="icon-search"  class="easyui-linkbutton"  onclick="userHot('+row.id+')">资料解冻&nbsp;&nbsp;</a>';
	}
	str=str+'<a href="../index/appNoPass?id='+row.id+'" style="text-decoration:none;" iconCls="icon-search" target="_Blank" class="easyui-linkbutton"  >登入&nbsp;&nbsp;</a>';
    return str;
}

</script>
<title>所有用户列表</title>
</head>
<body>
	<div class="easyui-panel" style="padding: 30px 60px;">
		<div style="margin-bottom:20px;">
			<label id="statisWord"></label>
		</div>
	</div>
	<div id="tb"style="border-bottom:0;padding:0px;"> 
	 <table style="width:100%;">
	   <tr>
    	 <td style="white-space:nowrap;" align="right">
			<form id="serchForm" action="../netFinanceManager/getUserFinanceDetail">
               <input id="userids" name="searchfiled" class="easyui-textbox" data-options="label:'用户名'" />   
               <a class="easyui-linkbutton" iconCls='icon-search' onclick="submitSearchForm('serchForm','tt')">查询</a>
             </form>
         </td>
       </tr>
      </table>
	</div>
	<div  class="easyui-panel"  style="width:100%;padding:30px 30px;overflow-y: hidden" >
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
				<c:if test="${user.depId==1}">
				   <th data-options="field:'moneyCoupon',width:550" align="center">优惠券</th>
				</c:if>
				<th data-options="field:'userFrozen',width:200" align="center">状态</th>
				<th data-options="field:'_operate',width:550,align:'center',formatter:formatOper">操作</th>
			</tr>
		</thead>
	</table>
	</div>
	
	<div id="rechargeId" class="easyui-dialog" title="充值" style="width:240px;padding:0px;height:388px">
		<div class="easyui-panel" style="padding:20px;">
		<form id="rechargeForm" action="../netFinanceManager/rechargMoneyCenter">
			<input  type="hidden" name="depId"/>
			<input  type="hidden" name="depId"/>
			<input  type="hidden" name="roleId"/>
			
			<div style="margin-bottom:20px">
				<input  class="easyui-textbox" name="userId"   
					data-options="label:'用户ID',required:true"
					readonly="readonly"/>
			</div>
			
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userName"
				  	data-options="label:'用户名',required:true," readonly="readonly"/>
		  	</div>
		  	<div style="margin-bottom:20px">
		  	
			  	<input  class="easyui-numberbox" name="moneyAmonut"  
			 	 	  data-options="label:'金额',required:true,min:0,precision:2">
			</div>
			<c:if test="${user.depId==1}">
		  		<div style="margin-bottom:20px">
			  		<input  class="easyui-numberbox" name="moneyCoupon"
			 	 	  data-options="label:'优惠券',min:-1152921504606846976,precision:2">
				</div>
			</c:if>
			<div>
				<a href="#" class="easyui-linkbutton" style="width:80px" onclick="submitForm('rechargeForm','tt','../netFinanceManager/selectPageFinacelUserInfo');opratorDailog('rechargeId','close')">充值</a>
				<a href="#" class="easyui-linkbutton" style="width:80px" onclick="opratorDailog('rechargeId','close')">取消</a>
			</div>
		</form>
		</div>
	</div>
	
	
	<div id="refundId" class="easyui-dialog" title="退款" style="width:240px;padding:0px;height:388px">
		<div class="easyui-panel" style="padding:20px;">
		<form id="refundForm" action="../netFinanceManager/refundMoneyCenter">
			<input  type="hidden" name="depId"/>
			<input  type="hidden" name="depId"/>
			<input  type="hidden" name="roleId"/>
			
			<div style="margin-bottom:20px">
				<input  class="easyui-textbox" name="userId"   
					data-options="label:'用户ID',required:true"
					readonly="readonly"/>
			</div>
			
			<div style="margin-bottom:20px">
				<input class="easyui-textbox" name="userName"
				  	data-options="label:'用户名',required:true," readonly="readonly"/>
		  	</div>
		  	<div style="margin-bottom:20px">
		  	
			  	<input  class="easyui-numberbox" name="moneyAmonut"  
			 	 	  data-options="label:'金额',required:true,min:-1152921504606846976,precision:2">
			</div>
			<c:if test="${user.depId==1}">
		  		<div style="margin-bottom:20px">
			  		<input  class="easyui-numberbox" name="moneyCoupon"
			 	 	  data-options="label:'优惠券',min:0,precision:2">
				</div>
			</c:if>
			<div>
				<a href="#" class="easyui-linkbutton" style="width:80px" onclick="submitForm('refundForm','tt','../netFinanceManager/selectPageFinacelUserInfo');opratorDailog('rechargeId','close')">退款</a>
				<a href="#" class="easyui-linkbutton" style="width:80px" onclick="opratorDailog('refundId','close')">取消</a>
			</div>
		</form>
		</div>
	</div>
</body>
</html>