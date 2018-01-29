<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="sql"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fn"%>
 <%@ page isELIgnored="false"%>
<html>  
  <head>  
    <title>测试</title>  
  </head>  
    
  <body>  
  	<c:forEach items="${user}" var="role">
  		<tr>
  			 <th><c:out value="${role.userName}" /></th>
  		 </tr>   
  	</c:forEach>
  </body>  
</html>