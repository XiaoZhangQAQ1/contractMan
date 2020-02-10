package com.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.RoleMapper;
import com.service.RoleService;
import com.shiro.entity.Role;

@Service
public class RoleServiceImpl implements RoleService {
	@Autowired
	RoleMapper RoleMapper;
	@Override
	public Set<Role> getRolesByUid(String uid) {
		// TODO Auto-generated method stub
		return RoleMapper.getRolesByUid(uid);
	}
	@Override
	public Set<Role> getRolesByAid(String aid) {
		// TODO Auto-generated method stub
		return RoleMapper.getRolesByAid(aid);
	}

}
