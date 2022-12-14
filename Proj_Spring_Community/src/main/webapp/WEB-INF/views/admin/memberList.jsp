<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="uId_Session" value="${sessionScope.uId_Session }"/>

<c:if test="${empty param.keyWord }">
	<c:set var="keyWord" value=""/>
</c:if>
<c:if test="${!empty param.keyWord }">
	<c:set var="keyWord" value="${param.keyWord }"/>
</c:if>
<c:if test="${empty param.keyField }">
	<c:set var="keyField" value=""/>
</c:if>
<c:if test="${!empty param.keyField }">
	<c:set var="keyField" value="${param.keyField }"/>
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>회원 목록 조회</title>
	<link rel="stylesheet" href="/resources/style/style_Common.css">
	<link rel="stylesheet" href="/resources/style/style_Template.css">
	<link rel="stylesheet" href="/resources/style/style_Admin.css">
	<link rel="stylesheet" href="/resources/source/style_Reset.css">
	<script src="/resources/source/jquery-3.6.0.min.js"></script>
	<script src="/resources/script/script_BBS.js"></script>
	<script src="/resources/script/script_Admin.js"></script>
</head>

<body>
    <div id="wrap">    	
    	<!--  헤더템플릿 시작 -->
		<%@ include file="../ind/headerTmp.jsp" %>
    	<!--  헤더템플릿 끝 -->    	
    	
    	<main id="main" class="dFlex">   	
    		<%-- <div id="lnb">
	    		<!--  메인 LNB 템플릿 시작 -->
				<%@ include file="../ind/mainLnbTmp.jsp" %>
	    		<!--  메인 LNB 템플릿 끝 -->    	
    		</div> --%>
    		   		
	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents" class="memList">
    		
    		<c:set var="prnType" value=" "/>
    		<c:if test="${empty keyWord }">
    			<c:set var="prnType" value= "전체 회원"/>
    		</c:if>
    		<c:if test="${!empty keyWord }">
    			<c:set var="prnType" value= "검색 결과"/>
    		</c:if>	
	    		<div id="pageInfo" class="dFlex">
					<span>${prnType} :  ${pagingInfo.totalRecord} 개</span>
					<span>페이지 : ${nowBlock}  / ${pagingInfo.totalPage}</span>  			
				</div>			
			<table id="memberList">
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>이메일</th>
						<th>가입날짜</th>
					</tr>		
					<tr>
						<td colspan="5" class="spaceTd"></td>
					</tr>		
				</thead>
				<tbody>
			<c:if test="${empty memList}">
				<tr>
					<td colspan="5" style="text-align: center; font-weight: bold; padding: 20px;">
						회원이 없습니다.
					</td>
				</tr>			
			</c:if>
			<c:if test="${!empty memList}">			
				<c:set var="num" value="${pagingInfo.num }"/>				
				<c:set var="curPos" value="${pagingInfo.firstRecordIndex}"/>
				
				<c:forEach var="i" begin="1" end="${pagingInfo.recordCountPerPage}">
					<c:if test="${num>=1 }">
						<c:set var="mem" value="${memList[curPos]}" />		
						<c:set var="curPos" value="${curPos+1 }"/>
						<c:set var="num" value="${num-1 }"/>		  		
						<tr class="prnTr" onclick="memberDetail('${mem.num}', '${nowBlock}')">			
							<td>${mem.num }</td>
							<td class="subjectTd">${mem.uId }</td>
							<td>${mem.uName }</td>
							<td>${mem.uEmail}</td>
							<td>
								<fmt:parseDate  value="${mem.joinTM}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedJoinTM" type="both" />
								<fmt:formatDate value="${parsedJoinTM}" pattern="yyyy-MM-dd"/>
							</td>
						</tr>	
				  	</c:if>			
				</c:forEach>				
			</c:if>			
						<td colspan="5">					
							<form name="searchFrm" class="dFlex" id="searchFrm" >						
								<div>
									<select name="keyField" id="keyField">
										<option value="uName" 
											<c:if test="${keyField=='uName'}">
												selected = "selected"
											</c:if>
										>이  름</option>
										<option value="uId" 
											<c:if test="${keyField=='uId'}">
												selected = "selected"
											</c:if>	
										>아이디</option>
										<option value="uEmail" 
											<c:if test="${keyField=='uEmail'}">
												selected = "selected"
											</c:if>	
										>이메일</option>
									</select>
								</div>
								<div>
									<input type="text" name="keyWord" id="keyWord"
									  id="keyWord" size="20" maxlength="30" value="${keyWord}">
								</div>
								<div>
									<button type="button" id="searchBtn" class="listBtnStyle">검색</button>
								</div>
															
							</form>
							
							<!-- 검색결과 유지용 매개변수 데이터시작 -->
							<input type="hidden" id="pKeyField" value="${keyField}">
							<input type="hidden" id="pKeyWord" value="${keyWord}">
							<!-- 검색결과 유지용 매개변수 데이터끝 -->
						
						</td>
					</tr>  <!-- tr#listBtnArea -->
					
					<tr id="listPagingArea">
						
					<!-- 페이징(= 페이지 나누기) 시작 -->
						<td colspan="5" id="pagingTd">
						<c:set var="pageStart" value="${(nowBlock-1) * pagingInfo.recordCountPerPage +1 }"/>
						<c:set var="pageEnd" value=""/>
						<c:if test="${pagingInfo.totalPage != 0}">
							<c:choose>
								<c:when test="${nowBlock < totalBlock }">
									<c:set var="pageEnd" value="${pagingInfo.pageStart + pagingInfo.recordCountPerPage - 1 }"/>
								</c:when>
								<c:otherwise>							
									<c:set var="pageEnd" value="${pagingInfo.totalPage }"/>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${nowBlock >1 }">
									<span class="moveBlockArea" onclick="moveBlock('${nowBlock -1 }', '${pagingInfo.recordCountPerPage }', 'pb')">
									&lt;
									</span>
								</c:when>
								<c:otherwise>							
									<span class="moveBlockArea" ></span>
								</c:otherwise>
							</c:choose>
							<!-- 페이지 나누기용 페이지 번호 출력 시작  -->
							<c:forEach var="i" begin="${pageStart }" end="${pageEnd }">
								<c:choose>
									<c:when test="${i == pagingInfo.currentPage }">
										<span class="nowPageNum">${i }</span>
									</c:when>
									<c:otherwise>							
										<span class="pageNum" onclick="movePage('${i }')">${i }</span>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:choose>
								<c:when test="${totalBlock > nowBlock }">
									<span  class="moveBlockArea" onclick="moveBlock('${nowBlock +1 }', '${pagingInfo.recordCountPerPage }', 'nb')">&gt;</span>
								</c:when>
								<c:otherwise>							
									<span class="moveBlockArea"></span>
								</c:otherwise>
							</c:choose>
						</c:if>
						</td>
					</tr>
					
				</tbody>
			</table>
		
		
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