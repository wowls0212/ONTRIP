package com.mbc.ontrip.pack;

import java.util.ArrayList;

public interface PackService {

	void ps(String packagename, String packageimg, String packagedetail, String packagelink, String packagecountry,
			int packageday);

	ArrayList<PackDTO> packout(PackPageDTO pdto);

	void psd(int packnum);

	PackDTO pss(int packnum);

	void ps2(String packagename, String packageimg, String packagedetail, String packagelink, String packagecountry,
			int packageday, int packnum);

	ArrayList<PackDTO> serch(String packcountry, int packday, PackPageDTO dto);

	ArrayList<PackDTO> mainsearch(String mainsearch);


	void palike(String id, int packagenum);

	void padellike(String id, int packagenum);

	int packisLiked(String id, int packagenum);

	int packtotal();

	int packsertotal(String country);

	ArrayList<PackDTO> packcountry(String country, PackPageDTO dto);

	int packsearchtotal(String packcountry, int packday);

}
