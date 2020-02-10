package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.contract.entity.ConAppendix;
import com.contract.entity.Contract;
import com.service.ConAppendixService;
import com.service.ContractService;
import com.shiro.entity.User;
import com.zhuozhengsoft.pageoffice.FileSaver;
import com.zhuozhengsoft.pageoffice.OpenModeType;
import com.zhuozhengsoft.pageoffice.PageOfficeCtrl;

@Controller
@RequestMapping("/crtLook")
public class CrtLookOnline {

	@Autowired
	ContractService contractService;
	@Autowired
	ConAppendixService conAppendixService;
	
	@RequestMapping("/look")
	public String look(HttpServletRequest request,String cno) {
		//System.out.println("进入look控制器");
		System.out.println(cno);
		Contract contract = contractService.getApproves(cno);
		String faddr = contract.getFaddr();
		//System.out.println(faddr);
		String filename = faddr.substring(faddr.lastIndexOf("\\"));
		User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
		String unm = loginUser.getuName();
		PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
		request.setAttribute("poCtrl", poCtrl);
		//设置服务器页面
		poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
		//设置保存页面
		poCtrl.setSaveFilePage("crtLook/save");
		//打开 Word 文档
		//poCtrl.webOpen("/upload/111111152019-04-21.docx",OpenModeType.docNormalEdit,"张佚名");
		poCtrl.webOpen("/upload"+filename, OpenModeType.docReadOnly, unm);
		return "contract/word";
	}
	
	@RequestMapping("/lookApx")
	public String lookApx(HttpServletRequest request,int id,String cno) {
		//System.out.println("进入look控制器");
		ConAppendix conAppendix = conAppendixService.getApxByid(id);
		String apxName = conAppendix.getApxName();
		String filename = "\\"+cno+"\\"+apxName;
		System.out.println(apxName);
		User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
		String unm = loginUser.getuName();
		PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
		request.setAttribute("poCtrl", poCtrl);
		//设置服务器页面
		poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
		//设置保存页面
		poCtrl.setSaveFilePage("crtLook/save");
		//打开 Word 文档
		//poCtrl.webOpen("/upload/111111152019-04-21.docx",OpenModeType.docNormalEdit,"张佚名");
		poCtrl.webOpen("/uploadApx"+filename, OpenModeType.docReadOnly, unm);
		return "contract/word";
	}
	
	@RequestMapping("/editAndLook")
	public String editAndLook(HttpServletRequest request,String cno) {
		System.out.println("进入look控制器");
		System.out.println(cno);
		Contract contract = contractService.getApproves(cno);
		String faddr = contract.getFaddr();
		//System.out.println(faddr);
		String filename = faddr.substring(faddr.lastIndexOf("\\")+1);
		System.out.println(filename);
		User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
		String unm = loginUser.getuName();
		PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
		request.setAttribute("poCtrl", poCtrl);
		//设置服务器页面
		poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
		poCtrl.addCustomToolButton("保存并关闭","Save",1);
		//设置保存页面
		poCtrl.setSaveFilePage("save");
		//打开 Word 文档
		poCtrl.webOpen("D:\\项目\\毕设\\springMVC\\src\\main\\webapp\\upload\\"+filename,OpenModeType.docNormalEdit,unm);
		//poCtrl.webOpen("/upload"+filename, OpenModeType.docReadOnly, unm);
		return "contract/word";
	}
	 
	@RequestMapping("/save")
	public void save(HttpServletRequest request,HttpServletResponse response) {
		System.out.println("进入save方法");
		FileSaver fs=new FileSaver(request,response);
		System.out.println(fs.getFileName());
		String fileName = fs.getFileName().substring(fs.getFileName().indexOf("\\")+1);
		String oldPath = "/upload"+fileName;
		String path ="D:\\项目\\毕设\\springMVC\\src\\main\\webapp\\upload\\111111192019-05-19.doc";
		System.out.println("服务器路径："+request.getSession().getServletContext().getRealPath("/upload/")+fileName);
		System.out.println(fileName);
		fs.saveToFile("D:\\项目\\毕设\\springMVC\\src\\main\\webapp\\upload\\"+fileName);
		System.out.println("保存结束");
		fs.close();
	}
}
