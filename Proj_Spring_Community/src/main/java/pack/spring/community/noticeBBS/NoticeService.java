package pack.spring.community.noticeBBS;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	// 공지사항 글쓰기
	int insert(Map<String, Object> map);

	// 전체 공지사항 글 수
	int getMaxNum(Map<String, Object> map);

	// 공지사항 글목록 보기
	List<Map<String, Object>> noticeList(Map<String, Object> map);

	// 조회수 증가
	int upCount(int num);

	// 공지사항 글 상세 보기
	Map<String, Object> detail(int num);

	//공지사항 수정
	int updateNotice(Map<String, Object> map);
	
	// 공지사항 삭제
	int deleteNotice(int num);
	// 공지사항 코멘트 수
	int getReplyMaxNum(Map<String, Object> map);

	// 공지사항 코멘트쓰기
	int insertReply(Map<String, Object> map);

	// 공지사항 코멘트 보기
	List<Map<String, Object>> noticeReplyList(int ref);
}
