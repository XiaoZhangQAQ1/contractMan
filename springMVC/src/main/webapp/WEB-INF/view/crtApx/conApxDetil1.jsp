<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript" src="<%=basePath%>jquery.min.js"></script> 
<script type="text/javascript" src="<%=basePath%>pageoffice.js" id="po_js_main"></script>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Bootstrap core CSS -->
    <link href="<%=basePath%>bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="<%=basePath%>css/dashboard.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap-validator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet">
</head>
<body>
<script>
	function loginOutCheck(){
		if(confirm("确认退出吗?")){
			return true;
		}
		return false;	
	}
</script>
	<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">合同管理系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <!-- <li><a href="#">Dashboard</a></li>
            <li><a href="#">Settings</a></li>
            <li><a href="#">About me</a></li> -->
            <li></li>
            <li class="dropdown">
            	<a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
            		<span class="glyphicon glyphicon-user"></span> 
            		${role}  
            		<span class="caret"></span>
            	</a>
            	<ul class="dropdown-menu">
					<li>
						<a href="<%=basePath%>user/userCenter">用户中心</a>
					</li>
					<li>
						<a href="<%=basePath%>/my/logout" onclick="return loginOutCheck();">退出当前登陆</a>
					</li>
            	</ul>
            </li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-2 col-md-1" id="sidebar-first">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="<%=basePath%>page/main">合同管理 <span class="sr-only">(current)</span></a></li>
            <li>
            	<a href="#" class="conStart">
            		<span class="glyphicon glyphicon-send"></span> 
            		发起合同
            	</a>
            </li>
            <li>
            	<a href="#" class="conApprove">
            		<span class="glyphicon glyphicon-edit"></span> 
            		待办事项
            	</a>
            </li>
            <li>
            	<a href="#" class="processFind">
            		<span class="glyphicon glyphicon-stats"></span>
            		进度查询
            	</a>
            </li>
            <li>
            	<a href="#" class="conOk">
	            	<span class="glyphicon glyphicon-check"></span> 
	            	已办事项 
            	</a>
        	</li>
        	<li>
            	<a href="#" class="userMan">
	            	<span class="glyphicon glyphicon-user"></span> 
	            	用户管理
            	</a>
        	</li>
        	<li>
            	<a href="#" class="conApx">
	            	<span class="glyphicon glyphicon-file"></span> 
	            	附件管理
            	</a>
        	</li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-11 col-md-offset-1 main">
        	<div id="alterText">
		<c:if test="${not empty error}">
			<div class="alert alert-danger" role="alert" style="position:fixed;bottom: 0px;right: 15px;width:13%;text-align:center;background-color:#c14842;color:white;">
		  	 	${error}
		  	 </div>
		</c:if>
		<c:if test="${not empty success}" >
			<div class="alert alert-success" role="alert" style="position:fixed;bottom: 0px;right: 15px;width:13%;text-align:center;color:white;background-color:#8ac007">
		  	 	${success}
		  	 </div>
		</c:if>
	</div>
