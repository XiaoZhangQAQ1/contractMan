package com.contract.entity;

/**
 * 合同模板
 * @author ZhangZY
 *
 */
public class ConTemplate {
	private String mdlCd;
	private String mdlNm;
	private String mdlAddr;
	private String mdlUrl;
	public String getMdlCd() {
		return mdlCd;
	}
	public void setMdlCd(String mdlCd) {
		this.mdlCd = mdlCd;
	}
	public String getMdlNm() {
		return mdlNm;
	}
	public void setMdlNm(String mdlNm) {
		this.mdlNm = mdlNm;
	}
	public String getMdlAddr() {
		return mdlAddr;
	}
	public void setMdlAddr(String mdlAddr) {
		this.mdlAddr = mdlAddr;
	}
	
	public String getMdlUrl() {
		return mdlUrl;
	}
	public void setMdlUrl(String mdlUrl) {
		this.mdlUrl = mdlUrl;
	}
	@Override
	public String toString() {
		return "ConTemplate [mdlCd=" + mdlCd + ", mdlNm=" + mdlNm + ", mdlAddr=" + mdlAddr + ", mdlUrl=" + mdlUrl + "]";
	}
	
}
