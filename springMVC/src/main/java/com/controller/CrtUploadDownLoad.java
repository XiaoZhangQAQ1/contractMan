package com.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.javassist.expr.NewArray;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.contract.entity.ConAppendix;
import com.contract.entity.ConApprove;
import com.contract.entity.ConTemplate;
import com.contract.entity.Contract;
import com.google.gson.Gson;
import com.service.ConAppendixService;
import com.service.ConApproveService;
import com.service.ConTemService;
import com.service.ContractService;
import com.shiro.entity.Resp;
import com.shiro.entity.User;

@RequestMapping("crtInfo")
@Controller("crtUploadDownLoad")
public class CrtUploadDownLoad {

	@Autowired
	ConTemService conTemService;
	@Autowired
	ContractService contractService;
	@Autowired
	ConApproveService conApproveService;
	@Autowired
	ConAppendixService conAppendixService;
	
	
	@RequestMapping(value="/download")
	public void downloadTemp(HttpServletRequest request,HttpServletResponse response,String mdlcd) throws IOException {
//		System.out.println(mdlcd);
		ConTemplate conTemplate = conTemService.getTemplateByMdlcd(mdlcd);
//		String path = request.getSession().getServletContext().getRealPath("contractTemp")+"\\"+"软件开发模板.doc";
//		System.out.println(path);
		String path = conTemplate.getMdlAddr();
		if (path==null||path.equals("")) {
			response.setContentType("text/html; charset=UTF-8");//注意text/html，和application/html
        	response.getWriter().print("<html><body><script type='text/javascript'>alert('您要下载的资源不存在！');</script></body></html>");
        	response.getWriter().close();   
            return;
		}
		//得到要下载的文件
		File file = new File(path);
		if (!file.exists()) {
			response.setContentType("text/html; charset=UTF-8");//注意text/html，和application/html
        	response.getWriter().print("<html><body><script type='text/javascript'>alert('您要下载的资源已被删除！');</script></body></html>");
        	response.getWriter().close(); 
            System.out.println("您要下载的资源已被删除！！");  
            return;  
		}
		//转码，免得文件名中文乱码  
		String name = URLEncoder.encode(conTemplate.getMdlNm(),"UTF-8");
		//System.out.println(name);
        //设置文件下载头  
        response.addHeader("Content-Disposition", "attachment;filename=" + name+".doc");    
        //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型    
        response.setContentType("application/msword"); 
        // 读取要下载的文件，保存到文件输入流
        FileInputStream in = new FileInputStream(path);
        // 创建输出流
        OutputStream out = response.getOutputStream();
        // 创建缓冲区
        byte buffer[] = new byte[1024]; 
        int len = 0;
        //循环将输入流中的内容读取到缓冲区当中
        while((len = in.read(buffer)) > 0){
        	out.write(buffer, 0, len);
        }
        //关闭文件输入流
        in.close();
        // 关闭输出流
        out.close();
	}
	
	@RequestMapping(value="/downloadCrt")
	public void downloadCrt(HttpServletRequest request,HttpServletResponse response,String cno) throws IOException {
		Contract contract = contractService.getApproves(cno);
		String path = contract.getFaddr();
		if (path==null||path.equals("")) {
			response.setContentType("text/html; charset=UTF-8");//注意text/html，和application/html
        	response.getWriter().print("<html><body><script type='text/javascript'>alert('您要下载的资源不存在！');</script></body></html>");
        	response.getWriter().close();   
            return;
		}
		File file = new File(path);
		if (!file.exists()) {
			response.setContentType("text/html; charset=UTF-8");//注意text/html，和application/html
        	response.getWriter().print("<html><body><script type='text/javascript'>alert('您要下载的资源已被删除！');</script></body></html>");
        	response.getWriter().close(); 
            System.out.println("您要下载的资源已被删除！！");  
            return;
		}
		//转码，免得文件名中文乱码  
		cno = URLEncoder.encode(cno,"UTF-8");
		//System.out.println(name);
		//设置文件下载头  
		response.addHeader("Content-Disposition", "attachment;filename=" + cno+".doc");    
		//1.设置文件ContentType类型，这样设置，会自动判断下载文件类型    
		response.setContentType("application/msword"); 
		// 读取要下载的文件，保存到文件输入流
		FileInputStream in = new FileInputStream(path);
		// 创建输出流
		OutputStream out = response.getOutputStream();
		// 创建缓冲区
		byte buffer[] = new byte[1024]; 
		int len = 0;
		//循环将输入流中的内容读取到缓冲区当中
		while((len = in.read(buffer)) > 0){
		       out.write(buffer, 0, len);
		}
		//关闭文件输入流
		in.close();
		// 关闭输出流
		out.close();
	}
	
