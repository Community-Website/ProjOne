package pack.spring.community.bbs;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.spring.community.common.ConstUtil;
import pack.spring.community.common.PaginationInfo;
import pack.spring.community.common.SearchVO;
import pack.spring.community.memberModel.MemberService;

@Controller
public class BoardController {
	@Autowired
	BoardService boardService;
	MemberService memberService;
	
	//글쓰기 화면 보기
	@ RequestMapping(value="/bbs/write", method = RequestMethod.GET)
	public ModelAndView write(HttpServletRequest request, @RequestParam String uId) {
		ModelAndView mav = new ModelAndView();
		System.out.println("여기까지");
		String uName = this.memberService.getMemberName(uId);
			
		mav.addObject("uName", uName);
		mav.setViewName("/bbs/write");
			
		return mav;
	}
		
	//글 쓰기 입력 처리
	@RequestMapping(value = "/bbs/write", method = RequestMethod.POST)
	public ModelAndView writePost(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		String num = this.boardService.write(map);
		
		if(num == null) {
			mav.setViewName("redirect:/bbs/write");
			mav.addObject(num);
		}else {
			mav.setViewName("redirect:/bbs/detail?num="+num);
		}
		
		return mav;
	}
	
	//글 목록 불러오기
	@RequestMapping(value = "/bbs/list")
	public ModelAndView list(@RequestParam Map<String, Object> map) {				
		List<Map<String, Object>> list = this.boardService.list(map); 

		ModelAndView mav = new ModelAndView(); 
		
		mav.addObject("list", list); 
		
		mav.setViewName("/bbs/list"); 
		
		return mav;
		
	}
	
}
