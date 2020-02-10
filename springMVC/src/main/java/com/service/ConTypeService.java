package com.service;

import java.util.List;


import com.contract.entity.ConType;

public interface ConTypeService {

	public ConType getTypeByTpcd(String tpCd);
	public List<ConType> getType();
}
