package model;

import java.util.ArrayList;
import java.util.List;

import dao.DataSql;

public class Orders {
	List<Order> orders = new ArrayList<>();
	
	public Orders(List<Order> orders) {
		this.orders = orders;
	}
	
	public List<Order> getMyOrders(String name){
		List<Order> myOrders = new ArrayList<>();
		
		for(Order order: orders) {
			if(order.getUser().equals(name)) {
				myOrders.add(order);
			}
		}
		return myOrders;
	}
	
	public static void deletePurchaseInfo(int purchaseID) {
		DataSql sql = new DataSql();
		sql.deletePurchaseInfo(purchaseID);
	}
	
	public static List<Order> getOrderByID(int purchaseID) {
		DataSql sql = new DataSql();
		return sql.getOrderByID(purchaseID);
	}
}
