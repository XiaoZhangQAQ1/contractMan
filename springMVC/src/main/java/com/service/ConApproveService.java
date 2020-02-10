package com.service;


import org.apache.ibatis.annotations.Param;

import com.contract.entity.ConApprove;

public interface ConApproveService {

	int cryApvSumbitUpdate(String cno);
	int cryApvSumbitInsert(ConApprove conApprove);
	int cryApvBackUpdate(String cno);
	int deleteApvByUid(String uid);
}
