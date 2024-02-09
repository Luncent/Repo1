package dao;

import java.util.List;

import model.Catalog;
import model.Order;
import model.Orders;
import model.Product;

public class test3 {

	public static void main(String[] args) {
		DataSql sql = new DataSql();
		Orders orders = new Orders(sql.getOrders());
		
		
		for(Order myOrder : orders.getMyOrders("Oleg")) {
			System.out.println("Пользователь: "+myOrder.getUser()+", OrderID: "+myOrder.getOrderID()+
			", Date: "+myOrder.getDate()		
			+", Product in Order: "+myOrder.getProductsNumber()+", Order Cost: "+myOrder.getCost()+", PRODUCTS IN ORDER:");
			for(Product product: myOrder.getProducts()) {
				System.out.println("Product: "+product.getName()+", ProductType: "+product.getTypeName()+
						", ProductParams: "+product.getProductParameters()+", ProductCost: "+
						product.getCost()+", ProcutsNumber: "+product.getNumber()+", Summary Cost: "+product.getAllCost());
			}
			System.out.println("------------------------------------------------------");
		}
	}

}
