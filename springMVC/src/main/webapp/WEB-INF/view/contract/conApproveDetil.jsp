<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript" src="<%=basePath%>jquery.min.js"></script> 
<script type="text/javascript" src="<%=basePath%>pageoffice.js" id="po_js_main"></script>
<button class="btn" id="goHome">返回</button>
    <h1 class="page-header"></h1>
    <h2 class="sub-header">
    <span class="glyphicon glyphicon-edit"></span> 合同审批
    <div class="btn-group" style="width: 15%;">
      <button type="button" class="btn btn-default" id="submit" style="background-color: #5cb85c;width: 50%;">办理</button>
      <c:if test="${rid!=1}">
      <button type="button" class="btn btn-default" id="back" style="background-color: #d9534f;width: 50%;">打回</button>
      </c:if>
    </div>
    </h2>
    <div class="contract">
      <h4 style="color: red;">合同基本信息(当前的显示信息仅为该合同的部分关键信息，具体合同内容请在线预览)</h4>
      <h5 class="help-block">合同编号:${contract.cno}</h5>
      <h5 class="help-block">合同名称:${contract.cnm}</h5>
      <h5 class="help-block">合同金额:${contract.amt}</h5>
      <h5 class="help-block">合同类型:${contract.conType.tpNm}</h5>
      <c:if test="${contract.tpcd!='b1' and contract.tpcd!='b2'}">
      	<h5 class="help-block">甲方公司:${contract.fpnm}</h5>
      </c:if>
      <c:if test="${contract.tpcd=='b1' or contract.tpcd=='b2'}">
      	<h5 class="help-block">乙方公司:${contract.fpnm}</h5>
      </c:if>
      <h5 class="help-block">签订时间:<fmt:formatDate value="${contract.sgtm}" pattern="yyyy-MM-dd HH:mm:ss" /></h5>
      <h2 class="sub-header"></h2>
      <c:if test="${not empty contract.faddr}">
      	<c:if test="${rid==1}">
	      	<h5 class="help-block">该合同被打回，可在线编辑</h5>
	      	<a href="javascript:POBrowser.openWindowModeless('../crtLook/editAndLook?cno='+${contract.cno},'width=1200px;height=1000px;')" class="btn btn-default" style="background-color: #5cb85c;width:8%">点击编辑</a>
      	</c:if>
      	<c:if test="${rid!=1}">
	      	<h5 class="help-block">该合同为直接上传，该浏览方式为word浏览</h5>
	      	<a href="javascript:POBrowser.openWindowModeless('../crtLook/look?cno='+${contract.cno},'width=1200px;height=1000px;')" class="btn btn-default" style="background-color: #5cb85c;width:8%">在线预览</a>
      	</c:if>
      </c:if>
      <c:if test="${empty contract.faddr}">
	      <c:if test="${rid!=1}">
	      	<h5 class="help-block">该合同为模板填写，该浏览方式为在线模板浏览</h5>
	      	<button class="btn btn-default onlyRead" style="background-color: #5cb85c;width:8%">在线预览</button>
	      </c:if>
	      <c:if test="${rid==1}">
	      	<h5 class="help-block">该合同被打回，可在线编辑</h5>
	      	<button class="btn btn-default editOnline" style="background-color: #5cb85c;width:8%">点击编辑</button>
	      </c:if>
      </c:if>

      
    </div>
    <h2 class="sub-header"></h2>
    <h4><span class=" glyphicon glyphicon-paperclip"></span> 附件详情</h4> 
    <div class="table-responsive" >
      <table class="table table-striped table-bordered">
      	<c:if test="${empty contract.conAppendix}">
          	该合同暂未上传任何附件
        </c:if>
        <c:if test="${not empty contract.conAppendix}">
        	<thead>
	          <tr>
        		<th class="col-md-1" >序号</th>
        		<th class="col-md-4" >附件名</th>
        		<th class="col-md-3" >上传时间</th>
        		<th class="col-md-2" >预览</th>
        		<th class="col-md-2" >下载</th>
        	  </tr>
        	</thead>
        </c:if>
        <tbody>
          <c:set value="0" var="h"></c:set>
          <c:forEach items="${contract.conAppendix}" var="conAppendix">
          	  <c:set value="${h+1}" var="h"></c:set>
	          <tr>
	            <td>${h}</td>
	            <td>${conAppendix.apxName}</td>
	            <td style="text-align:center;"><fmt:formatDate value="${conAppendix.date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	            <td><a href="javascript:POBrowser.openWindowModeless('../crtLook/lookApx?cno='+${contract.cno}+'&id='+${conAppendix.id},'width=1200px;height=1000px;')" style="">在线预览</a></td>
	            <td><a href="../crtInfo/downloadApx?id=${conAppendix.id}">点击下载</a></td>
	          </tr>
           </c:forEach>
        </tbody>
        
      </table>
      </div>
    <h2 class="sub-header"></h2>
    <h4><span class="glyphicon glyphicon-pencil"></span> 审批菜单</h4>
    <div class="form-inline">
    <c:if test="${not empty high}">
    	${high}
    </c:if>
    <c:if test="${not empty userRoleList}">
     	您只能送给您的上一级领导进行审批
      	<select name="" class="form-control" id="touid">
    	<c:forEach items="${userRoleList}" var="user">
    		<option value="${user.uid}+${user.uName}">${user.uName}</option>
    	</c:forEach>
    	</select>
    </c:if>
     	
        
    </div>
    <textarea class="form-control" id="content" rows="5" placeholder="意见留言" style="margin-top: 7px;"></textarea>
    

    <h2 class="sub-header"></h2>
    <h4><span class=" glyphicon glyphicon-search"></span> 审批记录</h4> 
    <div class="table-responsive" >
      <table class="table table-striped">
	     <c:if test="${empty conApproveList}">
		     <tr>暂未查询到相关合同审批信息</tr>
		 </c:if>
		 <c:if test="${not empty conApproveList}">
	        <thead>
	          <tr>
	            <th class="col-md-1" >序号</th>
	            <th class="col-md-2" >来自</th>
	            <th class="col-md-1" >电子签名</th>
	            <th class="col-md-2" >签名时间</th>
	            <th class="col-md-2" >操作</th>
	            <th class="col-md-4" >留言</th>
	          </tr>
	        </thead>
        </c:if>
        <tbody id="approve">
        	<c:set value="0" var="i"></c:set>
        	<c:forEach items="${conApproveList}" var="approve" varStatus="status">
        		<c:set value="${i+1}" var="i"></c:set>
	          <tr>
	          	<td style="display:none;">${approve.cno}</td>
	            <td>${i}</td>
	            <td style="text-align:center">${approve.uid}</td>
	            <c:set var="str" value="${approve.uid}" /> 
	            <c:set var="startCode" value="${fn:indexOf(str, ' ')}" />
	            <c:set var="endCode" value="${fn:length(str)}" />  
	            <td style="text-align: center;">${fn:substring(str,startCode,endCode)}</td>  
	            <td><fmt:formatDate value="${approve.apvtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	            <td>${approve.operation}</td>
	            <td>${approve.content}</td>
	          </tr>
           </c:forEach> 
        </tbody>
      </table>
    </div>
    <script>
    $('.editOnline').click(function(){
    	
    	window.open("<%=basePath%>crt/backEditOnline?cno=${contract.cno}");
    })
    $('.onlyRead').click(function(){
		window.open("<%=basePath%>crt/onlyRead?cno=${contract.cno}");
	})
	   /*  $('.lookOnline').click(function(){
	    	window.open("");
	    }) */
   		$('#submit').click(function(){
    		if($("#content").val()==""){
    			alert("意见留言一定要写哦");
    			return;
    		}
    		 var a=$("#touid").val();
    		 if(a==undefined){
    			 name="审批结束";
    			 touid="";
    		 }else{
    			 var b=a.split("+");
    			 touid = b[0];
    			 name="送给"+b[1]+"审批";
    		 }
    		
    		   $.ajax({
    			url:"../approve/submit",
    			type:"post",
    			data:{
    				cno:$("#approve tr td:first").text(),
    				touid:touid,
    				content:$("#content").val(),
    				operation:name
    			},
    			dataType: "html",
    			success: function(data){
    				$('.main').html(data);
    			},
    			error: function(){
    				alert("出现错误");
    			}
    		})   
    	})
    	
    	$('#back').click(function(){
    		if($("#content").val()==""){
    			alert("意见留言一定要写哦");
    			return;
    		}
    		 var a=$("#touid").val();
    		   $.ajax({
    			url:"../approve/back",
    			type:"post",
    			data:{
    				cno:$("#approve tr td:first").text(),
    				content:$("#content").val(),
    				operation:"打回给合同管理员"
    			},
    			dataType: "html",
    			success: function(data){
    				$('.main').html(data);
    			},
    			error: function(){
    				alert("出现错误");
    			}
    		})   
    	})
    </script>