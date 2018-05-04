package com.model2.mvc.web.product;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

//==> 회원관리 Controller
@Controller
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
/*	==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	==> 아래의 두개를 주석을 풀어 의미를 확인 할것*/
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping("/addProduct.do")
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {
		//			product.setProTranCode("0");
		productService.addProduct(product);
		return "forward:/product/getProduct.jsp";
		}
			
	@RequestMapping("/getProduct.do")
	public String getProduct( @RequestParam("menu") String menu, @RequestParam("prodNo") String prodNo, Model model ) throws Exception {
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		model.addAttribute("product", product);
		if(menu.equals("manage")) {
			return "forward:/product/updateProduct.jsp";
			}
			else {		
			return "forward:/product/getProductDetail.jsp";
			}
	}
		
	@RequestMapping("/updateProduct.do")
	public String updateProduct( @ModelAttribute("product") Product product, Model model) throws Exception{
		productService.updateProduct(product);
		return "forward:/product/getProductDetail.jsp?menu=ok";
	}
	
	@RequestMapping("/listProduct.do")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	

}