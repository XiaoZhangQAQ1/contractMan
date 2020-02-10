package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.contract.entity.Addv;
import com.dao.AddvMapper;
import com.service.AddvService;

@Service
public class AddvServiceImpl implements AddvService {

	@Autowired
	AddvMapper addvMapper;
	@Override
	public Addv getAddvByAdcd(String adcd) {
		// TODO Auto-generated method stub
		return addvMapper.getAddvByAdcd(adcd);
	}

	@Override
	public List<Addv> getAddv() {
		// TODO Auto-generated method stub
		return addvMapper.getAddv();
	}

}
