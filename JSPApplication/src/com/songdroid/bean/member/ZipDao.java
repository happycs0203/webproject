package com.songdroid.bean.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

public class ZipDao {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public ZipDao(){
		try{
			ds = (DataSource)new InitialContext().lookup("java:comp/env/jdbc/OracleDB");
		}
		catch(Exception err){
			System.out.println("DB연결 실패 : " + err);
		}
	}
	
	public Vector getZipList(String dong){
		String sql = "select * from tblZip where dong like '%" + dong + "%'";
		Vector v = new Vector();
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				ZipDto dto = new ZipDto();
				dto.setBunji(rs.getString("bunji"));
				dto.setDong(rs.getString("dong"));
				dto.setGugun(rs.getString("gugun"));
				dto.setSido(rs.getString("sido"));
				dto.setZipcode(rs.getString("zipcode"));
				
				v.add(dto);
			}
		}
		catch(Exception err){
			System.out.println("getZipList() 오류 : " + err);
		}
		finally{
			if(rs != null){
				try { rs.close(); } catch (SQLException e) {}
			}
			if(pstmt != null){
				try { pstmt.close(); } catch (SQLException e) {}
			}
			if(con != null){
				try { con.close(); } catch (SQLException e) {}
			}
		}
		
		return v;
	}
}
