package com.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.contract.entity.Contract;

public interface ContractMapper {

	public List<Contract> getContract(@Param("cno")String cno,@Param("cnm")String cnm,@Param("tpcd")String tpcd,@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("start") int start,@Param("size")int size);
	public List<Contract> getNewCrt();
	public Contract getContractApprove(@Param("cno")String cno);
	public Contract getApproves(@Param("cno")String cno);
	public List<Contract> getContractByUser(@Param("uid")String uid);
	public List<Contract> getContractOver(@Param("start") int start,@Param("size")int size);
	public int selectCount(@Param("cno")String cno,@Param("cnm")String cnm,@Param("tpcd")String tpcd,@Param("startDate")String startDate,@Param("endDate")String endDate);
	public int selectOverCount();
	public int insertCrt(Contract contract);
	public int deleteCrt(@Param("cno")String cno);
	public int updateCrt(@Param("cno")String cno,@Param("cnm")String cnm,@Param("fpnm")String fpnm,@Param("amt")Double amt);
	public int updateCrtFaddr(@Param("cno")String cno,@Param("faddr") String faddr);
}
