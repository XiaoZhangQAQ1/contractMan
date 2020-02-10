package com.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.contract.entity.Addv;

public interface AddvMapper {
	public Addv getAddvByAdcd(@Param("adcd")String adcd);
	public List<Addv> getAddv();
}
