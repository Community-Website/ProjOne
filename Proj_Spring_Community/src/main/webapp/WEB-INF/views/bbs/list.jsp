<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String uId_Session = (String)session.getAttribute("uId_Session"); 
%> 
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<link rel="stylesheet" href="/resources/style/style_Common.css">
	<link rel="stylesheet" href="/resources/style/style_Template.css">
	<link rel="stylesheet" href="/resources/style/style_BBS.css">
	<link rel="stylesheet" href="/resources/source/style_Reset.css">
	<script src="/resources/source/jquery-3.6.0.min.js"></script>
	<script src="/resources/script/script_BBS.js"></script>
</head>

<body>
    <div id="wrap">    	
    	<!--  헤더템플릿 시작 -->
		<%@ include file="../ind/headerTmp.jsp" %>
    	<!--  헤더템플릿 끝 -->    	
    	
    	<main id="main" class="dFlex">   	
    		<div id="lnb">
	    		<!--  메인 LNB 템플릿 시작 -->
				<%@ include file="../ind/mainLnbTmp.jsp" %>
	    		<!--  메인 LNB 템플릿 끝 -->    	
    		</div>
    		   		
	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents" class="bbsList">
    		
    		<%-- <c:set var="prnType" value=" "/>
    		<c:if test="${empty param.keyWord }">
    			<c:set var="prnType" value= "전체 게시글"/>
    		</c:if>
    		<c:if test="${!empty param.keyWord }">
    			<c:set var="prnType" value= "검색 결과"/>
    		</c:if>	
	    		<div id="pageInfo" class="dFlex">
					<span>prnType :  ${pagingInfo.totalRecord} 개</span>
					<span>페이지 : ${pagingInfo.currentpage}  / ${paging.totalPage}</span>  			
				</div>			 --%>			
			<table id="boardList">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>이름</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>		
					<tr>
						<td colspan="5" class="spaceTd"></td>
					</tr>		
				</thead>
				<tbody>
			<c:if test="${empty list}">
				<tr>
					<td colspan="5">게시물이 없습니다.</td>
				</tr>			
			</c:if>
			<c:if test="${!empty list}">
				<c:forEach var="i" begin="1" end="${list.size()}">			
					<c:set var="board" value="${list[i]}" />		
					<tr>	
						<td>${board.num }</td>
						<td>${board.subject }</td>
						<td>${board.uName }</td>
						<td>
							<fmt:parseDate  value="${board.regTM}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedRegTm" type="both" />
							<fmt:formatDate value="${parsedRegTm}" pattern="yyyy-MM-dd"/>
						</td>
						<td>${board.readCnt}</td>
					</tr>	
				</c:forEach>
			</c:if>	
					<tr id="listBtnArea">
						<td colspan="2">
						<c:if test="${empty uId_Session}">
							<button type="button" id="loginAlertBtn" class="listBtnStyle">글쓰기</button>			
						</c:if>
						<c:if test="${!empty uId_Session}"></c:if>
							<button type="button" id="writeBtn" class="listBtnStyle">글쓰기</button>
						</td>
						
						<td colspan="3">
						
							<form name="searchFrm" class="dFlex"
									id="searchFrm">						
								<div>
									<select name="keyField" id="keyField">
										<option value="subject" 
											<c:if test="${param.keyField=='subject'}">
												selected = "selected"
											</c:if>
										>제  목</option>
										<option value="uName" 
											<c:if test="${param.keyField=='uName'}">
												selected = "selected"
											</c:if>	
										>이  름</option>
										<option value="content" 
											<c:if test="${param.keyField=='content'}">
												selected = "selected"
											</c:if>	
										>내  용</option>
									</select>
								</div>
								<div>
									<input type="text" name="keyWord" id="keyWord"
									  id="keyWord" size="20" maxlength="30" value="${param.keyWord}">
								</div>
								<div>
									<button type="button" id="searchBtn" class="listBtnStyle">검색</button>
								</div>
															
							</form>
							
							<!-- 검색결과 유지용 매개변수 데이터시작 -->
							<input type="hidden" id="pKeyField" value="${param.keyField}">
							<input type="hidden" id="pKeyWord" value="${param.KeyWord}">
							<!-- 검색결과 유지용 매개변수 데이터끝 -->
						
						</td>
					</tr>  <!-- tr#listBtnArea -->
					
					<tr id="listPagingArea">
						
					<!-- 페이징(= 페이지 나누기) 시작 -->
						<td colspan="5" id="pagingTd">
					
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