package pack.spring.community.admin;

import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import pack.spring.community.common.PaginationInfo;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	
	// 회원 목록 조회
	@RequestMapping(value = "/admin/memberList")
	public ModelAndView selectAllMem(@RequestParam Map<String, Object> map,
			@RequestParam(value="nowPage", required = false) String nowPage) {
		List<Map<String, Object>> memList= this.adminService.selectAllMem(map);
		
		
		// 페이징 관련 속성값
		int totalRecord = 0; // 전체 데이터 수 
		int pageSize = 5; // 페이지당 출력하는 데이터 수 (=회원 목록 숫자)
		int blockSize = 5; // 블럭당 표시되는 페이지 수의 개수
		int totalPage = 0; // 전체 페이지 수
		int totalBlock = 0; // 전체 블록수
		
		int currentPage = 1; //현재 (사용자가 보고 있는) 페이지 번호
		
		if(nowPage != null && !nowPage.isEmpty()) {
			currentPage = Integer.parseInt(nowPage);
		}
		
		int nowBlock = 1; // 현재 (사용자가 보고 있는) 블럭
		
		int start = 0; // DB에서 데이터를 불러올 때 시작하는 익덱스 번호
		int end = 10; // 시작하는 인덱스 번호부터 반환하는(=출력하는) 데이터 개수
		
		int listSize = 0;
		
		// 회원 검색 소스
		String keyField = ""; // DB의 컬럼명 
		String keyWord = ""; // DB의 검색어
		
		if(map.get("keyWord") != null) {
			keyField = (String) map.get("keyField");
			keyWord = (String) map.get("keyWord");
		}
		
		if(map.get("currentPage") != null	) {
			currentPage = (int) map.get("currentPage");
			start = (currentPage * pageSize) - pageSize;
			end = pageSize;
		}
		
		totalRecord = 0;
		if(memList != null) {
			totalRecord = memList.size();
		}
		
		PaginationInfo pagingInfo = new PaginationInfo(currentPage, totalRecord, pageSize, blockSize);
		// 전체 데이터 수 반환

		nowBlock = (int) Math.ceil((double) pagingInfo.getCurrentPage() / pagingInfo.getBlockSize());
		totalBlock = (int) Math.ceil((double) pagingInfo.getTotalPage() / pagingInfo.getBlockSize());
		// 페이징 관련 속성 값 끝
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("memList", memList);
		mav.addObject("pagingInfo", pagingInfo);
		mav.addObject("nowBlock", nowBlock);
		mav.addObject("totalBlock", totalBlock);
		
		mav.setViewName("/admin/memberList");
		
		return mav;
	}
	
	// 회원 정보 조회
	@RequestMapping(value="/admin/memberDetail", method = RequestMethod.GET)
	public ModelAndView memDetail(@RequestParam int num) {
		Map<String, Object> mem =this.adminService.memDetail(num);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("mem", mem);
		mav.setViewName("/admin/memberDetail");
		
		return mav;	
	}
	
	// 회원 정보 수정 화면 보여주기
	@RequestMapping(value="/admin/memberModify", method = RequestMethod.GET)
	public ModelAndView memberModify(@RequestParam int num) {
		Map<String, Object> mem = this.adminService.memDetail(num);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("mem", mem);
		mav.setViewName("/admin/memberModify");
		
		return mav;
	}
	
	// 회원 정보 수정 처리
	@RequestMapping(value="/admin/memberModify", method = RequestMethod.POST)
	public ModelAndView memUpdate(@RequestParam Map<String, Object> map, 
			@RequestParam int num) {
		ModelAndView mav = new ModelAndView();
		
		int cnt = this.adminService.memUpdate(map);
		
		String msg = "회원 정보 수정 실패!", url = "/admin/memberModify?num="+num;
		if (cnt > 0) {
			msg = "회원 정보가 수정되었습니다.";
			url = "/admin/memberDetail?num="+ num;
		}
		
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		mav.setViewName("/common/message");
		
		return mav;
		
	}
	
	// 회원 삭제 화면 보여주기
	@RequestMapping(value="/admin/memberDelete", method = RequestMethod.GET)
	public ModelAndView memDeleteChk() {
		return new ModelAndView("/admin/memberDelete");
	}
	
	// 회원 삭제 처리
	@RequestMapping(value="/admin/memberDelete", method = RequestMethod.POST)
	public ModelAndView memDelete(@RequestParam int num, 
			@RequestParam String uPw, @RequestParam String uId) {
		ModelAndView mav = new ModelAndView();
		
		String adminPw = this.adminService.adminPw(uId);
		
		String msg = "", url = "";
		if(adminPw.equals(uPw)) {
			int cnt = this.adminService.memDelete(num);
		
			if(cnt > 0) {
				msg = "회원이 삭제 되었습니다.";
				url = "/admin/memberList";
			}else {
				msg = "회원 삭제 실패!";
				url = "/admin/memberDetail?num="+num;
			}
		}else {
			msg = "비밀번호를 확인하세요";
			url = "/admin/memberDelete?num="+num;
		}
		
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		mav.setViewName("/common/message");
		
		return mav;
	}
}
