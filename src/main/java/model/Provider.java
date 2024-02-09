package model;

public class Provider {
	int productID, productTypeID, provID;
	String name;
	String product;
	double cost;
	
	public Provider(String name, String product, double cost, int id, int typeID, int provId) {
		this.name=name;
		this.product=product;
		this.cost=cost;
		productID=id;
		productTypeID=typeID;
		provID=provId;
	}
	
	
	
	public String getName() {
		return name;
	}
	
	public String getProduct() {
		return product;
	}
	
	public double getCost() {
		return cost;
	}
	public int getProductID() {
		return productID;
	}
	public int getProductTypeID() {
		return productTypeID;
	}
	public int getProviderID() {
		return provID;
	}
}
