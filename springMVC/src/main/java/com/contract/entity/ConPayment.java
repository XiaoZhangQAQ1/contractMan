package com.contract.entity;

import java.util.Date;

/**
 * 合同收款信息
 * @author ZhangZY
 *
 */
public class ConPayment {

	private String cno;		// 合同编号
	private Date rcvtm;		// 收款时间
	private Double rcvamt;		// 收款金额
	private String rmk;		// 备注
	public String getCno() {
		return cno;
	}
	public void setCno(String cno) {
		this.cno = cno;
	}
	public Date getRcvtm() {
		return rcvtm;
	}
	public void setRcvtm(Date rcvtm) {
		this.rcvtm = rcvtm;
	}
	public Double getRcvamt() {
		return rcvamt;
	}
	public void setRcvamt(Double rcvamt) {
		this.rcvamt = rcvamt;
	}
	public String getRmk() {
		return rmk;
	}
	public void setRmk(String rmk) {
		this.rmk = rmk;
	}
	
	
}
