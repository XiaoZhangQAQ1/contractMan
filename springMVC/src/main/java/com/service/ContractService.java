package com.service;


import java.util.List;

import com.contract.entity.Contract;
import com.contract.entity.PageBean;

public interface ContractService {

	PageBean<Contract> getContract(String cno,String cnm,String tpcd,String startDate,String endDate,int currentPage) ;
	List<Contract> getNewCrt();
	Contract getApproves(String cno);
	List<Contract> getContractByUser(String uid);
	PageBean<Contract> getContractOver(int currentPage);
	int selectCount(String cno, String cnm, String tpcd, String startDate, String endDate);
	int selectOverCount();
	int insertCrt(Contract contract);
	int deleteCrt(String cno);
	int updateCrt(String cno,String cnm,String fpnm,Double amt);
	int updateCrtFaddr(String cno,String faddr);
}
