package com.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.*;

public class FreemakerWord {

	 private static Configuration configuration = null;  
	 private static Map<String, Template> allTemplates = null; 
	 
	 static {  
	        configuration = new Configuration(Configuration.getVersion()); 
	        /** 设置编码 **/
	        configuration.setDefaultEncoding("utf-8");  
	        /** 加载文件 **/
	        configuration.setClassForTemplateLoading(FreemakerWord.class, "/template");  
	        allTemplates = new HashMap<>();   
	        try {  
	        	 /** 加载模板 **/
	            allTemplates.put("contract", configuration.getTemplate("contract2.ftl"));  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	            throw new RuntimeException(e);  
	        }  
	    }  
	 
	 private FreemakerWord() {
		 
	 }
	 
	 public static File createDoc(Map<?,?> dataMap,String type){
	        String name = "contract"+(int)(Math.random()*100000)+".doc";
	        File f = new File(name);
	        System.out.println(f);
	        Template t = allTemplates.get(type);
	        try{
	            //这个地方不能使用FileWriter因为需要指定编码类型否则生成的word文档会因为有无法识别的编码而无法打开
	            Writer w = new OutputStreamWriter(new FileOutputStream(f),"utf-8");
	            t.process(dataMap,w);
	            w.close();
	        }catch(Exception e){
	            e.printStackTrace();
	            throw new RuntimeException(e);
	        }
	        return f;
	 }


}
