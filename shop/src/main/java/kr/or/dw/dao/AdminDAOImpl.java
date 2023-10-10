package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.dw.domain.CategoryVO;
import kr.or.dw.domain.GoodsVO;
import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.domain.OrderListVO;
import kr.or.dw.domain.OrderVO;

@Repository
public class AdminDAOImpl implements AdminDAO{
	
	@Inject
	private SqlSession sql;
	
	//매퍼
	private static String namespace = "kr.or.dw.mappers.adminMapper";

	@Override
	public List<CategoryVO> category() throws SQLException {
		
		return sql.selectList(namespace  + ".category");
	}

	@Override
	public void register(GoodsVO vo) throws SQLException {
		
		sql.insert(namespace + ".register", vo); 
		
	}

	@Override
	public List<GoodsViewVO> goodslist() throws SQLException {
		
		return sql.selectList(namespace + ".goodslist");
	}

	@Override
	public GoodsViewVO goodsView(int gdsNum) throws SQLException {
		
		return sql.selectOne(namespace + ".goodsView" , gdsNum);
		
	}

	@Override
	public void goodsModify(GoodsVO vo) throws SQLException {
		
		sql.update(namespace + ".goodsModify",vo);
		
	}

	@Override
	public void goodsDelete(int gdsNum) throws SQLException {
		sql.delete(namespace + ".goodsDelete" ,gdsNum);
		
	}

	@Override
	public List<OrderVO> orderList() throws SQLException {
		
		return sql.selectList(namespace + ".orderList");
	}

	@Override
	public List<OrderListVO> orderView(OrderVO order) throws SQLException {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".orderView", order);
	}

	@Override
	public void delivery(OrderVO order) throws SQLException {
		sql.update(namespace + ".delivery", order);
		
	}

	
	
	
}
