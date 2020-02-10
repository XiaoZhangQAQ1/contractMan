<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>技术开发合同模板</title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="<%=basePath%>css/conTemplate2.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
</head>
<body>
	<div id="content">
		<div id="first-page">
			<p>合同编号：${contract.cno}</p>
			<p id="cno" style="display:none;">${contract.cno}</p>
			<h1>技术开发（委托）合同</h1>
			<span>项目名称：<input type="text" id="cnm" name="cnm" style="width: 400px;" value="${contract.cnm}" readonly="true"></span>
			<span>委托方（甲方）：<input type="text" id="fpnm" name="fpnm" value="${contract.fpnm}" style="width: 350px;" readonly="true"></span>
			<span>受托方（乙方）：<input type="text" name="" value="江西昌大创新科技发展有限公司" readonly="true" style="width: 350px;"></span>
			<span>签订时间：<input type="text" name="" value="<fmt:formatDate value="${contract.sgtm}" pattern="yyyy-MM-dd" />" readonly="true"></span>
			<span>签订地点：<input type="text" name="" value="${contract.adcd}" readonly="true"></span>
			<span>有效期限：<input type="text" name="" value="一年" readonly="true"></span>
			<span>中华人民共和国科学技术部印制</span>
		</div>

		<div id="second-page">
			<h3>填 写 说 明</h3>
			<p> 一、本合同为中华人民共和国科学技术部印制的技术开发（委托）合同示范文本，各技术合同认定登记机构可推介技术合同当事人参照使用。</p>
			<p> 
			二、本合同书适用于一方当事人委托另一方当事人进行新技术、新产品、新工艺或者新材料及其系统的研究开发所订立的技术开发合同。</p>
			<p> 三、签约一方为多个当事人的，可按各自在合同关系中的作用等，在“委托方”、“受托方”项下（增页）分别排列为共同委托人或共同受托人。</p>
			<p> 四、本合同书未尽事项，可由当事人附页另行约定，并可作为本合同的组成部分。</p>
			<p>  五、当事人使用本合同书时约定无需填写的条款，应在该条款处注明“无”等字样。</p>
		</div>

		<div id="third-page">
			<h2>技术开发（委托）合同</h2>
			<span>委托方（甲方）：<input type="text" id="fpnm1" name="fpnm1" readonly="true" value="${contract.fpnm}"></span>
			<span>住  所  地：<input type="text" name="" readonly="true" value="XX省XX市XXXXX公司"></span>
			<span>法定代表人：<input type="text" name="" readonly="true" value="XXXXX"></span>
			<span>项目联系人：<input type="text" name="" readonly="true" value="XXXXX"></span>
			<span>联系方式：<input type="text" name="" readonly="true" value="XXXXXXXXXXX"></span>
			<span>通讯地址：<input type="text" name="" readonly="true" value="XX省XX市XX街区XXXXXXX"></span>
			<span>电话：<input type="text" name="" readonly="true" value="XXXXXXXX">传真:<input type="text" name="" readonly="true" value="XXXXXXXX"></span>
			<span>电子信箱：<input type="text" name="" readonly="true" value="XXXXXXXX@XX.com"></span>
			<span>受托方（乙方）：<input type="text" name="" value="江西昌大创新科技发展有限公司" readonly="true"></span>
			<span>住  所  地：<input type="text" name="" value="江西省南昌市红谷滩新区学府大道999号" readonly="true" style="width: 370px;"></span>
			<span>法定代表人：<input type="text" name="" readonly="true" value="谢明勇"></span>
			<span>项目联系人：<input type="text" name="" readonly="true" value="曾长清"></span>
			<span>联系方式 ：<input type="text" name="" readonly="true" value="13970901360 "></span>
			<span>通讯地址：<input type="text" name="" readonly="true" value="南昌大学北区理科楼102、103室"></span>
			<span>电话：<input type="text" name="" readonly="true" value="0791-8304127">传真:<input type="text" name="" readonly="true" value="0791-8304892"></span>
			<span>电子信箱：<input type="text" name="" readonly="true" value="cqzeng@ncu.edu.cn"></span>
			<p>本合同甲方委托乙方研究开发  基于SOA架构的客户关系管理系统  项目，并支付研究开发和测试经费，乙方接受委托并进行此项研究开发工作。双方经过平等协商，在真实、充分地表达各自意愿的基础上，根据《中华人民共和国合同法》的规定，达成如下协议，并由双方共同恪守。</p>
			<p><b>第一条</b>  本合同研究开发项目的要求如下：</p>
			<p> 1．技术目标： <h>完成基于SOA架构的客户关系管理系统研究开发工作，提交相关文档。</h></p>
		</div>
		
		<div id="forth-page">
			<p>2．技术内容和要求：</p>
			<p>1）<h>销售自动化子系统：为销售人员，管理人员提供先进的营销管理自动化工具，例如，潜在商机管理，商机获取渠道分析，销售阶段分析，竞争对手分析，实时预测，订单管理，报表及统计图表以及其他功能；  </h></p>
			<p>2）<h>营销自动化子系统：主要功能包括“规划及进行市场活动、电子邮件营销、生成线索、管理营销联系人、评估营销效果”等；</h></p>
			<p>3）<h>……</h></p>
			<p>3．技术方法和路线：<h>采用JEE平台解决方案及SOA架构；应用服务器采用Tomcat。</h></p>
			<p><b>第二条</b>  乙方应按下列进度完成研究开发工作：</p>
			<p><h>合同生效后，乙方开始进行软件开发工作，并于2012年9月31日前完成测试工作。</h></p>
			<p><b>第三条</b>  甲方应按以下方式支付研究开发和测试经费：</p>
			<p>1．研究开发和集成经费总额为<input type="text" id="amt" name="" value="${contract.amt}" readonly="true"></p>
			<p>2．研究开发经费由甲方<input type="text" name="" readonly="true" value="分期">（一次、分期或提成）支付乙方。具体支付方式和时间如下：</p>
			<p>(1)<h>合同签订后1周日内付人民币贰拾万元整(￥200,000.00)</h></p>
			<p>(2)<h>项目验收合格后1周内付人民币贰拾万元整(￥200,000.0)</h></p>
			<p>(3)<h>试运行1个月后付人民币壹拾叁万元整(￥100,000.0)；</h></p>
			<p style="text-indent:30px;">乙方开户银行名称、地址和帐号为：</p>
			<p style="text-indent:35px;">开户银行:<h>中国建设银行股份有限公司南昌南京东路支行</h></p>
			<p style="text-indent:35px;">户名:<h> 江西昌大创新科技发展有限公司 </h></p>
			<p style="text-indent:35px;">地址:<h>南昌市南京东路</h></p>
			<p style="text-indent:35px;">帐号:<h>36001051200052501459</h></p>
			<p style="text-indent:40px;"><b>第四条</b>  本合同的变更必须由双方协商一致，并以书面形式确定。</p>
			<p style="text-indent:40px;"><b>第五条</b>  未经甲方同意，乙方不得将本合同项目部分或全部研究开发工作转让第三人承担。</p>
		</div>

		<div id="fifth-page">
			<p><b>第六条</b>  在本合同履行中，因乙方出现在现有技术水平和条件下难以克服的技术困难，导致研究开发失败或部分失败，并造成甲方损失的，双方按如下约定承担风险损失：<h>  乙方承担因此造成的本身的损失，甲方有权追回已支付的经费，并不再经费。</h></p>
			<p><b>第七条</b>  在本合同履行中，因作为研究开发标的技术已经由他人公开（包括以专利权方式公开），一方应在<h> 15 </h>日内通知另一方解除合同。逾期未通知并致使另一方产生损失的，另一方有权要求予以赔偿。</p>
			<p><b>第八条</b>  双方确定因履行本合同应遵守的保密义务如下：</p>
			<p>甲方：</p>
			<p>1. 保密内容（包括技术信息和经营信息）:<h>本合同项目实施中未正式向社会公开的一切资料和信息及研究所涉及成果和主要方案等 。</h></p>
			<p>2．涉密人员范围: <h>项目参与人员及管理、辅助人员。</h></p>
			<p>3．保密期限：<h>本合同项下的保密义务自相关资料或信息以及研究所涉及成果和主要方案正式向社会公开之日或甲方书面解除乙方本合同项下保密义务之日起终止。</h></p>
			<p>4．泄密责任：<h>承担由此造成的一切损失</h></p>
			<p>乙方：</p>
			<p>1. 保密内容:<h>本合同项目实施中未正式向社会公开的一切资料和信息及研究所涉及成果和主要方案等 。</h></p>
			<p>2．涉密人员范围: <h>项目参与人员及管理、辅助人员。</h></p>
			<p>3．保密期限：<h>本合同项下的保密义务自相关资料或信息以及研究所涉及成果和主要方案正式向社会公开之日或甲方书面解除乙方本合同项下保密义务之日起终止。</h></p>
			<p>4．泄密责任：<h>应当退还甲方已支付的项目经费，承担因此给甲方造成的一切损失  。</h></p>
			<p><b>第九条</b>  双方确定，对乙方完成的研究开发和测试成果进行验收：<h>由甲方验收。</h></p>
		</div>

		<div id="sixth-page">
			<p><b>第十条</b>  双方确定：任何一方违反本合同约定，造成研究开发工作停滞、延误或失败的，按以下约定承担违约责任：</p>
			<p> 1、 甲方不能按时提供水文资料，承担由此造成的项目延期、费用增加的责任。</p>
			<p> 2、 在项目执行过程中，乙方不得擅自对研究内容、目标、进度、项目负责人等进行自行调整，否则，造成合同不能按期完成、合同目标有重大修改而影响成果质量，将视情况追究乙方的违约责任。</p>
			<p> 3、 乙方没有按照合同执行或目标的，甲方将适当减少或暂停支付项目经费。</p>
			<p> 4、 甲方单方面解除合同的，合同终止前所发生的费用由甲方承担；乙方单方面解除合同或因非技术性主观原因造成项目无法完成的，甲方有权追索全部已拨费用，同时乙方还应承担相应的损失；</p>
			<p><b>第十一条</b> 双方确定，在本合同有效期内，甲方指定<h>XXXXX</h>为甲方项目联系人，乙方指定<h>曾长青</h>为乙方项目联系人。</p>
			<p>一方变更项目联系人的，应当及时以书面形式通知另一方。未及时通知并影响本合同履行或造成损失的，应承担相应的责任。</p>
			<p><b>第十二条</b>  双方确定，出现下列情形，致使本合同的履行成为不必要或不可能的，一方可以提前15日向对方发出书面通知，经双方同意后解除本合同；</p>
			<p>1.<h>因发生不可抗力；</h></p>
			<p><b>第十三条</b>  双方因履行本合同而发生的争议，应协商、调解解决。协商、调解不成的，确定按以下第<h> 2 </h>种方式处理：</p>
			<p> 1．提交<h> \ </h>仲裁委员会仲裁；</p>
			<p> 2．依法向人民法院起诉。</p>
			<p><b>第十四条</b>  双方确定：本合同及相关附件中所涉及的有关名词和技术术语，其定义和解释如下：</p>
			<p> 1．<h>      无      </h></p>
			<p><b>第十五条</b>  双方约定本合同其他相关事项为：<h>未尽事宜，应由双方共同友好协商，做出补充规定。补充规定与本合同</h></p>
		</div>

		<div id="last-page">
			<p><h>具有同等效力 。</h></p>
			<p><b>第十六条</b>  本合同一式<h> 四 </h>份，具有同等法律效力。</p>
			<p><b>第十七条</b>  本合同经双方签字盖章后生效。</p>
			<p>甲方：<input type="text" name="" value="xxxxxx公司">（盖章）</p>
			<p>法定代表人/委托代理人：<input type="text" name="">（签名）</p>
			<p>2012年2月23日</p>
			<p>乙方：<input type="text" name="" value="江西昌大创新科技发展有限公司">（盖章）</p>
			<p>法定代表人/委托代理人：<input type="text" name="">（签名）</p>
			<p>2012年2月23日</p>
		</div>
		
	</div>
</body>
</html>