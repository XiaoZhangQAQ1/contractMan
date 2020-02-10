package com.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.contract.entity.ConApprove;
import com.dao.ConApproveMapper;
import com.service.ConApproveService;

@Service
public class ConApproveServiceImpl implements ConApproveService {

	@Autowired
	ConApproveMapper conApproveMapper;
	@Override
	public int cryApvSumbitUpdate(String cno) {
		// TODO Auto-generated method stub
		return conApproveMapper.cryApvSumbitUpdate(cno);
	}

	@Override
	public int cryApvSumbitInsert(ConApprove conApprove) {
		// TODO Auto-generated method stub
		return conApproveMapper.cryApvSumbitInsert(conApprove);
	}

	@Override
	public int cryApvBackUpdate(String cno) {
		// TODO Auto-generated method stub
		return conApproveMapper.cryApvBackUpdate(cno);
	}

	@Override
	public int deleteApvByUid(String uid) {
		// TODO Auto-generated method stub
		return conApproveMapper.deleteApvByUid(uid);
	}

}
