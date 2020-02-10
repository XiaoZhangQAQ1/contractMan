package com.controller;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.service.UserService;
import com.shiro.entity.Resp;
import com.shiro.entity.Role;
import com.shiro.entity.User;
import com.util.MailUtil;
import com.util.ShiroUtil;

@Controller("loginController")
@RequestMapping("/my")
@SessionAttributes(value={"username"})
public class LoginController {
	@Autowired
	UserService userService;
	@Autowired
	private SessionDAO sessionDao;
	private static String EmailCode;
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
    public ModelAndView index(String uid,String password,ModelAndView mv,boolean rememberMe){
	//	System.out.println("准备登陆");
		String error = null;
		User user1 = userService.getUserByUid(uid);
		if (user1==null) {
			error="该用户尚未注册";
			mv.addObject("error", error);
			mv.setViewName("login");
			return mv;
		}
		if (user1.getStatus()==-1) {
			error="该用户被冻结，如有疑问请联系超级管理员";
			mv.addObject("error", error);
			mv.setViewName("login");
			return mv;
		}
		Subject subject= SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(uid,password);
		rememberMe = rememberMe == false ? false : rememberMe;
		//System.out.println(rememberMe);
		token.setRememberMe(rememberMe);
		Collection<Session> sessions = sessionDao.getActiveSessions();
		//System.out.println("开始获取session列表");
        for (Session session : sessions) {
        	if (session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY)!=null) {
        		SimplePrincipalCollection collection = (SimplePrincipalCollection)session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
        		User user = (User)collection.getPrimaryPrincipal();
        		if (uid.equals(user.getUid())) {
                    mv.setViewName("login");
                    mv.addObject("error", "该用户已登录");
                    sessionDao.delete(session);
                    return mv;
        		}
			}
        }
		try {
			subject.login(token);
//			Session session=subject.getSession();
//			session.setAttribute("uid", uid);
		} catch (UnknownAccountException  e) {
			// TODO: handle exception
			error = "用户名/密码错误";
		}catch (IncorrectCredentialsException  e) {
			// TODO: handle exception
			error = "用户名/密码错误";
		}catch (AuthenticationException  e) {
			// TODO: handle exception
			e.printStackTrace();
			error = "用户尚未注册/出现其他错误";
		}
		if (error != null) {
			mv.addObject("error", error);
            mv.setViewName("login");
            return mv;
		}else {
			Session loginSession=SecurityUtils.getSubject().getSession();
			User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
			Set<Role> roleSet = loginUser.getRoleList();
			Set<String> roleName = new HashSet<String>();
			String rid = null ;
			if (roleSet.size()>=1) {
				for (Role role : roleSet) {
					roleName.add(role.getRoleName());
					//System.out.println(role.getRid());
					rid=role.getRid();
				}
				loginSession.setAttribute("role", roleName);
			}else {
				loginSession.setAttribute("role", "[游客]");
			}
			loginSession.setAttribute("rid", rid);
			loginUser.setLoginDate(new Date());
			userService.updateUserLoginDate(loginUser);
			System.out.println("登陆成功");
			//mv.setViewName("contract/main");
		}
		return  new ModelAndView("redirect:/page/main");

    }
	
	@ResponseBody
	@RequestMapping(value="/sendMail",method=RequestMethod.POST,produces="application/json;charset=UTF-8;")
	public String sendMail(String eMail) {
		Gson gson = new Gson();
		Resp resp = new Resp();
		if (eMail==null ||eMail.equals("")) {
			resp.setCode(-1);
			resp.setInfo("邮箱为空,请填写你的邮箱信息");
			return gson.toJson(resp);
		}
		User user=userService.getUserByUid(eMail);
		if (user==null || user.equals("")) {
			resp.setCode(-1);
			resp.setInfo("该邮箱还未注册，如有疑问，请联系系统管理员");
			return gson.toJson(resp);
		}
		String text = UUID.randomUUID().toString().substring(0,4);
		EmailCode=text;
		if (MailUtil.sendMail(eMail, text)) {
			resp.setCode(1);
			resp.setInfo("成功发送验证码");
		}else {
			resp.setCode(-1);
			resp.setInfo("验证码发送失败");
		}
		System.out.println(text);
		resp.setCode(1);
		resp.setInfo("成功发送验证码");
		return gson.toJson(resp);
	}
	
	@ResponseBody
	@RequestMapping(value="/valid",method=RequestMethod.POST,produces="application/json;charset=UTF-8;")
	public String valid(String validate) {
		//System.out.println("开始验证");
		//System.out.println(validate);
		//System.out.println(EmailCode);
		Gson gson = new Gson();
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		if (validate.equals(EmailCode)) {
			map.put("valid", true);
		}else {
			map.put("valid", false);
		}
		return gson.toJson(map);
	}
	
	@RequestMapping(value="/changPass",method=RequestMethod.POST,produces="application/json;charset=UTF-8;")
	public ModelAndView changePass(String email,String password,ModelAndView mv) {
		User user=userService.getUserByUid(email);
		if (user==null || user.equals("")) {
			mv.addObject("error", "用户不存在");
			return mv;
		}
		String salt = ShiroUtil.createSalt();
		password = ShiroUtil.getSalt(password, salt);
		user.setSalt(salt);
		user.setPassword(password);
		int n = userService.updateUserPass(user);
		System.out.println(n);
		if (n<=0) {
			mv.addObject("error", "更新信息失败");
		}else {
			mv.addObject("success", "修改密码成功");
		}
		mv.setViewName("login");
		return mv;
	}
	
}
