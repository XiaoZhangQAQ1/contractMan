package com.dao;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.shiro.entity.Permission;

public interface PermissionMapper {
	public Set<Permission> getPermissionByRid(@Param("rid") String rid);
	public Set<String> getUrlById(@Param("id") String id);
}
