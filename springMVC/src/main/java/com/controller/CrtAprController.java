package com.controller;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.contract.entity.ConApprove;
import com.service.ConApproveService;
import com.shiro.entity.User;

@Controller("crtAprController")
@RequestMapping("/approve")
public class CrtAprController {

	@Autowired
	ConApproveService conApproveService;
	
	@RequestMapping("/submit")
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT)
	public String ConAprSubmit(Model model,String cno,String touid,String content,String operation) {
//		System.out.println("进来啦");
		int n = conApproveService.cryApvSumbitUpdate(cno);
		if (n<0) {
			model.addAttribute("approveError", "审批失败");
		}else {
			ConApprove conApprove = new ConApprove();
			conApprove.setCno(cno);
			conApprove.setContent(content);
			conApprove.setOperation(operation);
			conApprove.setTouid(touid);
			User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
			String uid = loginUser.getUid();
			conApprove.setUid(uid);
			conApprove.setFlag("1");
			String rid = (String)SecurityUtils.getSubject().getSession().getAttribute("rid");
			conApprove.setResult(rid);
			int m = conApproveService.cryApvSumbitInsert(conApprove);
			if (m<0) {
				model.addAttribute("approveError", "审批失败");
			}
			model.addAttribute("approveSuccess", "审批成功");
		}
		return "redirect:../crt/conApprove";
	}
	
	@RequestMapping("/back")
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT)
	public String ConAprBack(Model model,String cno,String content,String operation) {
		System.out.println(cno);
		int n = conApproveService.cryApvBackUpdate(cno);
		if (n<0) {
			model.addAttribute("approveError", "打回失败");
		}else {
			ConApprove conApprove = new ConApprove();
			conApprove.setCno(cno);
			conApprove.setContent(content);
			conApprove.setOperation(operation);
			conApprove.setTouid("8000");
			User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
			String uid = loginUser.getUid();
			conApprove.setUid(uid);
			conApprove.setFlag("1");
			conApprove.setResult("-1");
			int m = conApproveService.cryApvSumbitInsert(conApprove);
			if (m<0) {
				model.addAttribute("approveError", "打回失败");
			}
			model.addAttribute("approveSuccess", "打回成功");
		}
		return "redirect:../crt/conApprove";
	}
	
}
