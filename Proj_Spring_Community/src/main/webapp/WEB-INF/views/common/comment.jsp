<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="/resources/source/jquery-3.6.0.min.js"></script>
<script src="/resources/script/script_Reply.js"></script>
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
						<td id="replyUName">
							<c:choose>
								<c:when test="${uId_Session=='admin' or uId_Session=='adminSub'}">관리자(${uId_Session})</c:when>
								<c:otherwise>${uName }(${uId_Session})</c:otherwise>
							</c:choose> <input type="hidden" name="uName" id="uName"value="
											<c:choose>
												<c:when test="${uId_Session=='admin' or uId_Session=='adminSub'}">관리자</c:when>
												<c:otherwise>${uName }</c:otherwise>
											</c:choose>
										">
							<input type="hidden" name="uId" id="uId" value="${uId_Session}">
							<input type="text" name="num" id="num" value="${detail.num}">
						</td>
					</tr>
					<tr>
						<td id="replyContent"><textarea name="content" id="content"
								cols="60" wrap="hard" placeholder="댓글을 남겨보세요"></textarea></td>
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
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
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
								pattern="yyyy-MM-dd'T'HH:mm" var="parsedRegTm" type="both" /> <fmt:formatDate
								value="${parsedRegTm}" pattern="yyyy-MM-dd HH:mm" />
							<p style="display: inline-block; margin: 0px;">
								<c:if test="${!empty uId_Session}">
									<button class="btn"
										style="background: none; border: 0px; font-size: 13px; color: #b1b1b1;"
										type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseExample${cnt }" aria-expanded="false"
										aria-controls="collapseExample">답변달기</button>
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
														name="noticeNum" id="noticeNum" value="${detail.num}">
													<!-- 게시판번호 --> <input type="hidden" name="num" id="num"
														value="${reply.num}">
													<!-- 게시판번호 --> <input type="hidden" name="ref" id="ref"
														value="${reply.ref}"> <input type="hidden"
														name="pos" id="pos" value="${reply.pos}"> <input
														type="hidden" name="depth" id="depth"
														value="${reply.depth}"> <input type="hidden"
														name="ip" value="<%=request.getRemoteAddr()%>"></td>
												</tr>
												<tr>
													<td id="replyContent" class="reply"><textarea
															name="content" id="content" cols="60" wrap="hard"
															placeholder="댓글을 남겨보세요"></textarea></td>
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
						<li id="reContent">
							<c:if test="${reply.depth>0}">
								<c:set var="blank" value="0" />
								<c:forEach var="blank" begin="1" end="${reply.depth}">
									&nbsp;&nbsp;&nbsp;&nbsp;
								</c:forEach>
							<img src='/resources/images/replyImg.png' alt='reply'>&nbsp;
							</c:if> 삭제된 댓글입니다.
						</li>
					</ul>
				</c:if>
			</div>
			<hr>
		</c:forEach>
	</c:if>
	<!--  게시글 상세보기 페이지 내용 출력 끝 -->
	<br>

	</div>
