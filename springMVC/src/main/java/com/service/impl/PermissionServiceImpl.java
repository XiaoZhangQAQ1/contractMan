package com.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.PermissionMapper;
import com.service.PermissionService;
import com.shiro.entity.Permission;

@Service
public class PermissionServiceImpl implements PermissionService {
	
	@Autowired
	PermissionMapper PermissionMapper;
	@Override
	public Set<Permission> getPermissionByRid(String rid) {
		// TODO Auto-generated method stub
		return PermissionMapper.getPermissionByRid(rid);
	}
	@Override
	public Set<String> getUrlById(String id) {
		// TODO Auto-generated method stub
		return PermissionMapper.getUrlById(id);
	}

}
