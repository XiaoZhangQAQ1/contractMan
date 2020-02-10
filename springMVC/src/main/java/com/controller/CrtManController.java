package com.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.contract.entity.ConApprove;
import com.contract.entity.ConType;
import com.contract.entity.Contract;
import com.contract.entity.PageBean;
import com.google.gson.Gson;
import com.service.ConAppendixService;
import com.service.ConApproveService;
import com.service.ConTypeService;
import com.service.ContractService;
import com.service.UserService;
import com.shiro.entity.Resp;
import com.shiro.entity.Role;
import com.shiro.entity.User;

@Controller("crtManController")
@RequestMapping("/crt")
public class CrtManController {

	@Autowired
	ContractService contractService;
	@Autowired
	UserService UserService;
	@Autowired
	ConApproveService conApproveService;
	@Autowired
	ConAppendixService conAppendixService;
	@Autowired
	ConTypeService conTypeService;
	
	//发起合同
	@RequiresPermissions("user:setCrt")
	@RequestMapping("/crtStart")
	public ModelAndView crtStart(ModelAndView mv) {
//		User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
//		System.out.println(loginUser);
//		System.out.println(SecurityUtils.getSubject().getSession().getId());
		Session session = SecurityUtils.getSubject().getSession();
		String cno = (String)session.getAttribute("cno");
		if (cno!=null && !cno.equals("") && cno.length()>0) {
			Contract contract = contractService.getApproves(cno);
			String crtType = contract.getConType().getTpNm();
			mv.addObject("crtType", crtType);
			mv.addObject("tpcd", contract.getTpcd());
			mv.setViewName("contract/crtStartDetil");
		}else {
			mv.setViewName("contract/crtStartNew");
		}
		
		return mv;
	}
	
	//合同关键信息填入后的控制器
	@RequestMapping("/crtStartDetil")
	public ModelAndView crtStartDetil(ModelAndView mv) {
		Session session = SecurityUtils.getSubject().getSession();
		String cno = (String)session.getAttribute("cno");
		Contract contract = contractService.getApproves(cno);
		String crtType = contract.getConType().getTpNm();
		mv.addObject("crtType", crtType);
		mv.addObject("tpcd", contract.getTpcd());
		mv.setViewName("contract/crtStartDetil");
		return mv;
	}
	
	@RequestMapping("/crtStartRemove")
	public ModelAndView crtStartRemove(ModelAndView mv) {
		Session session = SecurityUtils.getSubject().getSession();
		String cno = (String)session.getAttribute("cno");
		System.out.println(cno);
		if (cno!=" " || !cno.equals("")) {
			int n = contractService.deleteCrt(cno);
			if (n>0) {
				mv.addObject("success", "操作成功，您可以重新发起合同");
				session.removeAttribute("contract");
				session.removeAttribute("cno");
			}else {
				mv.addObject("error", "出现异常，请重试");
			}
		}
		mv.setViewName("contract/crtStart");
		return mv;
	}
	
	@RequestMapping("/editOnline")
	public ModelAndView editOnline(ModelAndView mv,HttpServletResponse response) throws IOException {
		Session session = SecurityUtils.getSubject().getSession();
		String cno = (String)session.getAttribute("cno");
		Contract contract = contractService.getApproves(cno);
		contract.setAdcd(contract.getAddv().getTpNm());
		
		mv.addObject("contract", contract);
		mv.setViewName(contract.getConType().getConTemplate().getMdlUrl());
		return mv;
	}
	
	@RequestMapping("/backEditOnline")
	public ModelAndView backEditOnline(ModelAndView mv,HttpServletResponse response,String cno) throws IOException {
		Contract contract = contractService.getApproves(cno);
		contract.setAdcd(contract.getAddv().getTpNm());
		mv.addObject("contract", contract);
		mv.setViewName(contract.getConType().getConTemplate().getMdlUrl());
		return mv;
	}
	
