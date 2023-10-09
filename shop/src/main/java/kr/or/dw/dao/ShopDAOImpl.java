package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.or.dw.domain.CartListVO;
import kr.or.dw.domain.CartVO;
import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.domain.ReplyListVO;
import kr.or.dw.domain.ReplyVO;

@Repository
public class ShopDAOImpl implements ShopDAO {
	
	@Inject
	private SqlSession sql;
	
	//매퍼
	private static String namespace = "kr.or.dw.mappers.shopMapper";

	@Override
	public List<GoodsViewVO> list(int cateCode) throws SQLException {
		
		return sql.selectList(namespace + ".list", cateCode);
	}

	@Override
	public GoodsViewVO goodsView(int gdsNum) throws SQLException {
		
		return sql.selectOne("kr.or.dw.mappers.adminMapper" + ".goodsView", gdsNum);
	}

	@Override
	public void registReply(ReplyVO reply) throws SQLException {
		sql.insert(namespace + ".registReply", reply); 
		
	}

	@Override
	public List<ReplyListVO> replyList(int gdsNum) throws SQLException {
		
		return sql.selectList(namespace + ".replyList", gdsNum);
	}

	@Override
	public void deleteReply(ReplyVO reply) throws SQLException {
		sql.delete(namespace + ".deleteReply", reply); 
		
	}

	@Override
	public String idCheck(int repNum) throws SQLException {
		return sql.selectOne(namespace + ".idCheck", repNum);
		
	}

	@Override
	public void modifyReply(ReplyVO reply) throws SQLException {
		sql.update(namespace + ".modifyReply", reply);
		
	}

	@Override
	public void addCart(CartVO cart) throws SQLException {
		sql.insert(namespace + ".addCart", cart);
		
	}

	@Override
	public List<CartListVO> cartList(String userId) throws SQLException {
		
		return sql.selectList(namespace + ".cartList", userId);
	}

	
	
}
