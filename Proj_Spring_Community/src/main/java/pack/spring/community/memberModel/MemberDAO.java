package pack.spring.community.memberModel;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MemberDAO {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insert(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("member.insert", map);
	}

	/* 아이디 중복 검사 시작(/member/idCheck.jsp) */
	public int checkId(String uId) {
		return this.sqlSessionTemplate.selectOne("member.checkId", uId);
	}
	/* 아이디 중복 검사 끝(/member/idCheck.jsp) */

	
	/* 우편번호 찾기 시작(/member/zipCheck.jsp) */
	public List<Map<String, Object>> zipcodeRead(String area3) {
		return this.sqlSessionTemplate.selectList("member.zipcodeRead", area3);
	}

	/* 우편번호 찾기 끝(/member/zipCheck.jsp) */

	
	/* 회원가입 시작 (/member/memberProc.jsp) */
	public int insertMember(Map<String, Object> map) {
		String value = (String) map.get("uHobby");
		System.out.println();
		String[] hobby = value.split(" ");
		String[] hobbyName = {"인터넷", "여행", "게임", "영화", "운동"};
		char[] hobbyCode = {'0', '0', '0', '0', '0'};
		for (int i=0; i<hobby.length; i++) {
			for(int j=0; j<hobbyName.length; j++) {
				if (hobby[i].equals(hobbyName[j])) {
					hobbyCode[j] = '1';
				}
			}
		}
		map.put("uHobby", new String(hobbyCode));
		return this.sqlSessionTemplate.insert("member.insert", map);
	}
	/* 회원가입 끝 (/member/memberProc.jsp) */

	
	/* 로그인 처리 시작 (/member/loginProc.jsp) */
	public int loginMember(Map<String, Object> map) {
		
		return this.sqlSessionTemplate.selectOne("member.loginMember", map);
	}
	/* 로그인 처리 끝 (/member/loginProc.jsp) */

	
	/* 회원정보 불러오기 시작 (/member/memberModProc.jsp) */
	public Map<String, Object> modifyMember(String uId) {
		return this.sqlSessionTemplate.selectOne("member.modifyMember", uId);
	}
	/* 회원정보 불러오기 끝 (/member/memberModProc.jsp) */
	
	
	/* 회원정보 수정 시작 (/member/memberModProc.jsp) */
	public int updateMember(Map<String, Object> map) {
		String value = (String) map.get("uHobby");
		System.out.println();
		String[] hobby = value.split(" ");
		String[] hobbyName = {"인터넷", "여행", "게임", "영화", "운동"};
		char[] hobbyCode = {'0', '0', '0', '0', '0'};
		for (int i=0; i<hobby.length; i++) {
			for(int j=0; j<hobbyName.length; j++) {
				if (hobby[i].equals(hobbyName[j])) {
					hobbyCode[j] = '1';
				}
			}
		}
		map.put("uHobby", new String(hobbyCode));
		return this.sqlSessionTemplate.update("member.updateMember", map);
	}
	/* 회원정보 수정 끝 (/member/memberModProc.jsp) */

	
	/* 회원탈퇴 시작 (/member/memberQuitProc.jsp) */
	public int quitMember(String uId) {
		return this.sqlSessionTemplate.delete("member.quitMember", uId);
	}
	/* 회원탈퇴 끝 (/member/memberQuitProc.jsp) */

	
	/* 로그인 사용자 이름 반환(/bbs/write.jsp) 시작 */
	public String getMemberName(String uId) {
		return this.sqlSessionTemplate.selectOne("member.getMemberName", uId);
	}
	/* 로그인 사용자 이름 반환(/bbs/write.jsp) 끝 */
}
