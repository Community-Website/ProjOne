package pack.spring.community.noticeBBS;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	// 공지사항 글쓰기
	public int insert(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("noticeBBS.insert", map);
	}

	// 전체 공지사항 글 수
	public int getMaxNum(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("noticeBBS.selectMaxNum", map);
	}

	// 공지사항 글목록 보기
	public List<Map<String, Object>> noticeList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("noticeBBS.selectAll", map);
	}

	// 조회수 증가
	public int upCount(int num) {
		return this.sqlSessionTemplate.update("noticeBBS.upCount", num);
	}

	// 공지사항 글 상세 보기
	public Map<String, Object> detail(int num) {
		return this.sqlSessionTemplate.selectOne("noticeBBS.selectDetail", num);
	}

	// 공지사항 수정
	public int updateNotice(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("noticeBBS.updateNotice", map);
	}

	// 공지사항 삭제
	public int deleteNotice(int num) {
		return this.sqlSessionTemplate.delete("noticeBBS.deleteNotice", num);
	}

	// 공지사항 삭제되면 코멘트도 삭제
	public int deleteReOfNotice(int ref) {
		return this.sqlSessionTemplate.delete("noticeBBS.deleteReOfNotice", ref);
	}

	// 공지사항 코멘트 수(MaxNum)
	public int getReplyMaxNum(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("noticeBBS.selectReplyMaxNum", map);
	}
	// 공지사항 코멘트 수(count)
	public Map<String, Object> selectReplyCount(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("noticeBBS.selectReplyCount", map);
	}
	// 공지사항 코멘트 pos 수
	public int getReplyMaxPos(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("noticeBBS.selectReplyMaxPos", map);
	}

	// 공지사항 코멘트쓰기
	public int insertReply(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("noticeBBS.insertReply", map);
	}

	// 공지사항 코멘트 보기
	public List<Map<String, Object>> noticeReplyList(int noticeNum) {
		return this.sqlSessionTemplate.selectList("noticeBBS.selectReplyAll", noticeNum);
	}

	// 공지사항 대댓글쓰기
	public int insertReplyReply(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("noticeBBS.insertReplyReply", map);
	}

	// 공지사항 댓글끼어들기
	public int replyUp(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("noticeBBS.replyUp", map);
	}

	// 공지사항 삭제
	public int deleteReply(int num) {
		return this.sqlSessionTemplate.delete("noticeBBS.deleteReply", num);
	}

	// 공지사항 댓글 수정
	public int updateReply(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("noticeBBS.updateReply", map);
	}
}
