<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="res" value="${sessionScope.res }"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>헤더템플릿</title>
</head>
<body>

    	<header id="header" class="dFlex"> 	<!-- 로고, GNB -->
    		<div id="headerLogo">
    			<a href="/">
    				<img src="/resources/images/headerLogo.png" alt="헤더로고이미지">
    			</a>
    		</div>
    		<nav id="gnb">
    		
    			<ul id="mainMenu" class="dFlex">
    			<c:choose>
    				<c:when test="${empty sessionScope.uId_Session }">
    					<li class="mainLi"><a href="/">HOME</a></li>
	    				<li>|</li>
	    				<li class="mainLi"><a href="/member/login">로그인</a></li>
	    				<li>|</li>
	    				<li class="mainLi"><a href="/member/joinAgreement">회원가입</a></li>
	    				<li>|</li>
	    				<li class="mainLi"><a href="/bbs/list">게시판</a></li>
    				</c:when>
    				<c:when test="${res eq 'admin' }">
    					<li class="mainLi"><a href="/">HOME</a></li>
	    				<li>|</li>
	    				<li class="mainLi"><a href="/member/logout">로그아웃</a></li>
	    				<li>|</li>
	    				<li class="mainLi"><a href="/member/myPage?gnbParam=adminPage" style="width: 102px;">관리자페이지</a></li>
	    				<li>|</li>
	    				<li class="mainLi"><a href="/noticeBBS/n_list">공지사항</a></li>
    				</c:when>
    				<c:otherwise>
	    				<li class="mainLi"><a href="/">HOME</a></li>
	    				<li>|</li>
	    				<li class="mainLi"><a href="/member/logout">로그아웃</a></li>
	    				<li>|</li>
	    				<li class="mainLi"><a href="/member/myPage?gnbParam=myPage">마이페이지</a></li>
	    				<li>|</li>
	    				<li class="mainLi"><a href="/bbs/list">게시판</a></li>
    				</c:otherwise>
    			</c:choose>
    			</ul>    			
    		</nav>
    	</header>
    	<!--  header#header  -->
    	<hr class="sepLine">
    	
</body>
</html>