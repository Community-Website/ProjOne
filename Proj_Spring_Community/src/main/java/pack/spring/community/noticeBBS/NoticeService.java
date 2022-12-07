package pack.spring.community.noticeBBS;

import java.util.Map;

public interface NoticeService {
	int insert(Map<String, Object> map);
	
	int getMaxNum(Map<String, Object> map);
}
