package model;

public class ProductDataSource {
	String name;
	String typeName;
	String productInfo;
	int left,sold, minNumberToBuy, numberToBuy=0;
	double providerCost, productCost;
	
	
	public ProductDataSource(String name, String typeName, String productInfo, int left, int sold, int minNumberToBuy,double providerCost, double productCost) {
		this.name=name;
		this.typeName=typeName;
		this.productInfo=productInfo;
		this.left=left;
		this.sold=sold;
		this.minNumberToBuy=minNumberToBuy;
		this.providerCost=providerCost;
		this.productCost=productCost;
	}
	
	public ProductDataSource(ProductDataSource prod) {
		this.name=prod.getName();
		this.typeName=prod.getTypeName();
		this.productInfo=prod.getProductInfo();
		this.left=prod.getLeft();
		this.sold=prod.getSold();
		this.minNumberToBuy=prod.getMinNumberToBuy();
		this.providerCost=prod.getProviderCost();
		this.productCost=prod.getProductCost();
	}
	
	public void setNumberToBuy(int number) {
		numberToBuy=number;
	}
	
	public int getSold() {
		return sold;
	}
	
	public int getNumberToBuy() {
		return numberToBuy;
	}
	
	public int getMinNumberToBuy() {
		return minNumberToBuy;
	}
	
	public double getProviderCost() {
		return providerCost;
	}
	public double getProductCost() {
		return productCost;
	}
	
	public String getName() {
		return name;
	}
	
	public String getTypeName() {
		return typeName;
	}
	
	public String getProductInfo() {
		return productInfo;
	}
	
	public int getLeft() {
		return left;
	}
}
