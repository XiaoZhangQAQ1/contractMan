package com.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.service.ConApproveService;
import com.service.UserService;
import com.shiro.entity.Resp;
import com.shiro.entity.Role;
import com.shiro.entity.User;
import com.util.MailUtil;
import com.util.ShiroUtil;

@RequestMapping("/user")
@Controller("userController")
public class UserController {

	@Autowired
	UserService userService;
	@Autowired
	ConApproveService conApproveService;
	
	@RequestMapping("/userCenter")
	public ModelAndView userCenter(ModelAndView mv,String success,String error) {
		if (success!="" || !success.equals("")) {
			System.out.println(success);
			mv.addObject("success", success);
		}
		if (error!="" || !error.equals("") ) {
			mv.addObject("error", error);
		}
		User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
		User user = userService.getUserByUid(loginUser.getUid());
		mv.addObject("user", user);
		mv.setViewName("/contract/userCenter");
		return mv;
	}
	
	@RequestMapping("/userAlter")
	public ModelAndView userAlter(ModelAndView mv,String uName,String tel) {
		User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
		if (uName=="" || uName.equals("")) {
			uName=loginUser.getuName();
//			System.out.println(uName);
		}
		if (tel=="" || tel.equals("")) {
			tel=loginUser.getTel();
		}
		User user = new User();
		user = loginUser;
		user.setuName(uName);
		user.setTel(tel);
		user.setUid(loginUser.getUid());
		int n=userService.updateUserInfo(user);
		if (n>0) {
			mv.addObject("success", "修改成功");
		}else {
			mv.addObject("error", "修改失败");
		}
		//mv.setViewName("/contract/userCenter");
		mv.setViewName("redirect:../user/userCenter");
		return mv;
	}
	
	@RequiresPermissions("user:manage")
	@RequestMapping("/userMan")
	public ModelAndView userMan(ModelAndView mv) {
		List<User> userList = userService.getUsers("", "", "", "");
		if (userList.size()!=0) {
			mv.addObject("userList", userList);
		}
		mv.setViewName("/user/userMan");
		return mv;
	}
	
	@RequestMapping("/userFindDetil")
	public ModelAndView userFindDetil(ModelAndView mv,String uid,String uName,String eMail,String tel) {
		List<User> userList = userService.getUsers(uid,uName,eMail,tel);
		if (userList.size()!=0) {
			mv.addObject("userList", userList);
		}
		mv.setViewName("/user/userMan");
		return mv;
	}
	
	@RequestMapping("/deleteUser")
	public ModelAndView deleteUser(ModelAndView mv,String uid) {
		System.out.println(uid);
		int n = userService.freezeUser(uid, -1);
		List<User> userList = userService.getUsers("","","","");
		if (userList.size()!=0) {
			mv.addObject("userList", userList);
		}
		mv.setViewName("/user/userMan");
		
		if (n>0) {
			mv.addObject("success", "用户"+uid+"冻结成功");
		}else {
			mv.addObject("error", "用户"+uid+"冻结失败");
		}
		return mv;
	}
	
	@RequestMapping("/renewUser")
	public ModelAndView renewUser(ModelAndView mv,String uid) {
		int n = userService.freezeUser(uid, 0);
		List<User> userList = userService.getUsers("","","","");
		if (userList.size()!=0) {
			mv.addObject("userList", userList);
		}
		mv.setViewName("/user/userMan");
		
		if (n>0) {
			mv.addObject("success", "用户"+uid+"恢复成功");
		}else {
			mv.addObject("error", "用户"+uid+"恢复失败");
		}
		return mv;
	}
	
	@RequestMapping("/alterUserRole")
	public ModelAndView alterUserRole(ModelAndView mv,String uid,String rid) {
		List<User> userList = userService.getUsers("","","","");
		if (userList.size()!=0) {
			mv.addObject("userList", userList);
		}
		uid = uid.substring(7);
		int n = userService.deleteUserRole(uid);
		if (n>0) {
			int m = userService.insertUserRole(uid, rid);
			if (m>0) {
				mv.addObject("success", "用户权限修改成功");
			}else {
				mv.addObject("error", "用户权限修改失败");
			}
		}else {
			mv.addObject("error", "用户权限修改失败");
		}
		mv.setViewName("/user/userMan");
		return mv;
	}
	
	@RequestMapping("/insertUser")
	public ModelAndView insertUser(ModelAndView mv,String uid,String uName,String tel,String eMail,String rid) {
		System.out.println(eMail);
		User user = new User();
		user.setUid(uid);
		user.setuName(uName);
		user.setTel(tel);
		user.seteMail(eMail);
		String password = "000000";
		String salt = ShiroUtil.createSalt();
		password = ShiroUtil.getSalt(password, salt);
		user.setSalt(salt);
		user.setPassword(password);
		user.setCreateDate(new Date());
		int n = userService.insert(user);
		if (n>0) {
			userService.deleteUserRole(uid);
			int m = userService.insertUserRole(uid, rid);
			if (m>0) {
				mv.addObject("success", "用户添加成功");
			}else {
				mv.addObject("error", "用户添加失败");
			}
		}else {
			mv.addObject("error", "用户添加失败");
		}
		List<User> userList = userService.getUsers("","","","");
		if (userList.size()!=0) {
			mv.addObject("userList", userList);
		}
		mv.setViewName("/user/userMan");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/checkUser",method=RequestMethod.POST,produces="application/json;charset=UTF-8;")
	public String checkUser(String uid) {
		Gson gson = new Gson();
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		User user = userService.getUserByUid(uid);
		if (user!=null) {
			map.put("valid", false);
		}else {
			map.put("valid", true);
		}
		return gson.toJson(map);
	}
}
