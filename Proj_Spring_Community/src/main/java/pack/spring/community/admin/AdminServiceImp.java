package pack.spring.community.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImp implements AdminService {
	
	@Autowired
	AdminDao adminDao;
	
	// 관리자 체크
	@Override
	public int adminCheck(Map<String, Object> map) {
		return this.adminDao.adminCheck(map);
	}
	
	@Override
	public boolean adminLogin(Map<String, Object> map) {
		boolean loginChkTF = false;
		int recordCnt = this.adminDao.adminLogin(map);
		System.out.println("---------recordCnt"+recordCnt);
		if(recordCnt > 0) {
			loginChkTF = true;
		}
		
		return loginChkTF;
	}
	
	@Override
	public List<Map<String, Object>> selectAllMem(Map<String, Object> map) {
		return this.adminDao.selectAllMem(map);
	}

	@Override
	public Map<String, Object> memDetail(int num) {
		return this.adminDao.memDetail(num);
	}

	@Override
	public Map<String, Object> adminDetail(Map<String, Object> map) {
		return this.adminDao.adminDetail(map);
	}

	
}
