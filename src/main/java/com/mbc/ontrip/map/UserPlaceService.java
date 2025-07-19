package com.mbc.ontrip.map;

import java.util.List;

public interface UserPlaceService {

	void insertPlace(UserPlaceDTO dto);

	void updatePlaceOrder(String userid, String placename, int placeorder);

	List<UserPlaceDTO> getPlacesByUser(String userid);

}
