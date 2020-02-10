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
	<h2 class="sub-header"><span class="glyphicon glyphicon-user"></span> 用户管理
            <button class="btn findUserCon" style="float: right;background-color: #f4f4f4;font-weight: bold;width:7%">
                <span class="glyphicon glyphicon-filter"></span> 查询
            </button>
            <button class="btn" data-toggle="modal" data-target="#adUser" style="float:right;background-color: #f4f4f4;font-weight: bold;width: 8%;margin-right: 15px;">
                <span class="glyphicon glyphicon-plus"></span> 新增用户
            </button>
          </h2>
          <div class="sub-header findMenu" style="display: none;">
              <div class="row-right">
                <form class="form-inline">
                    <div class="form-group col-md-2">
                        用户id：<input type="text" name="" id="uid" class="form-control" style="width: 60%;" />
                    </div>
                    <div class="form-group col-md-2">
                        用户名: <input type="text" name="" id="uName" class="form-control" style="width: 60%;" />
                    </div>
                    <div class="form-group col-md-2">
                        用户手机: <input type="text" name="" id="tel" class="form-control" style="width: 60%;" />
                    </div>
                    <div class="form-group col-md-2">
                        用户邮箱: <input type="text" name="" id="eMail" class="form-control" style="width: 60%;" />
                    </div>
                    <div class="form-group">
                        <a class="btn btn-primary findUser">查询</a>
                    </div>
                </form>
              </div>
          </div>
          <!-- 模态框（Modal） -->
                <div class="modal fade" id="adUser" data-backdrop="false" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">添加用户</h4>
                            </div>
                            <div class="modal-body">
                                <form id="defaultForm" role="form" class="form-register" action="" method="post">
                                  <div class="form-group">
                                   <input type="text" id="zuid" name="uid" class="form-control" placeholder="请输入用户id">
                                  </div>
                                  <div class="form-group">
                                   <input type="text" id="zuName" name="uname" class="form-control" placeholder="请输入用户昵称">
                                  </div>
                                  <div class="form-group">
                                   <input type="text" id="ztel" name="tel" class="form-control" placeholder="请输入用户手机号">
                                  </div>
                                  <div class="form-group">
                                   <input type="text" id="zeMail" name="eMail" class="form-control" placeholder="请输入用户邮箱">
                                  </div>
                                  <div class="role form-group">
                                    请选择该用户的身份
                                   <select class="form-control" id="zrid" >
                                        <option value="1">合同管理员</option>
                                        <option value="2">部门经理</option>
                                        <option value="3">分管领导</option>
                                        <option value="4">单位领导</option>
                                        <option value="5">超级管理员</option>
                                    </select>
                                  </div>
                                  <p class="help-block">注册成功后，初始密码为000000</p>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal" style="width: 10%">关闭</button>
                                <button type="submit" id="validateBtn" class="btn btn-primary zhuce" style="width: 20%;background-color: #337ab7">快速注册</button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>
                
                <!-- 模态框（Modal） -->
                <div class="modal fade" id="aterUser" data-backdrop="false" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">修改用户权限</h4>
                            </div>
                            <div class="modal-body">
                                
                                  <div class="form-group alterUserUid">
                                  
                                  </div>
                                  <div class="form-group alterUserRole">
                                   
                                  </div>
                                  
                                  <div class="role form-group">
                                      	请选择该用户修改后的身份
                                   <select class="form-control" id="alterRole" name="role" >
                                        <option value="1">合同管理员</option>
                                        <option value="2">部门经理</option>
                                        <option value="3">分管领导</option>
                                        <option value="4">单位领导</option>
                                        <option value="5">超级管理员</option>
                                    </select>
                                  </div>
   
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal" style="width: 10%">关闭</button>
                                <button type="button" class="btn btn-primary userAlterSub" data-dismiss="modal" style="width: 20%;background-color: #337ab7">立即修改</button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>
                
          <div class="table-responsive">
              <table class="table table-striped">
              <c:if test="${empty userList}">
	              	<tr>暂未查询到相关用户信息</tr>
	          </c:if>
	          <c:if test="${not empty userList}">
	              <thead>
	                <tr>
	                  <th class="col-md-1" >序号</th>
	                  <th class="col-md-1" >用户id</th>
	                  <th class="col-md-1" >用户名</th>
	                  <th class="col-md-2" >电子邮箱</th>
	                  <th class="col-md-2" >手机号码</th>
	                  <th class="col-md-2" >状态</th>
	                  <th class="col-md-2" >最后一次登陆时间</th>
	                  <th class="col-md-2" >操作</th>
	                </tr>
	              </thead>
	          </c:if>
              <tbody>
              	<c:set var="i" value="0"></c:set>
              	<c:forEach items="${userList}" var="user">
              		<c:set var="i" value="${i+1}"></c:set>
              		<tr>
              		<c:forEach items="${user.roleList}" var="role">
              		  <td style="display:none;">${role.roleName} (${role.description})</td>
              		</c:forEach>
	                  <td style="text-align: center;">${i}</td>
	                  <td style="text-align: center;">${user.uid}</td>
	                  <td style="text-align: center;">${user.uName}</td>    
	                  <td>${user.eMail}</td>
	                  <td>${user.tel}</td>
	                  <td>
	                  	<c:if test="${user.status==0}">
	                  		正常
	                  	</c:if>
	                  	<c:if test="${user.status==-1}">
	                  		被冻结
	                  	</c:if>
	                  </td>
	                  <td>
		                  <c:if test="${empty user.loginDate}">
		                  	该用户暂未登陆过系统
		                  </c:if>
		                  <c:if test="${not empty user.loginDate}">
		                  	<fmt:formatDate value="${user.loginDate}" pattern="yyyy-MM-dd HH:mm:ss" />
		                  </c:if>
		                  
	                  </td>
	                  <td>
	                  	<c:if test="${user.status==0}">
	                  		<a href="#" class="deleteUser" data-toggle="tooltip" data-placement="top" title="冻结该用户"><span class="glyphicon glyphicon-trash" style="color: red;"></span></a>
	                    	<a href="#" class="alterUser" data-toggle="tooltip" data-placement="top" title="修改用户权限" style="margin-left: 15px;"><span class="glyphicon glyphicon-pencil"></span></a>
	                  	</c:if>
	                  	<c:if test="${user.status==-1}">
	                  		<a href="#" class="renewUser" data-toggle="tooltip" data-placement="top" title="恢复该用户"><span class="glyphicon glyphicon-ok"></span></a>
	                  	</c:if>
	                    
	                  </td>
	                </tr>
              	</c:forEach>
              </tbody>
           
             
          </div>
    </div>
    <script type="text/javascript">
    $('.alert').fadeOut(5000);
    $('.renewUser').click(function(){
    	if(!confirm("确认恢复该用户吗?")){
			return ;
		}
    	var a=$(this).parent().siblings();
    	$.ajax({
 			url:"../user/renewUser",
 			type:"post",
 			data:{
 				uid:$(a[2]).text()
 			},
 			dataType: "html",
 			success: function(data){
 				$('.main').html(data);
 			}
 		})
    })
	    $('.deleteUser').click(function(){
	    	if(!confirm("确认冻结该用户吗?")){
				return ;
			}
	        var a=$(this).parent().siblings();
	       // alert($(a[1]).text());
	        $.ajax({
     			url:"../user/deleteUser",
     			type:"post",
     			data:{
     				uid:$(a[2]).text()
     			},
     			dataType: "html",
     			success: function(data){
     				$('.main').html(data);
     			}
     		})
	    })
	    $('.alterUser').click(function(){
	        var a=$(this).parent().siblings();
	       // alert($(a[1]).text());
	        $('.alterUserUid').html("<p class='help-block' id='alterId'>当前用户id:"+$(a[2]).text()+"</p>");
	        $('.alterUserRole').html("<p class='help-block'>当前用户角色:"+$(a[0]).text()+"</p>"); 
	        $('#aterUser').modal('show');
	    })
	    $('.userAlterSub').click(function(){
	    	$.ajax({
     			url:"../user/alterUserRole",
     			type:"post",
     			data:{
     				uid:$('#alterId').text(),
     				rid:$('#alterRole').val()
     			},
     			dataType: "html",
     			success: function(data){
     				$('.main').html(data);
     			}
     		})
	    })
	   /*  $('.zhuce').click(function(){
	    	
	    }) */
	    
        $(function () { $("[data-toggle='tooltip']").tooltip(); });
       	var userFlag=1;
        $('.findUserCon').click(function(){
                if (userFlag==1) {
                    $('.findMenu').removeAttr("style");
                    $('.findUserCon').html("<span class='glyphicon glyphicon-eye-close'></span> 隐藏");
                    userFlag = -userFlag;
                }else{
                    $('.findMenu').attr("style","display:none");
                    $('.findUserCon').html("<span class='glyphicon glyphicon-filter'></span> 查询");
                    userFlag = -userFlag;
                }
            })
         $('.findUser').click(function(){
        	 $.ajax({
     			url:"../user/userFindDetil",
     			type:"post",
     			data:{
     				uid:$('#uid').val(),
     				uName:$('#uName').val(),
     				eMail:$('#eMail').val(),
     				tel:$('#tel').val()
     			},
     			dataType: "html",
     			success: function(data){
     				$('.main').html(data);
     			}
     		})
         })
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
             uid: {//验证input项：验证规则
                 message: 'The username is not valid',
                
                 validators: {
                     notEmpty: {//非空验证：提示消息
                         message: '用户id不能为空'
                     },
                     stringLength: {
                         min: 4,
                         max: 4,
                         message: '用户id只能为4位'
                     },
                     regexp: {
                         regexp: /^[a-zA-Z0-9]+$/,
                         message: '用户id由数字字母组成'
                     },
                     threshold :  4 , //有4字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                     remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}  
                         url: '../user/checkUser',//验证地址
                         message: '该用户存在',//提示消息
                         delay :  2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                         type: 'POST'//请求方式
                     }
                 }
             },
             uname: {
                 message:'用户名无效',
                 validators: {
                     notEmpty: {
                         message: '用户名不能为空'
                     }
                 }
             },
             tel: {
                 message: '用户手机号无效',
                 validators: {
                     notEmpty: {
                         message: '用户手机号不能为空'
                     },
                     stringLength: {
                         min: 11,
                         max: 11,
                         message: '用户手机号只能为11位'
                     },
                     regexp: {
                          regexp: /^1[3|5|7|8]{1}[0-9]{9}$/,
                          message: '请输入正确的手机号码'
                      }
                 }
             },
             eMail: {
                 message: '用户邮箱无效',
                 validators: {
                     notEmpty: {
                         message: '用户邮箱不能为空'
                     },
                     emailAddress:{
                         message: '邮箱地址格式有误'
                     }
                 }
             },
             role: {
                 message: '用户角色选择无效',
                 validators: {
                     notEmpty: {
                         message: '用户角色不能为空'
                     }
                 }
             }
         }
     })
     $('#validateBtn').click(function() {
    	 var bootstrapValidator = $("#defaultForm").data('bootstrapValidator');
         //$('#defaultForm').bootstrapValidator('validate');
         bootstrapValidator.validate();
         if(bootstrapValidator.isValid()){
        	 $.ajax({
       			url:"../user/insertUser",
       			type:"post",
       			data:{
       				uid:$('#zuid').val(),
       				rid:$('#zrid').val(),
       				tel:$('#ztel').val(),
       				eMail:$('#zeMail').val(),
       				uName:$('#zuName').val()
       			},
       			dataType: "html",
       			success: function(data){
       				$('.main').html(data);
       			}
       		})
         }else{
        	 return;
         }
        	 
         
     });
 });
    </script>
</body>
</html>