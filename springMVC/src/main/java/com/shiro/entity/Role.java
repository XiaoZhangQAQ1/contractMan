package com.shiro.entity;

import java.util.List;
import java.util.Set;

public class Role {
	private int id;
	private String rid;
	private String roleName;
	private String description;
	private Set<User> userList;
	private Set<Permission> permissionList;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Set<User> getUserList() {
		return userList;
	}
	public void setUserList(Set<User> userList) {
		this.userList = userList;
	}
	public Set<Permission> getPermissionList() {
		return permissionList;
	}
	public void setPermissionList(Set<Permission> permissionList) {
		this.permissionList = permissionList;
	}
	
	
	
	
	
}
