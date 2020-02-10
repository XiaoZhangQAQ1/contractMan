package com.service;

import java.util.List;
import java.util.Set;

import com.shiro.entity.Role;

public interface RoleService {
	Set<Role> getRolesByUid(String id);
	Set<Role> getRolesByAid(String aid);
	
}
