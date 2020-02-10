package com.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.contract.entity.ConType;

public interface ConTypeMapper {

	public ConType getTypeByTpcd(@Param("tpCd")String tpCd);
	public List<ConType> getType();
}
