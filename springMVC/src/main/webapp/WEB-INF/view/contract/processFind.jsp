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

          <h2 class="sub-header">
          	<span class="glyphicon glyphicon-stats"></span> 进度查询
			<button class="btn findCon" style="float: right;background-color: #f4f4f4;font-weight: bold;width:7%">
				<span class="glyphicon glyphicon-filter"></span> 查询
			</button>
          </h2>
          <div class="sub-header findMenu" style="display: none;">
	          <div class="row-right">
				<form class="form-inline">
	          		<div class="form-group col-md-2">
						合同号：<input type="text" name="cno" id="cno" class="form-control" style="width: 60%;" value="${Findcno}" />
	          		</div>
					<div class="form-group col-md-2">
	          			合同名称: <input type="text" name="cnm" id="cnm" class="form-control cnm" style="width: 60%;" value="${Findcnm}"/>
	          		</div>
    				合同类型: 
		          	<select name="" class="form-control" id="ctype">
		          		<option value="${Findctype}" style="display:none">${findCtnm}</option>
		          		<option></option>
						<option value="s1">软件开发</option>
						<option value="s2">技术服务</option>
						<option value="s3">技术咨询</option>
						<option value="s4">产品销售</option>
						<option value="s5">系统集成</option>
						<option value="b1">设备采购</option>
						<option value="b1">服务采购</option>
		          	</select>
	          		<div class="form-group col-md-4">
	          			发起时间段: 
	          			<input type="date" id="startDate" name="startDate" class="form-control timer" value="${FindsDate}"/> 
	          			一 
	          			<input type="date" id="endDate" name="endDate" class="form-control timer" value="${FindeDate}"/>
	          		</div>
	          		<div class="form-group">
	          			<a class="btn btn-primary find">查询</a>
	          		</div>
	         	</form>
	          </div>
          </div>

          <div class="table-responsive processInfo">
            <table class="table table-striped">
            	<c:if test="${empty contractList}">
	              	<tr>暂未查询到相关合同信息</tr>
	            </c:if>
	            <c:if test="${not empty contractList}">
	            	<thead>
		                <tr>
		                  <th class="col-md-1" >合同号</th>
		                  <th class="col-md-2" >最后一次审批人</th>
		                  <th class="col-md-3" >标题</th>
		                  <th class="col-md-2" >最后一次办理时间</th>
		                  <th class="col-md-2" >审批进度</th>
		                  <th class="col-md-1" >状态</th>
		                  <th class="col-md-1" >查看详情</th>
	                </tr>
	              	</thead>
	            </c:if>
              <tbody>
              	<c:forEach items="${contractList}" var="contract">
              	  <tr>
              	  	  <td>${contract.cno}</td>
	                  <c:forEach items="${contract.conApprove}" var="approve" varStatus="status">
	                  	<td>${approve.uid}</td>
	                  	<td name="cnm"><span class="glyphicon glyphicon-book"></span> ${contract.cnm}</td>
	                  	<td><fmt:formatDate value="${approve.apvtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                  	<td style="display:none;">${approve.result}</td>
	                  	<td>
	                  		<c:if test="${approve.result==-1}">
	                  			<div class="progress progress-striped active" style="margin:0px;">
									<div class="progress-bar progress-bar-warning" role="progressbar"
										 style="width: 0%;">
										<span>0%</span>
									</div>
								</div> 
	                  		</c:if>
	                  		<c:if test="${approve.result!=-1}">
	                  			<div class="progress progress-striped active" style="margin:0px;">
									<div class="progress-bar progress-bar-warning" role="progressbar"
										 style="width: ${approve.result/4*100}%;">
										<span>${approve.result/4*100}%</span>
									</div>
								</div> 
	                  		</c:if>
							
							
	                  	</td>
	                  	<c:if test="${approve.result==4}">
	                  		<td>完成</td>
	                  	</c:if>
	                  	<c:if test="${approve.result!=4}">
	                  		<td>未完成</td>
	                  	</c:if>
	                  </c:forEach>	
	                  <td><a href="#" class="conInfo"><span class="glyphicon glyphicon-record"></span></a></td>
                  </tr>
              	</c:forEach>
              	<c:if test="${not empty contractList}">
                 <tr style="background-color:#fff;position:fixed;top:450px;border:none;">
                	<td colspan="6" style="text-align:left;border:none;">
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
                </c:if>
              </tbody>
            </table>
          </div>
	<script type="text/javascript">
	var Processflag = 1;
	$('.findCon').click(function(){
		if (Processflag==1) {
			$('.findMenu').removeAttr("style");
			$('.findCon').html("<span class='glyphicon glyphicon-eye-close'></span> 隐藏");
			Processflag = -Processflag;
		}else{
			$('.findMenu').attr("style","display:none");
			$('.findCon').html("<span class='glyphicon glyphicon-filter'></span> 查询");
			Processflag = -Processflag;
		}
	})
	$('.find').click(function(){
		if($('#startDate').val()>$('#endDate').val()){
			alert('起始时间不能大于结束时间哦');
			return;
		}
		$.ajax({
			url:"../crt/processFindDetil",
			type:"post",
			data:{
				cno:$('#cno').val(),
				cnm:$('#cnm').val(),
				startDate:$('#startDate').val(),
				endDate:$('#endDate').val(),
				ctype:$('#ctype').val()
			},
			dataType: "html",
			success: function(data){
				$('.main').html(data);
			}
		})
	})
	
	function older(){
		$.ajax({
			url:"../crt/processFindDetil",
			type:"get",
			data:{
				cno:$('#cno').val(),
				cnm:$('#cnm').val(),
				startDate:$('#startDate').val(),
				endDate:$('#endDate').val(),
				ctype:$('#ctype').val(),
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
			url:"../crt/processFindDetil",
			type:"get",
			data:{
				cno:$('#cno').val(),
				cnm:$('#cnm').val(),
				startDate:$('#startDate').val(),
				endDate:$('#endDate').val(),
				ctype:$('#ctype').val(),
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
			url:"../crt/processFindDetil",
			type:"get",
			data:{
				cno:$('#cno').val(),
				cnm:$('#cnm').val(),
				startDate:$('#startDate').val(),
				endDate:$('#endDate').val(),
				ctype:$('#ctype').val(),
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
			url:"../crt/processFindDetil",
			type:"get",
			data:{
				cno:$('#cno').val(),
				cnm:$('#cnm').val(),
				startDate:$('#startDate').val(),
				endDate:$('#endDate').val(),
				ctype:$('#ctype').val(),
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
			url:"../crt/processFindDetil",
			type:"get",
			data:{
				cno:$('#cno').val(),
				cnm:$('#cnm').val(),
				startDate:$('#startDate').val(),
				endDate:$('#endDate').val(),
				ctype:$('#ctype').val(),
				currentPage:$(obj).text()
			},
			dataType: "html",
			success: function(data){
				$('.main').html(data);
			}
		}) 
	}
	</script>