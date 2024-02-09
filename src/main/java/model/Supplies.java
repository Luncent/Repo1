package model;

import java.util.List;

import dao.DataSql;

public class Supplies {
	
	public List<String> getAllProviders(){
		DataSql sql = new DataSql();
		return sql.getAllProviders();
	}

}
