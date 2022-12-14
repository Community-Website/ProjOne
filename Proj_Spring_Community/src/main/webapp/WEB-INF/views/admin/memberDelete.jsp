<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="uId_Session" value="${sessionScope.uId_Session }"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>회원탈퇴</title>
	<link rel="stylesheet" href="/resources/style/style_Admin.css">
	<link rel="stylesheet" href="/resources/style/style_Template.css">
	<link rel="stylesheet" href="/resources/source/style_Reset.css">
	<script src="/resources/source/jquery-3.6.0.min.js"></script>
	<script src="/resources/script/script.js"></script>
</head>

<body>
    <div id="wrap">
    	
    	<!--  헤더템플릿 시작 -->
		<%@ include file="../ind/headerTmp.jsp" %>
    	<!--  헤더템플릿 끝 -->    	
    	
    	
    	<main id="main" class="dFlex">	
    		
	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents" class="memQuitDiv">

				<form name="memQuitFrm" id="memQuitFrm" method="post" action="/admin/memberDelete">
					<input type="hidden" name="uId" id="uId" maxlength="20" value="${sessionScope.uId_Session}">
					<input type="hidden" name="num" id="num" maxlength="20" value="${param.num}">
					<h1>회원탈퇴</h1>
					<p>관리자 비밀번호를 입력하세요</p>
					<input type ="password" name="uPw" id="uPw" class="uPw"><br>				
					<button type="submit" id="memQuitBtn">회원 삭제</button>
				</form>

    		</div>
    		<!-- 실제 작업 영역 끝 -->
    		    	
    	</main>
    	<!--  main#main  -->
    
        	   	
    	<!--  푸터템플릿 시작 -->
		<%@ include file="../ind/footerTmp.jsp" %>
    	<!--  푸터템플릿 끝 -->  
        
    </div>
    <!-- div#wrap -->

</body>

</html>