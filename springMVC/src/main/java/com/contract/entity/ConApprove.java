package com.contract.entity;

import java.util.Date;

/**
 * 合同审批
 * @author ZhangZY
 *
 */
public class ConApprove {
	
	private String cno;		// 合同编号
	private String uid;		// 用户id
	private String content;		// 审批内容
	private String result;		// 审批结果
	private Date apvtm;		//审批时间
	private String flag;  //审批标志位，打回审批时生效
	private String operation; //记录送给谁审批
	private String touid; //给谁审批
	public String getCno() {
		return cno;
	}
	public void setCno(String cno) {
		this.cno = cno;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	
	public Date getApvtm() {
		return apvtm;
	}
	public void setApvtm(Date apvtm) {
		this.apvtm = apvtm;
	}
	
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
	
	public String getTouid() {
		return touid;
	}
	public void setTouid(String touid) {
		this.touid = touid;
	}
	@Override
	public String toString() {
		return "ConApprove [cno=" + cno + ", uid=" + uid + ", content=" + content + ", result=" + result + "]";
	}
	
	
}
