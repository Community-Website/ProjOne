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


function movePage(p1) {    // 페이지 이동
let param = "/admin/memberList?nowPage="+p1;	    

	location.href = param;

}