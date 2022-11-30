package pack.spring.community.board;

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
	
	public int getTotalRecord(SearchVO searchVo) {
		return sqlSessionTemplate.selectOne("bbs.getTotalRecord", searchVo);
	}
	
}
