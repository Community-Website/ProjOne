package pack.spring.community.admin;

import java.util.List;
import java.util.Map;

public interface AdminService {
	
	// 관리자 로그인 체크
	int adminCheck(Map<String, Object> map);
	
	// 관리자 로그인 처리
	boolean adminLogin(Map<String, Object> map);
	
	Map<String, Object> adminDetail(Map<String, Object> map);
	
	// 회원 목록 조회
	List<Map<String, Object>> selectAllMem(Map<String, Object> map);
	
	// 회원 정보 조회
	Map<String, Object> memDetail(int num);
	
	// 회원 정보 수정
	int memUpdate(Map<String, Object> map);
	
	// 회원 삭제
	int memDelete(int num);
	
	// 관리자 비밀번호 가져오기
	String adminPw(String uId);
}
