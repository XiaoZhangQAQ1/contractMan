package com.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.mail.Flags.Flag;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.contract.entity.Addv;
import com.contract.entity.ConType;
import com.contract.entity.Contract;
import com.contract.entity.PageBean;
import com.service.AddvService;
import com.service.ConTypeService;
import com.service.ContractService;
import com.service.DataAnalyseService;
import com.shiro.entity.User;

@Controller
@RequestMapping("/page")
public class PageController {

	@Autowired
	ContractService contractService;
	@Autowired
	AddvService addvService;
	@Autowired
	ConTypeService conTypeService;
	@Autowired
	DataAnalyseService dataAnalyseService;
	
	@RequestMapping(value="/login")
	public ModelAndView login(ModelAndView mv) {
		//System.out.println("进入login控制器");
		mv.setViewName("login");
		return mv;
	}
	
	@RequestMapping(value="/main")
	public ModelAndView main(ModelAndView mv) {
		User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
		List<Contract> contractApvList=contractService.getContractByUser(loginUser.getUid());
		List<Contract> newCrtList = contractService.getNewCrt();
		//获取合同所有区域
		List<Addv> addvs = addvService.getAddv();
		String addvString = "";
		if (addvs.size()>0) {
			for (Addv addv : addvs) {
				addvString+="'"+addv.getTpNm() +"',";
			}
			addvString = addvString.substring(0,addvString.length()-1);
		}
		//System.out.println(addvString);
		
		//获取所有合同类型
		List<ConType> conTypes = conTypeService.getType();
		String typeString="";
		if (conTypes.size()>0) {
			for (ConType conType : conTypes) {
				typeString+="'"+conType.getTpNm() +"',";
			}
			typeString = typeString.substring(0,typeString.length()-1);
		}
		//System.out.println(typeString);
		
		//获取合同类别占比信息
		List<Map<String, Integer>> CntTypeData = dataAnalyseService.getCntTypeData();
		String CntTypeDataString = "";
		boolean flag=true;
		if (CntTypeData.size()>0) {
			for (Map<String, Integer> map : CntTypeData) {
				Set<String> keySet = map.keySet();
				for (String key : keySet) {
//					System.out.print(key+"=");
//					System.out.println(map.get(key));
//					System.out.println(map.entrySet());
					if (flag) {
						CntTypeDataString+="{value:"+map.get(key)+",";
						flag=false;
					}else {
						CntTypeDataString+="name:'"+map.get(key)+"'},";
						flag=true;
					}
				}
			}
			CntTypeDataString = CntTypeDataString.substring(0,CntTypeDataString.length()-1);
			//System.out.println(CntTypeDataString);
		}
		
		
		//获取甲方公司区域信息
		List<Map<String, Integer>> cmpAdcdData = dataAnalyseService.getAddvData();
		String cmpAdcdDataString = "";
		boolean flag1=true;
		if (cmpAdcdData.size()>0) {
			for (Map<String, Integer> map : cmpAdcdData) {
				Set<String> keySet = map.keySet();
				for (String key : keySet) {
					if (flag1) {
						cmpAdcdDataString+="{value:"+map.get(key)+",";
						flag1=false;
					}else {
						cmpAdcdDataString+="name:'"+map.get(key)+"'},";
						flag1=true;
					}
				}
			}
			cmpAdcdDataString = cmpAdcdDataString.substring(0,cmpAdcdDataString.length()-1);
			//System.out.println(cmpAdcdDataString);
		}
		
		
		//获取合同审批通过率信息
		//List<Contract> contracts = contractService.getContract("", "", "", "", "");
		//List<Contract> contractsOk = contractService.getContractOver();
		int totalCrt = contractService.selectCount("","","","","");
		//System.out.println(totalCrt);
		int crtOk = contractService.selectOverCount();
		String crtOkRateDataString = "{value:"+crtOk+", name:'完成'}," +"{value:"+(totalCrt-crtOk)+", name:'未完成'}";
		
		//获取合同金额详情
		List<Map<String, String>> cntMyData = dataAnalyseService.getCntMyData();
		String cntMyDataString = "",oneDataString="";
		int i = 0;
		float moneyNum = 0;
		
		Object money,month = null,type = null;
		Set<String> monthSet = new HashSet<String>();
		if (cntMyData.size()>0) {
			for (Map<String, String> map : cntMyData) {
				//System.out.println(map.entrySet());
				Set<String> keySet = map.keySet();
				i=0;
				for (String key : keySet) {
					//合同总金额
					if (i==0) {
						i++;
						money = map.get(key);
						moneyNum = Float.parseFloat(money.toString());
					}
					//月份
					else if (i==1) {
						i++;
						month = map.get(key);
						monthSet.add(month.toString());
						//System.out.println("month="+month.toString());
					}
					//合同类型,判断合同的月份加上所对应的money
					else if (i==2) {
						type = map.get(key);
						//System.out.println("type="+type.toString());
						oneDataString +="{month:"+"'"+month.toString()+"月',"+ "'"+type.toString()+"':"+moneyNum/10000+"},";
					}	
				}			
			}
			cntMyDataString=oneDataString.substring(0,oneDataString.length()-1);
			//System.out.println("cntMyDataString="+cntMyDataString);
		}
		
		//获取合同的利润信息
		List<Map<String, Float>> cntPftList = dataAnalyseService.getCntPft();
		Object in,out,pft;
		String cntPftMonth = "[";
		String cntPftIn = "[";
		String cntPftOut = "[";
		String cntPft = "[";
		if (cntPftList.size()>0) {
			for (Map<String, Float> map : cntPftList) {
				//System.out.println(map.entrySet());
				Set<String> keySet = map.keySet();
				for (String key : keySet) {
					if (key.equals("month")) {
						cntPftMonth+="'"+map.get(key)+"月',";
					}else if (key.equals("profit")) {
						pft = map.get(key);
						cntPft+=Float.parseFloat(pft.toString())/10000+",";
					}else if (key.equals("shouru")) {
						in = map.get(key);
						cntPftIn+=Float.parseFloat(in.toString())/10000+",";
					}else if (key.equals("zhichu")) {
						out = map.get(key);
						cntPftOut+="-"+Float.parseFloat(out.toString())/10000+",";
					}
				}
			}
		}
		cntPftMonth = cntPftMonth.substring(0,cntPftMonth.length()-1)+"]";
		cntPftIn = cntPftIn.substring(0,cntPftIn.length()-1)+"]";
		cntPftOut = cntPftOut.substring(0,cntPftOut.length()-1)+"]";
		cntPft = cntPft.substring(0,cntPft.length()-1)+"]";
		
		mv.addObject("cntPftMonth", cntPftMonth);
		mv.addObject("cntPftIn", cntPftIn);
		mv.addObject("cntPftOut", cntPftOut);
		mv.addObject("cntPft", cntPft);
		
		mv.addObject("contractApvList", contractApvList);
		mv.addObject("cntMyDataString", cntMyDataString);
		mv.addObject("crtOkRateDataString", crtOkRateDataString);
		mv.addObject("CntTypeDataString", CntTypeDataString);
		mv.addObject("cmpAdcdDataString", cmpAdcdDataString);
		mv.addObject("newCrtList", newCrtList);
		mv.addObject("addv", addvString);
		mv.addObject("type", typeString);
		mv.addObject("user", loginUser);
		mv.setViewName("/contract/main");
		return mv;
	}
	
	
	@RequestMapping(value="/wrong/noRole")
	public ModelAndView noRole(ModelAndView mv) {
		mv.setViewName("/wrong/noRole");
		return mv;
	}
	
	@RequestMapping(value="/wrong/noPer")
	public ModelAndView noPer(ModelAndView mv) {
		mv.setViewName("/wrong/noPer");
		return mv;
	}

}
