package com.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.contract.entity.ConAppendix;

public interface ConAppendixMapper {

	public List<ConAppendix> getApxByCno(@Param("cno")String cno);
	public int deleteApxByid(@Param("id")int id);
	public int insertApx(@Param("cno")String cno,@Param("addr")String addr,@Param("apxName")String apxName);
	public int updateApx(@Param("addr") String addr,@Param("cno") String cno,@Param("date") Date date);
	public ConAppendix getApxByid(@Param("id")int id);
}
