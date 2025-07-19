package com.mbc.ontrip.country;

import java.time.LocalDate;
import java.util.ArrayList;

public interface CountryService {

	void csave(String country, String tripname, String tripimg, String lat, String llong, String address, String tripstyle,
			int branch, String tripdetail);

	ArrayList<CountryDTO> out(CountryPageDTO dto);

	CountryDTO cdetail(int countrynum);

	CountryDTO cupdateview(int countrynum);

	void cupdate(String country, String tripname, String lat, String llong, String address, String tripstyle,
			int branch, String tripdetail, int countrynum);

	void cupdatesave(int countrynum, String tripname, String tripimg, String lat, String llong, String address,
			String tripstyle, String tripstyle2, int branch, String tripdetail);

	ArrayList<CountryDTO> consearch(CountryPageDTO dto);

	ArrayList<CountryDTO> mainsearch(String mainsearch);

	ArrayList<CountryDTO> countryser(String tripstyle, CountryPageDTO dto);

	ArrayList<CountryDTO> month(int month);

	void like(String id, int countrynum);

	void dellike(String id, int countrynum);

	int isLiked(String id, int countrynum);

	int countrytotal();

	int countrysearchtotal(String search);

	int countrysertotal(String tripstyle);

	int branchtotal(int branch);

	ArrayList<CountryDTO> branchser(int branch, CountryPageDTO dto);

	int conliketotal();

	ArrayList<CountryDTO> likeCountry(CountryPageDTO dto);

	int contotal(String con);

	ArrayList<CountryDTO> con(String con, CountryPageDTO dto);

	void condel(int countrynum);




}
