<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'login.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Document</title>
	<!-- Bootstrap -->
    <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/zhuce.css">
    <link href="https://cdn.bootcss.com/bootstrap-validator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
  </head>
  <body>
   <div id="alterText">
	<c:if test="${not empty error}">
		<div class="alert alert-danger" role="alert" style="position:fixed;bottom: 0px;right: 15px;text-align:center;background-color:#c14842;color:white;">
	  	 	${error}
	  	 </div>
	</c:if>
	<c:if test="${not empty success}" >
		<div class="alert alert-success" role="alert" style="position:fixed;bottom: 0px;right: 15px;width:13%;text-align:center;color:white;background-color:#8ac007">
	  	 	${success}
	  	 </div>
	</c:if>
  </div>
  <div class="main col-md-4 col-md-offset-4" style="margin-top: 140px; ">
		<form class="form-login" action="./my/login" method="post">
			<div class="logo">
				<b>合同管理系统</b><small>V1.0</small>
			</div>
	        <div class="login-content col-md-8" style="margin-left: 70px;">
				<div class="input-group col-md-10">
				 <input type="text" id="uid" name="uid" class="form-control" placeholder="请输入你的账号/邮箱" required autofocus>
		        </div>
		       
		    	<div class="input-group col-md-10">
		    		<input type="password" id="password" name="password" class="form-control" placeholder="请输入你的密码" required>
		    	</div>
				
				<div class="input-group" style="margin-left: 25px;">
			        <input type="checkbox" name="rememberMe" value="true">记住密码
		    	</div>
				
				<div class="input-group col-md-10" style="margin-top: 20px;">
					<button class="btn btn-primary btn-block" type="submit">立即登录</button>
				</div>

				<div class="forget col-md-offset-1">
					<a id="forgetPass">[忘记密码]</a>
				</div>
	        </div>
	    </form>

	    <form id="defaultForm" role="form" class="form-register" action="./my/changPass"
                method="post">
			<div class="register-content col-md-9" style="margin-left: 45px;display: none;">
				<div class="form-group" >
				 <button type="button" class="btn btn-default btn-block dropdown-toggle" data-toggle="dropdown" style="text-align: left;">
					使用电子邮箱找回您的密码 <span class="caret" style="float:right;margin-top: 8px;"></span>
				 </button>
		        </div>
				<div class="form-group">
				 <input type="text" name="email" id="email" class="form-control" placeholder="请输入验证邮箱" required autofocus>
		        </div>
		       
		       	<div class="code form-group">
		    		<div class="input-group" style="margin-top: 0px;">
		    			<input type="text" name="validate" id="validate" class="form-control" placeholder="请输入右侧的验证码" required>
                    	<div class="input-group-btn">
				    		<button type="button" class="btn btn-default getCode" >
									获取邮箱验证码
							</button>
						</div>
		    		</div>
                </div>

		       	<div class="form-group">
		    		<span class="font">设置新密码</span>
		    	</div>
		       	
		    	<div class="form-group">
		    		<input type="password" name="password" class="form-control" placeholder="请输入密码" required>
		    	</div>
				
				<div class="form-group">
		    		<input type="password" name="repassword" class="form-control" placeholder="再次输入密码" required>
		    	</div>

				<!-- <div class="form-group">
					<div class="input-group" style="margin-top: 0px;">
						<div class="input-group-btn">
				    		<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
									+86
									<span class="caret"></span>
							</button>
						</div>
						<input type="text" name="tel" class="form-control" placeholder="请输入手机号" required>
					</div>
				</div> -->

				<div class="form-group lastbtn" style="margin-top: 20px;margin-bottom: 20px;">
					<button class="btn btn-primary" type="submit" id="validateBtn">提交</button>
					<button class="btn btn-default col-md-offset-3" type="button" id="goLogin">返回</button>
				</div>

			</div>
	    </form>
	</div>	
  </body>
  <script type="text/javascript">
