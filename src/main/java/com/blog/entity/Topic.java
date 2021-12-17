package com.blog.entity;

 /** 
 * @ClassName: Topic
 * @describe:解析文章所拥有得标签
 */
public class Topic {
	String tocId; //标签id
	String tocName;	//标签名
	Integer tocIndex;//标签索引
	public String getTocId() {
		return tocId;
	}
	public void setTocId(String tocId) {
		this.tocId = tocId;
	}

	public String getTocName() {
		return tocName;
	}
	public void setTocName(String tocName) {
		this.tocName = tocName;
	}
	public Integer getTocIndex() {
		return tocIndex;
	}
	public void setTocIndex(Integer tocIndex) {
		this.tocIndex = tocIndex;
	}
	
}
