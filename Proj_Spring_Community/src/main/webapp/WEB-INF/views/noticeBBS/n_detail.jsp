<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!--   errorPage="/err/errorProc.jsp" -->

<c:set var="uId_Session" value="${sessionScope.uId_Session }"/>

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
	<script src="/resources/script/script_Notice.js"></script>
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
									<c:if test="${uId_Session==detail.uId}">
										<button type="button" id="delBtn">삭 제</button>
										<button type="button" id="modBtn">수 정</button>
									</c:if>
								</c:if>
							</td>
						</tr>
					</tfoot>
					 
				</table>
				<input type="hidden" name="nowPage" value="${nowPage}" id="nowPage">
				<input type="hidden" name="num" value="${detail.num}" id="num">
				
				<!-- 검색어전송 시작 -->
				<input type="hidden" id="pKeyField" value="${keyField}">
				<input type="hidden" id="pKeyWord" value="${keyWord}">
				<!-- 검색어전송 끝 -->
				<c:if test="${!empty list}">
					<table id="replyList">
						<thead>
							<tr>
								<th>이름</th>
								<th>제목</th>
								<th>날짜</th>
								<th>조회수</th>
							</tr>
							<tr>
								<td colspan="5" class="spaceTd"></td>
							</tr>
						</thead>
						<tbody>
							
							<c:forEach var="reply" items="${list }">
								
									<tr class="prnTr">
										<td>${reply.uName }</td>
										<td class="contentTd">
											${reply.content }
										</td>
										<td><fmt:parseDate value="${reply.regTM}"
												pattern="yyyy-MM-dd'T'HH:mm" var="parsedRegTm" type="both" />
											<fmt:formatDate value="${parsedRegTm}" pattern="yyyy-MM-dd" />
										</td>
									</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
				<!--  게시글 상세보기 페이지 내용 출력 끝 -->
				<br>
				<form name="replyFrm"  method="post" id="replyFrm" action="/noticeBBS/n_reply">		
					<table id="replyTbl">
						<tbody id="replyTblbody">
							<tr >
								<td id="replyUName">
									${uName }(${uId_Session})
									<input type="hidden" name="uName" id="uName" value="${uName}">
									<input type="hidden" name="uId" id="uId" value="${uId_Session}">
									<input type="hidden" name="num" id="num" value="${detail.num}" >
								</td>
							</tr>
							<tr>
								<td id="replyContent">
									<textarea name="content" id="content" cols="60" wrap="hard" placeholder="댓글을 남겨보세요"></textarea>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2" id="replyButton">
									<button type="submit" id="replyBtn">등록</button>
								</td>
							</tr>
						</tfoot>
					</table>
					<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
					    <!--  
					    IP주소를 IPv4 형식으로 설정함.(IPv6 형식이 기본으로 설정되어 있음)
					    프로젝트 => Run Configuration => Tomcat 클릭
					    => (x)Argument => VM arguments 입력란 =>
					    -Djava.net.preferIPv4Stack=true  
					     -->							
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