package pack.spring.community.noticeBBS;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insert(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("noticeBBS.insert", map);
	}

	// 전체 게시글 수
	public int getMaxNum(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("noticeBBS.selectMaxNum", map);
	}
}
