package com.shiro.entity;

import java.util.Set;

public class Permission {
	private int id;
	private String aid;
	private String auNm;
	private String url;
	private String description;
	private Set<Role> roleList;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getAuNm() {
		return auNm;
	}
	public void setAuNm(String auNm) {
		this.auNm = auNm;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Set<Role> getRoleList() {
		return roleList;
	}
	public void setRoleList(Set<Role> roleList) {
		this.roleList = roleList;
	}
	@Override
	public String toString() {
		return "Permission [id=" + id + ", aid=" + aid + ", auNm=" + auNm + ", url=" + url + ", description="
				+ description + ", roleList=" + roleList + "]";
	}
	
}
