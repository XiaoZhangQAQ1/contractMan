package com.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.contract.entity.ConAppendix;
import com.dao.ConAppendixMapper;
import com.service.ConAppendixService;
@Service
public class ConAppendixServiceImpl implements ConAppendixService {

	@Autowired
	ConAppendixMapper conAppendixMapper;
	@Override
	public List<ConAppendix> getApxByCno(String cno) {
		// TODO Auto-generated method stub
		return conAppendixMapper.getApxByCno(cno);
	}

	@Override
	public int deleteApxByid(int id) {
		// TODO Auto-generated method stub
		return conAppendixMapper.deleteApxByid(id);
	}

	@Override
	public int insertApx(String cno, String addr,String apxname) {
		// TODO Auto-generated method stub
		return conAppendixMapper.insertApx(cno, addr,apxname);
	}

	@Override
	public int updateApx(String addr, String cno, Date date) {
		// TODO Auto-generated method stub
		return conAppendixMapper.updateApx(addr, cno, date);
	}

	@Override
	public ConAppendix getApxByid(int id) {
		// TODO Auto-generated method stub
		return conAppendixMapper.getApxByid(id);
	}

}
