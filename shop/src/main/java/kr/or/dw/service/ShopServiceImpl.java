package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.dao.ShopDAO;
import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.domain.ReplyListVO;
import kr.or.dw.domain.ReplyVO;

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	ShopDAO shopDAO;

	@Override
	public List<GoodsViewVO> list(int cateCode) throws SQLException {
		
		return shopDAO.list(cateCode);
	}

	@Override
	public GoodsViewVO goodsView(int gdsNum) throws SQLException {
		
		return shopDAO.goodsView(gdsNum);
	}

	@Override
	public void registReply(ReplyVO reply) throws SQLException {
		shopDAO.registReply(reply);
		
	}

	@Override
	public List<ReplyListVO> replyList(int gdsNum) throws SQLException {
		
		return shopDAO.replyList(gdsNum);
	}
}
