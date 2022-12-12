package pack.spring.community.noticeBBS;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeServiceImp implements NoticeService {
	@Autowired
	NoticeDAO noticeDAO;

	// 공지사항 글쓰기
	@Override
	public int insert(Map<String, Object> map) {
		return this.noticeDAO.insert(map);
	}

	// 전체 공지사항 글 수
	@Override
	public int getMaxNum(Map<String, Object> map) {
		return this.noticeDAO.getMaxNum(map);
	}

	// 공지사항 글목록 보기
	@Override
	public List<Map<String, Object>> noticeList(Map<String, Object> map) {
		return this.noticeDAO.noticeList(map);
	}

	// 조회수 증가
	@Override
	public int upCount(int num) {
		return this.noticeDAO.upCount(num);
	}

	// 공지사항 글 상세 보기
	@Override
	public Map<String, Object> detail(int num) {
		return this.noticeDAO.detail(num);
	}

	// 공지사항 수정
	@Override
	public int updateNotice(Map<String, Object> map) {
		return this.noticeDAO.updateNotice(map);
	}

	// 공지사항 삭제
	@Override
	public int deleteNotice(int num) {
		return this.noticeDAO.deleteNotice(num);
	}

	// 공지사항 삭제되면 코멘트도 삭제
	@Override
	public int deleteReOfNotice(int ref) {
		return this.noticeDAO.deleteReOfNotice(ref);
	}

	// 공지사항 코멘트 수(maxNum)
	@Override
	public int getReplyMaxNum(Map<String, Object> map) {
		return this.noticeDAO.getReplyMaxNum(map);
	}

	// 공지사항 코멘트쓰기
	@Override
	public int insertReply(Map<String, Object> map) {
		return this.noticeDAO.insertReply(map);
	}

	// 공지사항 코멘트 보기
	@Override
	public List<Map<String, Object>> noticeReplyList(int ref) {
		return this.noticeDAO.noticeReplyList(ref);
	}

	// 공지사항 대댓글쓰기
	@Override
	public int insertReplyReply(Map<String, Object> map) {
		return this.noticeDAO.insertReplyReply(map);
	}

	// 공지사항 댓글끼어들기
	@Override
	public int replyUp(Map<String, Object> map) {
		return this.noticeDAO.replyUp(map);
	}

	// 공지사항 댓글 삭제
	@Override
	public int deleteReply(int num) {
		return this.noticeDAO.deleteReply(num);
	}

	// 공지사항 댓글 수정
	@Override
	public int updateReply(Map<String, Object> map) {
		return this.noticeDAO.updateReply(map);
	}

	// 공지사항 코멘트 수(count)
	@Override
	public Map<String, Object> selectReplyCount(Map<String, Object> map) {
		return this.noticeDAO.selectReplyCount(map);
	}

}
