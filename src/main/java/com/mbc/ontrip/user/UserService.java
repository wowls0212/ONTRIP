package com.mbc.ontrip.user;

import java.util.ArrayList;

import com.mbc.ontrip.country.CountryDTO;

public interface UserService {

	void usersave(String id, String pw, String phone, String email, String birth, String tripstyle, String admin);

	ArrayList<UserDTO> out(UserPageDTO dto);

	UserDTO updateview(String id);

	void update(int usernum, String id, String pw, String phone, String email, String birth, String tripstyle);

	void delete2(String id);

	String pwsearch(String id);

	String getAdminStatus(String id);

	UserDTO mypage(String id);

	String getAdminpw();

	int idcnt(String id);

	ArrayList<UserDTO> usersearch(String id, UserPageDTO dto);

	UserDTO passmatch(String id);

	void newpass(String id, String password);

	UserDTO getuser(int usernum);

	UserDTO matchpw(int usernumber);

	ArrayList<LikeDTO> conlike(String id);

	ArrayList<LikeDTO> wifilike(String id);

	ArrayList<LikeDTO> packlike(String id);

	int usertotal();

	int usersearchtotal(String id);

	UserDTO idgetuser(String id);

	UserDTO tripstyle(String userid);


}
