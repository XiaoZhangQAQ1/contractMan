package com.service;

import org.apache.ibatis.annotations.Param;

import com.contract.entity.ConTemplate;

public interface ConTemService {

	ConTemplate getTemplateByMdlcd(@Param("mdlcd")String mdlcd);
}
