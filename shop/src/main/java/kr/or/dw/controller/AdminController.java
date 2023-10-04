package kr.or.dw.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.Multipart;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.dw.domain.CategoryVO;
import kr.or.dw.domain.GoodsVO;
import kr.or.dw.domain.GoodsViewVO;
import kr.or.dw.service.AdminService;
import kr.or.dw.utils.UploadFileUtils;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	AdminService adminService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	// 관리자 화면
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public void getIndex() {
		logger.info("get index");
	}
	
	// 상품 등록 get
	@RequestMapping(value = "/goods/register", method = RequestMethod.GET)
	public void getGoodsRegister(Model model) throws Exception {
	   logger.info("get goods register");
	   
	   List<CategoryVO> category = null;
	   category = adminService.category();
	   model.addAttribute("category", JSONArray.fromObject(category));
	   
	}
	
	// 상품등록 post
	@RequestMapping(value = "/goods/register", method = RequestMethod.POST)
	public String postGoodRegister(GoodsVO vo,MultipartFile file) throws IOException, Exception{
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			 fileName =  UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
			} else {
			 fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
			}
		
		vo.setGdsImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		vo.setGdsThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		
		adminService.register(vo);
		
		return "redirect:/admin/index";
	}
	
	// 상품목록  get
	@RequestMapping(value = "/goods/list", method = RequestMethod.GET)
	public void getGoodList(Model model) throws SQLException {
		logger.info("get goods list");
		
		List<GoodsVO> list = adminService.goodslist();
		
		model.addAttribute("list", list);
	}
	
	// 상품목록
	@RequestMapping(value = "/goods/view" , method = RequestMethod.GET)
	public void getGoodsview(@RequestParam("p") int gdsNum, Model model) throws SQLException {
		logger.info("get goods view");
		
		GoodsViewVO goods = adminService.goodsView(gdsNum);
		
		model.addAttribute("goods" , goods);
		
	}
	
	// 상품 수정
	@RequestMapping(value = "/goods/modify", method = RequestMethod.GET)
	public void getGoodsmodify(@RequestParam("p") int gdsNum, Model model) throws SQLException {
		logger.info("get goods modify");
		
		GoodsViewVO goods = adminService.goodsView(gdsNum);
		model.addAttribute("goods", goods);
		
		List<CategoryVO> category = null;
		category = adminService.category();
		model.addAttribute("category", JSONArray.fromObject(category));
		
	}
	
	// 상품 수정 post
	@RequestMapping(value = "/goods/modify", method = RequestMethod.POST)
	public String postGoodsModify(GoodsVO vo,MultipartFile file, HttpServletRequest req) throws IOException, Exception {
		logger.info("post goods modify");
		
		// 새로운 파일이 등록되었는지 확인
		 if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
		  // 기존 파일을 삭제
		  new File(uploadPath + req.getParameter("gdsImg")).delete();
		  new File(uploadPath + req.getParameter("gdsThumbImg")).delete();
		  
		  // 새로 첨부한 파일을 등록
		  String imgUploadPath = uploadPath + File.separator + "imgUpload";
		  String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		  String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		  
		  vo.setGdsImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		  vo.setGdsThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		  
		 } else {  // 새로운 파일이 등록되지 않았다면
		  // 기존 이미지를 그대로 사용
		  vo.setGdsImg(req.getParameter("gdsImg"));
		  vo.setGdsThumbImg(req.getParameter("gdsThumbImg"));
		  
		 }
		
		adminService.goodsModify(vo);
		System.out.println(vo.getCateCode());
		
		return "redirect:/admin/index";
	}

	// 상품 삭제
	@RequestMapping(value = "/goods/delete", method = RequestMethod.POST)
	public String postGoodsDelete(@RequestParam("p") int gdsNum) throws SQLException {
		logger.info("post goods delete");
		
		adminService.goodsDelete(gdsNum);
		
		return "redirect:/admin/index";
	}
	
}
