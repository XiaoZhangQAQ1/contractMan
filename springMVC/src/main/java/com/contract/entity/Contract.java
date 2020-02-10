package com.contract.entity;

import java.util.Date;
import java.util.List;
/**
 * 合同基本信息
 * @author ZhangZY
 *
 */
public class Contract {
	
	private String cno;		// 合同编号
	private String tpcd;		// 合同类型
	private String fcno;		// 销售合同编号
	private String cnm;		// 合同名称
	private String fpnm;		// 甲方名称
	private Date sgtm;		// 签订时间
	private Double amt;		// 合同金额
	private String adcd;		// 甲方所属行政区划
	private String paytm;		// 付款条件
	private String faddr;		// 审批的版本地址
	private String laddr;		// 合同终稿地址
	private Addv addv; //合同跟甲方所属行政区划是一对一关系
	private ConType conType; //合同跟合同类型是一对一关系
	private List<ConApprove> conApprove;//合同跟合同审批是一对多关系
	private List<ConAppendix> conAppendix;
	
	public String getCno() {
		return cno;
	}
	public void setCno(String cno) {
		this.cno = cno;
	}
	public String getTpcd() {
		return tpcd;
	}
	public void setTpcd(String tpcd) {
		this.tpcd = tpcd;
	}
	public String getFcno() {
		return fcno;
	}
	public void setFcno(String fcno) {
		this.fcno = fcno;
	}
	public String getCnm() {
		return cnm;
	}
	public void setCnm(String cnm) {
		this.cnm = cnm;
	}
	public String getFpnm() {
		return fpnm;
	}
	public void setFpnm(String fpnm) {
		this.fpnm = fpnm;
	}
	public Date getSgtm() {
		return sgtm;
	}
	public void setSgtm(Date sgtm) {
		this.sgtm = sgtm;
	}
	public Double getAmt() {
		return amt;
	}
	public void setAmt(Double amt) {
		this.amt = amt;
	}
	public String getAdcd() {
		return adcd;
	}
	public void setAdcd(String adcd) {
		this.adcd = adcd;
	}
	public String getPaytm() {
		return paytm;
	}
	public void setPaytm(String paytm) {
		this.paytm = paytm;
	}
	public String getFaddr() {
		return faddr;
	}
	public void setFaddr(String faddr) {
		this.faddr = faddr;
	}
	public String getLaddr() {
		return laddr;
	}
	public void setLaddr(String laddr) {
		this.laddr = laddr;
	}
	public Addv getAddv() {
		return addv;
	}
	public void setAddv(Addv addv) {
		this.addv = addv;
	}
	public ConType getConType() {
		return conType;
	}
	public void setConType(ConType conType) {
		this.conType = conType;
	}
	public List<ConApprove> getConApprove() {
		return conApprove;
	}
	public void setConApprove(List<ConApprove> conApprove) {
		this.conApprove = conApprove;
	}
	public List<ConAppendix> getConAppendix() {
		return conAppendix;
	}
	public void setConAppendix(List<ConAppendix> conAppendix) {
		this.conAppendix = conAppendix;
	}
	
	
	
}
