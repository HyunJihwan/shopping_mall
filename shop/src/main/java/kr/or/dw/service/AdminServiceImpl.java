package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.dw.dao.AdminDAO;
import kr.or.dw.domain.CategoryVO;
import kr.or.dw.domain.GoodsVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Inject
	private AdminDAO adminDAO;
	
	@Override
	public List<CategoryVO> category() throws SQLException {
		
		return adminDAO.category();
	}

	@Override
	public void register(GoodsVO vo) throws SQLException {
		adminDAO.register(vo);
		
	}

	@Override
	public List<GoodsVO> goodslist() throws SQLException {
		
		return adminDAO.goodslist();
	}

	

}
