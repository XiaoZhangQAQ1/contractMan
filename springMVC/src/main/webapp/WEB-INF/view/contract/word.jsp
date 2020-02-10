<%@page import="com.zhuozhengsoft.pageoffice.PageOfficeCtrl"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
PageOfficeCtrl poCtrl = (PageOfficeCtrl)request.getAttribute("poCtrl");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>word</title>
</head>
<body>
<script type="text/javascript">
        function Save() {
            document.getElementById("PageOfficeCtrl1").WebSave();
             window.external.close();//关闭POBrowser窗口
        }
    </script>
	<div style=" width:auto; height:1000px;">
	 <%=poCtrl.getHtmlCode("PageOfficeCtrl1")%>
	</div>
</body>
</html>