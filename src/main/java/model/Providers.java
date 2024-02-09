package model;

import java.util.ArrayList;
import java.util.List;

import dao.DataSql;

public class Providers {
	public List<Provider> providers=new ArrayList<>();;
	
	public Providers() {
		DataSql sql = new DataSql();
		if(sql.getProvidersInfo()!=null) {
			providers.addAll(sql.getProvidersInfo());
		}
	}
	
	public List<Provider> getProviders(){
		return providers;
	}
	
	public static void editProviderCost(int provId, int productId, int productTypeId, double cost) {
		DataSql sql = new DataSql();
		sql.editProviderCost(provId, productId, productTypeId, cost);
	} 
	
	public static void editProviderName(int id, String name) {
		DataSql sql = new DataSql();
		sql.editProviderName(name, id);
	}
	
	public static void createProvider(String name) {
		DataSql sql = new DataSql();
		sql.createProvider(name);
	}
	
	public static void deleteProvider(int id) {
		DataSql sql = new DataSql();
		sql.deleteProvider(id);
	}
} 
