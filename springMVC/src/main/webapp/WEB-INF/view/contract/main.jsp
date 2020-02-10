<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
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
    <script type="text/javascript" src="<%=basePath%>js/echarts.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>jquery.min.js"></script> 
	<script type="text/javascript" src="<%=basePath%>pageoffice.js" id="po_js_main"></script>
</head>
<body>
<script>
	function loginOutCheck(){
		if(confirm("确认退出吗?")){
			return true;
		}
		return false;	
	}
</script>
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
						<a href="<%=basePath%>/my/logout" onclick="return loginOutCheck();">退出当前登陆</a>
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

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-2 col-md-1" id="sidebar-first">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="<%=basePath%>page/main">合同管理 <span class="sr-only">(current)</span></a></li>
            <shiro:hasRole name="合同管理员">
	            <li>
	            	<a href="#" class="conStart">
	            		<span class="glyphicon glyphicon-send"></span> 
	            		发起合同
	            	</a>
	            </li>
            </shiro:hasRole>
            <li>
            	<a href="#" class="conApprove">
            		<span class="glyphicon glyphicon-edit"></span> 
            		待办事项
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
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-11 col-md-offset-1 main">
        	<div class="col-md-3 col-md-offset-0" style="width: 20%;padding: 0px;">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">个人名片</h3>
              </div>
              <div class="panel-body">
                <table class="table">
                  <tr><td><span class="glyphicon glyphicon-user "></span> &nbsp; ${user.uName}${role}</td></tr>
                  <tr><td><span class="glyphicon glyphicon-envelope"></span> &nbsp; ${user.eMail}</td></tr>
                  <tr><td><span class=" glyphicon glyphicon-earphone"></span> &nbsp; ${user.tel}</td></tr>
                </table>
              </div>
            </div> 
            <!-- <div class="col-sm-5 col-sm-offset-1 col-md-5 col-md-offset-0" style="border:1px solid #a49191;text-align: center;">
              <p style="font-size: 40px;margin-bottom: 0px;">15</p>
              <p style="font-size: 16px;">合同数</p>
            </div>
            <div class="col-sm-5 col-sm-offset-1 col-md-5 col-md-offset-2" style="border:1px solid #a49191;text-align: center;">
              <p style="font-size: 40px;margin-bottom: 0px;">25</p>
              <p style="font-size: 16px;">待审批</p>
            </div> -->
            <div id="cntPass">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><a data-toggle="collapse" data-parent="#cntPass" href="#cntPassInfo" style="text-decoration:none;">Dashboard-合同审批完成率</a></h3>
                </div>
                <div id="cntPassInfo" class="panel-collapse collapse in">
                  <div class="panel-body">
                    <div class="col-sm-12 col-sm-offset-0 col-md-12 col-md-offset-0" style="height: 180px;" id="cntPassInfoDetil"></div>                   
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="col-sm-6 col-sm-offset-1 col-md-7 col-md-offset-0 content" style="margin-left: 20px;">
            <div id="accordionInfo">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordionInfo" href="#cntInfo" style="text-decoration:none;">Dashboard-合同信息分析</a></h3>
                </div>
                <div id="cntInfo" class="panel-collapse collapse in">
                  <div class="panel-body">
                    <div class="col-sm-12 col-sm-offset-0 col-md-5 col-md-offset-0" style="height: 300px;" id="cmpTp"></div>
                    <div class="col-sm-12 col-sm-offset-0 col-md-6 col-md-offset-1" style="height: 300px;" id="cntTp"></div>
                  </div>
                </div>
              </div>
            </div>

            <div id="accordionMey">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordionMey" href="#cntMony" style="text-decoration:none;">Dashboard-各类合同签订金额详情</a></h3>
                </div>
                <div id="cntMony" class="panel-collapse collapse in">
                  <div class="panel-body">
                    <div class="col-sm-12 col-sm-offset-0 col-md-12 col-md-offset-0" style="height: 300px;" id="cmpMy"></div>
                  </div>
                </div>
              </div>
            </div>
            
            <div id="accordionProfit">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordionProfit" href="#cntProfit" style="text-decoration:none;">Dashboard-销售、购买合同收支详情</a></h3>
                </div>
                <div id="cntProfit" class="panel-collapse collapse in">
                  <div class="panel-body">
                    <div class="col-sm-12 col-sm-offset-0 col-md-12 col-md-offset-0" style="height: 300px;" id="cmpPft"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="col-sm-12 col-sm-offset-0 col-md-2 col-md-offset-0 news" style="float: right;padding:0px;width: 19%">
            <div id="accordion">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" style="text-decoration:none;">消息助手</a></h3>
                </div>

                <div id="collapseOne" class="panel-collapse collapse in">
                  <div class="panel-body">
                    <div class="newCon">
                      <div id="new">
                        <div class="panel panel-success">
                          <div class="panel-heading">
                            <h3 class="panel-title">
                              <a data-toggle="collapse" data-parent="#new" href="#collapseTwo" style="text-decoration:none;"><span class="glyphicon glyphicon-book"></span> 最新合同</a>
                            </h3>
                          </div> 
                          <div id="collapseTwo" class="panel-collapse collapse in">
                            <div class="panel-body" style="font-size: 12px;">
                            <c:if test="${not empty newCrtList}">
                            	<c:forEach items="${newCrtList}" var="newCrt">
                            		<c:if test="${not empty newCrt.faddr}">
                            			<p><a href="javascript:POBrowser.openWindowModeless('../crtLook/look?cno='+${newCrt.cno},'width=1200px;height=1000px;')">${newCrt.cnm}</a></p>
                            		</c:if>
                            		<c:if test="${empty newCrt.faddr}">
                            			<p><a href="../crt/onlyRead?cno=${newCrt.cno}" target="_blank">${newCrt.cnm}</a></p>
                            		</c:if>
                            	</c:forEach>
                            </c:if>
                            <c:if test="${empty newCrtList}">
                            	暂无新合同的发布
                            </c:if>
                              
                             
                            </div>
                          </div>	
                        </div>
                      </div>
                      
                      <div id="apv">
                        <div class="panel panel-danger">
                          <div class="panel-heading">
                            <h3 class="panel-title">
                              <a data-toggle="collapse" data-parent="#apv" href="#collapseTid" style="text-decoration:none;"><span class="glyphicon glyphicon-edit"></span> 我的待办事项</a>
                            </h3>
                          </div>
                          <div id="collapseTid" class="panel-collapse collapse in">
                            <div class="panel-body" style="font-size: 12px;">
                            <c:if test="${empty contractApvList}">
                            	<p>暂无待办事项</p>
                            </c:if>
                            <c:if test="${not empty contractApvList}">
                            	<c:forEach items="${contractApvList}" var="contractApv">
                            		<p><a href="#" cno="${contractApv.cno}">${contractApv.cnm}</a></p>
                            	</c:forEach>
                            </c:if>
                              
                            </div>
                          </div>
                        </div>
                      </div>

                    </div>
                  </div>
                </div>


              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script src="<%=basePath%>bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>  
    <script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript">
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
		
		$(document).on('click','#collapseTid p a',function(e){
			var cno = $(this).attr("cno");
			 $.ajax({
				url:"../crt/conApproveDetil",
				type:"post",
				data:{
					cno:cno
				},
				dataType: "html",
				success: function(data){
					$('.main').html(data);
				}
			})
			 
		})
		
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
		$(document).on('click','#goHome',function(e){
    		window.location.href="<%=basePath%>page/main";
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
		}) 
		
		var myChart = echarts.init(document.getElementById('cmpTp'));
    var option = {
      title : {
          text: '签订合同公司区域分布',
          x:'center'
      },
      tooltip : {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
      },
      legend: {
        bottom:'bottom',
        data: [${addv}]
      },
      series : [
          {
              name: '数据统计',
              type: 'pie',
              radius : '50%',
              center: ['50%', '43%'],
              data:[
                  ${cmpAdcdDataString}
              ]
          }
      ]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

    var myChart1 = echarts.init(document.getElementById('cntTp'));
    var option1 = {
      title : {
          text: '系统合同类别占比',
          x:'center'
      },
      tooltip : {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
      },
      legend: {
        bottom:'bottom',
        data: [${type}]
      },
      series : [
          {
              name: '数据统计',
              type: 'pie',
              radius : '50%',
              center: ['50%', '43%'],
              data:[
                  ${CntTypeDataString}
              ],
              itemStyle: {
                  emphasis: {
                      shadowBlur: 10,
                      shadowOffsetX: 0,
                      shadowColor: 'rgba(0, 0, 0, 0.5)'
                  }
              }
          }
      ]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart1.setOption(option1);

    var myChart2 = echarts.init(document.getElementById('cmpMy'));
    option2 = {
      legend: {},
      tooltip: {},
      dataset: {
    	  dimensions: ['month','设备采购','服务采购','软件开发','技术服务','技术咨询','产品销售','系统集成'],
          source: [
              ${cntMyDataString}
          ]
      },
      xAxis: {type: 'category'},
      yAxis: {
        type:'value',
        axisLabel:{
            formatter:'{value}万元'
        }
      },
      // Declare several bar series, each will be mapped
      // to a column of dataset.source by default.
      series: [
          {type: 'bar'},
          {type: 'bar'},
          {type: 'bar'},
          {type: 'bar'},
          {type: 'bar'},
          {type: 'bar'},
          {type: 'bar'}
      ]
  };
  myChart2.setOption(option2);

   var myChart3 = echarts.init(document.getElementById('cntPassInfoDetil'));
   option3 = {
    title: {
        text: '合同审批完成率',
        left: 'center'
    },

    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },

   
    series : [
        {
            name:'数据分析',
            type:'pie',
            radius : '50%',
            center: ['50%', '50%'],
            data:[
            	${crtOkRateDataString}
            ].sort(function (a, b) { return a.value - b.value; }),
            roseType: 'angle'
        }
    ]
};
  myChart3.setOption(option3);
  
  var myChart4 = echarts.init(document.getElementById('cmpPft'));
  option4 = {
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        data:['利润', '支出', '收入']
    },
    grid: {
        left: '2%',
        right: '1%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'value',
            axisLabel:{
              formatter:'{value}万元'
          }
        }
    ],
    yAxis : [
        {
            type : 'category',
            axisTick : {show: false},
            data : ${cntPftMonth}
        }
    ],
    series : [
        {
            name:'利润',
            type:'bar',
            label: {
                normal: {
                    show: true,
                    position: 'inside'
                }
            },
            data:${cntPft}
        },
        {
            name:'收入',
            type:'bar',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position:'right'
                }
            },
            data:${cntPftIn}
        },
        {
            name:'支出',
            type:'bar',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position: 'left'
                }
            },
            data:${cntPftOut}
        }
    ]
};
myChart4.setOption(option4);
    </script>
</body>
</html>