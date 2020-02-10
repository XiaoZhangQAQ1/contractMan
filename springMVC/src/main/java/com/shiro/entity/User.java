package com.shiro.entity;

import java.util.Date;
import java.util.List;
import java.util.Set;

public class User {
	private String uid;
	private String uName;
	private String password;
	private String tel;
	private Date loginDate;
	private String salt;
	private Date createDate;
	private int status;
	private String eMail;
	private Set<Role> roleList;
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public Date getLoginDate() {
		return loginDate;
	}
	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public Set<Role> getRoleList() {
		return roleList;
	}
	public void setRoleList(Set<Role> roleList) {
		this.roleList = roleList;
	}
	
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String geteMail() {
		return eMail;
	}
	public void seteMail(String eMail) {
		this.eMail = eMail;
	}
	@Override
	public String toString() {
		return "User [uid=" + uid + ", uName=" + uName + ", password=" + password + ", tel=" + tel
				+ ", loginDate=" + loginDate + ", salt=" + salt + ", createDate=" + createDate + ", status=" + status
				+ ", eMail=" + eMail + ", roleList=" + roleList + "]";
	}
	
	
	
	
	
}
