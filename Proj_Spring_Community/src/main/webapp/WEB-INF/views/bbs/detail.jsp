<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!--   errorPage="/err/errorProc.jsp" -->

<c:set var="uId_Session" value="${sessionScope.uId_Session }"/>
<c:set var="ulevel" value="${sessionScope.ulevel }"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글내용 보기</title>
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
    		<div id="contents" class="bbsRead">

				<!--  게시글 상세보기 페이지 내용 출력 시작 -->
				<h2>${detail.subject}</h2>
				
				<table id="readTbl">
					<tbody id="readTblBody">
						<tr>
							<td>작성자</td>  <!-- td.req 필수입력 -->
							<td>${detail.uName}</td>
							<td>등록일</td>  <!-- td.req 필수입력 -->
							<td>					
								<fmt:parseDate  value="${detail.regTM}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedRegTm" type="both" />
								<fmt:formatDate value="${parsedRegTm}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
						<tr>
							<td>첨부파일</td> <!-- td.req 필수입력 -->
							<td colspan="3">
								<input type="hidden" name="fileName" value="${detail.fileName}" 
											id="hiddenFname">
								<c:if test="${!empty detail.fileName}">
									<span id="downloadFile">${detail.fileName}</span>							
									(<span>		
										<c:set var="fUnit" value="Bytes"/>						
										<c:if test="${detail.fileSize > 1024}">
											<c:set var="fileSize" value="${detail.fileSize / 1024}" />
											<c:set var="fUnit" value="KBytes"/>
											<fmt:formatNumber value="${fileSize}" pattern=".00"/> ${fUnit}
										</c:if>
										<c:if test="${detail.fileSize <= 1024}">
											<fmt:formatNumber value="${detail.fileSize}" pattern=".00"/> ${fUnit}										
										</c:if>
									</span>)
								</c:if>
								<c:if test="${empty detail.fileName}">
									등록된 파일이 없습니다.
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="4" id="readContentTd"><pre>${detail.content}</pre></td>
						</tr>					
					</tbody>
					 
					<tfoot id="readTblFoot">	
						<tr>
							<td colspan="4" id="footTopSpace"></td>							
						</tr>			     
						<tr>
							<td colspan="4" id="articleInfoTd">
								<span>"조회수 : ${detail.readCnt}"</span>
								<span>(IP :  ${detail.ip})</span>							
							</td>							
						</tr>
						<tr>
							<td colspan="4" id="hrTd"><hr></td>							
						</tr>
						<tr>
							<c:set var="listBtnLabel" value=""/>
							<c:choose>
								<c:when test="${keyWord ne null or keyWord ne ''}">
									<c:set var="listBtnLabel" value="리스트"/>
								</c:when>
								
								<c:otherwise>
									<c:set var="listBtnLabel" value="검색목록"/>
								</c:otherwise>
							</c:choose>
						
							<td colspan="4" id="btnAreaTd" class="read">
								<button type="button" id="listBtn">${listBtnLabel}</button>
								<button type="button" id="replyBtn">답 변</button>
								<c:if test="${!empty uId_Session}">
									<c:if test="${uId_Session==detail.uId || ulevel>0 }">
										<c:if test="${uId_Session==detail.uId || ulevel<3 }">
											<button type="button" id="modBtn">수 정</button>										
										</c:if>
										<c:if test="${uId_Session==detail.uId || ulevel<2 }">
											<button type="button" id="delBtn">삭 제</button>										
										</c:if>										
									</c:if>
								</c:if>
							</td>
						</tr>
					</tfoot>
					 
				</table>
				<input type="hidden" name="nowPage" value="${nowPage}" id="nowPage">
				<input type="hidden" name="num" value="${detail.num}" id="num">
				<input type="hidden" name="ulevel" value="${ulevel}" id="ulevel">
				
				<!-- 검색어전송 시작 -->
				<input type="hidden" id="pKeyField" value="${keyField}">
				<input type="hidden" id="pKeyWord" value="${keyWord}">
				<!-- 검색어전송 끝 -->
			  
				<!--  게시글 상세보기 페이지 내용 출력 끝 -->
				

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