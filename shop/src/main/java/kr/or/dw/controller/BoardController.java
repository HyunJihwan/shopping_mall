package kr.or.dw.controller;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.Criteria;
import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.domain.BoardReplyVO;
import kr.or.dw.domain.BoardVO;
import kr.or.dw.domain.LikeVO;
import kr.or.dw.domain.MemberVO;
import kr.or.dw.service.BoardService;
import kr.or.dw.service.ReplyService;
import kr.or.dw.utils.UploadFileUtils;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ReplyService replyService;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ModelAndView list(ModelAndView mnv, Criteria cri) throws SQLException {
		logger.info("get board");
		String url = "/board/list";
		
		List<BoardVO> list = null;
		list = boardService.list(cri);
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.listCount());
		mnv.setViewName(url);
		mnv.addObject("list", list);
		mnv.addObject("pageMaker",pageMaker);
		
		return mnv;
	}
	
	
	// 게시물 작성
	@GetMapping
	(value="/write")
	public void getWrite() throws Exception {
		logger.info("get write");
		
	}
	
	
	// 게시물 작성
	@RequestMapping(value="/write", method = RequestMethod.POST)
	public String postWrite(BoardVO vo, MultipartFile file) throws Exception {
		logger.info("post write");
		
		 String imgUploadPath = uploadPath + File.separator + "imgUpload";  // 이미지를 업로드할 폴더를 설정 = /uploadPath/imgUpload
		 String ymdPath = UploadFileUtils.calcPath(imgUploadPath);  // 위의 폴더를 기준으로 연월일 폴더를 생성
		 String fileName = null;  // 기본 경로와 별개로 작성되는 경로 + 파일이름
		 
		 if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			 
			 fileName =  UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			 
			  
			    vo.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			 	 
		 }else {
			 fileName = File.separator + "images" + File.separator + "none.png";
			 vo.setImg(fileName);
		 }
		 
		
		boardService.write(vo);
		 
		 return "redirect:/board/listSearch";
	}
	
	// 게시글 조회 + 조회수
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public void getView(@RequestParam("bno") int bno, Model model,HttpSession session) throws SQLException {
		logger.info("get View");
		BoardVO vo = boardService.view(bno);

		boardService.viewCnt(bno);
		model.addAttribute("view" ,vo);
		
		// 댓글 구현 부분
		MemberVO member = (MemberVO) session.getAttribute("member");
		System.out.println("Member object from session: " + member);
		
//		LikeVO like = new LikeVO();
//		like.setBno(vo.getBno());
//		like.setUserId(member.getUserId());
//		
//		System.out.println("확인용 1 : " + like.getBno());
//		System.out.println("확인용 2 : " + like.getUserId());
//		
//		
//		
//		if(member != null) {
//			boardService.selectLike(like);
//			System.out.println("들어온 like :  " + like);
//		}
		
		
		List<BoardReplyVO> reply = null;
		
		reply = replyService.list(bno);			
		model.addAttribute("reply", reply);
		
		
		
	}
	
	
	
	@GetMapping
	(value ="/modify")
	public void getModify(@RequestParam("bno") int bno, Model model) throws SQLException {
		logger.info("get Modify");
		
		BoardVO vo = boardService.view(bno);
		model.addAttribute("view", vo);
		
	}
	
	// 이미지만
	@RequestMapping(value = "/modify" , method = RequestMethod.POST)
	public String postModify(BoardVO board, MultipartFile file, HttpServletRequest req) throws IOException, Exception {
		logger.info("post Modify");
		
			// 새로운 파일이 등록되었는지 확인
				 if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
				  // 기존 파일을 삭제
				  new File(uploadPath + req.getParameter("img")).delete();
				  
				  // 새로 첨부한 파일을 등록
				  String imgUploadPath = uploadPath + File.separator + "imgUpload";
				  String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
				  String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
				  
				  board.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
				  
				 } else {  // 새로운 파일이 등록되지 않았다면
				  // 기존 이미지를 그대로 사용
				  board.setImg(req.getParameter("img"));
				  
				 }
				
		
		
		boardService.modify(board);
		
		return "redirect:/board/view?bno=" + board.getBno();
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("bno") int bno, Model model, HttpSession session) throws SQLException {
	    logger.info("Delete");

	    MemberVO member = (MemberVO) session.getAttribute("member");

	    if (member == null) {
	        return "redirect:/member/signin";
	    }

	    // 게시글 정보를 가져옵니다.
	    BoardVO board = boardService.getBoard(bno);

	    if (board == null || !board.getUserId().equals(member.getUserId())) {
	        return "redirect:/board/listSearch";
	    }

	    boardService.delete(bno);
	    return "redirect:/board/listSearch";
	}
	
	@RequestMapping(value = "/listSearch", method = RequestMethod.GET)
	public void listSearch(@ModelAttribute("scri") SearchCriteria scri, Model model) throws SQLException {
		logger.info("get list search");
		
		List<BoardVO> searchList = boardService.listSearch(scri);
		model.addAttribute("searchList" , searchList);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(boardService.countSearch(scri));
		model.addAttribute("pageMaker", pageMaker);
		
	}
	
	
	// 좋아요 체크 여부
	@RequestMapping(value = ("/likeChk/{bno}/{userId}"), method = RequestMethod.GET)
	public ResponseEntity<Integer> likeChk(@PathVariable("bno") int bno, @PathVariable String userId) throws SQLException{
		System.out.println("들어옴?");
		
		return new ResponseEntity<>(boardService.likeChk(bno, userId), HttpStatus.OK);
	}
	
	
	// 좋아요 등록
	@RequestMapping(value ="/likeUp", method = RequestMethod.POST)
	public ResponseEntity<String> likeUp(@RequestBody LikeVO like, HttpSession session) throws SQLException{
		
		
		int result = boardService.likeUp(like);
		
		System.out.println(result + "하트 등록 ~");
		
		
		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 좋아요 취소
	@RequestMapping(value = "/likeDown", method = RequestMethod.POST)
	public ResponseEntity<String> likeDown (@RequestBody LikeVO like) throws SQLException{
		int result = boardService.likeDown(like);
		System.out.println( result + "하트삭제 ~");
		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
		
	
		
		
		
	
	
}
