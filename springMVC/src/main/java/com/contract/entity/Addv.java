package com.contract.entity;
/**
 * 行政区划表
 * @author ZhangZY
 *
 */
public class Addv {

	private String adCd; //行政区划代码
	private String tpNm; //行政区划名称
	public String getAdCd() {
		return adCd;
	}
	public void setAdCd(String adCd) {
		this.adCd = adCd;
	}
	public String getTpNm() {
		return tpNm;
	}
	public void setAdNm(String tpNm) {
		this.tpNm = tpNm;
	}
	@Override
	public String toString() {
		return "Addv [adCd=" + adCd + ", tpNm=" + tpNm + "]";
	}
}
