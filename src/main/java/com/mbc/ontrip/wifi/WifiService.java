package com.mbc.ontrip.wifi;

import java.util.ArrayList;

public interface WifiService {

	void wifiin(String wifiname, String image, String wifidetail, String wifilink, String wificountry, int wifiday);

	ArrayList<WIfiDTO> wifiout(WifiPageDTO pdto);

	void wifidel(int wifinum);

	WIfiDTO wifiupdateview(int wifinum);

	void wifiup(int wifinum, String wifiname, String wifidetail, String wifilink, String wificountry, int wifiday,
			String image);

	ArrayList<WIfiDTO> search(String wificountry, int wifiday, WifiPageDTO dto);

	ArrayList<WIfiDTO> mainsearch(String mainsearch);

	int wifiisLiked(String id, int wifinum);

	void wlike(String id, int wifinum);

	void wdellike(String id, int wifinum);

	int wifitotal();

	ArrayList<WIfiDTO> wificountry(String country, WifiPageDTO dto);

	int wifisertotal(String country);

	int wifisearchtotal(String wificountry, int wifiday);

	ArrayList<Integer> getLikedWifiNums(String userId);




}
