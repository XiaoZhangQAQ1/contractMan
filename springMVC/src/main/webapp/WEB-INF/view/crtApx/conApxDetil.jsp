<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript" src="<%=basePath%>jquery.min.js"></script> 
<script type="text/javascript" src="<%=basePath%>pageoffice.js" id="po_js_main"></script>
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
    <h1 class="page-header"></h1>
    <h2 class="sub-header">
    <span class="glyphicon glyphicon-file"></span> 合同附件详情
    </h2>
    <div class="contract">
      <h4 style="color: red;">合同基本信息(当前的显示信息仅为该合同的部分关键信息)</h4>
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
    </div>
    <h2 class="sub-header"></h2>
    
    <h4><span class=" glyphicon glyphicon-paperclip"></span> 附件详情</h4> 
    <div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-0" style="border: 1px solid #eee;">
        <div class="form-group">
        	
                <h4><span class=" glyphicon glyphicon-upload"></span>上传附件</h4>
                <h4 class="sub-header"></h4>
                <input type="file" name="file" id="inputfile">
                <p class="help-block">请选择您要上传的附件,支持附件格式为doc,docx</p>
                <button class="btn btn-primary" id="uploadApx" style="width: 100%;background-color: #418bca;">确认上传</button>
            
        </div>
    </div>
    <div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-1" style="border: 1px solid #eee;">
        <div class="form-group">
                <h4><span class=" glyphicon glyphicon-search"></span> 在线预览附件</h4>
                <h4 class="sub-header"></h4>
                 <p class="help-block">在线预览,可检查您上传的附件是否有误</p>
                 <p class="help-block">点击附件名即可在线预览</p>
                 <c:if test="${not empty contract.conAppendix}">
                 <c:forEach items="${contract.conAppendix}" var="conAppendix">
                 	<a href="javascript:POBrowser.openWindowModeless('../crtLook/lookApx?cno='+${contract.cno}+'&id='+${conAppendix.id},'width=1200px;height=1000px;')">${conAppendix.apxName}</a><br>
                 </c:forEach>
                 </c:if>
                <c:if test="${empty contract.conAppendix}">
                 	该合同暂未上传任何附件
                </c:if>
        </div>
    </div>
    <div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-1" style="border: 1px solid #eee;">
        <div class="form-group">
            <form>
                <h4><span class=" glyphicon glyphicon-ok"></span> 当前合同已上传的附件</h4>
                <h4 class="sub-header"></h4>
                 <p class="help-block">点击附件名,可进行下载/删除操作</p>
                 <p class="help-block" style="color: red;">附件一经删除不可恢复，请慎重操作</p>
                 <c:if test="${not empty contract.conAppendix}">
                 <div id="accordion">
	                 <c:set var="i" value="0"></c:set>
	                 <c:forEach items="${contract.conAppendix}" var="conAppendix">
	                 <c:set var="i" value="${i+1}"></c:set>
	                 <div class="panel panel-default" style="border:none;margin-bottom:0px;">
		                 <p class="panel-title" style="font-size:15px;">
			                 <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne${i}">
								${conAppendix.apxName}
							 </a>
						 </p>
						 <div id="collapseOne${i}" class="panel-collapse collapse">
							<div class="panel-body" style="padding:0;">
								<a href="../crtInfo/downloadApx?id=${conAppendix.id}" style="margin-left: 0px;margin-top:0px;">点我下载</a>
								<a href="../crtApx/delApx?id=${conAppendix.id}&cno=${conAppendix.cno}" style="margin-left: 30px;">点我删除</a>
							</div>
						</div>
					</div>
	                 	<%-- <p>${conAppendix.apxName}<a href="../crtInfo/downloadApx?id=${conAppendix.id}" style="margin-left: 15px;">下载</a><a href="../crtApx/delApx?id=${conAppendix.id}&cno=${conAppendix.cno}" style="margin-left: 15px;">删除</a></p> --%>
	                 </c:forEach>
                 </div>
                 </c:if>
                 <c:if test="${empty contract.conAppendix}">
                 	该合同暂未上传任何附件
                 </c:if>
            </form>
        </div>
    </div>
    <script>
    $('.alert').fadeOut(5000);
    	$('#uploadApx').click(function(){
    		alert('ss');
    		var cno = ${contract.cno};
    		var form = new FormData();
    		form.append("cno",cno);
    		form.append("file",$('#inputfile')[0].files[0]);
    		 $.ajax({
    			url:"../crtApx/addApx",
    			type:"post",
    			data:form,
    			processData: false,
                contentType: false,
                
                cache:false,
                dataType: "html",
                success: function(data){
/*                 	alert("成功");
                	alert(data); */
					$('.main').html(data); 
				},
				error:function() {//出现异常执行方法
					alert("出现错误");
				}
    		}) 
    	})
    </script>