	@RequestMapping("/onlyRead")
	public ModelAndView onlyRead(ModelAndView mv,HttpServletResponse response,String cno) throws IOException {
		Contract contract = contractService.getApproves(cno);
		contract.setAdcd(contract.getAddv().getTpNm());
		mv.addObject("contract", contract);
		mv.setViewName(contract.getConType().getConTemplate().getMdlUrl()+"2");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/editOlineSub",method=RequestMethod.POST,produces="application/json;charset=UTF-8;")
	public String editOlineSub(String cno,String cnm,String fpnm,Double amt,MultipartFile file) {
		Resp resp = new Resp();
		Gson gson = new Gson();
		String fileName = null;
		try {
			fileName = file.getOriginalFilename();
			System.out.println(fileName);
			String rootPath = "D:\\项目\\毕设\\springMVC\\src\\main\\webapp\\crtApxUpload\\"+cno;
			File rootFile = new File(rootPath);
			if (!rootFile.exists()) {
				rootFile.mkdir();
				System.out.println(rootFile+"文件夹创建成功");
			}
			//获取文件后缀
			String prefixName = FilenameUtils.getExtension(fileName);
			if (prefixName.equalsIgnoreCase("doc")||prefixName.equalsIgnoreCase("docx")) {
				String newFileName = rootPath+"\\"+fileName;
				File targetFile = new File(newFileName);
				//上传文件
				try {
					file.transferTo(targetFile);
					int m = conAppendixService.insertApx(cno, newFileName, fileName);
					if (m<0) {
						resp.setCode(0);
						resp.setInfo("更新失败");
						return gson.toJson(resp);
					}
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println(e.toString());
					resp.setCode(-2);
					resp.setInfo("上传失败");
					return gson.toJson(resp);
				}
			}else {
				resp.setCode(-1);
				resp.setInfo("只能上传word文档");
				return gson.toJson(resp);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("合同附件为空");
			System.out.println(e.toString());
		}
		//插入合同信息
		int n = contractService.updateCrt(cno, cnm, fpnm, amt);
		if (n>0) {
			Session session = SecurityUtils.getSubject().getSession();
			session.removeAttribute("cno");
			session.removeAttribute("contract");
			
			//默认合同管理员审批通过
			ConApprove conApprove = new ConApprove();
			conApprove.setCno(cno);
			conApprove.setContent("审批通过");
			conApprove.setOperation("送给小H审批");
			conApprove.setTouid("8001");
			User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
			String uid = loginUser.getUid();
			conApprove.setUid(uid);
			conApprove.setFlag("1");
			conApprove.setResult("1");
			conApproveService.cryApvSumbitInsert(conApprove);
			resp.setCode(1);
			resp.setInfo("提交成功");
		}else {
			resp.setCode(0);
			resp.setInfo("更新失败");
		}
		return gson.toJson(resp);
	}
	
	@RequestMapping("/insertCrt")
	public ModelAndView insertCrt(ModelAndView mv,String cno,String tpcd,String fpnm,String adcd,String amt,String cnm){
		Double amt1 = Double.parseDouble(amt);
		String adcd1 = adcd.substring(0,6);
		//System.out.println(adcd1);
		Contract contract = new Contract();
		contract.setCno(cno);
		contract.setTpcd(tpcd);
		contract.setFpnm(fpnm);
		contract.setAdcd(adcd1);
		contract.setAmt(amt1);
		contract.setCnm(cnm);
		try {
			int n = contractService.insertCrt(contract);
			if (n>0) {
				mv.setViewName("contract/crtStartDetil");
				mv.addObject("success", "提交成功");
				Session session = SecurityUtils.getSubject().getSession();
				session.setAttribute("cno", cno);
				Contract contract1 = contractService.getApproves(cno);
				String crtType = contract1.getConType().getTpNm();
				session.setAttribute("contract", contract1);
				mv.addObject("crtType", crtType);
				mv.addObject("tpcd", contract.getTpcd());
			}else {
				mv.setViewName("contract/crtStart");
				mv.addObject("error", "提交失败，请重试");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.setViewName("contract/crtStartNew");
			mv.addObject("error", "系统中可能存在该合同信息...请在确认后重试");
		}

		return mv;
	}
	
	@RequestMapping(value ="/conOk" )
	public ModelAndView conOk(ModelAndView mv,@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage) {
		PageBean<Contract> pageBean = contractService.getContractOver(currentPage);
		List<Contract> contractList = pageBean.getLists();
		//List<Contract> contractList = contractService.getContractOver();
		for (Contract contract : contractList) {
			List<ConApprove> conApproveList=contract.getConApprove();
			if (conApproveList.size() !=0) {
				for (int i = 0; i < conApproveList.size(); i++) {
					ConApprove conApprove = conApproveList.get(i);
					String uid1 = conApprove.getUid();
					User user = UserService.getUserByUid(uid1);
					Set<Role> roleSet = user.getRoleList();
					Set<String> roleName = new HashSet<String>();
					if (roleSet.size()>=1) {
						for (Role role : roleSet) {
							roleName.add(role.getRoleName());
						}
					}
					conApprove.setUid(roleName+"");
					conApproveList.set(i, conApprove);
					
				}
			}
			
		}
		mv.setViewName("contract/conOK");
		mv.addObject("contractList",contractList );
		mv.addObject("page", pageBean);
		return mv;
	}
	
	@RequestMapping(value ="/processFind" )
	public ModelAndView processFind(ModelAndView mv,@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage) {
		//List<Contract> contractList = contractService.getContract("", "","","","");
		PageBean<Contract> pageBean = contractService.getContract("", "", "", "", "",currentPage);
		mv.addObject("page", pageBean);
		List<Contract> contractList = pageBean.getLists();
		if (contractList.size()!= 0) {
			for (Contract contract : contractList) {
				List<ConApprove> conApproveList=contract.getConApprove();
				if (conApproveList.size() != 0) {
					for (int i = 0; i < conApproveList.size(); i++) {
						ConApprove conApprove = conApproveList.get(i);
						String uid = conApprove.getUid();
						User user = UserService.getUserByUid(uid);
						Set<Role> roleSet = user.getRoleList();
						Set<String> roleName = new HashSet<String>();
						if (roleSet.size()>=1) {
							for (Role role : roleSet) {
								roleName.add(role.getRoleName());
							}
						}
						conApprove.setUid(roleName+" "+user.getuName());
						//System.out.println(conApprove.getUid());
						conApproveList.set(i, conApprove);
					}
				}
			}
			mv.addObject("contractList", contractList);
		}else {
			mv.addObject("contractList", "");
		}
		mv.setViewName("contract/processFind");
		return mv;
	}
	
	@RequestMapping(value ="/conInfo" )
	public ModelAndView conInfo(ModelAndView mv,String cno,String flagValue) {
		if (cno!="" || cno.equals("")) {
			Contract contract=contractService.getApproves(cno);
			mv.addObject("contract", contract);
			mv.addObject("flagValue", flagValue);
			List<ConApprove> conApproveList=contract.getConApprove();
			if (conApproveList.size() !=0) {
				for (int i = 0; i < conApproveList.size(); i++) {
					ConApprove conApprove = conApproveList.get(i);
					String uid1 = conApprove.getUid();
					User user = UserService.getUserByUid(uid1);
					Set<Role> roleSet = user.getRoleList();
					Set<String> roleName = new HashSet<String>();
					if (roleSet.size()>=1) {
						for (Role role : roleSet) {
							roleName.add(role.getRoleName());
						}
					}
					conApprove.setUid(user.getuName()+" "+roleName);
					conApproveList.set(i, conApprove);
					
				}
				mv.addObject("conApproveList", conApproveList);
			}
		}else {
			mv.addObject("conApproveList", "");
		}
		mv.setViewName("contract/conInfo");
		return mv;
	}
	
	@RequestMapping(value ="/conApprove" )
	public ModelAndView conApprove(ModelAndView mv,String approveSuccess,String approveError){
		System.out.println("进入conApprove Controller");
		if (approveSuccess!="" || !approveSuccess.equals("")) {
			mv.addObject("approveSuccess", approveSuccess);
		}
		if (approveError!="" || !approveError.equals("")) {
			mv.addObject("approveError", approveError);
		}
		User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
		List<Contract> contractList=contractService.getContractByUser(loginUser.getUid());
		for (Contract contract : contractList) {
			List<ConApprove> conApproveList=contract.getConApprove();
			if (conApproveList.size() !=0) {
				for (int i = 0; i < conApproveList.size(); i++) {
					ConApprove conApprove = conApproveList.get(i);
					String uid1 = conApprove.getUid();
					User user = UserService.getUserByUid(uid1);
					Set<Role> roleSet = user.getRoleList();
					Set<String> roleName = new HashSet<String>();
					if (roleSet.size()>=1) {
						for (Role role : roleSet) {
							roleName.add(role.getRoleName());
						}
					}
					conApprove.setUid(roleName+"");
					conApproveList.set(i, conApprove);
					
				}
			}
			
		}
		mv.addObject("contractList", contractList);
		mv.setViewName("contract/conApprove");
		return mv;
	}
	
	@RequestMapping(value ="/conApproveDetil",method=RequestMethod.POST)
	public ModelAndView conApproveDetil(ModelAndView mv,String cno) {
		String rid = (String)SecurityUtils.getSubject().getSession().getAttribute("rid");
//		System.out.println(rid);
		if (rid.equals("4") || rid.equals("5")) {
			mv.addObject("high","你已经是最高权限，办理完成后流程结束");
		}else {
			int rid1 = Integer.parseInt(rid);
			rid = String.valueOf(rid1+1);
			List<User> userRoleList = UserService.getUserByRid(rid);
			mv.addObject("userRoleList",userRoleList);
		}

		if (cno!="" || cno.equals("")) {
			Contract contract=contractService.getApproves(cno);
			System.out.println(contract.getFaddr());
			List<ConApprove> conApproveList=contract.getConApprove();
			if (conApproveList.size() !=0) {
				for (int i = 0; i < conApproveList.size(); i++) {
					ConApprove conApprove = conApproveList.get(i);
					String uid1 = conApprove.getUid();
					User user = UserService.getUserByUid(uid1);
					Set<Role> roleSet = user.getRoleList();
					Set<String> roleName = new HashSet<String>();
					if (roleSet.size()>=1) {
						for (Role role : roleSet) {
							roleName.add(role.getRoleName());
						}
					}
					conApprove.setUid(user.getuName()+" "+roleName);
					conApproveList.set(i, conApprove);
					
				}
				mv.addObject("conApproveList", conApproveList);
				mv.addObject("contract", contract);	
			}
		}else {
			mv.addObject("conApproveList", "");
		}
		mv.setViewName("contract/conApproveDetil");
		return mv;
	}
	
	@RequestMapping(value ="/processFindDetil")
	public ModelAndView conApproveDetil(String cno,String cnm ,String startDate,String endDate,String ctype,ModelAndView mv,@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage) {
		mv.addObject("Findcno", cno);
		mv.addObject("Findcnm", cnm);
		mv.addObject("FindsDate", startDate);
		mv.addObject("FindeDate", endDate);
		mv.addObject("Findctype", ctype);
		if (ctype!="") {
			ConType conType = conTypeService.getTypeByTpcd(ctype);
			String findCtnm = conType.getTpNm();
			mv.addObject("findCtnm", findCtnm);
		}
		if (endDate != "") {
			endDate = endDate+" 23:59:59";
		}
		PageBean<Contract> pageBean = contractService.getContract(cno, cnm,ctype,startDate,endDate,currentPage);
		mv.addObject("page", pageBean);
		//List<Contract> contractList = contractService.getContract("","","","","");
		List<Contract> contractList = pageBean.getLists();
		//List<Contract> contractList = contractService.getContract(cno, cnm,ctype,startDate,endDate);
		if (contractList.size()!= 0) {
			for (Contract contract : contractList) {
				List<ConApprove> conApproveList=contract.getConApprove();
				if (conApproveList.size() != 0) {
					for (int i = 0; i < conApproveList.size(); i++) {
						ConApprove conApprove = conApproveList.get(i);
						String uid = conApprove.getUid();
						User user = UserService.getUserByUid(uid);
						Set<Role> roleSet = user.getRoleList();
						Set<String> roleName = new HashSet<String>();
						if (roleSet.size()>=1) {
							for (Role role : roleSet) {
								roleName.add(role.getRoleName());
							}
						}
						conApprove.setUid(roleName+" "+user.getuName());
						//System.out.println(conApprove.getUid());
						conApproveList.set(i, conApprove);
						
					}
				}
			}
			mv.addObject("contractList", contractList);
		}else {
			mv.addObject("contractList", "");
		}
		mv.setViewName("contract/processFind");
		return mv;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/checkCrt",method=RequestMethod.POST,produces="application/json;charset=UTF-8;")
	public String checkUser(String cno) {
		Gson gson = new Gson();
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		Contract contract = contractService.getApproves(cno);
		if (contract!=null) {
			map.put("valid", false);
		}else {
			map.put("valid", true);
		}
		return gson.toJson(map);
	}
	
}
