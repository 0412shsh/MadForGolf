package com.madforgolf.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.madforgolf.domain.ProductSellerVO;
import com.madforgolf.service.ProductSellerService;
import com.madforgolf.utils.PageMaker;

@Controller
@RequestMapping("/product/*")
public class ProductSellerController {

	private static final Logger log = LoggerFactory.getLogger(ProductSellerController.class);

	@Autowired
	private ProductSellerService productSellerService;

	@RequestMapping(value="/seller", method = RequestMethod.GET)
	public String sellerView(@RequestParam("prod_num") Integer prodNum, ProductSellerVO productSellerVO, Model model)
			throws Exception {
		
		productSellerVO.setProd_num(prodNum);
		ProductSellerVO sellerInfo = productSellerService.selectSellerInfo(productSellerVO);
		String number = sellerInfo.getUser_phone();
		//String hide_number = number.substring(0, 4) + "**" + number.substring(7, 8) + "**";
		String hide_number = number.substring(0, number.length()-4)+"****";
				
		model.addAttribute("hide_number", hide_number);
		
		model.addAttribute("sellerInfo", sellerInfo);
		return "/product_seller/seller_view";
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value="/sellerProductList", method = RequestMethod.GET, produces = "text/html;charset=utf-8")
	public ResponseEntity<?> sellerProductList( @RequestParam String sellerId , PageMaker pageMaker,  Model model) throws Exception {
		
		System.out.println(" seller Id  : "+ sellerId);
		Map<String ,Object> map=new HashMap<String, Object>();
		map.put("seller_id", sellerId);		
		pageMaker.setPerPageNum(3);

		
		int totalCnt=productSellerService.sellerProductTotlaCount(map);
		pageMaker.setTotalCount(totalCnt);
		
		map.put("pageStart", pageMaker.getPageStart());	
		map.put("perPageNum", pageMaker.getPerPageNum());			
		List<ProductSellerVO> sellerProductList = productSellerService.sellerProductList(map);
		
		
		//LinkedHashMap 입력된 순서대로 출력
		//json 반환처리 참조 주소
		//ex) http://localhost:8080/product/sellerProductList?sellerId=itwill01
		
		Map<String, Object> resultMap=new LinkedHashMap<String, Object>();
		resultMap.put("code", "success");
		resultMap.put("totalCnt", totalCnt);
		resultMap.put("pageMaker", pageMaker);	
		resultMap.put("sellerProductList", sellerProductList);	

		
		return new ResponseEntity(new ObjectMapper().writeValueAsString(resultMap) , HttpStatus.OK);		
	}
	
	
	

}
