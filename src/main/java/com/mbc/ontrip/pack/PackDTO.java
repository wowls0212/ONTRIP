package com.mbc.ontrip.pack;

public class PackDTO {
	int packagenum;
	String packagename, packageimg, packagedetail, packagelink, packagecountry;
	int packageday;
	boolean liked;
	
	
	public PackDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public int getPackagenum() {
		return packagenum;
	}


	public void setPackagenum(int packagenum) {
		this.packagenum = packagenum;
	}


	public String getPackagename() {
		return packagename;
	}


	public void setPackagename(String packagename) {
		this.packagename = packagename;
	}





	public String getPackageimg() {
		return packageimg;
	}


	public void setPackageimg(String packageimg) {
		this.packageimg = packageimg;
	}


	public String getPackagedetail() {
		return packagedetail;
	}


	public void setPackagedetail(String packagedetail) {
		this.packagedetail = packagedetail;
	}


	public String getPackagelink() {
		return packagelink;
	}


	public void setPackagelink(String packagelink) {
		this.packagelink = packagelink;
	}


	public String getPackagecountry() {
		return packagecountry;
	}


	public void setPackagecountry(String packagecountry) {
		this.packagecountry = packagecountry;
	}


	public int getPackageday() {
		return packageday;
	}


	public void setPackageday(int packageday) {
		this.packageday = packageday;
	}


	public boolean isLiked() {
		return liked;
	}


	public void setLiked(boolean liked) {
		this.liked = liked;
	}
	
	

}