<button class="btn" id="goHome">返回</button>
    <h1 class="page-header"></h1>
    <h2 class="sub-header">
    <span class="glyphicon glyphicon-file"></span> 合同附件详情
    </h2>
    <div class="contract">
      <h4 style="color: red;">合同基本信息(当前的显示信息仅为该合同的部分关键信息)</h4>
      <h5 class="help-block">合同编号:${contract.cno}</h5>
      <h5 class="help-block">合同名称:${contract.cnm}</h5>
      <h5 class="help-block">合同金额:${contract.amt}</h5>
      <c:if test="${contract.tpcd!='b1' and contract.tpcd!='b2'}">
      	<h5 class="help-block">甲方公司:${contract.fpnm}</h5>
      </c:if>
      <c:if test="${contract.tpcd=='b1' or contract.tpcd=='b2'}">
      	<h5 class="help-block">乙方公司:${contract.fpnm}</h5>
      </c:if>
      <h5 class="help-block">签订时间:<fmt:formatDate value="${contract.sgtm}" pattern="yyyy-MM-dd HH:mm:ss" /></h5>
    </div>
    <h2 class="sub-header"></h2>
    
    <h4><span class=" glyphicon glyphicon-paperclip"></span> 附件详情</h4> 
    <div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-0" style="border: 1px solid #eee;">
        <div class="form-group">
        	
                <h4><span class=" glyphicon glyphicon-upload"></span>上传附件</h4>
                <h4 class="sub-header"></h4>
                <input type="file" name="file" id="inputfile">
                <p class="help-block">请选择您要上传的附件,支持附件格式为doc,docx</p>
                <button class="btn btn-primary" id="uploadApx" style="width: 100%;background-color: #418bca;">确认上传</button>
            
        </div>
    </div>
    <div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-1" style="border: 1px solid #eee;">
        <div class="form-group">
                <h4><span class=" glyphicon glyphicon-search"></span> 在线预览附件</h4>
                <h4 class="sub-header"></h4>
                 <p class="help-block">在线预览,可检查您上传的附件是否有误</p>
                 <p class="help-block">点击附件名即可在线预览</p>
                 <c:if test="${not empty contract.conAppendix}">
                 <c:forEach items="${contract.conAppendix}" var="conAppendix">
                 	<a href="javascript:POBrowser.openWindowModeless('../crtLook/lookApx?cno='+${contract.cno}+'&id='+${conAppendix.id},'width=1200px;height=1000px;')">${conAppendix.apxName}</a><br>
                 </c:forEach>
                 </c:if>
                <c:if test="${empty contract.conAppendix}">
                 	该合同暂未上传任何附件
                </c:if>
        </div>
    </div>
    <div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-1" style="border: 1px solid #eee;">
        <div class="form-group">
            <form>
                <h4><span class=" glyphicon glyphicon-ok"></span> 当前合同已上传的附件</h4>
                <h4 class="sub-header"></h4>
                 <p class="help-block">点击附件名,可进行下载/删除操作</p>
                 <p class="help-block" style="color: red;">附件一经删除不可恢复，请慎重操作</p>
                 <c:if test="${not empty contract.conAppendix}">
                 <div id="accordion">
	                 <c:set var="i" value="0"></c:set>
	                 <c:forEach items="${contract.conAppendix}" var="conAppendix">
	                 <c:set var="i" value="${i+1}"></c:set>
	                 <div class="panel panel-default" style="border:none;margin-bottom:0px;">
		                 <p class="panel-title" style="font-size:15px;">
			                 <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne${i}">
								${conAppendix.apxName}
							 </a>
						 </p>
						 <div id="collapseOne${i}" class="panel-collapse collapse">
							<div class="panel-body" style="padding:0;">
								<a href="../crtInfo/downloadApx?id=${conAppendix.id}" style="margin-left: 0px;margin-top:0px;">点我下载</a>
								<a href="../crtApx/delApx?id=${conAppendix.id}&cno=${conAppendix.cno}" style="margin-left: 30px;">点我删除</a>
							</div>
						</div>
					</div>
	                 	<%-- <p>${conAppendix.apxName}<a href="../crtInfo/downloadApx?id=${conAppendix.id}" style="margin-left: 15px;">下载</a><a href="../crtApx/delApx?id=${conAppendix.id}&cno=${conAppendix.cno}" style="margin-left: 15px;">删除</a></p> --%>
	                 </c:forEach>
                 </div>
                 </c:if>
                 <c:if test="${empty contract.conAppendix}">
                 	该合同暂未上传任何附件
                 </c:if>
            </form>
        </div>
    </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script src="<%=basePath%>bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>  
    <script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript">
    $(document).on('click','#goHome',function(e){
		window.location.href="<%=basePath%>page/main";
	})
    $('.alert').fadeOut(5000);
    	$('#uploadApx').click(function(){
    		var cno = ${contract.cno};
    		var form = new FormData();
    		form.append("cno",cno);
    		form.append("file",$('#inputfile')[0].files[0]);
    		 $.ajax({
    			url:"../crtApx/addApx",
    			type:"post",
    			data:form,
    			processData: false,
                contentType: false,
                
                cache:false,
                dataType: "html",
                success: function(data){
/*                 	alert("成功");
                	alert(data); */
					$('.main').html(data); 
				},
				error:function() {//出现异常执行方法
					alert("出现错误");
				}
    		}) 
    	})
 
    	var flag = -1;
		$('.navbar-brand').click(function(){
			if (flag==1) {
				$('.row').attr("id","sidebar-show");
				$('.main').attr("class","col-sm-9 col-sm-offset-3 col-md-11 col-md-offset-1 main");
				flag = -flag;
			}else{
				$('.row').removeAttr("id");
		        $('#sidebar-first').attr("class","col-sm-2 col-md-1 sidebar");
		        $('.sidebar').removeAttr("id");
				var timer=setTimeout(function(){
					$('.main').attr("class","col-sm-9 col-sm-offset-3 col-md-12 col-md-offset-0 main");
					flag = -flag;
					clearTimeout(timer);
				},500);
				
			}
		});
		
		$('.conApx').click(function(){
			$.ajax({
				url:"../crtApx/apxMan",
				type:"get",
				dataType: "html",
				success: function(data){
					$('.main').html(data);
				}
			})
		});
		
		$('.conStart').click(function(e){
			window.location.href="<%=basePath%>crt/crtStart";
		});
		
		$('.conOk').click(function(e){
			$.ajax({
				url:"../crt/conOk",
				type:"get",
				dataType: "html",
				success: function(data){
					$('.main').html(data);
				}
			})
		});
		
		$('.processFind').click(function(e){
			$.ajax({
				url:"../crt/processFind",
				type:"get",
				dataType: "html",
				success: function(data){
					$('.main').html(data);
				}
			})
		});
		
		$('.conApprove').click(function(e){
			$.ajax({
				url:"../crt/conApprove",
				type:"get",
				dataType: "html",
				success: function(data){
					$('.main').html(data);
				}
			})
		});
		
		$('.userMan').click(function(e){
			$.ajax({
				url:"../user/userMan",
				type:"get",
				dataType: "html",
				success: function(data){
					$('.main').html(data);
				}
			})
		});
		
		$(document).on('click','tbody tr td .conInfo',function(e){
			var a=$(this).parent().siblings();
			var value=$(a[0]).text();
			var flagValue = $(a[4]).text();
			
			//var rid = ${role};
			//alert("${rid}");
			//alert($(a[0]).text());
			$.ajax({
				url:"../crt/conInfo",
				type:"post",
				data:{
					cno:value,
					flagValue:flagValue
				},
				dataType: "html",
				success: function(data){
					$('.main').html(data);
				}
			})
		})
		
		 $(document).on('click','tbody tr td .conDetil',function(e){
			var a=$(this).parent().siblings();
			var value=$(a[0]).text();
			//var rid = ${role};
			//alert("${rid}");
			//alert($(a[0]).text());
			$.ajax({
				url:"../crt/conApproveDetil",
				type:"post",
				data:{
					cno:value
				},
				dataType: "html",
				success: function(data){
					$('.main').html(data);
				}
			})
		}) 
		
    </script>
</body>
</html>