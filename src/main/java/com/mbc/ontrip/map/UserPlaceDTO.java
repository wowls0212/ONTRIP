package com.mbc.ontrip.map;

import java.util.Date;

public class UserPlaceDTO {
	private int usernumber;
	private String userid,placename,address,phone;
	private double lat, lng;
	private Date regdate;
	private int placeorder;
	public UserPlaceDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getUsernumber() {
		return usernumber;
	}
	public void setUsernumber(int usernumber) {
		this.usernumber = usernumber;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPlacename() {
		return placename;
	}
	public void setPlacename(String placename) {
		this.placename = placename;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getPlaceorder() {
		return placeorder;
	}
	public void setPlaceorder(int placeorder) {
		this.placeorder = placeorder;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
}
