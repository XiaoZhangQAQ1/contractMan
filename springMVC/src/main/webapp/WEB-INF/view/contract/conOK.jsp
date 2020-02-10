<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

          <button class="btn" id="goHome">返回</button>
          <h1 class="page-header"></h1>

          <h2 class="sub-header"><span class="glyphicon glyphicon-check"></span> 已办事项</h2>
          <div class="table-responsive">
            <table class="table table-striped">
              <c:if test="${empty contractList}">
	             <tr>还没有合同办理完结哦~快去催催领导们审批吧</tr>
	          </c:if>
	          <c:if test="${not empty contractList}">
	              <thead>
	                <tr>
	                  <th class="col-md-1" >合同号</th>
	                  <th class="col-md-2" >来自</th>
	                  <th class="col-md-4" >标题</th>
	                  <th class="col-md-2" >最后一次办理时间</th>
	                  <th class="col-md-2" >状态</th>
	                  <th class="col-md-1" >详情</th>
	                </tr>
	              </thead>
              </c:if>
              <tbody>
              <c:forEach items="${contractList}" var="contract">
              	<tr>
                  <td>${contract.cno}</td>
                  <c:forEach items="${contract.conApprove}" var="approve" varStatus="status">
                  <td>${approve.uid}</td>
                  <td><span class="glyphicon glyphicon-book"></span> ${contract.cnm}</td>	
                  <td><fmt:formatDate value="${approve.apvtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                  <td style="display:none;">4</td>
                  <td>完成</td>
                  <td><a href="#" class="conInfo"><span class="glyphicon glyphicon-record"></span></a></td>
                  </c:forEach>
                </tr>
              </c:forEach>
                <tr style="background-color:#fff;position:fixed;top:400px;border:none;">
                	<td colspan="6" style="text-align:left;">
                		<ul class="pagination" style="margin:0px;">
                		<c:if test="${page.currPage == 1}">
                			<li class="disabled"><a href="#">首页</a></li>
                			<li class="disabled"><a href="#">上一页</a></li>
                		</c:if>
                		<c:if test="${page.currPage != 1}">
                			<li><a href="#" onclick="first();">首页</a></li>
                			<li><a href="#" onclick="previous();">上一页</a></li>
                		</c:if>
	                		<c:forEach var="p" begin="1" end="${page.totalPage}">
	                			<c:if test="${page.currPage == p}">
	                				<li class="disabled"><a href="#">${p}</a></li>
	                			</c:if>
		                		<c:if test="${page.currPage != p}">
		                			<li><a href="#" onclick="clickPage(this);">${p}</a></li>
		                		</c:if>
	                		</c:forEach>
	                	<c:if test="${page.currPage == page.totalPage}">
	                		<li class="disabled"><a href="#">下一页</a></li>
	                		<li class="disabled"><a href="#">尾页</a></li>
	                	</c:if>
	                	<c:if test="${page.currPage != page.totalPage}">
	                		<li><a href="#" onclick="older();">下一页</a></li>
	                		<li><a href="#" onclick="end();">尾页</a></li>
	                	</c:if>
	                	<li><a style="color:#000;border:none;margin-left:2px;">共查询到${page.totalCount}条数据,当前是第${page.currPage}页,共${page.totalPage}页</a></li>
                		</ul>
                	</td>
                </tr>
              </tbody>
            </table>
          </div>
          <script>
          function older(){
      		$.ajax({
      			url:"../crt/conOk",
      			type:"get",
      			data:{
      				currentPage:${page.currPage+1}
      			},
      			dataType: "html",
      			success: function(data){
      				$('.main').html(data);
      			}
      		})
      	}
      	
      	function previous(){
      		$.ajax({
      			url:"../crt/conOk",
      			type:"get",
      			data:{
      				currentPage:${page.currPage-1}
      			},
      			dataType: "html",
      			success: function(data){
      				$('.main').html(data);
      			}
      		})
      	}
      	
      	function first(){
      		$.ajax({
      			url:"../crt/conOk",
      			type:"get",
      			data:{
      				currentPage:1
      			},
      			dataType: "html",
      			success: function(data){
      				$('.main').html(data);
      			}
      		})
      	}
      	
      	function end(){
      		$.ajax({
      			url:"../crt/conOk",
      			type:"get",
      			data:{
      				currentPage:${page.totalPage}
      			},
      			dataType: "html",
      			success: function(data){
      				$('.main').html(data);
      			}
      		})
      	}
      	
      	function clickPage(obj){
      		//alert($(obj).text());
      		 $.ajax({
      			url:"../crt/conOk",
      			type:"get",
      			data:{
      				currentPage:$(obj).text()
      			},
      			dataType: "html",
      			success: function(data){
      				$('.main').html(data);
      			}
      		}) 
      	}
          </script>