package pack.spring.community.admin;

import java.util.List;
import java.util.Map;

public interface AdminService {
	
	// 회원 목록 조회
	List<Map<String, Object>> selectAllMem(Map<String, Object> map);
	
	// 회원 정보 조회
	Map<String, Object> memDetail(int num);
}
