package com.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.DataAnalyseMapper;
import com.service.DataAnalyseService;

@Service
public class DataAnalyseServiceImpl implements DataAnalyseService {

	@Autowired
	DataAnalyseMapper dataAnalyseMapper;
	@Override
	public List<Map<String, Integer>> getCntTypeData() {
		// TODO Auto-generated method stub
		return dataAnalyseMapper.getCntTypeData();
	}
	@Override
	public List<Map<String, Integer>> getAddvData() {
		// TODO Auto-generated method stub
		return dataAnalyseMapper.getAddvData();
	}
	@Override
	public List<Map<String, String>> getCntMyData() {
		// TODO Auto-generated method stub
		return dataAnalyseMapper.getCntMyData();
	}
	@Override
	public List<Map<String, Float>> getCntPft() {
		// TODO Auto-generated method stub
		return dataAnalyseMapper.getCntPft();
	}
	

}
