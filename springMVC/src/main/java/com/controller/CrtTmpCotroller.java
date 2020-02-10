package com.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.contract.entity.Contract;
import com.service.ContractService;
import com.util.FreemakerWord;

@RequestMapping("/template")
@Controller("crtTmpCotroller")
public class CrtTmpCotroller {

	@Autowired
	ContractService contractService;
	@RequestMapping("/download")
	public String downDoc(HttpServletRequest request,HttpServletResponse response,String cno) throws IOException {
		Map<String,Object> map = new HashMap<String,Object>();
		Contract contract = contractService.getApproves(cno);
		map.put("cnm",contract.getCnm());
	    map.put("adcd",contract.getAddv().getTpNm());
	    map.put("tpcd",contract.getTpcd());
	    map.put("sgtm",contract.getSgtm());
	    map.put("fpnm",contract.getFpnm());
	    map.put("amt",contract.getAmt());
	    map.put("paytm",contract.getPaytm());
	    map.put("cno", contract.getCno());
	     
	    File file = null;
	    InputStream fin = null;
	    ServletOutputStream out = null;
	     
	    try{
	            //调用工具类WordGenerator的createDoc方法生成Word文档
	            file = FreemakerWord.createDoc(map, "contract");
	            fin = new FileInputStream(file);

	            response.setCharacterEncoding("utf-8");
	            response.setContentType("application/msword");
	            response.addHeader("Content-Disposition", "attachment;filename=contract.doc");

	            out = response.getOutputStream();
	            byte[] buffer = new byte[1024];//缓冲区
	            int bytesToRead = -1;
	            // 通过循环将读入的Word文件的内容输出到浏览器中  
	            while((bytesToRead = fin.read(buffer)) != -1) {  
	                out.write(buffer, 0, bytesToRead);  
	            }

	        }catch(Exception ex){
	            ex.printStackTrace();
	        }
	        finally{
	            if(fin != null) fin.close();  
	            if(out != null) out.close();  
	            if(file != null) file.delete(); // 删除临时文件  
	        }
		return null;
	}
	
}
