package com.songdroid.bean.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDaoImpl implements IBoardDao {
	private DataSource ds;
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BoardDaoImpl(){
		try{
			ds = (DataSource)new InitialContext().lookup("java:comp/env/jdbc/OracleDB");
		}
		catch(Exception err){
			System.out.println("BoardDaoImpl()에서 오류 : " + err);
		}
	}
	
	public void freeResource(){
		if(con != null){
			try{
				con.close();
			}
			catch(Exception err){}
		}
		
		if(rs != null){
			try{
				rs.close();
			}
			catch(Exception err){}
		}
		
		if(pstmt != null){
			try{
				pstmt.close();
			}
			catch(Exception err){}
		}
	}
	
	@Override
	public Vector getBoardList(String keyField, String keyWord) {
		Vector v = new Vector();
		String sql = "";
		try{
			con = ds.getConnection();
			if(keyWord == null || keyWord.isEmpty()){
				sql = "select * from tblBoard order by pos asc";
			}
			else{
				sql = "select * from tblBoard where " + keyField + " like '%" + keyWord + "%' order by pos asc"; 
			}
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();
				dto.setContent(rs.getString("content"));
				dto.setCount(rs.getInt("count"));
				dto.setDepth(rs.getInt("depth"));
				dto.setEmail(rs.getString("email"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setIp(rs.getString("ip"));
				dto.setName(rs.getString("name"));
				dto.setNum(rs.getInt("num"));
				dto.setPass(rs.getString("pass"));
				dto.setPos(rs.getInt("pos"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setSubject(rs.getString("subject"));
				
				v.add(dto);
			}
		}
		catch(Exception err){
			System.out.println("getBoardList() : " + err);
		}
		finally{
			freeResource();
		}
		return v;
	}

	@Override
	public void insertBoard(BoardDto dto) {
		try{
			con = ds.getConnection();
			String sql = "update tblBoard set pos = pos + 1";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			sql = "insert into tblBoard(num, name, email, homepage, subject, content, regdate, pass, count, ip, pos, depth) " +
				"values(seq_num.nextVal, ?, ?, ?, ?, ?, sysdate, ?, 0, ?, 0, 0)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getHomepage());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getPass());
			pstmt.setString(7, dto.getIp());
			
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("insertBoard() : " + err);
		}
		finally{
			freeResource();
		}
	}

	@Override
	public BoardDto getBoard(int num) {
		BoardDto dto = new BoardDto();
		try{
			con = ds.getConnection();
			
			String sql = "update tblBoard set count = count + 1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from tblBoard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto.setContent(rs.getString("content"));
				dto.setCount(rs.getInt("count"));
				dto.setDepth(rs.getInt("depth"));
				dto.setEmail(rs.getString("email"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setIp(rs.getString("ip"));
				dto.setName(rs.getString("name"));
				dto.setNum(rs.getInt("num"));
				dto.setPass(rs.getString("pass"));
				dto.setPos(rs.getInt("pos"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setSubject(rs.getString("subject"));
			}
		}
		catch(Exception err){
			System.out.println("getBoard() : " + err);
		}
		finally{
			freeResource();
		}
		return dto;
	}

	@Override
	public void updateBoard(BoardDto dto) {
		try{
			con = ds.getConnection();
			String sql = "update tblBoard set name=?, email=?, subject=?, content=? where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getNum());
			
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("updateBoard() : " + err);
		}
		finally{
			freeResource();
		}
	}

	@Override
	public void deleteBoard(int num) {
		try{
			con = ds.getConnection();
			String sql = "delete from tblBoard where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("deleteBoard() : " + err);
		}
		finally{
			freeResource();
		}
	}
	
	public void replyUpPos(int ParentPos){
		try{
			con = ds.getConnection();
			String sql = "update tblBoard set pos=pos+1 where pos > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ParentPos);
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("replyUpPos() : " + err);
		}
		finally{
			freeResource();
		}
	}

	@Override
	public void replyBoard(BoardDto dto) {
		try{
			con = ds.getConnection();
			int pos = dto.getPos() + 1;
			int depth = dto.getDepth() + 1;
			
			String sql = "insert into tblBoard(num, name, email, homepage, subject, content, regdate, pass, count, ip, pos, depth) " +
					"values(seq_num.nextVal, ?, ?, ?, ?, ?, sysdate, ?, 0, ?, ?, ?)";
				
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getHomepage());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getPass());
			pstmt.setString(7, dto.getIp());
			pstmt.setInt(8, pos);
			pstmt.setInt(9, depth);
				
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("replyBoard() : " + err);
		}
		finally{
			freeResource();
		}
	}
	
	public String useDepth(int depth){
		String result="";
		for(int i=0; i<depth*3; i++)
			result += "&nbsp;";
		
		return result;
	}
}
