<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
<h2 class="sub-header"><span class="glyphicon glyphicon-file"></span> 附件管理
            <button class="btn findApxCon" style="float: right;background-color: #f4f4f4;font-weight: bold;width:7%">
                <span class="glyphicon glyphicon-filter"></span> 查询
            </button>
            
          </h2>
          <p style="color:red;">只能在三级领导(部门经理)审批通过前进行上传/删除附件</p>
          <div class="sub-header findMenu" style="display: none;">
              <div class="row-right">
                <form class="form-inline">
                    <div class="form-group col-md-3">
                        合同号：<input type="text" name="cno" id="cno" class="form-control" style="width: 60%;" />
                    </div>
                    
                    <div class="form-group">
                        <a class="btn btn-primary find">查询</a>
                    </div>
                </form>
              </div>
          </div>
          <div class="table-responsive">
              <table class="table table-striped">
              <c:if test="${empty contractList}">
	             <tr>该系统中没有该合同哦~</tr>
	          </c:if>
	          <c:if test="${not empty contractList}">
	              <thead>
	                <tr>
	                  <th class="col-md-1" >序号</th>
	                  <th class="col-md-1" >合同号</th>
	                  <th class="col-md-3" >合同名</th>                 
	                  <th class="col-md-2" >发起时间</th>
	                  <th class="col-md-4" >附件信息</th>
	                  <th class="col-md-1" >详情</th>
	                </tr>
	              </thead>
              </c:if>
              <tbody>
              <c:set var="i" value="0"/>
              <c:forEach items="${contractList}" var="contract">
              <c:set var="i" value="${i+1}"/>
                <tr>
                  <td>${i}</td>
                  <td>${contract.cno}</td>
                  <td name="cnm" style="text-align: center;">${contract.cnm}</td>    
                  <td><fmt:formatDate value="${contract.sgtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                  <c:if test="${empty contract.conAppendix}">
                  <td>该合同暂无附件，若要添加附件，请点击查看详情按钮</td>
                  </c:if>
                  <c:if test="${not empty contract.conAppendix}">
                  <td>该合同存在附件，若要重新上传/删除，请点击查看详情按钮</td>
                  </c:if>
                  <td>
                  <c:forEach items="${contract.conApprove}" var="approve" varStatus="status">
                  	<c:if test="${approve.result==1 || approve.result==-1}">
                    	<a href="#" class="Apx" data-toggle="tooltip" data-placement="top" title="上传/删除附件"><span class="glyphicon glyphicon-record"></span></a>
                    </c:if>
                    <c:if test="${approve.result==2 || approve.result==3 || approve.result==4}">
                    	<a href="#" class="Apx1" data-toggle="tooltip" data-placement="top" title="上传/删除附件"><span class="glyphicon glyphicon-record"></span></a>
                    </c:if>
                  </c:forEach>
                  
                  </td>
                </tr>
                </c:forEach>
                <c:if test="${not empty contractList}">
                <tr style="background-color:#fff;position:fixed;top:470px;border:none;">
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
           
             
        </div>
        
      <script type="text/javascript">
      $('.alert').fadeOut(5000);
        $('.Apx').click(function(){
            var a=$(this).parent().siblings();
            var value = $(a[1]).text();
           // alert($(a[1]).text());
            $.ajax({
				url:"../crtApx/apxDetil",
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
        $('.Apx1').click(function(){
            alert('当前合同已被三级领导审批通过，所以不能进行上传/删除附件哦~');
        })
       var apxFlag=1;
        $('.findApxCon').click(function(){
                if (apxFlag==1) {
                    $('.findMenu').removeAttr("style");
                    $('.findApxCon').html("<span class='glyphicon glyphicon-eye-close'></span> 隐藏");
                    apxFlag = -apxFlag;
                }else{
                    $('.findMenu').attr("style","display:none");
                    $('.findApxCon').html("<span class='glyphicon glyphicon-filter'></span> 查询");
                    apxFlag = -apxFlag;
                }
        })
        
        $('.find').click(function(){
		$.ajax({
			url:"../crtApx/apxFindDetil",
			type:"post",
			data:{
				cno:$('#cno').val()
			},
			dataType: "html",
			success: function(data){
				$('.main').html(data);
			}
		})
	})
	
	function older(){
		$.ajax({
			url:"../crtApx/apxMan",
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
			url:"../crtApx/apxMan",
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
			url:"../crtApx/apxMan",
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
			url:"../crtApx/apxMan",
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
			url:"../crtApx/apxMan",
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