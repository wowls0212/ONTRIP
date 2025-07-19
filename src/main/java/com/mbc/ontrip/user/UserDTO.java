package com.mbc.ontrip.user;

public class UserDTO {
	int usernumber;
	String id, pw, phone, email,birth;
	String tripstyle, admin;
	int age;
	public UserDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getUsernumber() {
		return usernumber;
	}
	public void setUsernumber(int usernumber) {
		this.usernumber = usernumber;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getTripstyle() {
		return tripstyle;
	}
	public void setTripstyle(String tripstyle) {
		this.tripstyle = tripstyle;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	
	
}
