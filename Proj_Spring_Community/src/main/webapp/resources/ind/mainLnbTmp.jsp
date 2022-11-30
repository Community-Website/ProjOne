<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="uId_Session_MLTmp" value="${sessionScope.uId_Session }"/>
	<c:set var="gnbParam" value=""/>
<c:if test="${!empty param.gnbParam }">
	<c:set var="gnbParam" value="${param.gnbParam }"/>
</c:if>  

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인영역 LNB 메뉴</title>
</head>
<body>

	<nav id="mainLNB">
		<ul id="lnbMainMenu">
			<c:if test="${empty  uId_Session_MLTmp}">
				<li class="lnbMainLi"><a href="#">menu1</a></li>
				<li class="lnbMainLi"><a href="#">menu2</a></li>
				<li class="lnbMainLi"><a href="#">menu3</a></li>
				<li class="lnbMainLi"><a href="#">menu4</a></li>
				<li class="lnbMainLi"><a href="#">menu5</a></li>		
			</c:if>
			<c:if test="${!empty  uId_Session_MLTmp}">
				<c:if test="${gnbParam eq 'myPage' }">
				<li class="lnbMainLi"><a href="/member/memberMod?uId=${uId_Session_MLTmp}">회원정보수정</a></li>
					<li class="lnbMainLi"><a href="/member/memberQuit">회원탈퇴</a></li>
					<li class="lnbMainLi"><a href="#">menu3</a></li>
					<li class="lnbMainLi"><a href="#">menu4</a></li>
					<li class="lnbMainLi"><a href="#">menu5</a></li>
				</c:if>
				<c:if test="${gnbParam ne 'myPage' }">
				<li class="lnbMainLi"><a href="#">menu1</a></li>
					<li class="lnbMainLi"><a href="#">menu2</a></li>
					<li class="lnbMainLi"><a href="#">menu3</a></li>
					<li class="lnbMainLi"><a href="#">menu4</a></li>
					<li class="lnbMainLi"><a href="#">menu5</a></li>
				</c:if>
			</c:if>		
		</ul>
	</nav>	
</body>
</html>