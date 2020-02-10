package com.service;

import java.util.List;

import com.contract.entity.Addv;

public interface AddvService {

	public Addv getAddvByAdcd(String adcd);
	public List<Addv> getAddv();
}
