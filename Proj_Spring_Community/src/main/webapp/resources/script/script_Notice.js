/**
 * 
 *//**
 * 
 */
$(function(){

	/* 리스트 페이지 글쓰기 버튼 시작 /noticeBBS/list.jsp */	
	$("#loginAlertBtn").click(function(){		
		alert("로그인 후 게시글을 작성하실 수 있습니다.");
	});	
	$("#writeBtn").click(function(){	
		let uId=$("#uId").val().trim();	
		location.href="/noticeBBS/n_write?uId=" + uId;
	});
	/* 리스트 페이지 글쓰기 버튼 끝 /noticeBBS/n_list.jsp */
	
	
	/* 글쓰기 페이지 게시글 등록 시작 /noticeBBS/n_write.jsp */
	$("#regBtn").click(function(){
		let subject = $("#subject").val().trim();		
		
		 if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {
			$("#writeFrm").attr("action", "/noticeBBS/n_write");
			$("#writeFrm").submit();
		}
	
	});	
	
	/* 글쓰기 페이지 게시글 등록 끝 /noticeBBS/n_write.jsp */
	
	
	/* 게시글 삭제버튼 시작 /noticeBBS/n_read.jsp */
	$("button#delBtn").click(function(){
		
		let chkTF = confirm("게시글을 삭제하시겠습니까?");
		
		if (chkTF) {
			let nowPage = $("input#nowPage").val().trim();
			let num = $("input#num").val().trim();
					
			let p3 = $("#pKeyField").val().trim();  // p3 : keyField
		    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		    
			let url = "/noticeBBS/n_delete?";
				url += "num="+num+"&nowPage="+nowPage;
				url += "&keyField="+p3;
				url += "&keyWord="+p4;
			location.href=url;
		} else {
			alert("취소하셨습니다.");	
		}
		
	});
	/* 게시글 삭제버튼 끝 /noticeBBS/n_read.jsp */
	
	
	
	/* 게시글 내용보기페이지에서 수정버튼 시작 /noticeBBS/n_read.jsp */
	$("td.read>button#modBtn").click(function(){
	
		let nowPage = $("input#nowPage").val().trim();
		let num = $("input#num").val().trim();
				
		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	
		let url = "/noticeBBS/n_modify?";
			url += "num="+num;
			url += "&nowPage="+nowPage;
			url += "&keyField="+p3;
	     	url += "&keyWord="+p4; 
		location.href=url;
	});
	
	/* 게시글 내용보기페이지에서 수정버튼 끝 /noticeBBS/n_read.jsp */
	
	
	/* 게시글 수정페이지에서 수정내용 전송 시작 /noticeBBS/n_modify.jsp */
	$("td.update>button#modProcBtn").click(function(){
		let subject = $("#subject").val().trim();
		
		//let keyField = $("#keyField").val().trim();
		//let keyWord = $("#keyWord").val().trim();
		
		if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {
		
			//alert("keyField : " + keyField + "\nkeyWord : " + keyWord);
			//return;
			$("#modifyFrm").submit();
		}
	
	});	
	/* 게시글 수정페이지에서 수정내용 전송 끝 /noticeBBS/n_modify.jsp */
	
	
			
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
	$("#replyUpdate").click(function(){
		$(this).closest("div#replyDiv").find("ul#replyUl").css({
			display:"none"
		});
		$(this).closest("div#replyDiv").find("div#updateReplyDiv").css({
			display:"inherit"
		});
		$(this).closest("div#replyDiv").find("div#updateReplyDiv").focus();
		
	});
	$("#replyUpdateCancel").click(function(){
		$(this).closest("div#replyDiv").find("ul#replyUl").css({
			display:"inherit"
		});
		$(this).closest("div#replyDiv").find("ul#replyUl").focus();
		$(this).closest("div#replyDiv").find("div#updateReplyDiv").css({
			display:"none"
		});
		
	});
	/* 댓글 수정 전송 끝 /noticeBBS/n_reply2 */		
	
	
	
	/* 리스트페이지 검색 시작 /noticeBBS/n_list.jsp */	
	$("button#searchBtn").click(function(){
		let keyWord = $("#keyWord").val();    // 검색어에서는 .trim()을 지양하는 추세
		                                                      // 단, 로그인, 회원가입, 회원정보 수정에서 사용하는
                                                              // ID 에는 입력값 전후의 공백을 제거한다. 
		//alert("keyWord : " + keyWord +"\nkeyWord 글자수 : " + keyWord.length);
		if (keyWord=="") {
			alert("검색어를 입력해주세요.");
			$("#keyWord").focus();			
		} else {
			$("#searchFrm").submit();
		}
	});	
	/* 리스트페이지 검색 끝 /noticeBBS/n_list.jsp */	
	
	
	/* 검색 결과를 유지한 리스트페이지 이동 시작 /noticeBBS/n_read.jsp */
	$("#listBtn").click(function(){
		let param = $("#nowPage").val().trim();
		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	     
		let url = "/noticeBBS/n_list?nowPage=" + param;		    
		    url += "&keyField="+p3;
	     	url += "&keyWord="+p4 ; 
		location.href=url;
	});
	/* 검색 결과를 유지한 리스트페이지 이동 끝 /noticeBBS/n_read.jsp */
	
	$("#downloadFile").click(function(){
		let file = $("#downloadFile").html();
		
		location.href = "/n_downloadFile?filename="+file;
		
	});
	
	$("#backBtn").click(function(){
		location.href = "javascript:history.back()";
	});
	
});
	
	
/* 상세내용 보기 페이지 이동 시작 /noticeBBS/n_list.jsp => n_detail.jsp */
function detail(p1, p2) {
	// p1 : num (게시글의 고유번호, 고유값, 키값 : Key Value)
	// p2 : nowPage (현재페이지)
    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	let param = "n_detail?num="+p1;
	     param += "&nowPage="+p2;
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 
	location.href=param;
}		
/* 상세내용 보기 페이지 이동 끝 /noticeBBS/n_list.jsp => n_detail.jsp  */



/* 리스트페이지 페이징 시작 /noticeBBS/n_list.jsp */
function movePage(p1) {    // 페이지 이동
	
    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord

	let param = "/noticeBBS/n_list?nowPage="+p1;	    
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 
	location.href= param;

}
/* 리스트페이지 페이징 끝 /noticeBBS/n_list.jsp */


/* 리스트페이지 페이징 블럭이동 시작 /noticeBBS/n_list.jsp */
function moveBlock(p1, p2, param3) {    
	                // 이전 블럭 또는 이후 블럭으로 이동  p1 => nowBlock-1  또는 nowBlock+1

	let moveBlock = parseInt(p1);    // 이전 블럭의 시작페이지로 이동에 사용하는 소
	let pagePerBlock = parseInt(p2);	
	//alert("p1(moveBlock) : " + p1 + "\np2(pagePerBlock) : " + p2);
	
    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	
	if (param3 == 'pb') {
		 param = "/noticeBBS/n_list?nowPage="+(moveBlock*pagePerBlock);
	                                                          // moveBlock : nowBlock - 1 
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ;
	} else if (param3 == 'nb' ) {		
		 param = "/noticeBBS/n_list?nowPage="+(pagePerBlock*(moveBlock-1)+1);   
	                                                          // moveBlock : nowBlock + 1 
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ;
	}

	location.href=param;
}
/* 리스트페이지 페이징 블럭이동 끝 /noticeBBS/n_list.jsp */


<!-- 첨부파일 다운로드 -->


 