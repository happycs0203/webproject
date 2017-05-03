package com.songdroid.bean.member;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ZipServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("euc-kr");
		String dong = req.getParameter("dong");
		
		ZipDao dao = new ZipDao();
		Vector v = dao.getZipList(dong);
		
		req.setAttribute("ziplist", v);
		
		RequestDispatcher view = req.getRequestDispatcher("/member/zipSearch.jsp");
		view.forward(req, resp);
	}
}
