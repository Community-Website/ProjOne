package pack.spring.community.noticeBBS;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack.spring.community.common.PaginationInfo;
import pack.spring.community.common.UtilMgr;
import pack.spring.community.memberModel.MemberService;

@Controller
public class NoticeController {
	private static final String SAVEFOLER = "E:/silsp/Community/WebContent/fileUpload";
	private static String encType = "UTF-8";
	private static int maxSize = 5 * 1024 * 1024;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	MemberService memberService;
	////////////////////////////////// G E T 방 식 /////////////////////////////////////////////
	//공지사항 쓰기 get
	@RequestMapping(value = "/noticeBBS/n_write", method = RequestMethod.GET)
	public ModelAndView write() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/noticeBBS/n_write");
		return mav;
	}
	
	// 글 목록 불러오기
		@RequestMapping(value = "/noticeBBS/n_list")
		public ModelAndView list(@RequestParam Map<String, Object> map,@RequestParam(value="nowPage", required = false) String nowPage) {

			//System.out.println("글 목록 불러오기 map=" + map.get("keyWord") + map.get("keyField"));
			List<Map<String, Object>> list = this.noticeService.noticeList(map);
			/*
			 * for (int i = 0; i < list.size(); i++) { System.out.println((String)
			 * list.get(i).get("uName")); }
			 */
			/////////////////////// 페이징 관련 속성 값 시작///////////////////////////
			// 페이징(Paging) = 페이지 나누기를 의미함
			int totalRecord = 0; // 전체 데이터 수(DB에 저장된 row 개수)
			int pageSize = 10; // 페이지당 출력하는 데이터 수(=게시글 숫자)
			int blockSize = 5; // 블럭당 표시되는 페이지 수의 개수
			int totalPage = 0; // 전체 페이지 수
			int totalBlock = 0; // 전체 블록수

			/*
			 * 페이징 변수값의 이해 totalRecord=> 200 전체레코드 numPerPage => 10 pagePerBlock => 5
			 * totalPage => 20 totalBlock => 4 (20/5 => 4)
			 */
			int currentPage = 1; // 현재 (사용자가 보고 있는) 페이지 번호
			if(nowPage !=null&& !nowPage.isEmpty()) {
				currentPage=Integer.parseInt(nowPage);
			}
			int nowBlock = 1; // 현재 (사용자가 보고 있는) 블럭

			int start = 0; // DB에서 데이터를 불러올 때 시작하는 인덱스 번호
			int end = 5; // 시작하는 인덱스 번호부터 반환하는(=출력하는) 데이터 개수
			// select * from T/N where... order by ... limit 5, 5;
			// 데이터가 6개 1~5
			// 인덱스번호 5이므로 6번 자료를 의미 5개

			int listSize = 0; // 1페이지에서 보여주는 데이터 수
			// 출력할 데이터의 개수 = 데이터 1개는 가로줄 1개

			// 게시판 검색 관련소스
			String keyField = ""; // DB의 컬럼명
			String keyWord = ""; // DB의 검색어

			if (map.get("keyWord") != null) {
				keyField = (String) map.get("keyField");
				keyWord = (String) map.get("keyWord");
			}

			if (map.get("currentPage") != null) {
				currentPage = (int) map.get("currentPage");
				start = (currentPage * pageSize) - pageSize; // 2 페이지라면 start 5
				end = pageSize; // 2 페이지라고 하더라도 end 5
			}

			/*
			 * select * from tblBoard order by num desc limit 10, 10; 데이터가 100개 => num : 100
			 * 99 98 97 ... 91 | 90 .... 2 1 start, end : 0 1 2 3.... 9 10 페이지당 출력할 데이터 수
			 * 10개 현재 페이지 1페이지라면 => 1페이지의 출력결과 100 ~ 91 2페이지(= currentPage가 2라는 의미) 90~81
			 * 3페이지 80~71
			 */

			totalRecord = 0;
			if (list != null) {
				totalRecord = list.size();
			}
			PaginationInfo pagingInfo = new PaginationInfo(currentPage, totalRecord, pageSize, blockSize);
			// 전체 데이터 수 반환

			nowBlock = (int) Math.ceil((double) pagingInfo.getCurrentPage() / pagingInfo.getBlockSize());
			totalBlock = (int) Math.ceil((double) pagingInfo.getTotalPage() / pagingInfo.getBlockSize());

			/////////////////////// 페이징 관련 속성 값 끝///////////////////////////

			ModelAndView mav = new ModelAndView();

			mav.addObject("list", list);
			mav.addObject("pagingInfo", pagingInfo);
			mav.addObject("nowBlock", nowBlock);
			mav.addObject("totalBlock", totalBlock);

			mav.setViewName("/noticeBBS/n_list");

			return mav;

		}
		
		// 글 상세 페이지 보기
		@RequestMapping(value = "/noticeBBS/n_detail", method = RequestMethod.GET)
		public ModelAndView detail(HttpServletRequest request,@RequestParam int num) {	
			HttpSession session = request.getSession();
			String uId= (String) session.getAttribute("uId_Session");
			String uName = this.memberService.getMemberName(uId);
			// 글 조회수 증가
			int cnt = this.noticeService.upCount(num);
			
			Map<String, Object> detailMap = this.noticeService.detail(num);
			
			int ref= num;
			List<Map<String, Object>> list= this.noticeService.noticeReplyList(ref);
			
			ModelAndView mav = new ModelAndView();
			
			mav.addObject("detail", detailMap);
			mav.addObject("list", list);
			mav.addObject("uId", uId);
			mav.addObject("uName", uName);
			mav.addObject("num", num);
			mav.setViewName("/noticeBBS/n_detail");

			return mav;
		}
	////////////////////////////////// P O S T 방 식 /////////////////////////////////////////////////////////////////////////
	//공지사항 쓰기 post
	@RequestMapping(value = "/noticeBBS/n_write", method = RequestMethod.POST)
	public ModelAndView writePost(HttpServletRequest request, @RequestParam Map<String, Object> map) throws IOException {
		int maxNum =this.noticeService.getMaxNum(map);
		int ref = maxNum + 1;

		MultipartRequest multi = null;

		int fileSize = 0;
		String fileName = null;

		File file = new File(SAVEFOLER);

		if (!file.exists()) {
			file.mkdirs();
		}

		multi = new MultipartRequest(request, SAVEFOLER, maxSize, encType, new DefaultFileRenamePolicy());

		if (multi.getFilesystemName("fileName") != null) {
			fileName = multi.getFilesystemName("fileName");
			fileSize = (int) multi.getFile("fileName").length();

		}

		String uId = multi.getParameter("uId");
		String uName = multi.getParameter("uName");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");

		if (multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
			// ignoreCase, 대소문자 무시, tExt == TEXT => true
			content = UtilMgr.replace(content, "<", "&lt;");
			// a1, a2, a3
			// 입력값 가정 => ABC<p>가나다</p>
			// UtilMgr.replace( ) 실행 후 content에 저장되는 값 ABC&lt;p>가나다&lt;p>
		}

		map.put("uId", uId);
		map.put("uName", uName);
		map.put("subject", subject);
		map.put("content", content);
		map.put("ref", ref);
		map.put("fileName", fileName);
		map.put("fileSize", fileSize);

		int cnt = this.noticeService.insert(map);
		
		String msg = "글 등록 실패!", url="/noticeBBS/n_write";
		if (cnt>0) {
			msg = "글이 등록되었습니다.";
			url = "/noticeBBS/n_list";
		}
		System.out.println("글등록 url="+url);
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		mav.setViewName("/common/message");
		return mav;
	}
	//상세보기 코멘트 달기
	@RequestMapping(value = "/noticeBBS/n_reply", method = RequestMethod.POST)
	public ModelAndView replyPost(@RequestParam Map<String, Object> map) throws IOException {
		int num=Integer.parseInt((String) map.get("num"));
		int ref =num;
		map.put("ref", ref);
		int cnt=this.noticeService.insertReply(map);
		ModelAndView mav=new ModelAndView();
		mav.setViewName("redirect:/noticeBBS/n_detail?num="+num);
		return mav;
	}
}
