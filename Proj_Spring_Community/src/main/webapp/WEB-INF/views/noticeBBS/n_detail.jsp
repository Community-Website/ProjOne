<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!--   errorPage="/err/errorProc.jsp" -->

<c:set var="uId_Session" value="${sessionScope.uId_Session }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>글내용 보기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<link rel="stylesheet" href="/resources/style/style_Common.css">
<link rel="stylesheet" href="/resources/style/style_Template.css">
<link rel="stylesheet" href="/resources/style/style_noticeBBS.css">
<link rel="stylesheet" href="/resources/source/style_Reset.css">
</head>

<body>
	<div id="wrap">

		<!--  헤더템플릿 시작 -->
		<%@ include file="../ind/headerTmp.jsp"%>
		<!--  헤더템플릿 끝 -->


		<main id="main" class="dFlex">

			<div id="lnb">
				<!--  메인 LNB 템플릿 시작 -->
				<%@ include file="../ind/mainLnbTmp.jsp"%>
				<!--  메인 LNB 템플릿 끝 -->
			</div>


			<!-- 실제 작업 영역 시작 -->
			<div id="contents" class="bbsRead">

				<!--  게시글 상세보기 페이지 내용 출력 시작 -->
				<h2>${detail.subject}</h2>

				<table id="readTbl">
					<tbody id="readTblBody">
						<tr>
							<td>작성자</td>
							<!-- td.req 필수입력 -->
							<td>${detail.uName}</td>
							<td>등록일</td>
							<!-- td.req 필수입력 -->
							<td><fmt:parseDate value="${detail.regTM}"
									pattern="yyyy-MM-dd'T'HH:mm" var="parsedRegTm" type="both" />
								<fmt:formatDate value="${parsedRegTm}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<!-- td.req 필수입력 -->
							<td colspan="3"><input type="hidden" name="fileName"
								value="${detail.fileName}" id="hiddenFname"> <c:if
									test="${!empty detail.fileName}">
									<span id="downloadFile">${detail.fileName}</span>							
									(<span> <c:set var="fUnit" value="Bytes" /> <c:if
											test="${detail.fileSize > 1024}">
											<c:set var="fileSize" value="${detail.fileSize / 1024}" />
											<c:set var="fUnit" value="KBytes" />
											<fmt:formatNumber value="${fileSize}" pattern=".00" /> ${fUnit}
										</c:if> <c:if test="${detail.fileSize <= 1024}">
											<fmt:formatNumber value="${detail.fileSize}" pattern=".00" /> ${fUnit}										
										</c:if>
									</span>)
								</c:if> <c:if test="${empty detail.fileName}">
									등록된 파일이 없습니다.
								</c:if></td>
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
							<td colspan="4" id="articleInfoTd"><span>"조회수 :
									${detail.readCnt}"</span> <span>(IP : ${detail.ip})</span></td>
						</tr>
						<tr>
							<td colspan="4" id="hrTd"><hr></td>
						</tr>
						<tr>
							<c:set var="listBtnLabel" value="" />
							<c:choose>
								<c:when test="${keyWord ne null or keyWord ne ''}">
									<c:set var="listBtnLabel" value="리스트" />
								</c:when>

								<c:otherwise>
									<c:set var="listBtnLabel" value="검색목록" />
								</c:otherwise>
							</c:choose>

							<td colspan="4" id="btnAreaTd" class="read">
								<button type="button" id="listBtn">${listBtnLabel}</button> <c:if
									test="${!empty uId_Session}">
									<c:if test="${uId_Session=='admin'}">
										<!-- <button type="button" id="replyBtn">답 변</button>  -->
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
				<input type="hidden" id="pKeyField" value="${param.keyField}">
				<input type="hidden" id="pKeyWord" value="${param.keyWord}">
				<!-- 검색어전송 끝 -->
				<p id="replyTitle">
					댓글 <span
						style="font-weight: normal; font-size: 16px; vertical-align: center;">${fn:length(list) }</span>
				</p>
				<br>
				<c:if test="${!empty uId_Session}">
					<form name="replyFrm" method="post" id="replyFrm"
						action="/noticeBBS/n_reply">
						<table id="replyTbl">
							<tbody id="replyTblbody">
								<tr>
									<td id="replyUName"><c:choose>
											<c:when
												test="${uId_Session=='admin' or uId_Session=='adminSub'}">관리자(${uId_Session})</c:when>
											<c:otherwise>${uName }(${uId_Session})</c:otherwise>
										</c:choose> <input type="hidden" name="uName" id="uName"
										value="
											<c:choose>
												<c:when test="${uId_Session=='admin' or uId_Session=='adminSub'}">관리자</c:when>
												<c:otherwise>${uName }</c:otherwise>
											</c:choose>
										">
										<input type="hidden" name="uId" id="uId"
										value="${uId_Session}"> <input type="hidden"
										name="num" id="num" value="${detail.num}"></td>
								</tr>
								<tr>
									<td id="replyContent"><textarea name="content"
											id="content" cols="60" wrap="hard" placeholder="댓글을 남겨보세요"></textarea></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="2" id="replyButton" class="reply">
										<button type="button" id="replyBtn">등록</button>
									</td>
								</tr>
							</tfoot>
						</table>
						<input type="hidden" name="ip"
							value="<%=request.getRemoteAddr()%>">
						<!--  
						    IP주소를 IPv4 형식으로 설정함.(IPv6 형식이 기본으로 설정되어 있음)
						    프로젝트 => Run Configuration => Tomcat 클릭
						    => (x)Argument => VM arguments 입력란 =>
						    -Djava.net.preferIPv4Stack=true  
						     -->
					</form>
				</c:if>
				<c:if test="${!empty list}">
					<br>
					<!-- 댓글 목록 시작 -->
					<c:set var="cnt" value="0" />
					<c:forEach var="reply" items="${list }">
						<c:set var="cnt" value="${cnt+1 }" />
						<div id="replyDiv">
							<c:if test="${reply.del=='N' }">
								<ul id="replyUl" style="margin: 0px;">
									<li id="reName"><c:if test="${reply.depth>0}">
											<c:set var="blank" value="0" />
											<c:forEach var="blank" begin="1" end="${reply.depth}">
												&nbsp;&nbsp;&nbsp;&nbsp;
											</c:forEach>
										</c:if> ${reply.uName }</li>
									<li id="reMenu">
										<div class="btn-group"
											style="border: 0px; background: none; color: #e1e1e1; font-size: 20px; font-weight: bold;">
											<c:if test="${!empty uId_Session}">
												<c:if test="${uId_Session==reply.uId}">
													<button type="button" class="btn" data-bs-toggle="dropdown"
														style="border: 0px;">···</button>
													<ul class="dropdown-menu">
														<li><a class="dropdown-item" href="#updateReplyDiv"
															id="replyUpdateBtn">수정</a></li>
														<li><a class="dropdown-item"
															href="/noticeBBS/n_deleteReply?num=${reply.num }&noticeNum=${reply.noticeNum}"
															id="replydelete">삭제</a></li>
													</ul>
												</c:if>
											</c:if>
										</div>
									</li>
									<li id="reContent"><c:if test="${reply.depth>0}">
											<c:set var="blank" value="0" />
											<c:forEach var="blank" begin="1" end="${reply.depth}">
												&nbsp;&nbsp;&nbsp;&nbsp;
											</c:forEach>
											<img src='/resources/images/replyImg.png' alt='reply'>&nbsp;
										</c:if> ${reply.content }</li>
									<li id="reDate"><c:if test="${reply.depth>0}">
											<c:set var="blank" value="0" />
											<c:forEach var="blank" begin="1" end="${reply.depth}">
												&nbsp;&nbsp;&nbsp;&nbsp;
											</c:forEach>
										</c:if> <fmt:parseDate value="${reply.regTM}"
											pattern="yyyy-MM-dd'T'HH:mm" var="parsedRegTm" type="both" />
										<fmt:formatDate value="${parsedRegTm}"
											pattern="yyyy-MM-dd HH:mm" />
										<p style="display: inline-block; margin: 0px;">
											<c:if test="${!empty uId_Session}">
												<button class="btn"
													style="background: none; border: 0px; font-size: 13px; color: #b1b1b1;"
													type="button" data-bs-toggle="collapse"
													data-bs-target="#collapseExample${cnt }"
													aria-expanded="false" aria-controls="collapseExample">
													답변달기</button>
											</c:if>
										</p>
										<div class="collapse" id="collapseExample${cnt }">
											<div class="card card-body"
												style="border: 0px; padding: 0px; margin-bottom: 0px;">
												<c:if test="${reply.depth>0}">
													<c:set var="blank" value="0" />
													<c:forEach var="blank" begin="1" end="${reply.depth}">
														&nbsp;&nbsp;&nbsp;&nbsp;
													</c:forEach>
												</c:if>
												<form name="replyFrm2" method="post" id="replyFrm2"
													action="/noticeBBS/n_reply2">
													<table id="replyTbl">
														<tbody id="replyTblbody">
															<tr>
																<td id="replyUName">
																	<c:choose>
																		<c:when test="${uId_Session=='admin' or uId_Session=='adminSub'}">관리자(${uId_Session})
																			<c:set var="replyName" value="관리자"></c:set>
																		</c:when>
																		<c:otherwise>${uName }(${uId_Session})
																			<c:set var="replyName" value="${uId_Session }"></c:set>
																		</c:otherwise>
																	</c:choose> 
																	<input type="hidden" name="uName" id="uName" value="${replyName }">
																	<input type="hidden" name="uId" id="uId" value="${uId_Session}"> 
																	<input type="hidden" name="noticeNum" id="noticeNum" value="${detail.num}"> <!-- 게시판번호 --> 
																	<input type="hidden" name="num" id="num" value="${reply.num}"> 	<!-- 댓글번호 --> 
																	<input type="hidden" name="ref" id="ref" value="${reply.ref}"> 
																	<input type="hidden" name="pos" id="pos" value="${reply.pos}"> 
																	<input type="hidden" name="depth" id="depth" value="${reply.depth}"> 
																	<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
																</td>
															</tr>
															<tr>
																<td id="replyContent" class="reply">
																	<textarea name="content" id="content" cols="60" wrap="hard" placeholder="댓글을 남겨보세요"></textarea>
																</td>
															</tr>
														</tbody>
														<tfoot>
															<tr>
																<td colspan="2" id="replyButton">
																	<button type="button" id="replyBtn2">등록</button>
																</td>
															</tr>
														</tfoot>
													</table>
												</form>
											</div>
										</div></li>
								</ul>
								<!-- 댓글 수정 -->
								<div id="updateReplyDiv" style="display: none"
									class="updateReplyDiv${reply.num }">
									<form name="replyFrm3" method="post" id="replyFrm3"
										action="/noticeBBS/n_updateReply">
										<table id="replyTbl">
											<tbody id="replyTblbody">
												<tr>
													<td id="replyUName">${uName }(${uId_Session})<input
														type="hidden" name="uName" id="uName" value="${uName}">
														<input type="hidden" name="uId" id="uId"
														value="${uId_Session}"> <input type="hidden"
														name="num" id="num" value="${reply.num}"> <input
														type="hidden" name="ref" id="ref" value="${detail.num}">
													</td>
												</tr>
												<tr>
													<td id="replyContent"><textarea name="content"
															id="content" cols="60" wrap="hard">${reply.content }</textarea></td>
												</tr>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="2" id="replyButton" class="reply">
														<button type="button" id="replyBtn3">등록</button>
														<button type="button" id="replyUpdateCancel">취소</button>
													</td>
												</tr>
											</tfoot>
										</table>
									</form>
								</div>
							</c:if>
							<c:if test="${reply.del=='Y' }">
								<ul id="replyUl" style="margin: 0px;">
									<li id="reContent"><c:if test="${reply.depth>0}">
											<c:set var="blank" value="0" />
											<c:forEach var="blank" begin="1" end="${reply.depth}">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</c:forEach>
											<img src='/resources/images/replyImg.png' alt='reply'>&nbsp;
									</c:if> 삭제된 댓글입니다.</li>
								</ul>
							</c:if>
						</div>
						<hr>
					</c:forEach>
				</c:if>
				<!--  게시글 상세보기 페이지 내용 출력 끝 -->
				<br>

			</div>
			<!-- 실제 작업 영역 끝 -->

		</main>
		<!--  main#main  -->


		<!--  푸터템플릿 시작 -->
		<%@ include file="../ind/footerTmp.jsp"%>
		<!--  푸터템플릿 끝 -->

	</div>
	<!-- div#wrap -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
	<script src="/resources/source/jquery-3.6.0.min.js"></script>
	<script src="/resources/script/script_Notice.js"></script>
	<script src="/resources/script/script_Reply.js"></script>
</body>

</html>