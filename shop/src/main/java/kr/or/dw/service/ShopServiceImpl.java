package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.dao.ShopDAO;
import kr.or.dw.domain.CartListVO;
import kr.or.dw.domain.CartVO;
import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.domain.OrderDetailVO;
import kr.or.dw.domain.OrderListVO;
import kr.or.dw.domain.OrderVO;
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

	@Override
	public void deleteReply(ReplyVO reply) throws SQLException {
		shopDAO.deleteReply(reply);
		
	}

	@Override
	public String idCheck(int repNum) throws SQLException {
		
		return shopDAO.idCheck(repNum);
	}

	@Override
	public void modifyReply(ReplyVO reply) throws SQLException {
		shopDAO.modifyReply(reply);
		
	}

	@Override
	public void addCart(CartVO cart) throws SQLException {
		shopDAO.addCart(cart);
		
	}

	@Override
	public List<CartListVO> cartList(String userId) throws SQLException {
		
		return shopDAO.cartList(userId);
	}

	@Override
	public void deleteCart(CartVO cart) throws SQLException {
		shopDAO.deteteCart(cart);
		
	}

	@Override
	public void orderInfo(OrderVO order) throws SQLException {
		shopDAO.orderInfo(order);
		
	}

	@Override
	public void orderInfo_Details(OrderDetailVO orderDetail) throws SQLException {
		shopDAO.orderInfo_Details(orderDetail);
		
	}

	@Override
	public void cartAllDelete(String userId) throws SQLException {
		shopDAO.cartAllDelete(userId);
		
	}

	@Override
	public List<OrderVO> orderList(OrderVO order) throws SQLException {
		
		return shopDAO.orderList(order);
	}

	@Override
	public List<OrderListVO> orderView(OrderVO order) throws SQLException {
		
		return shopDAO.orderView(order);
	}

	
}
