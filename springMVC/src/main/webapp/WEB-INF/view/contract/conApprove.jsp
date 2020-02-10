<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div id="alterText">
		<c:if test="${not empty approveError}">
			<div class="alert alert-danger" role="alert" style="position:fixed;bottom: 0px;right: 15px;width:13%;text-align:center;background-color:#c14842;color:white;">
		  	 	${approveError}
		  	 </div>
		</c:if>
		<c:if test="${not empty approveSuccess}" >
			<div class="alert alert-success" role="alert" style="position:fixed;bottom: 0px;right: 15px;width:13%;text-align:center;color:white;background-color:#8ac007">
		  	 	${approveSuccess}
		  	 </div>
		</c:if>
	</div>
<button class="btn" id="goHome">返回</button>
          <h1 class="page-header"></h1>

          <h2 class="sub-header">
          	<span class="glyphicon glyphicon-edit"></span> 合同审批
          </h2>

          <div class="table-responsive processInfo">
            <table class="table table-striped">
              <thead>
              	<c:if test="${empty contractList}">
		     		<tr>暂无待办事项</tr>
		 		</c:if>
		 		<c:if test="${not empty contractList}">
	                <tr>
	                  <th class="col-md-1" >合同号</th>
	                  <th class="col-md-1" >来自</th>
	                  <th class="col-md-6" >标题</th>
	                  <th class="col-md-2" >上一节点办理时间</th>
	                  <th class="col-md-1" >当前状态</th>
	                  <th class="col-md-1" >办理</th>
	                </tr>
                </c:if>
              </thead>
              <tbody>
              	<c:forEach items="${contractList}" var="contract">
	              	<tr>
	                  <td>${contract.cno}</td>
	                  <c:forEach items="${contract.conApprove}" var="approve" varStatus="status">
	                  <td>${approve.uid}</td>
	                  <td><span class="glyphicon glyphicon-book"></span> ${contract.cnm}</td>	
	                  <td><fmt:formatDate value="${approve.apvtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                  <td>待审批</td>
	                  <td><a href="#" class="conDetil"><span class="glyphicon glyphicon-record"></span></a></td>
	                  </c:forEach>
	                  <%-- <td>部门领导</td>
	                  <td><span class="glyphicon glyphicon-book"></span> ${contract.cnm}</td>	
	                  <td><fmt:formatDate value="${contract.sgtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                  <td>待审批</td>
	                  <td><a href="#" class="conDetil"><span class="glyphicon glyphicon-record"></span></a></td> --%>
	                </tr>
              	</c:forEach>
              </tbody>
            </table>
          </div>
          <Script>
          $('.alert').fadeOut(5000);
          </Script>