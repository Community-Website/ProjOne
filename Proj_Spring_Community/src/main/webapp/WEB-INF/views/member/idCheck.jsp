<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 중복 체크</title>
    <link rel="stylesheet" href="/resources/style/style_Common.css">
    <link rel="stylesheet" href="/resources/source/style_Reset.css">    
    <script src="/resources/source/jquery-3.6.0.min.js"></script>
    <script src="/resources/script/script_Join.js"></script>
</head>

<body>
    <div id="wrap_Popup">
    	<div>
    		<h1>${param.uId }</h1>
    	
    		<span>
    			<c:set var="result" value="${idCheck}"/>
    			<c:choose>
					<c:when test="${result==true }">
						<c:set var="btnCap" value="ID 재입력"/>
						<span>는 존재하는 ID 입니다.</span>
					</c:when>
					<c:otherwise>
						<c:set var="btnCap" value="사용하기"/>
						<span>는 사용가능합니다.</span>
					</c:otherwise>
				</c:choose>	
	    	</span>
    	
    	</div>
    	<hr>
    	<div id="closeBtnArea">
    		<button type="button">${btnCap }</button>
    	</div>
    	
    	        
    </div>
    <!-- div#wrap -->

</body>

</html>






