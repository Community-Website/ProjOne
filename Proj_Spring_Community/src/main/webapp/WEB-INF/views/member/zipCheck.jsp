<%@page import="java.util.Map"%>
<%@page import="pack.spring.community.memberModel.ZipcodeBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="memberService" class="pack.spring.community.memberModel.MemberServiceImp"  />   

 <!-- 참조자료형은 미입력 상태에서 null 값이 기본값으로 저장된다. -->
<c:if test="${empty area3 }">
	<c:set var="area3" value=""/>
</c:if>
<c:if test="${!empty area3 }">
	<c:set var="objList" value="${objList}"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>우편번호 찾기</title>
    <link rel="stylesheet" href="/resources/style/style_Common.css">
    <script src="/resources/source/jquery-3.6.0.min.js"></script>
    <script src="/resources/script/script_Join.js"></script>
</head>

<body>
    <div id="wrap_zipcodePopup">    	
    	<h1>우편번호 찾기</h1>    	
    	<form name="zipFrm" id="zipFrm" method="post" action="/member/zipCheck">
    		<table id="zipFrmTbl">
    			<tbody>
    				<tr>
    					<td id="searchInputArea">
    						<span>동 이름 입력</span>
    						<input type="text" name="area3" id="area3">
    						<button type="button" id="addrSearchBtn">검색</button>
    					</td>
    				</tr>
    				<tr>
    					<td><hr></td>
    				</tr>
    				
    				<tr>
    					<td id="zipResArea">
	    					<c:choose>
	    						<c:when test="${area3 eq '' }">
									<span>검색어를 입력해주세요</span>
	    						</c:when>
	    						<c:otherwise>
		    						<span><b>[ ${area3 } ]</b></span> 에 대한 검색결과입니다.
									<table id="zipResTbl">
										<tbody>
											<c:forEach var="list" items="${objList}">
												<tr>
													<td><span>${list.zipcode } ${list.area1 } ${list.area2 } ${list.area3 } ${list.area4 } </span></td>
												</tr>
											</c:forEach>
										</tbody>							
									</table>
	    						</c:otherwise>
	    					</c:choose>	
    					</td>
    				</tr>
    			</tbody>
    		</table>
    	</form>
        
    </div>
    <!-- div#wrap -->

</body>

</html>