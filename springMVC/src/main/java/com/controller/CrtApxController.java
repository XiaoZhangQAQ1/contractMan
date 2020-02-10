package com.controller;

import java.io.File;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.contract.entity.ConAppendix;
import com.contract.entity.Contract;
import com.contract.entity.PageBean;
import com.service.ConAppendixService;
import com.service.ContractService;

@Controller("crtApxController")
@RequestMapping("crtApx")
public class CrtApxController {

	@Autowired
	ContractService contractService;
	@Autowired
	ConAppendixService conAppendixService;
	
	@RequiresPermissions("user:apx")
	@RequestMapping("/apxMan")
	public ModelAndView apxMan(ModelAndView mv,@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage) {
		PageBean<Contract> pageBean = contractService.getContract("", "", "", "", "",currentPage);
		mv.addObject("page", pageBean);
		//List<Contract> contractList = contractService.getContract("","","","","");
		List<Contract> contractList = pageBean.getLists();
		if (contractList.size()!=0) {
			mv.addObject("contractList", contractList);
		}
		mv.setViewName("crtApx/conApx");
		return mv;
	}
	
	@RequestMapping("/apxDetil")
	public ModelAndView apxDetil(ModelAndView mv,String cno) {
		Contract contract = contractService.getApproves(cno);
//		List<ConAppendix> conAppendixs = contract.getConAppendix();
//		for (ConAppendix conAppendix : conAppendixs) {
//			System.out.println(conAppendix.getDate());
//		}
		mv.setViewName("crtApx/conApxDetil");
		mv.addObject("contract", contract);
		return mv;
	}
	
	@RequestMapping(value="/addApx")
	public ModelAndView addApx(MultipartFile file,String cno) {
		ModelAndView mv = new ModelAndView();
		System.out.println(cno);
		Contract contract = contractService.getApproves(cno);
		mv.addObject("contract", contract);
		mv.setViewName("crtApx/conApxDetil");
		String fileName = null;
		try {
			fileName = file.getOriginalFilename();
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("error", "上传文件不能为空");
			return mv;
		}

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
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.toString());
				mv.addObject("error", "上传失败");
				return mv;
			}
			//判断是否上传过同名文件
			List<ConAppendix> conAppendixList = contract.getConAppendix();
			for (ConAppendix conAppendix : conAppendixList) {
				if (conAppendix.getApxName().equals(fileName)) {
					String addr = conAppendix.getAddr();
					Date date = conAppendix.getDate();
					int n = conAppendixService.updateApx(addr, cno, date);
					if (n>0) {
						mv.addObject("success", "上传成功");
						contract = contractService.getApproves(cno);
						mv.addObject("contract", contract);
					}else {
						mv.addObject("error", "上传失败");
					}
					return mv;
				}
			}
			int n = conAppendixService.insertApx(cno, newFileName, fileName);
			if (n>0) {
				contract = contractService.getApproves(cno);
				mv.addObject("contract", contract);
				mv.addObject("success", "上传成功");
			}else {
				mv.addObject("error", "上传失败");
				return mv;
			}
		}else {
			mv.addObject("error", "上传文件只能为word文档");
		}
		return mv;
	}
	
	@RequestMapping(value="/delApx")
	public ModelAndView delApx(ModelAndView mv,String cno,int id) {
		Contract contract = contractService.getApproves(cno);
		mv.setViewName("crtApx/conApxDetil1");
		mv.addObject("contract", contract);
		int n=conAppendixService.deleteApxByid(id);
		if (n>0) {
			mv.addObject("success","删除成功");
		}else {
			mv.addObject("error","删除失败");
		}
		return mv;
	}
	
	@RequestMapping(value ="/apxFindDetil",method=RequestMethod.POST)
	public ModelAndView apxFindDetil(String cno,ModelAndView mv) {
		//List<Contract> contractList = contractService.getContract(cno,"","","","");
		PageBean<Contract> pageBean = contractService.getContract(cno, "", "", "", "",1);
		mv.addObject("page", pageBean);
		List<Contract> contractList = pageBean.getLists();
		if (contractList.size()!= 0) {
			mv.addObject("contractList", contractList);
		}else {
			mv.addObject("contractList", "");
		}
		mv.setViewName("crtApx/conApx");
		return mv;
	}
}
