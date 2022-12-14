/**
 * 
 */
 
/* 상세내용 보기 페이지 이동 시작 /admin/memberList.jsp => memberDetail.jsp */
function memberDetail(p1, p2) {
	// p1 : num (게시글의 고유번호, 고유값, 키값 : Key Value)
	// p2 : nowPage (현재페이지)
    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	let param = "memberDetail?num="+p1;
	     param += "&nowPage="+p2;
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 
	location.href=param;
}		
/* 상세내용 보기 페이지 이동 끝 /admin/memberList.jsp => memberDetail.jsp  */

/* 페이지 이동 */
function movePage(p1) {    // 페이지 이동
	let param = "/admin/memberList?nowPage="+p1;	    

	location.href = param;

}
/* 페이지 이동 끝 */

/* 회원정보수정 페이지 이동 */  
function memberModify(p1) {
	// p1 : num	
	let param = "memberModify?num="+p1; 
	location.href=param;
}	
/* 회원정보수정 페이지 이동 끝 */  

/* 회원정보수정 버튼 전송 실행 */  
$(function(){
	// 우편번호 찾기 팝업 
	$("#regFrm button#findZipBtn").click(function(){
		
		let url = "/member/zipCheck";
		let nickName = "zipChkPop";

		let w = screen.width;     // 1920
		let popWidth = 640;
		let leftPos = (w - popWidth) / 2; // left Position 팝업창 왼쪽 시작위치

		let h = screen.height;    // 1080
		let popHeight = 400;
		let topPos = (h - popHeight) / 2; 		
		
		let prop = "width="+ popWidth +", height="+ popHeight;
			  prop += ", left=" + leftPos + ", top=" + topPos; 
		window.open(url, nickName, prop);
		
	});
	
	
	// 우편번호 팝업창에서 주소 검색
	$("#addrSearchBtn").click(function(){
		let area3 = $("#area3").val().trim();
		if (area3 == "") {
			alert("검색어를 입력해주세요.");
			$("#area3").focus();
		} else {
			$("#zipFrm").submit();
		}
	});
	
	
	// 우편번호 팝업창에서 주소 선택
	$("table#zipResTbl td").click(function(){
		let txtAddr = $(this).children("span").text();
		let zipcode = txtAddr.substring(0, 7);
		let addr = txtAddr.substring(8);
		window.opener.uZipcode.value = zipcode;
		window.opener.uAddr.value = addr;
		window.close();
	});

	$("#modSbmBtn").click(function(){    
		fnModSbm();    
	});

	function fnModSbm() {
	
		let uId = $("#uId").val();
	    $("#uId").val(uId);
	    let uName = $("#uName").val();
	    $("#uName").val(uName);
	    let uEmail_01 = $("#uEmail_01").val();
	    let uEmail_02 = $("#uEmail_02").val();
	    $("#uEmail").val(uEmail_01+"@"+uEmail_02);
	    let uBirthday = $("#uBirthday").val();
	    
		if (uId == "") {
			alert("아이디를 입력해주세요.");
			$("#uId").focus();
			return;
	    }  else if (uName == "") {
			alert("이름을 입력해주세요.");
			$("#uName").focus();
			return;
	    } else if (uEmail_01 == "") {
			alert("이메일 주소를 입력해주세요.");
			$("#uEmail_01").focus();
			return;
	    } else if (uEmail_02 == "") {
			alert("이메일 주소를 입력해주세요.");
			$("#uEmail_02").focus();
			return;
	    } else if (uBirthday != "" && isNaN(uBirthday)) {
			// 생년월일 숫자유효성 검사
			alert("생년월일은 숫자만 입력할 수 있습니다.");
			$("#uBirthday").val("").focus();
			return;
	    } else {
			let chkSbmTF = confirm("회원정보를 수정하시겠습니까?");
			if (chkSbmTF) {
				$("#regFrm").submit();
			}
		}
	}
});


/* 회원삭제 페이지 이동 */  
function memberDelete(p1) {
	// p1 : num	
	let param = "memberDelete?num="+p1; 
	location.href=param;
}	
/* 회원삭제 페이지 이동 끝 */  