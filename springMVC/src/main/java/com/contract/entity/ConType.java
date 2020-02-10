package com.contract.entity;

/**
 * 合同类型
 * @author ZhangZY
 *
 */
public class ConType {
	private String tpCd; //合同类型代码
	private String tpNm; //合同类型名称
	private String mdlCd; //合同模板代码
	private ConTemplate conTemplate; //合同类型跟模板是一对一的关系
	
	public String getTpCd() {
		return tpCd;
	}
	public void setTpCd(String tpCd) {
		this.tpCd = tpCd;
	}
	public String getTpNm() {
		return tpNm;
	}
	public void setTpNm(String tpNm) {
		this.tpNm = tpNm;
	}
	public String getMdlCd() {
		return mdlCd;
	}
	public void setMdlCd(String mdlCd) {
		this.mdlCd = mdlCd;
	}
	
	public ConTemplate getConTemplate() {
		return conTemplate;
	}
	public void setConTemplate(ConTemplate conTemplate) {
		this.conTemplate = conTemplate;
	}
	@Override
	public String toString() {
		return "ConType [tpCd=" + tpCd + ", tpNm=" + tpNm + ", mdlCd=" + mdlCd + "]";
	}
	
	
}
