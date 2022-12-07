package pack.spring.community.noticeBBS;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack.spring.community.common.UtilMgr;

@Controller
public class NoticeController {
	private static final String SAVEFOLER = "E:/silsp/Community/WebContent/fileUpload";
	private static String encType = "UTF-8";
	private static int maxSize = 5 * 1024 * 1024;
	
	@Autowired
	NoticeService noticeService;
	////////////////////////////////// G E T 방 식 /////////////////////////////////////////////
	//공지사항 쓰기 get
	@RequestMapping(value = "/noticeBBS/n_write", method = RequestMethod.GET)
	public ModelAndView write() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/noticeBBS/n_write");
		return mav;
	}
	
	////////////////////////////////// P O S T 방 식 ///////////////////////////////////////////////
	//공지사항 쓰기 post
	@RequestMapping(value = "/noticeBBS/n_write", method = RequestMethod.POST)
	public ModelAndView writePost(HttpServletRequest request, @RequestParam Map<String, Object> map) throws IOException {
		int maxNum =0;
		/*
		 * if((Integer)this.noticeService.getMaxNum(map) != null) {
		 * maxNum=this.noticeService.getMaxNum(map); }
		 */
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
	
}
