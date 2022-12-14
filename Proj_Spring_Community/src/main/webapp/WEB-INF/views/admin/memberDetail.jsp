<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="uId_Session" value="${sessionScope.uId_Session }"/>
<c:set var="res" value="${sessionScope.res }"/>
<c:set var="level" value="${sessionScope.level }"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 상세 조회</title>
<link rel="stylesheet" href="/resources/style/style_Admin.css">
<link rel="stylesheet" href="/resources/style/style_Template.css">
<script src="/resources/source/jquery-3.6.0.min.js"></script>
<script src="/resources/script/script_Admin.js"></script>
</head>

<body>
	<div id="wrap">

		<!--  헤더템플릿 시작 -->
		<%@ include file="../ind/headerTmp.jsp"%>
		<!--  헤더템플릿 끝 -->


		<main id="main" class="dFlex">
			<%-- <div id="lnb">
	    		<!--  메인 LNB 템플릿 시작 -->
				<%@ include file="../ind/mainLnbTmp.jsp" %>
	    		<!--  메인 LNB 템플릿 끝 -->    	
    		</div> --%>
			<!-- 실제 작업 영역 시작 -->
			<div id="contents" class="memDetail">

				<form name="regFrm" id="regFrm" method="post" action="/admin/memberDetail">
					<input type="hidden" name="uId" id="uId" maxlength="20" value="${mem.uId }">
					<table id="regFrmTbl">
						<caption>회원 상세 정보</caption>
						<tbody>
							<tr>
								<td>아이디</td>
								<td>${mem.uId}</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>이름</td>
								<td>${mem.uName}</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>Email</td>
								<td >${mem.uEmail}</td>
								<td>&nbsp;</td>
							<tr>
								<td>성별</td>							
									<c:if test="${mem.gender eq 1}">
										<td>남자</td>
									</c:if>
									<c:if test="${mem.gender eq 2}">
										<td>여자</td>
									</c:if>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>생년월일</td>
								<td>${mem.uBirthday }</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>우편번호</td>
								<td>${mem.uZipcode }</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>주소</td>
								<td>${mem.uAddr }</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>취미</td>
								<td>
									<c:if test="${fn:substring(mem.uHobby,0,1) eq'1'}">
										인터넷
									</c:if>
									<c:if test="${fn:substring(mem.uHobby,1,2) eq'1'}">
										여행
									</c:if>
									<c:if test="${fn:substring(mem.uHobby,2,3) eq'1'}">
										게임 
									</c:if>
									<c:if test="${fn:substring(mem.uHobby,3,4) eq'1'}">
										영화
									</c:if>
									<c:if test="${fn:substring(mem.uHobby,4,5) eq'1'}">
										운동
									</c:if>
								</td>
								<td></td>
							</tr>
							<tr>
								<td>직업</td>
								<td>${mem.uJob}</td>
								<td></td>
							</tr>
							<tr>
								<td colspan="3">
									<c:if test="${level ==1 }">
										<button type="button" id="deleteBtn" class="frmBtn" onclick="memberDelete('${mem.num}')">회원삭제</button>
									</c:if>
									<c:if test="${level < 3 }">
										<button type="button" id="modBtn" class="frmBtn" onclick="memberModify('${mem.num}')">회원수정</button>
									</c:if>
									<button type="button" id="frmBtn" class="frmBtn" onclick="movePage('${param.nowPage}')">회원리스트</button>
								</td>
							</tr>
						</tbody>
					</table>

				</form>
				<!-- form[name=regFrm] -->

			</div>
			<!-- 실제 작업 영역 끝 -->

		</main>
		<!--  main#main  -->


		<!--  푸터템플릿 시작 -->
		<%@ include file="../ind/footerTmp.jsp"%>
		<!--  푸터템플릿 끝 -->

	</div>
	<!-- div#wrap -->

</body>

</html>