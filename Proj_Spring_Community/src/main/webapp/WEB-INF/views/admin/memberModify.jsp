<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="uId_Session" value="${sessionScope.uId_Session }"/>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보 수정</title>
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
			<div id="contents" class="joinInsert">

				<form name="regFrm" id="regFrm" method="post" action="/admin/memberModify">
					<input type="hidden" name="num" id="num" maxlength="20" value="${mem.num }">
					<table id="regFrmTbl">
						<caption>회원 정보 수정</caption>
						<tbody>
							<tr>
								<td class="req">아이디</td>
								<td>${mem.uId }</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td class="req">이름</td>
								<td><input type="text" name="uName" id="uName"
									maxlength="20" value="${mem.uName }" readonly></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<c:set var="uEmail_02" value="${fn:split(mem.uEmail,'@')[1]}" />
								<td class="req">Email</td>
								<td><input type="text" id="uEmail_01" maxlength="20"
									size="7" value="${fn:split(mem.uEmail,'@')[0]}"> <span>@</span>
									<input type="text" id="uEmail_02" maxlength="40" size="10" value="${uEmail_02 }">

									<select id="emailDomain" class="frmDropMenu">
										
										<option value=""
											<c:if test="${uEmail_02 !='naver.com' and uEmail_02 !='daum.net' }">selected="selected"</c:if>
										>직접입력</option>
										<option 
											<c:if test="${uEmail_02 =='naver.com' }">selected="selected"</c:if>
										>naver.com</option>
										<option
											<c:if test="${uEmail_02 =='daum.net' }">selected="selected"</c:if>
										>daum.net</option>
								</select>

									<button type="button" id="emailAuthBtn" class="frmBtn">인증코드받기</button>

									<!--  이메일 인증 영역 시작 : Authentication Code 인증코드-->
									<div id="emailAuthArea">
										<span>인증코드 입력</span> <input type="text" id="emailAuth"
											size="25">
										<button type="button" class="frmBtn">인증하기</button>
									</div> <!-- div#emailAuthArea --> 
									<input type="hidden" name="uEmail" id="uEmail"></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>성별</td>
								<td>
									<label> 남 <input type="radio" name="gender"value="1" 
										<c:if test="${mem.gender ==1 }">checked="checked"</c:if>
									></label> 
									<label> 여 <input type="radio" name="gender" value="2"
										<c:if test="${mem.gender ==2 }">checked="checked"</c:if>
									></label>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>생년월일</td>
								<td><input type="text" name="uBirthday" id="uBirthday"
									maxlength="6" size="8" value="${mem.uBirthday }">&nbsp;&nbsp;&nbsp;&nbsp; <span>ex.
										830815</span></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>우편번호</td>
								<td><input type="text" name="uZipcode" id="uZipcode"
									maxlength="7" size="7" readonly value="${mem.uZipcode }">
									<button type="button" id="findZipBtn" class="frmBtn">우편번호찾기</button>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>주소</td>
								<td>
									<input type="text" name="uAddr" id="uAddr" maxlength="100" size="50" value="${mem.uAddr }">
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>취미</td>
								<td>
									<label> 인터넷 <input type="checkbox" name="uHobby" value="인터넷 " 
										<c:if test="${fn:substring(mem.uHobby,0,1) eq'1'}">
										    checked="checked"
										</c:if>
									></label> 
									<label> 여행 <input type="checkbox" name="uHobby"value="여행" 
										<c:if test="${fn:substring(mem.uHobby,1,2) eq '1'}">
										    checked="checked"
										</c:if>
									></label> 
									<label> 게임 <input type="checkbox" name="uHobby"value="게임"
										<c:if test="${fn:substring(mem.uHobby,2,3) eq '1'}">
										    checked="checked"
										</c:if>
									></label> 
									<label> 영화 <input type="checkbox" name="uHobby"value="영화"
										<c:if test="${fn:substring(mem.uHobby,3,4) eq '1'}">
										    checked="checked"
										</c:if>
									></label> 
									<label> 운동 <input type="checkbox" name="uHobby"value="운동"
										<c:if test="${fn:substring(mem.uHobby,4,5) eq '1'}">
										    checked="checked"
										</c:if>
									></label> 
								</td>
								<td></td>
							</tr>
							<tr>
								<td>직업</td>
								<td><select name="uJob" id="uJob" class="frmDropMenu">
										<option value="">- 선택 -</option>
										<option
											<c:if test="${mem.uJob =='교수' }">selected="selected"</c:if>
										>교수</option>
										<option
											<c:if test="${mem.uJob =='학생' }">selected="selected"</c:if>
										>학생</option>
										<option
											<c:if test="${mem.uJob =='회사원' }">selected="selected"</c:if>
										>회사원</option>
										<option
											<c:if test="${mem.uJob =='공무원' }">selected="selected"</c:if>
										>공무원</option>
										<option
											<c:if test="${mem.uJob =='자영업' }">selected="selected"</c:if>
										>자영업</option>
										<option
											<c:if test="${mem.uJob =='전문직' }">selected="selected"</c:if>
										>전문직</option>
										<option
											<c:if test="${mem.uJob =='주부' }">selected="selected"</c:if>
										>주부</option>
										<option
											<c:if test="${mem.uJob =='무직' }">selected="selected"</c:if>
										>무직</option>
								</select></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="3">
									<button type="reset" class="frmBtn">다시쓰기</button>
									<button type="button" id="modSbmBtn" class="frmBtn">회원정보수정</button>
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