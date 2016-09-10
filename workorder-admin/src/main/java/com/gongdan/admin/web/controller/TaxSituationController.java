package com.gongdan.admin.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("taxsituation")
public class TaxSituationController {

	
	public String toAdd(){
		
		
		return "tax/add";
	}
	
	public String add(HttpServletRequest request,String title){
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
		return "tax/add";
	}
}
