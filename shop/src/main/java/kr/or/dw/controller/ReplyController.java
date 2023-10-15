package kr.or.dw.controller;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.dw.domain.BoardReplyVO;
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
	
	
}
