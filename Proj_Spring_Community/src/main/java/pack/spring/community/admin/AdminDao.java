package pack.spring.community.admin;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	// 회원 목록 조회
	public List<Map<String, Object>> selectAllMem(Map<String, Object> map){
		return this.sqlSessionTemplate.selectList("admin.selectAllMem", map);
	}
	
	// 회원 정보 조회
	public Map<String, Object> memDetail(int num){
		return this.sqlSessionTemplate.selectOne("admin.memDetail", num);
	}
	
}
