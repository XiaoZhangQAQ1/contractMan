package com.dao;

import java.util.List;
import java.util.Map;

public interface DataAnalyseMapper {

	public List<Map<String, Integer>> getCntTypeData();
	public List<Map<String, Integer>> getAddvData();
	public List<Map<String, String>> getCntMyData();
	public List<Map<String, Float>> getCntPft();
}
