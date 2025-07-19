package com.mbc.ontrip.hotel;

public class HotelPageDTO {
    private int nowPage;
    private int cntPerPage;
    private int total;
    private int start;
    private int lastPage;
    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;


    public HotelPageDTO(int nowPage, int total, int cntPerPage) {
        this.nowPage = nowPage;
        this.total = total;
        this.cntPerPage = cntPerPage;
        this.start = (nowPage - 1) * cntPerPage;
        this.lastPage = (int) Math.ceil((double) total / cntPerPage);
        int pageGroup = (int) Math.ceil((double) nowPage / 10);
        this.endPage = pageGroup * 10;
        this.startPage = endPage - 9;

        if (endPage > lastPage) this.endPage = lastPage;

        this.prev = startPage > 1;
        this.next = endPage < lastPage;

    }

    public int getNowPage() { return nowPage; }
    public int getCntPerPage() { return cntPerPage; }
    public int getStart() { return start; }
    public int getLastPage() { return lastPage; }

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public void setCntPerPage(int cntPerPage) {
		this.cntPerPage = cntPerPage;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
    
    
}

