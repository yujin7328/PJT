package com.model2.mvc.service.product;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductDAO {
	
	public void insertProduct(Product proudct) throws Exception;

	public Product findProduct(int prodNo) throws Exception;

	public Map<String, Object> getProductList(Search searchVO) throws Exception;

	public void updateProduct(Product productVO) throws Exception;
	
}
