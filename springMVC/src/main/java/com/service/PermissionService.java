package com.service;

import java.util.Set;

import com.shiro.entity.Permission;

public interface PermissionService {
	Set<Permission> getPermissionByRid(String rid);
	Set<String> getUrlById(String id);
}
