package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.contract.entity.ConType;
import com.dao.ConTypeMapper;
import com.service.ConTypeService;

@Service
public class ConTypeServiceImpl implements ConTypeService {

	@Autowired
	ConTypeMapper conTypeMapper;
	@Override
	public ConType getTypeByTpcd(String tpCd) {
		// TODO Auto-generated method stub
		return conTypeMapper.getTypeByTpcd(tpCd);
	}

	@Override
	public List<ConType> getType() {
		// TODO Auto-generated method stub
		return conTypeMapper.getType();
	}

}
