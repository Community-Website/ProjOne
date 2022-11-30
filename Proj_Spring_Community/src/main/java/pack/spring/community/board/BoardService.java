package pack.spring.community.board;

import java.util.List;
import java.util.Map;

import pack.spring.community.common.SearchVO;

public interface BoardService {
	// 게시판 글쓰기
	String write(Map<String, Object> map);
	
	// 글 목록 Service
	List<Map<String, Object>> list(Map<String, Object> map);
	
	// 전체 글 수
	int getTotalRecord(SearchVO searchVo);
}
