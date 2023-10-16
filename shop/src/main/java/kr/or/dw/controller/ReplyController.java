package kr.or.dw.controller;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.dw.domain.BoardReplyVO;
import kr.or.dw.domain.ReplyVO;
import kr.or.dw.service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	//댓글 작성 부
	@RequestMapping(value = "/board/replyWrite", method = RequestMethod.POST)
	public String postWrite(BoardReplyVO reply) throws SQLException {
		logger.info("post board reply"); 
		
		
		replyService.wrtie(reply);
		
		
		return "redirect:/board/view?bno=" + reply.getBno();
	}
	
	@GetMapping(value = "/board/replyUpdate")
	public void getReplyUpdate(@RequestParam("rno") int rno, @RequestParam("bno") int bno,Model model) throws SQLException {
	    logger.info("get reply update");
	    
	    BoardReplyVO vo = new BoardReplyVO();
	    vo.setBno(bno);
	    vo.setRno(rno);
	    
	    BoardReplyVO reply = replyService.replySelect(vo);
	    
	    model.addAttribute("reply", reply);
	    
	}
	
	@RequestMapping(value = "/board/replyUpdate", method = RequestMethod.POST)
	public String postReplyUpdate(BoardReplyVO vo) throws SQLException {
		
		replyService.replyUpdate(vo);
		
		return "redirect:/board/view?bno=" + vo.getBno() + "&rno=" +vo.getRno();
	}
	
	
	// 댓글 삭제
	@RequestMapping(value ="/board/replyDelete", method = RequestMethod.POST)
	public String replyDelete(BoardReplyVO vo) throws SQLException {
		logger.info("reply Delete");
		replyService.replyDelete(vo);
		
		return "redirect:/board/view?bno=" +vo.getBno() +"&rno=" + vo.getRno();
	}
	
}
