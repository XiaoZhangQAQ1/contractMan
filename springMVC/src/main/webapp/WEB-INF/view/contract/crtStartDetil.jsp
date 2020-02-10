<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
    <div id="alterText">
		<c:if test="${not empty success}" >
			<div class="alert alert-success" role="alert" style="position:fixed;bottom: 0px;right: 15px;width:13%;text-align:center;color:white;background-color:#8ac007">
		  	 	${success}
		  	 </div>
		</c:if>
		<c:if test="${not empty error}" >
			<div class="alert alert-success" role="alert" style="position:fixed;bottom: 0px;right: 15px;text-align:center;color:white;background-color:#c14842">
		  	 	${error}
		  	 </div>
		</c:if>
	</div>

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
            		<!-- <span class="badge">21</span> -->
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
          <!-- <ul class="nav nav-sidebar">  
            <li><a href="">Nav item</a></li>	
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
            <li><a href="">More navigation</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
          </ul> -->
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-11 col-md-offset-1 main">
			<button class="btn newCrt" style="width:10%">重新发起合同</button>
			          <h1 class="page-header"></h1>
			
			          <h2 class="sub-header"><span class="glyphicon glyphicon-send"></span> 发起合同</h2>
			          <div class="startCrt" style="margin-top: 20px;">
			            <h4>您现在有三种方式发起合同:</h4>
			            <div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-0" style="border: 1px solid #eee;">
			              <div class="form-group">
			              <form method="post" enctype="multipart/form-data" action="../crtInfo/uoloadCrt">
			              	<h4>上传合同</h4>
			                <h4 class="sub-header"></h4>
			                <p class="help-block">您可以选择直接上传编辑好的合同</p>
                			<p class="help-block">上传前，请确认合同文档规范</p>
                			<h4 class="sub-header"></h4>
			                <input type="file" id="inputfile" name="file">
			                <p class="help-block">请选择您要上传的合同</p>
			                <p class="sub-header" style="padding-bottom: 0px;"></p>
			                <div id="accordion">
			                <div class="panel panel-default">
			                	<div class="panel-heading">
			                		<h4 class="panel-title">
			                			<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" style="text-decoration:none">如有附件，请点击上传</a>
			                		</h4>
			                	</div>
			                	<div id="collapseOne" class="panel-collapse collapse">
									<div class="panel-body">
										<input type="file" id="inputApx" name="file">
			                			<p class="help-block">请选择您要上传的合同附件</p>
									</div>
								</div>
							</div>
			                </div>
			                <button class="btn btn-primary upload" style="width: 100%;background-color: #418bca;">确认上传</button>
			              </form>
			              </div>
			            </div>
			
			            <div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-1" style="border: 1px solid #eee;">
			              <div class="form-group">
			                <h4>使用模板在线编辑合同</h4>
			                <h4 class="sub-header"></h4>
			                <p class="help-block">您可以选择系统中自带的模板进行在线编辑</p>
			                <p class="help-block">当前仅支持软件开发合同的在线编辑</p>
			                <h4 class="sub-header"></h4>
			                <span class="help-block" style="display: inline-block;">您选择的合同模板类型：${crtType}</span>
			                <c:if test="${crtType== '软件开发' }">
			                	<button class="btn btn-primary editOnline" style="width: 100%;background-color: #418bca;margin-top:20px;">在线编辑</button>
			                </c:if>   
			                <c:if test="${crtType!= '软件开发'}">
			                	<button class="btn btn-primary disabled editOnline" style="width: 100%;background-color: #418bca;margin-top:20px; pointer-events:none;">该模板暂时不支持在线编辑</button>
			                </c:if>  
			              </div>
			            </div>
			
			             <div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-1" style="border: 1px solid #eee;">
			              <div class="form-group">
			                <h4>下载对应的模板</h4>
			                <h4 class="sub-header"></h4>
			                <p class="help-block">您可以下载系统中自带的模板进行离线编辑</p>
			                <p class="help-block">当前仅支持软件开发合同的模板下载</p>
			                <h4 class="sub-header"></h4>
			                <span class="help-block" style="display: inline-block;">您选择的合同模板类型：${crtType}</span>
			                <c:if test="${crtType== '软件开发'}">
			                	<button class="btn btn-primary downloadNow" style="width: 100%;background-color: #418bca;margin-top:20px;">点击下载</button>
			                </c:if>   
			                <c:if test="${crtType!= '软件开发'}">
			                	<button class="btn btn-primary disabled downloadNow" style="width: 100%;background-color: #418bca;margin-top:20px; pointer-events:none;">暂无该模板下载资源</button>
			                </c:if>  
			              </div>
			            </div>
			          </div>
			           </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script src="<%=basePath%>bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>  
    <script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript">
    	$('.alert').fadeOut(5000);
    	$(document).on('click','#goHome',function(e){
    		window.location.href="<%=basePath%>page/main";
    	})
    	$('.downloadNow').click(function(){
    		//alert($('#downModel').val());
    		//var mdlcdV = $('#downModel').val();
    		//alert(${tpcd});
    		window.open("<%=basePath%>crtInfo/download?mdlcd=${tpcd}");
    	})
    	
    	$('.editOnline').click(function(){
    		window.open("<%=basePath%>crt/editOnline?cno=${cno}");
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
					clearInterval(timer);
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
		
		$('.newCrt').click(function(e){
			$.ajax({
				url:"../crt/crtStartRemove",
				type:"get",
				dataType: "html",
				success: function(data){
					$('.main').html(data);
				}
			})
		})
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

			//var rid = ${role};
			//alert("${rid}");
			//alert($(a[0]).text());
			$.ajax({
				url:"../crt/conInfo",
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
		});
		
    </script>
</body>
</html>