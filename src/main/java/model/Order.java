package model;

import java.util.ArrayList;
import java.util.List;

public class Order {
	String user, date;
	int productsNumber, orderID;
	double cost;
	List<Product> orderProducts = new ArrayList<>();
	
	public Order(String userName,String date,int prodctsNumber, double cst,List<Product> products, int id) {
		this.user= userName;
		this.productsNumber=prodctsNumber;
		this.cost=cst;
		this.orderProducts=products;
		this.orderID=id;
		this.date=date;
	}
	
	public String getUser() {
		return user;
	}
	
	public String getDate() {
		return date;
	}
	
	public int getProductsNumber() {
		return productsNumber;
	}
	
	public int getOrderID() {
		return orderID;
	}
	
	public double getCost() {
		return cost;
	}
	
	public List<Product> getProducts() {
		return orderProducts;
	}
	
//	public static Order getOrder() {
//		return new Order();
//	}
	
	
}