$(function(){/* 文档加载，执行一个函数*/
	 $('.alert').fadeOut(5000);
	 var eMailCode;
     $('#defaultForm')
     .bootstrapValidator({
         message: 'This value is not valid',
         feedbackIcons: {/*input状态样式图片*/
             valid: 'glyphicon glyphicon-ok',
             invalid: 'glyphicon glyphicon-remove',
             validating: 'glyphicon glyphicon-refresh'
         },
         fields: {/*验证：规则*/
             email: {//验证input项：验证规则
                 message: 'The username is not valid',
                
                 validators: {
                     notEmpty: {//非空验证：提示消息
                         message: '邮箱不能为空'
                     },
                     emailAddress:{
                     	 message: '邮箱地址格式有误'
                     }
                 }
             },
             password: {
                 message:'密码无效',
                 validators: {
                     notEmpty: {
                         message: '密码不能为空'
                     },
                     stringLength: {
                         min: 6,
                         max: 30,
                         message: '密码长度必须在6到30之间'
                     },
                     identical: {//相同
                         field: 'password', //需要进行比较的input name值
                         message: '两次密码不一致'
                     },
                     different: {//不能和用户名相同
                         field: 'username',//需要进行比较的input name值
                         message: '不能和用户名相同'
                     },
                     regexp: {
                         regexp: /^[a-zA-Z0-9_\.]+$/,
                         message: '密码只能包含数字，字母，下划线'
                     }
                 }
             },
             repassword: {
                 message: '密码无效',
                 validators: {
                     notEmpty: {
                         message: '密码不能为空'
                     },
                     stringLength: {
                         min: 6,
                         max: 30,
                         message: '密码长度必须在6到30之间'
                     },
                     identical: {//相同
                         field: 'password',
                         message: '两次密码不一致'
                     },
                     different: {//不能和用户名相同
                         field: 'username',
                         message: '不能和用户名相同'
                     },
                     regexp: {//匹配规则
                         regexp: /^[a-zA-Z0-9_\.]+$/,
                         message: '密码只能包含数字，字母，下划线'
                     }
                 }
             },
             validate: {
                 message: '验证码',
                 validators: {
                     notEmpty: {
                         message: '验证码不能为空'
                     },
                     threshold :  4 , //有4字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                     remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}  
                         url: 'my/valid',//验证地址
                         message: '验证码错误',//提示消息
                         delay :  2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                         type: 'POST'//请求方式
                     }
                 }
             }
         }
     })
	$('#validateBtn').click(function() {
         $('#defaultForm').bootstrapValidator('validateBtn');
     });
	$('#goLogin').click(function(){
		$('.register-content').hide();
		$('.login-content').show();
	});
	$('#forgetPass').click(function(){
		$('.register-content').show();
		$('.login-content').hide();
	});
	$('.getCode').click(function(){
		$.ajax({
			url: "my/sendMail",
			type: "post",
			data: {
				eMail: $("#email").val()
			},
			dataType: "json",
			success: function(data) {//响应成功执行的方法
				if(data.code==1){
					eMailCode=data.object;
					var count = 60;
					var countDown = setInterval(function(){
						$('.getCode').attr("disabled",true);
						$('.getCode').text(count+"秒后再次获取");
						if (count==0) {
							$('.getCode').text("获取邮箱验证码").removeAttr("disabled");
							clearInterval(countDown);
						}
						count--;
					},1000);	
				}else{
					//alert(data.info);
					var a = $("<div></div>").text(data.info);
					a.attr("class","alert alert-danger");
					a.attr("style","position:fixed;bottom: 0px;right: 15px;text-align:center;color:white;background-color:#c14842;");
					$('#alterText').append(a);
					a.fadeOut(3000);
				}
			},
			error : function() {//出现异常执行方法
				alert("出现错误");
			}

		});
	});
//      .on('success.form.bv', function(e) {//点击提交之后
//          // Prevent form submission
//          e.preventDefault();

//          // Get the form instance
//          var $form = $(e.target);

//          // Get the BootstrapValidator instance
//          var bv = $form.data('bootstrapValidator');

//          // Use Ajax to submit form data 提交至form标签中的action，result自定义
//          $.post($form.attr('action'), $form.serialize(), function(result) {
// //do something...
// });
//      });
});

</script>
</html>
