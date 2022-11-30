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
    		
    		<c:set var="prnType" value=" "/>
    		<c:if test="${empty param.keyWord }">
    			<c:set var="prnType" value= "전체 게시글"/>
    		</c:if>
    		<c:if test="${!empty param.keyWord }">
    			<c:set var="prnType" value= "검색 결과"/>
    		</c:if>	
	    		<div id="pageInfo" class="dFlex">
					<span>prnType :  ${pagingInfo.totalRecord} 개</span>
					<span>페이지 : ${pagingInfo.currentpage}  / ${paging.totalPage}</span>  
				
				</div>						
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
						<% if (uId_Session == null) { %>
							<button type="button" id="loginAlertBtn" class="listBtnStyle">글쓰기</button>
						<% } else { %>
							<button type="button" id="writeBtn" class="listBtnStyle">글쓰기</button>
						<% } %>
						</td>
						
						<td colspan="3">
						
							<form name="searchFrm" class="dFlex"
									id="searchFrm">
							
								<div>
									<select name="keyField" id="keyField">
										<option value="subject" 
												<% if(keyField.equals("subject")) out.print("selected"); %>>제  목</option>
										<option value="uName" 
												<% if(keyField.equals("uName")) out.print("selected"); %>>이  름</option>
										<option value="content" 
												<% if(keyField.equals("content")) out.print("selected"); %>>내  용</option>
									</select>
								</div>
								<div>
									<input type="text" name="keyWord" id="keyWord"
									  id="keyWord" size="20" maxlength="30" value="<%=keyWord%>">
								</div>
								<div>
									<button type="button" id="searchBtn" class="listBtnStyle">검색</button>
								</div>
															
							</form>
							
							<!-- 검색결과 유지용 매개변수 데이터시작 -->
							<input type="hidden" id="pKeyField" value="<%=keyField%>">
							<input type="hidden" id="pKeyWord" value="<%=keyWord%>">
							<!-- 검색결과 유지용 매개변수 데이터끝 -->
						
						</td>
					</tr>  <!-- tr#listBtnArea -->
					
					<tr id="listPagingArea">
						
					<!-- 페이징(= 페이지 나누기) 시작 -->
						<td colspan="5" id="pagingTd">
				<%
				int pageStart = (nowBlock - 1 ) * pagePerBlock + 1;
							// 26개 자료기준
							// 현재 기준 numPerPage : 5;    // 페이지당 출력 데이터 수
							//            pagePerBlock : 5;  //  블럭당 페이지 수
							//            nowBlock : 현재블럭
							//            totalBlock : 전체블럭
							//  -------------------------------------------------
							//            totalRecord : 26    totalPage : 6
							// 적용결과  nowBlock : 1  =>   pageStart : 1   pageEnd : 5
							//            nowBlock : 2  =>   pageStart : 6   pageEnd : 6( = totalPage)
							//
				int pageEnd = (nowBlock < totalBlock) ? pageStart + pagePerBlock - 1 :  totalPage;
				//  마지막 블럭이 아니면 pageEnd 값은 pageStart + pagePerBlock - 1 의 값
				//  여기서 pageEnd는 해당 블럭의 마지막 페이지를 의미
				//   즉, 1블럭에서는  pageStart 1  pagePerBlock 10  이므로  pageEnd  는 10
				//   2블럭에서는  pageStart 11  pagePerBlock 10  이므로  pageEnd  는 20
			    //   마지막 블럭(5)에서는 pageStart 41  pagePerBlock 10 을 따지지 않고 totalPage 41이 pageEnd 에 적용됨
			    //   ----------------------------------------------------
				// 3항 연산자(= 조건 연산자) =>    (조건식) ?  true 일 때 결과(A)  :  false 일 때 결과(B);
				// 블럭당 5페이지 출력 =>        pageStart    pageEnd
				//                          1블럭        1                 5
				//                          2블럭        6                 10    		
				// 블럭마다 시작되는 첫 페이지와 마지막 페이지 관련 작업				
				if (totalPage != 0) {   //   전체 페이지가 0이 아니라면 = 게시글이 1개라도 있다면
					// #if01_totalPage   
				%>
					
					<% if (nowBlock>1) { 	   // 페이지 블럭이 2이상이면 => 2개이상의 블럭이 있어야 가능 %>
								<span class="moveBlockArea" onclick="moveBlock('<%=nowBlock-1%>', '<%=pagePerBlock%>', 'pb')">
								&lt;
								</span>
					<% } else { %>
					            <span class="moveBlockArea" ></span>
					<% } %>
				
					<!-- 페이지 나누기용 페이지 번호 출력 시작  -->
					<% 
										             // 2        <     6                     
					             // for (초기식;  조건식;  증감식) {    }
					             // for (     ;  조건식;  증감식) {    }   => 초기식은 조건식의 변수가
					             //      for구문 사용이전에 명시되어 있으므로 그 변수를 활용한다.
						for (int i=pageStart   ; i<=pageEnd; i++) { %>
						
							<% if (i == nowPage) {   // 현재 사용자가 보고 있는 페이지 %>
								<span class="nowPageNum"><%=i %></span>
							<% } else {                              // 현재 사용자가 보고 있지 않은 페이지 %>
							 	<span class="pageNum" onclick="movePage('<%=i %>')">
									<%=i %>
							 	</span>					
							<% } // End If%>
									 	
					<% }  // End For%>
					<!-- 페이지 나누기용 페이지 번호 출력 끝  -->	
					
				
				<% if (totalBlock>nowBlock) { // 다음 블럭이 남아 있다면  %>
							<span  class="moveBlockArea" onclick="moveBlock('<%=nowBlock+1%>', '<%=pagePerBlock%>', 'nb')">
							&gt;
							</span>
			
				<% } else { %>
				            <span class="moveBlockArea"></span>
				<% } %>
				
					
					
				<%
				} else {
					out.print("<b>[ Paging Area ]</b>"); // End if
				}
				%>						
										
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