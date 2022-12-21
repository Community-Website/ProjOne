/**
 * 
 */
 		
	/* 게시글 내용보기페이지에서 답변버튼 시작 /noticeBBS/n_read.jsp */
	$("td.read>button#replyBtn").click(function(){
	
		let nowPage = $("input#nowPage").val().trim();
		let num = $("input#num").val().trim();
				
		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	
		let url = "/noticeBBS/n_reply?";
			url += "num="+num;
			url += "&nowPage="+nowPage;
			url += "&keyField="+p3;
	     	url += "&keyWord="+p4; 
		location.href=url;
	
	});
	/* 게시글 내용보기페이지에서 답변버튼 끝 /noticeBBS/n_read.jsp */
	
	
	/* 댓글입력양식 페이지에서 댓글내용 전송 시작 /noticeBBS/n_reply */
	$("button#replyBtn").click(function(){
		let content = $("form#replyFrm").find("textarea#content").val();
		
		if (content == "") {
			alert("댓글을 입력하세요.");
			$("#content").focus();
		} else {		
			$("#replyFrm").submit();
		}
		
	});
	/* 댓글입력양식 페이지에서 댓글내용 전송 끝 /noticeBBS/n_reply */		
	
	/* 대댓글입력양식 페이지에서 대댓글내용 전송 시작 /noticeBBS/n_reply2 */
	$("button#replyBtn2").click(function(){
		
		let content = $(this).closest("form#replyFrm2").find("textarea#content").val();
		
		if (content == "") {
			alert("댓글을 입력하세요.");
			$(this).closest("form#replyFrm2").find("#content").focus();
		} else {		
			$(this).closest("form#replyFrm2").submit();
		}
		
	});
	/* 대댓글입력양식 페이지에서 대댓글내용 전송 끝 /noticeBBS/n_reply2 */		
	
	/* 댓글입력양식 수정 페이지 전송 시작 /noticeBBS/n_reply2 */
	$("button#replyBtn3").click(function(){
		
		let content = $(this).closest("form#replyFrm3").find("textarea#content").val();
		
		if (content == "") {
			alert("댓글을 입력하세요.");
			$(this).closest("form#replyFrm3").find("#content").focus();
		} else {		
			$(this).closest("#replyFrm3").submit();
		}
		
	});
	/* 댓글입력양식 수정 페이지 전송 끝 /noticeBBS/n_reply2 */		
	
	/* 댓글 수정 전송 시작 /noticeBBS/n_reply2 */
	$("[id^=replyUpdateBtn]").on('click',function(event){
		$(this).closest("div#replyDiv").find("ul#replyUl").css({
			display:"none"
		});
		$(this).closest("div#replyDiv").find("div#updateReplyDiv").css({
			display:"inherit"
		});
		$(this).closest("div#replyDiv").find("div#updateReplyDiv").focus();
		
	});
	$("[id^=replyUpdateCancel]").on('click',function(event){
		$(this).closest("div#replyDiv").find("ul#replyUl").css({
			display:"inherit"
		});
		$(this).closest("div#replyDiv").find("ul#replyUl").focus();
		$(this).closest("div#replyDiv").find("div#updateReplyDiv").css({
			display:"none"
		});
		
	});
	/* 댓글 수정 전송 끝 /noticeBBS/n_reply2 */