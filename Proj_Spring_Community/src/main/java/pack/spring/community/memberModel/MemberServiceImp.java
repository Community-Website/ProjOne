package pack.spring.community.memberModel;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImp implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public String create(Map<String, Object> map) {
		int affectRowCnt = this.memberDAO.insert(map);
		if (affectRowCnt == 1) {
			return map.get("member_id").toString();
		}
		return null;
	}

	/* 아이디 중복 검사 시작(/member/idCheck) */
	@Override
	public boolean checkId(String uId) {
		boolean res = false;
		int recordCnt = this.memberDAO.checkId(uId);
		// System.out.println("DB의 테이블에 저장된 입력한 ID의 갯수 : " + objRS.getInt(1));
		// objRS.getInt(1) 의 반환값이 1이라면 => 사용중인 아이디를 의미함
		// res값에는 true 저장해야 함.
		// objRS.getInt(1) 의 반환값이 0이라면 => 사용가능한 아이디를 의미함
		// res값에는 false 저장해야 함, 그러나 이미 false로 초기화되어 있으므로
		// 별도의 작업이 필요없음
		if (recordCnt==1)
			res = true;
		// DB에서 반환된 데이터가 1이라면 입력한 ID로 조회한 데이터가
		// 있다는 뜻이므로 다시 말하면 사용할 수 없는 아이디를 의미한다.

		return res;
		
	}

	/* 우편번호 찾기 시작(/member/zipCheck) */
	@Override
	public List<Map<String, Object>> zipcodeRead(String area3) {
		return this.memberDAO.zipcodeRead(area3);
	}

	/* 회원가입 시작 (/member/memberProc) */
	@Override
	public boolean insertMember(Map<String, Object> map) {
		boolean flag = false;
		int rowCnt= this.memberDAO.insertMember(map);
		System.out.println("회원가입 rowCnt="+rowCnt);
		if (rowCnt>0) flag = true;
		return flag;
	}

	/* 로그인 처리 시작 (/member/loginProc) */
	@Override
	public boolean loginMember(Map<String, Object> map) {
		boolean loginChkTF = false;
		int recordCnt = this.memberDAO.loginMember(map);
		if (recordCnt == 1)
			loginChkTF = true;
		return loginChkTF;
	}

	/* 회원정보 불러오기 시작 (/member/memberMod) */
	@Override
	public Map<String, Object> modifyMember(String uId) {
		Map<String, Object> map=this.memberDAO.modifyMember(uId);
		return map;
	}
	
	/* 회원정보 수정 시작 (/member/memberModProc) */
	@Override
	public boolean updateMember(Map<String, Object> map) {
		boolean flag = false;
		int rowCnt= this.memberDAO.updateMember(map);
		System.out.println("회원가입 rowCnt="+rowCnt);
		if (rowCnt>0) flag = true;
		return flag;
	}

	/* 로그인 사용자 이름 반환(/bbs/write) 시작 */
	@Override
	public String getMemberName(String uId) {
		return this.memberDAO.getMemberName(uId);
	}

	/* 회원탈퇴 시작 (/member/memberQuit) */
	@Override
	public boolean quitMember(String uId) {
		boolean flag = false;
		int rowCnt= this.memberDAO.quitMember(uId);
		System.out.println("회원탈퇴 rowCnt="+rowCnt);
		if (rowCnt>0) flag = true;
		return flag;
	}
	
}