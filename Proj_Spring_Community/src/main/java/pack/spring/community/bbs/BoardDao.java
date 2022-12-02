package pack.spring.community.bbs;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pack.spring.community.common.SearchVO;

@Repository
public class BoardDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	// 게시판 글쓰기
	public int insert(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("bbs.insert", map);
	}

	// 게시판 글목록 보기
	public List<Map<String, Object>> boardList(Map<String, Object> map){
		return this.sqlSessionTemplate.selectList("bbs.selectAll", map);
	}
	
	// 전체 게시글 수 
	public int getMaxNum(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("bbs.selectMaxNum", map);
	}
	
	// 게시글 상세 보기
	public Map<String, Object> detail(int num){
		return this.sqlSessionTemplate.selectOne("bbs.selectDetail", num);
	}
	
	// 조회수 증가
	public int upCount(int num) {
		return this.sqlSessionTemplate.update("upCount", num);
	}
	
	// 게시글 수정하기
	public int updateBoard(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("bbs.updateBoard", map);
	}
	
	// 게시글 삭제하기
	public int deleteBoard(int num) {
		return this.sqlSessionTemplate.delete("bbs.deleteBoard", num	);
	}
	
	// 댓글 등록하기
	public int replyBoard(Map<String, Object> map	) {
		return this.sqlSessionTemplate.insert("bbs.replyBoard", map);
	}
	
	// 댓글 끼어들기
	public int replyUp(Map<String, Object> map	) {
		return this.sqlSessionTemplate.update("bbs.replyUp", map);
	}
}
