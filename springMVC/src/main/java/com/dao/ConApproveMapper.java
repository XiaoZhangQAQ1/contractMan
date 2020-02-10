package com.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.contract.entity.ConApprove;

public interface ConApproveMapper {
	
	public ConApprove getApproveByCno(@Param("cno")String cno);
	public List<ConApprove> getApprovesByCno(@Param("cno")String cno);
	public int cryApvSumbitUpdate(@Param("cno")String cno);
	public int cryApvSumbitInsert(ConApprove conApprove);
	public int cryApvBackUpdate(@Param("cno")String cno);
	public int deleteApvByUid(@Param("uid")String uid);
}
