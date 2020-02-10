<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
            <shiro:hasRole name="合同管理员">
	            <li>
	            	<a href="#" class="conStart">
	            		<span class="glyphicon glyphicon-send"></span> 
	            		发起合同
	            	</a>
	            </li>
            </shiro:hasRole>
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
        	<h2 class="sub-header">
            <span class="glyphicon glyphicon-user"></span> 用户基本信息
            <button class="btn findCon" data-toggle="modal" data-target="#alterInfo" style="float: right;background-color: #f4f4f4;font-weight: bold;width:8%">
              	修改信息
            </button>
            <!-- 模态框（Modal） -->
			<div class="modal fade" data-backdrop="false" id="alterInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                <h4 class="modal-title" id="myModalLabel">修改信息</h4>
			            </div>
			            <div class="modal-body">
			            	<div class="form-group">
	                          <input type="text" id="uName" name="uName" class="form-control" placeholder="请输入修改后的用户昵称">
	                        </div>
	                        <div class="form-group">
	                          <input type="text" id="tel" name="tel" class="form-control" placeholder="请输入修改后的手机号">
	                        </div>
						</div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-default" data-dismiss="modal" style="width: 10%">关闭</button>
                            <button type="button" class="btn btn-primary userInfoSub" data-dismiss="modal" style="width: 10%;background-color: #337ab7">提交</button>
			            </div>
			        </div><!-- /.modal-content -->
			    </div><!-- /.modal -->
			</div>
          </h2>
          <div class="col-sm-9 col-sm-offset-3 col-md-8 col-md-offset-2">
            <div class="panel panel-default">
              <div class="panel-body">
                  <table class="table">
                    <tr><td><span>用户昵称：</span> ${user.uName}</td></tr>
                    <tr><td><span>用户身份：</span> ${role}</td></tr>
                    <tr><td><span>用户邮箱：</span> ${user.eMail}</td></tr>
                    <tr><td><span>用户手机：</span> ${user.tel}</td></tr>
                    <tr><td><span>创建时间：</span><fmt:formatDate value="${user.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td></tr>
                    <tr><td><span>最近登录时间：</span><fmt:formatDate value="${user.loginDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td></tr>
                  </table>
              </div>
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
    $('.alert').fadeOut(5000);
    $(document).on('click','#goHome',function(e){
		window.location.href="<%=basePath%>page/main";
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
		
		
		
		$('.userInfoSub').click(function(e){
			if(!$('#tel').val().match(/^1[34578]\d{9}$/)) {
		         alert("手机号格式输入有误");
		         return ;
		     }
	      $(location).attr("href","<%=basePath%>user/userAlter?uName="+$('#uName').val()+"&tel="+$('#tel').val());
	    })
    </script>
</body>
</html>