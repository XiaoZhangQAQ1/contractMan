<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:if test="${not empty error}">
			<div class="alert alert-danger" role="alert" style="position:fixed;bottom: 0px;right: 15px;width:13%;text-align:center;background-color:#c14842;color:white;">
		  	 	${error}
		  	 </div>
</c:if>
<c:if test="${not empty success}">
			<div class="alert alert-danger" role="alert" style="position:fixed;bottom: 0px;right: 15px;text-align:center;background-color:#8ac007;color:white;">
		  	 	${success}
		  	 </div>
</c:if>
<button class="btn" id="goHome">返回</button>
          <h1 class="page-header"></h1>
          <h2 class="sub-header"><span class="glyphicon glyphicon-send"></span> 发起合同</h2>
          <div class="crtNecInfo">
            <h4 style="margin-top: 15px;">在发起合同前，请填写以下必须信息</h4>
            <form id="defaultForm" role="form" class="form-register" action="../crt/insertCrt" method="post">
              <div class="register-content col-md-4 col-md-offset-4" style="border: 1px solid #eee">
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
          <script type="text/javascript">
          $('.alert').fadeOut(5000);
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