	@RequestMapping(value="/downloadApx")
	public void downloadApx(HttpServletRequest request,HttpServletResponse response,int id) throws IOException {
		ConAppendix conAppendix = conAppendixService.getApxByid(id);
		String addr = conAppendix.getAddr();
		String name = conAppendix.getApxName();
		if (addr==null||addr.equals("")) {
			response.setContentType("text/html; charset=UTF-8");//注意text/html，和application/html
        	response.getWriter().print("<html><body><script type='text/javascript'>alert('您要下载的资源不存在！');</script></body></html>");
        	response.getWriter().close();   
            return;
		}
		File file = new File(addr);
		if (!file.exists()) {
			response.setContentType("text/html; charset=UTF-8");//注意text/html，和application/html
        	response.getWriter().print("<html><body><script type='text/javascript'>alert('您要下载的资源已被删除！');</script></body></html>");
        	response.getWriter().close(); 
            System.out.println("您要下载的资源已被删除！！");  
            return;
		}
		//转码，免得文件名中文乱码  
		name = URLEncoder.encode(name,"UTF-8");
		//System.out.println(name);
		//设置文件下载头  
		response.addHeader("Content-Disposition", "attachment;filename=" + name+".doc");    
		//1.设置文件ContentType类型，这样设置，会自动判断下载文件类型    
		response.setContentType("application/msword"); 
		// 读取要下载的文件，保存到文件输入流
		FileInputStream in = new FileInputStream(addr);
		// 创建输出流
		OutputStream out = response.getOutputStream();
		// 创建缓冲区
		byte buffer[] = new byte[1024]; 
		int len = 0;
		//循环将输入流中的内容读取到缓冲区当中
		while((len = in.read(buffer)) > 0){
		       out.write(buffer, 0, len);
		}
		//关闭文件输入流
		in.close();
		// 关闭输出流
		out.close();
	}
	
	@RequestMapping(value="/uoloadCrt",method=RequestMethod.POST)
	public ModelAndView uoloadCrt(@RequestParam("file")MultipartFile[] files,HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		
		Session session = SecurityUtils.getSubject().getSession();
		Contract contract1 = (Contract)session.getAttribute("contract");
		String crtType = contract1.getConType().getTpNm();
		mv.addObject("crtType", crtType);
		mv.addObject("tpcd", contract1.getTpcd());
		
		String cno = (String)session.getAttribute("cno");
		
		//判断上传的文件是否为空
		if (files!=null && files.length>0) {
			MultipartFile file = files[0];
			MultipartFile apxFile = files[1];
			String fileName = file.getOriginalFilename();
			String apxFileName = apxFile.getOriginalFilename();
			System.out.println(fileName);
			System.out.println(apxFileName);	
			if (fileName=="" || fileName.equals("") || fileName.length()<=0) {
				mv.setViewName("contract/crtStartDetil");
				mv.addObject("error", "上传文件不能为空");
				return mv;
			}
			String rootPath = "D:\\项目\\毕设\\springMVC\\src\\main\\webapp\\upload";
			//获取文件后缀
			String prefixName = FilenameUtils.getExtension(fileName);
			if (prefixName.equalsIgnoreCase("doc")||prefixName.equalsIgnoreCase("docx")) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String date = format.format(new Date());
				String newFileName =rootPath+"\\"+cno+date+fileName.substring(fileName.lastIndexOf("."));
				System.out.println(newFileName);
				File targitFile = new File(newFileName);
				//System.out.println(targitFile);
				String ApxNewFileName = null;
				try {
					file.transferTo(targitFile);
					//如果附件不为空
					if (apxFileName!="" && !apxFileName.equals("") && apxFileName.length()>0) {
						System.out.println("附件不为空");
						String ApxRootPath = "D:\\项目\\毕设\\springMVC\\src\\main\\webapp\\crtApxUpload\\"+cno;
						File rootFile = new File(ApxRootPath);
						if (!rootFile.exists()) {
							rootFile.mkdir();
							System.out.println(rootFile+"文件夹创建成功");
						}
						//获取文件后缀
						String ApxPrefixName = FilenameUtils.getExtension(apxFileName);
						if (ApxPrefixName.equalsIgnoreCase("doc")||ApxPrefixName.equalsIgnoreCase("docx")) {
							ApxNewFileName = ApxRootPath+"\\"+apxFileName;
							File ApxTargetFile = new File(ApxNewFileName);
							//上传文件
							try {
								apxFile.transferTo(ApxTargetFile);
							} catch (Exception e) {
								// TODO: handle exception
								System.out.println(e.toString());
								mv.setViewName("contract/crtStartDetil");
								mv.addObject("error", "合同附件上传失败");
								return mv;
							}
						}else {
							mv.setViewName("contract/crtStartDetil");
							mv.addObject("error", "合同附件只能上传word文档哦");
							return mv;
						}
					}
					mv.setViewName("contract/crtStartNew");
					mv.addObject("success", "上传成功");
				}catch (IOException e) {
					// TODO: handle exception
					mv.setViewName("contract/crtStartDetil");
					mv.addObject("error", "合同上传失败,请重试");
					System.out.println(e.toString());
					return mv;
				}
				
				//合同跟附件都上传成功，数据入库
				contractService.updateCrtFaddr(cno, newFileName);
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
				if (apxFileName!="" && !apxFileName.equals("") && apxFileName.length()>0) {
					conAppendixService.insertApx(cno, ApxNewFileName, apxFileName);
				}
				session.removeAttribute("cno");
				session.removeAttribute("contract");
				
			}else {
				mv.setViewName("contract/crtStartDetil");
				mv.addObject("error", "您只能上传word文档哦");
				return mv;
			}
		}else {
			mv.setViewName("contract/crtStartDetil");
			mv.addObject("error", "上传文件不能为空");
		}
		
		return mv;
	}
}
