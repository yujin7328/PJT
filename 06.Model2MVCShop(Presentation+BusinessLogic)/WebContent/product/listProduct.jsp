<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">

function fncGetList(currentPage){
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();		
}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/listProduct.do" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
			
		 	<c:if test = "${param.menu =='manage'}"> 
							상품 관리
			<input type="hidden" name="menu" value="manage"/></c:if>
			<c:if test = "${param.menu =='search'}"> 
				상품 목록조회 
			<input type="hidden" name="menu" value="search"/></c:if>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			
			<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }> 상품번호</option>
			<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : ""}> 상품명</option>
			<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }> 상품가격</option>
			
	</select>
	<input type="text" value ="${! empty search.searchKeyword ? search.searchKeyword : ""}" name="searchKeyword"
	class = "ct_input_g" style="width:200px; height:19px" />
	
	</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetList('1');">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" > 전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
		

	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
	<c:set var="i" value="${ i+1 }" />
	
	<tr class>
		<td align="center">${ i }</td>
		<td></td>
	
		
		<c:choose>
			<c:when test = "${(user!=null && user.role=='admin') || product.proTranCode ==null}"> 
			<td align="left"><a href="/getProduct.do?prodNo=${product.prodNo}&menu=${menu}">
			${product.prodName}</a></td> </c:when>
			<c:when test = "${! empty product.proTranCode}">
	<td align="left"><a href="/getProduct.do?prodNo=${product.prodNo}&menu=${menu}">${product.prodName}</td></c:when>		
				
		</c:choose>	
				
		<td></td>
		<td align="left">${product.price}</td>
		<td></td>
		<td align="left">${product.regDate}</td>
		<td></td>
		<td align="left">
				
				
	<!-- 판매중/재고없음/구매완료 -->			
		<c:choose>		
			<c:when test = "${product.proTranCode.trim() ==null}"> 판매중 </c:when> 
			<c:when test = "${product.proTranCode.trim() >0 && (user==null || user.role=='user')}"> 재고없음 </c:when> 	
			<c:when test = "${product.proTranCode.trim() ==1}">구매완료
			<a href="/updateTranCodeByProd.do?prodNo=${product.prodNo}&proTranCode=2">배송하기</a>
			 </c:when>
			<c:when test = "${product.proTranCode.trim() ==2}">배송중 </c:when>
			<c:when test = "${product.proTranCode.trim() ==3}">배송완료 </c:when>
			
		</c:choose>
			
			
	
			</c:forEach>
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	

</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>

		
			<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->

</form>

</div>

</body>
</html>
