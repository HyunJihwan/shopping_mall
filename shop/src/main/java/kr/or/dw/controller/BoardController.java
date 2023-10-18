package kr.or.dw.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.Criteria;
import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.domain.BoardReplyVO;
import kr.or.dw.domain.BoardVO;
import kr.or.dw.domain.MemberVO;
import kr.or.dw.service.BoardService;
import kr.or.dw.service.ReplyService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
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
	public String postWrite(BoardVO vo) throws Exception {
		logger.info("post write");
		boardService.write(vo);
		 
		 return "redirect:/board/list";
	}
	
	// 게시글 조회 + 조회수
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public void getView(@RequestParam("bno") int bno, Model model,HttpSession session) throws SQLException {
		logger.info("get View");
		BoardVO vo = boardService.view(bno);
		
		boardService.viewCnt(bno);
		model.addAttribute("view" ,vo);
		
		// 댓글 구현 부분
		
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
	
	@RequestMapping(value = "/modify" , method = RequestMethod.POST)
	public String postModify(BoardVO board) throws SQLException {
		logger.info("post Modify");
		
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
	        return "redirect:/board/list";
	    }

	    boardService.delete(bno);
	    return "redirect:/board/list";
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
	
	
		
		
	
		
		
		
	
	
}
