package pack.spring.community.board;

import java.util.List;
import java.util.Map;

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

@Controller
public class BoardController {
	
	//글쓰기 화면 보기
	@ RequestMapping(value="/bbs/write", method = RequestMethod.GET)
	public ModelAndView write() {
		return new ModelAndView("/bbs/write");
	}
	
	@Autowired
	BoardService boardService;
	
	//글 쓰기 입력 처리
	@RequestMapping(value = "/bbs/write", method = RequestMethod.POST)
	public ModelAndView writePost(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		String num = this.boardService.write(map);
		
		if(num == null) {
			mav.setViewName("redirect:/bbs/write");
		}else {
			mav.setViewName("redirect:/bbs/detail?num="+num);
		}

		return mav;
	}
	
	//글 목록 불러오기
	@RequestMapping(value = "/bbs/list")
	public ModelAndView list(@RequestParam Map<String, Object> map, 
												@ModelAttribute SearchVO searchVo ) {		
		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(ConstUtil.BLOCKSIZE);
		pagingInfo.setRecordCountPerPage(ConstUtil.RECORD_COUNT);
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());
		
		//searchVo에 페이징 처리 관련 변수의 값 세팅
		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		searchVo.setRecordCountPerPage(ConstUtil.RECORD_COUNT);
			
		List<Map<String, Object>> list = this.boardService.list(map); 
		
		//totalRecord 개수 구하기
		int totalRecord = boardService.getTotalRecord(searchVo);
		
		pagingInfo.setTotalRecord(totalRecord);

		ModelAndView mav = new ModelAndView(); 
		
		mav.addObject("list", list); 
		mav.addObject("pagingInfo", pagingInfo);
		
		mav.setViewName("/bbs/list"); 
		
		return mav;
		
	}
	
}
