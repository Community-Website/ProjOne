package pack.spring.community.common;

public interface ConstUtil {
	//게시판 페이징 관련 상수
	public static final int RECORD_COUNT=5;
	int BLOCKSIZE=10;

	//파일 업로드 관련 상수
	//String FILE_UPLOAD_TYPE="test";   //테스트시
	String FILE_UPLOAD_TYPE="deploy"; //배포시
	
	//자료실 - 파일 저장 경로
	String FILE_UPLOAD_PATH="board_upload";
	//String FILE_UPLOAD_PATH_TEST="C:\\lecture\\workspace_list\\spboot_ws\\springherb\\src\\main\\resources\\static\\pds_upload";
	String FILE_UPLOAD_PATH_TEST="C:\\board_upload";
	
	//관리자 페이지 - 상품 등록시 상품 이미지 저장 경로
	//String IMAGE_FILE_UPLOAD_PATH="board_images";
	//String IMAGE_FILE_UPLOAD_PATH_TEST="C:\\lecture\\workspace_list\\spboot_ws\\springherb\\src\\main\\resources\\static\\pd_images";
	//String IMAGE_FILE_UPLOAD_PATH_TEST="C:\\lecture\\board_images";
	
	//자료실 업로드인지, 상품 등록시 업로드인지 구분값
	int UPLOAD_FILE_FLAG=1;  //자료실 업로드
	//int UPLOAD_IMAGE_FLAG=2; //상품 등록시 이미지 업로드
	
}