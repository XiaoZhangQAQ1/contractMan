package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.contract.entity.Contract;
import com.contract.entity.PageBean;
import com.dao.ContractMapper;
import com.service.ContractService;
import com.util.PageUtil;

@Service
public class ContractServiceImpl implements ContractService {

	@Autowired
	ContractMapper contractmapper;
	
	@Override
	public PageBean<Contract> getContract(String cno, String cnm, String tpcd, String startDate, String endDate,
			int currentPage) {
		// TODO Auto-generated method stub
		PageBean<Contract> pageBean = new PageBean<Contract>();
		//封装当前页数
		pageBean.setCurrPage(currentPage);
		//每页显示的数据
		pageBean.setPageSize(PageUtil.pagesize);
		//封装总记录数
		int totalCount = contractmapper.selectCount(cno, cnm, tpcd, startDate, endDate);
		pageBean.setTotalCount(totalCount);
		//封装总页数
		double tc = totalCount;
        Double num =Math.ceil(tc/PageUtil.pagesize);//向上取整
        pageBean.setTotalPage(num.intValue());
        int start = (currentPage-1)*PageUtil.pagesize;
        int size = pageBean.getPageSize();
        List<Contract> lists = contractmapper.getContract(cno, cnm, tpcd, startDate, endDate, start, size);
        pageBean.setLists(lists);
		return pageBean;
	}


	@Override
	public Contract getApproves(String cno) {
		// TODO Auto-generated method stub
		return contractmapper.getApproves(cno);
	}


	@Override
	public List<Contract> getContractByUser(String uid) {
		// TODO Auto-generated method stub
		return contractmapper.getContractByUser(uid);
	}


	@Override
	public PageBean<Contract> getContractOver(int currentPage) {
		// TODO Auto-generated method stub
		PageBean<Contract> pageBean = new PageBean<Contract>();
		//封装当前页数
		pageBean.setCurrPage(currentPage);
		//每页显示的数据
		pageBean.setPageSize(PageUtil.pagesize);
		//封装总记录数
		int totalCount = contractmapper.selectOverCount();
		pageBean.setTotalCount(totalCount);
		//封装总页数
		double tc = totalCount;
        Double num =Math.ceil(tc/PageUtil.pagesize);//向上取整
        pageBean.setTotalPage(num.intValue());
        int start = (currentPage-1)*PageUtil.pagesize;
        int size = pageBean.getPageSize();
        List<Contract> lists = contractmapper.getContractOver(start,size);
        pageBean.setLists(lists);
		return pageBean;
	}


	@Override
	public int insertCrt(Contract contract) {
		// TODO Auto-generated method stub
		return contractmapper.insertCrt(contract);
	}


	@Override
	public int deleteCrt(String cno) {
		// TODO Auto-generated method stub
		return contractmapper.deleteCrt(cno);
	}


	@Override
	public int updateCrt(String cno, String cnm, String fpnm, Double amt) {
		// TODO Auto-generated method stub
		return contractmapper.updateCrt(cno, cnm, fpnm, amt);
	}


	@Override
	public int updateCrtFaddr(String cno, String faddr) {
		// TODO Auto-generated method stub
		return contractmapper.updateCrtFaddr(cno, faddr);
	}


	@Override
	public List<Contract> getNewCrt() {
		// TODO Auto-generated method stub
		return contractmapper.getNewCrt();
	}


	@Override
	public int selectCount(String cno, String cnm, String tpcd, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return contractmapper.selectCount(cno,cnm,tpcd,startDate,endDate);
	}


	@Override
	public int selectOverCount() {
		// TODO Auto-generated method stub
		return contractmapper.selectOverCount();
	}

}
