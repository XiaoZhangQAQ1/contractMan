package com.contract.entity;

import java.util.Date;

public class ConAppendix {

	private int id;
	private String cno;
	private String addr;
	private Date date;
	private String apxName;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCno() {
		return cno;
	}
	public String getApxName() {
		return apxName;
	}
	public void setApxName(String apxName) {
		this.apxName = apxName;
	}
	public void setCno(String cno) {
		this.cno = cno;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return "ConAppendix [cno=" + cno + ", addr=" + addr + ", date=" + date + "]";
	}

}
