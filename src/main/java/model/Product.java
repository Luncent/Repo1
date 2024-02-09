package model;

import dao.DataSql;

public class Product {
	int id;
	int productTypeID;
	String name;
	String typeName;
	String parameters;
	double cost, allCost;
	int numbInStorage;
	int number;
	
	public Product(String name, String typeName,String parameters, double cost, int numberInStorage, int id, int productTypeID) {
		this.name=name;
		this.typeName=typeName;
		this.cost=cost;
		this.numbInStorage=numberInStorage;
		this.id=id;
		this.productTypeID=productTypeID;
		this.parameters=parameters;
	}
	
	public Product(String name, String typeName,String parameters, double cost, int number, double allCost) {
		this.name=name;
		this.typeName=typeName;
		this.parameters=parameters;
		this.cost=cost;
		this.number=number;
		this.allCost=allCost;
	}
	
	public int getNumber() {
		return number;
	}
	
	public String[] getOtherParameters() {
		String[] parts = parameters.split(",");
		for (int i = 0; i < parts.length; i++) {
		    parts[i] = parts[i].replaceAll("[^\\d.]", "");
		}
		return parts;
	}
	
	
	
	public String getProductParameters() {

		return parameters;
	}
	
	public int getProductTypeID() {
		return productTypeID;
	}
	public int getID() {
		return id;
	}
	
	public String getName() {
		return name;
	}
	
	public String getTypeName() {
		return typeName;
	}
	
	public double getAllCost() {
		return allCost;
	}
	
	public double getCost() {
		return cost;
	}
	
	public int getNumbInStorage() {
		return numbInStorage;
	}
	
	public static void editProduct(String type, String properties ,double cost,int left, int id, int typeID) {
		DataSql sql = new DataSql();
		sql.editProduct(type, properties, cost, left, id, typeID);
	}
	
	public static void insertProduct(String name, String typeName, String properties,double cost,
			int left,double providerCost,String providerName) {
		
		DataSql sql = new DataSql();
		sql.insertProduct(name, typeName, properties, cost, left, providerCost, providerName);
	}
	
	public static void deleteProduct(int id) {
		DataSql sql = new DataSql();
		sql.deleteProduct(id);
	}

	
}
