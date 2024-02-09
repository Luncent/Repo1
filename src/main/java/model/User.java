package model;

import java.sql.SQLException;

import dao.DataSql;

public class User {
	String login;
	String password;
	int id;
	
	public User(String login, String password){
		this.login=login;
		this.password=password;
	}
	
	public User(String login, String password, boolean exists){
		this.login=login;
		this.password=password;
		DataSql datacls = new DataSql();
		this.id=datacls.getUserID(login, password);
	}
	
	public int getID() {
		return id;
	}
	
	public String getLogin() {
		return login;
	}
	
	public void setLogin(String login) {
		this.login=login;
	}
	
	public String getPassword() {
		return login;
	}
	
	public void setPassword(String password) {
		this.password=password;
	}
	
	public boolean tryLogin() {
		DataSql datacls= new DataSql();
		if(datacls.checkIfUserExists(login, password)) {
			return true;
		}
		return false;
	}
	public void createUser(String login, String password) {
		DataSql sql = new DataSql();
		sql.createNewUser(login, password);
	}
	
	public boolean checkLogin(String login) {
		DataSql sql = new DataSql();
		if(sql.checkLogin(login)>0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public String getUserRole() {
		DataSql sql = new DataSql();
		return sql.getUserRole(login);
	}
	
}
