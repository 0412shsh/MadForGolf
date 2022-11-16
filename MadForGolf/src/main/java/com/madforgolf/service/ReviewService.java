package com.madforgolf.service;

import java.util.List;

import com.madforgolf.domain.MemberVO;
import com.madforgolf.domain.ReviewVO;

public interface ReviewService {

	// 리뷰 스코어 가져오기
	public MemberVO getReviewScore(String user_id) throws Exception;
	
	// 다른 사람이 쓴 리뷰 가져오기
	public List<ReviewVO> gerReviewListAll (String seller_id) throws Exception;
	
	// 페이징 처리
	public Integer getTotalCnt (String seller_id) throws Exception;
	
	// 판매 상품 리뷰 상세 조회
	public ReviewVO reviewSell(Integer prod_num, String user_id) throws Exception;
	
}
