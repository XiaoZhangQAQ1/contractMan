package com.dao;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.shiro.entity.Permission;
import com.shiro.entity.Role;

public interface RoleMapper {
	public Set<Role> getRolesByUid(@Param("uid") String uid);
	public Set<Role> getRolesByAid(@Param("aid") String aid);
}
