package pack.spring.community.memberController;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.spring.community.memberModel.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService memberService;
	
////////////////////////////// G E T 방식 /////////////////////////////////////////////////////////////////////////////////////////
	// 회원가입 get
	@RequestMapping(value = "/member/create", method = RequestMethod.GET)
	public ModelAndView create() {
		return new ModelAndView("/member/create");
	}

	// 개인정보동의 get
	@RequestMapping(value = "/member/joinAgreement", method = RequestMethod.GET)
	public ModelAndView joinAgreement() {
		return new ModelAndView("/member/joinAgreement");
	}

	// 아이디 중복확인 get
	@RequestMapping(value = "/member/idCheck", method = RequestMethod.GET)
	public ModelAndView idCheck(@RequestParam String uId) {
		boolean bool = this.memberService.checkId(uId);
		System.out.println("아이디 중복확인 bool=" + bool);
		ModelAndView mav = new ModelAndView();
		mav.addObject("idCheck", bool);
		mav.setViewName("/member/idCheck");
		return mav;
	}

	// 주소찾기
	@RequestMapping(value = "/member/zipCheck", method = RequestMethod.GET)
	public ModelAndView zipCheck() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/zipCheck");
		return mav;
	}

	// 회원가입확인 get
	@RequestMapping(value = "/member/memberProc", method = RequestMethod.GET)
	public ModelAndView memberProc() {
		return new ModelAndView("/member/memberProc");
	}

	// 로그인 get
	@RequestMapping(value = "/member/login", method = RequestMethod.GET)
	public ModelAndView login() {
		return new ModelAndView("/member/login");
	}
	
	// 로그인확인 get
	@RequestMapping(value = "/member/loginProc", method = RequestMethod.GET)
	public ModelAndView loginProc(HttpServletRequest request,@RequestParam String uId, boolean loginRes) {
		HttpSession session =request.getSession();
		if(loginRes) {
			session.setAttribute("uId_Session", uId);			
		}
		return new ModelAndView("/member/loginProc");
	}
	// 로그아웃 get
	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
	public ModelAndView logoutProc(HttpServletRequest request) {
		HttpSession session =request.getSession();
		session.invalidate();
		return new ModelAndView("/member/logout");
	}
	// 마이페이지 get
	@RequestMapping(value = "/member/myPage", method = RequestMethod.GET)
	public ModelAndView myPageProc() {
		return new ModelAndView("/member/myPage");
	}
	// 회원정보수정 get
	@RequestMapping(value = "/member/memberMod", method = RequestMethod.GET)
	public ModelAndView memberMod(HttpServletRequest request,@RequestParam String uId) {
		HttpSession session =request.getSession();
		session.setAttribute("uId_Session", uId);
		Map<String, Object> map=this.memberService.modifyMember(uId);
		ModelAndView mav=new ModelAndView();
		mav.addObject("mBean", map);
		mav.setViewName("/member/memberMod");
		return mav;
	}
	// 회원정보 수정 확인 get
	@RequestMapping(value = "/member/memberModProc", method = RequestMethod.GET)
	public ModelAndView memberModProc() {
		return new ModelAndView("/member/memberModProc");
	}
	
	// 회원탈퇴  get
	@RequestMapping(value = "/member/memberQuit", method = RequestMethod.GET)
	public ModelAndView memberQuit() {
		
		return new ModelAndView("/member/memberQuit");
	}
	// 회원탈퇴 확인  get
	@RequestMapping(value = "/member/memberQuitProc", method = RequestMethod.GET)
	public ModelAndView memberQuitProc() {
		return new ModelAndView("/member/memberQuitProc");
	}
	
	
	
////////////////////////////// P O S T 방식 ///////////////////////////////////////////////////////////////////////////////////


	// 회원가입 post
	@RequestMapping(value = "/member/create", method = RequestMethod.POST)
	public ModelAndView createPost(@RequestParam Map<String, Object> map) {
		String value = (String) map.get("uHobby");
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
		ModelAndView mav = new ModelAndView();
		boolean joinRes = this.memberService.insertMember(map);

		mav.addObject("joinRes", joinRes);
		mav.setViewName("redirect:/member/memberProc");

		return mav;
	}

	// 개인정보동의 post
	@RequestMapping(value = "/member/joinAgreement", method = RequestMethod.POST)
	public ModelAndView joinAgreementPost(@RequestParam String vCode) {
		System.out.println("회원가입 파라미터 vCode=" + vCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("vCode", vCode);
		mav.setViewName("redirect:/member/create");
		return mav;
	}

	// 주소찾기 post
	@RequestMapping(value = "/member/zipCheck", method = RequestMethod.POST)
	public ModelAndView zipCheckPost(@RequestParam String area3) {
		System.out.println("여기까지 됨");
		List<Map<String, Object>> map = this.memberService.zipcodeRead(area3);
		ModelAndView mav = new ModelAndView();
		mav.addObject("objList", map);
		mav.addObject("area3", area3);
		mav.setViewName("/member/zipCheck");
		return mav;
	}

	// 로그인 post
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public ModelAndView loginPost(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		boolean loginRes = this.memberService.loginMember(map);
		String uId=(String) map.get("uId");
		System.out.println("로그인 loginRes="+loginRes+" uId="+uId);
		mav.addObject("loginRes", loginRes);
		mav.addObject("uId", uId);
		mav.setViewName("redirect:/member/loginProc");

		return mav;
	}
	
	// 회원정보수정 post
	@RequestMapping(value = "/member/memberMod", method = RequestMethod.POST)
	public ModelAndView memberModPost(@RequestParam Map<String, Object> map) {
		String value = (String) map.get("uHobby");
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
		ModelAndView mav = new ModelAndView();
		boolean editRes = this.memberService.updateMember(map);

		mav.addObject("editRes", editRes);
		mav.setViewName("redirect:/member/memberModProc");

		return mav;
	}
	
	// 회원탈퇴  post
	@RequestMapping(value = "/member/memberQuit", method = RequestMethod.POST)
	public ModelAndView memberQuitPost(HttpServletRequest request,@RequestParam String uId) {
		HttpSession session = request.getSession();
		String uId_Session = (String)session.getAttribute("uId_Session"); 
		session.invalidate();
		Cookie[] ck= request.getCookies();
		for(int i=0; i<ck.length;i++){
			if(ck[i].getName()==uId_Session){
				ck[i].setMaxAge(0);
				break;
			}
		}
		ModelAndView mav = new ModelAndView();
		boolean quitRes = this.memberService.quitMember(uId);

		mav.addObject("quitRes", quitRes);
		mav.setViewName("redirect:/member/memberQuitProc");

		return mav;
	}
}
