package pack.spring.community.bbs;

import java.util.List;
import java.util.Map;

public interface BoardService {
	// 게시판 글쓰기
	int write(Map<String, Object> map);
	
	// 글 목록 Service
	List<Map<String, Object>> list(Map<String, Object> map);
	
	// 전체 글 수
	int getMaxNum(Map<String, Object> map);
	
	// 게시글 상세보기
	Map<String, Object> detail(int num);
	
	// 조회수 증가
	int upCount(int num);
	
	// 게시글 수정
	int updateBoard(Map<String, Object> map);
	
	// 게시글 삭제
	int deleteBoard(int num);
	
	// 댓글 등록
	int replyBoard(Map<String, Object> map);
	
	// 댓글 끼어들기
	int replyUp(Map<String, Object> map);
	
}
