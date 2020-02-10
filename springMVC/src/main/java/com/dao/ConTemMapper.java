package com.dao;

import org.apache.ibatis.annotations.Param;

import com.contract.entity.ConTemplate;

public interface ConTemMapper {

	public ConTemplate getTemplateByMdlcd(@Param("mdlcd")String mdlcd);
	
}
