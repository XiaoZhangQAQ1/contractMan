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
						<a href="<%=basePath%>/my/logout">退出当前登陆</a>
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
            		代办事项
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
<button class="btn" id="goHome">返回</button>
          <h1 class="page-header"></h1>

          <h2 class="sub-header"><span class="glyphicon glyphicon-send"></span> 发起合同</h2>
          <div class="crtNecInfo">
            <h4 style="text-align: center;margin-top: 50px;">在发起合同前，请填写以下必须信息~</h4>
            <form id="defaultForm" role="form" class="form-register" action="../crt/insertCrt" method="post">
              <div class="register-content col-md-4 col-md-offset-4" style="border: 1px solid #eee;">
              <div class="form-group" style="width:60%;margin:auto;margin-top: 20px;">
                 <input type="text" name="cno" id="crtNm" class="form-control" placeholder="请输入合同号" required autofocus>
              </div> 
              <div class="form-group" style="margin:auto; margin-top: 20px;width:60%">
                 <input type="text" name="cnm" class="form-control" placeholder="请输入合同名" required autofocus>
              </div> 
                    
                <div class="tpcd form-group" style="width:60%;margin:auto; margin-top: 20px">
                  请选择您的合同类别
                  <select class="form-control" name="tpcd" >
                    <option value="s1">软件开发</option>
                    <option value="s2">技术服务</option>
                    <option value="s3">技术咨询</option>
                    <option value="s4">产品销售</option>
                    <option value="s5">系统集成</option>
                    <option value="b1">设备采购</option>
                    <option value="b2">服务采购</option>
                  </select>
                </div>
                
                <div class="form-group" style="width:60%;margin:auto; margin-top: 20px">
                    <input type="text" name="fpnm" class="form-control" placeholder="请输入甲方名称" required>
                </div>

                <div class="adcd form-group" style="width:60%;margin:auto; margin-top: 20px">
                  请选择甲方所属行政区
                  <select class="form-control" name="adcd">
                    <option value="110000北京市">北京市</option>
                    <option value="120000天津市">天津市</option>
                    <option value="130000河北省">河北省</option>
                    <option value="140000山西省">山西省</option>
                    <option value="360000江西省">江西省</option>
                  </select>
                </div>

                <div class="form-group" style="width:60%;margin:auto; margin-top: 20px">
                    <input type="text" name="amt" class="form-control" placeholder="请输入签订金额" required>
                </div>

                <div class="form-group lastbtn" style="margin-top: 20px;margin-bottom: 20px;text-align:center;">
                  <button class="btn btn-primary" type="submit" id="validateBtn" style="width: 60%;background-color: #418bca;">提交</button>
                </div>

              </div>
            </form>
            
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
		});
		$(function(){/* 文档加载，执行一个函数*/
		     $('#defaultForm')
		     .bootstrapValidator({
		         message: 'This value is not valid',
		         feedbackIcons: {/*input状态样式图片*/
		             valid: 'glyphicon glyphicon-ok',
		             invalid: 'glyphicon glyphicon-remove',
		             validating: 'glyphicon glyphicon-refresh'
		         },
		         fields: {/*验证：规则*/
		             cno: {//验证input项：验证规则
		                 message: 'The username is not valid',
		                
		                 validators: {
		                     notEmpty: {//非空验证：提示消息
		                         message: '合同号不能为空'
		                     },
		                     stringLength: {
		                         min: 8,
		                         max: 8,
		                         message: '合同号只能为8位'
		                     },
		                     regexp: {
		                         regexp: /^[a-zA-Z0-9]+$/,
		                         message: '合同号由数字字母组成'
		                     },
		                     threshold :  8 , //有8字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
		                     remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}  
		                         url: '../crt/checkCrt',//验证地址
		                         message: '该合同已存在',//提示消息
		                         delay :  2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
		                         type: 'POST'//请求方式
		                     }
		                 }
		             },
		             cnm: {
		                 message:'合同名无效',
		                 validators: {
		                     notEmpty: {
		                         message: '合同名不能为空'
		                     }
		                 }
		             },
		             tpcd: {
		                 message:'合同类别无效',
		                 validators: {
		                     notEmpty: {
		                         message: '合同类别不能为空'
		                     }
		                 }
		             },
		             fpnm: {
		                 message: '甲方名称无效',
		                 validators: {
		                     notEmpty: {
		                         message: '甲方名称不能为空'
		                     },
		                     stringLength: {
		                         min: 0,
		                         max: 50,
		                         message: '甲方名称不能超过50位'
		                     }
		                 }
		             },
		             adcd: {
		                 message: '甲方所属行政区无效',
		                 validators: {
		                     notEmpty: {
		                         message: '甲方所属行政区不能为空'
		                     }
		                 }
		             },
		             amt: {
		                 message: '签订金额无效',
		                 validators: {
		                     notEmpty: {
		                         message: '签订金额不能为空'
		                     },
		                     regexp: {
		                         regexp: /^[0-9]+$/,
		                         message: '签订金额只能由数字组成'
		                     }
		                 }
		             }
		         }
		     })
		     $('#validateBtn').click(function() {
		         $('#defaultForm').bootstrapValidator('validateBtn');
		     });
		 });
    </script>
</body>
</html>