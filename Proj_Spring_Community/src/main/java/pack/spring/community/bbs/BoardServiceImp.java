package pack.spring.community.bbs;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pack.spring.community.common.SearchVO;

@Service
public class BoardServiceImp implements BoardService{
	
	@Autowired
	BoardDao boardDao;
	
	//게시판 글쓰기
	@Override
	public String write(Map<String, Object> map) {
		int affectRowCnt = this.boardDao.insert(map);
		
		if(affectRowCnt == 1) {
			return map.get("num").toString();
		}
		
		return null;
	}

	//게시판 글목록
	@Override
	public List<Map<String, Object>> list(Map<String, Object> map) {
		return this.boardDao.boardList(map);
	}

	@Override
	public int getMaxNum(Map<String, Object> map) {
		return this.boardDao.getMaxNum(map);
	}

	@Override
	public Map<String, Object> detail(int num) {
		return this.boardDao.detail(num);
	}

	@Override
	public int updateBoard(Map<String, Object> map) {
		return this.boardDao.updateBoard(map);
	}

	@Override
	public int upCount(int num) {
		return this.boardDao.upCount(num);
	}

	@Override
	public int deleteBoard(int num) {
		return this.boardDao.deleteBoard(num);
	}
	
}
