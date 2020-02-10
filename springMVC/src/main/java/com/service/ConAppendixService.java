package com.service;

import java.util.Date;
import java.util.List;

import com.contract.entity.ConAppendix;

public interface ConAppendixService {

	List<ConAppendix> getApxByCno(String cno);
	int deleteApxByid(int id);
	int insertApx(String cno,String addr,String apxname);
	public int updateApx(String addr,String cno,Date date);
	ConAppendix getApxByid(int id);
}
