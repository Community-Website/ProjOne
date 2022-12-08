package pack.spring.community.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImp implements AdminService {
	
	@Autowired
	AdminDao adminDao;

	@Override
	public List<Map<String, Object>> selectAllMem(Map<String, Object> map) {
		return this.adminDao.selectAllMem(map);
	}

	@Override
	public Map<String, Object> memDetail(int num) {
		return this.adminDao.memDetail(num);
	}

}
