package pack.spring.community.noticeBBS;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeServiceImp implements NoticeService {
	@Autowired
	NoticeDAO  noticeDAO;
	
	@Override
	public int insert(Map<String, Object> map) {
		return this.noticeDAO.insert(map);
	}

	@Override
	public int getMaxNum(Map<String, Object> map) {
		return this.noticeDAO.getMaxNum(map);
	}

}
