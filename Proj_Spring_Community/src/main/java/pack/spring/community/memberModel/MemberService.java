package pack.spring.community.memberModel;

import java.util.List;
import java.util.Map;

public interface MemberService {
	
	String create(Map<String, Object> map);
	
	/* 아이디 중복 검사 시작(/member/idCheck.jsp) */
	boolean checkId(String uId);
	
	/* 우편번호 찾기 시작(/member/zipCheck.jsp) */
	List<Map<String, Object>> zipcodeRead(String area3);
	
	/* 회원가입 시작 (/member/memberProc.jsp) */
	boolean insertMember(Map<String, Object> map);
	
	/* 로그인 처리 시작 (/member/loginProc.jsp) */
	boolean loginMember(Map<String, Object> map);
	
	/* 회원정보 불러오기 시작 (/member/memberModProc.jsp) */
	Map<String, Object> modifyMember(String uId);
	
	/* 회원정보 수정 시작 */
	boolean updateMember(Map<String, Object> map);
	
	/* 회원탈퇴 시작 (/member/memberQuitProc.jsp) */
	boolean quitMember(String uId);
	
	/* 로그인 사용자 이름 반환(/bbs/write.jsp) 시작 */
	String getMemberName(String uId);
	
}
