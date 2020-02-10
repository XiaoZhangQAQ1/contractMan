package com.shiro.entity;

public class Resp {
	private int code;
	private String info;
	private Object object;
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public Object getObject() {
		return object;
	}
	public void setObject(Object object) {
		this.object = object;
	}
	@Override
	public String toString() {
		return "Resp [code=" + code + ", info=" + info + ", object=" + object + "]";
	}
	
}
