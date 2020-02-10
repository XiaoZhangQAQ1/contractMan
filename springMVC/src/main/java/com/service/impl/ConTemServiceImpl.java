package com.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.contract.entity.ConTemplate;
import com.dao.ConTemMapper;
import com.service.ConTemService;

@Service
public class ConTemServiceImpl implements ConTemService {

	@Autowired
	ConTemMapper conTemMapper;
	@Override
	public ConTemplate getTemplateByMdlcd(String mdlcd) {
		// TODO Auto-generated method stub
		return conTemMapper.getTemplateByMdlcd(mdlcd);
	}

}
