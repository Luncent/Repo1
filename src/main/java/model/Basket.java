package model;

import java.util.ArrayList;
import java.util.Iterator;

import dao.DataSql;

public class Basket {
	public ArrayList<BasketProduct>basketProducts=new ArrayList<>();
	
	public void addProduct(Product p, int numb) {
		for(BasketProduct basketProduct: basketProducts) {
			if(basketProduct.product.equals(p)) {
				basketProduct.incNumber(numb);
				return;
			}
		}
		basketProducts.add(new BasketProduct(p, numb));
	}
	
	public void removeProduct(String productType, int productID) {
		Iterator<BasketProduct> iter = basketProducts.iterator();
		
		while(iter.hasNext()) {
			BasketProduct product = iter.next();
			if(product.getProduct().getID()==productID && product.getProduct().getName().equals(productType)) {
				if(product.getProductsNumber()>1) {
					product.decNumber();
				}
				else {
					iter.remove();
				}
			}
		}
	}
	
	public int getAllProductsNumber() {
		int number=0;
		for(BasketProduct product: basketProducts) {
			number+=product.getProductsNumber();
		}
		return number;
	}
	
	public double getPurchaseCost() {
		double cost=0;
		for(BasketProduct product: basketProducts) {
			cost+=product.getProductsNumber()*product.getProduct().getCost();
		}
		return cost;
	}
	
	public void makePurchase(int userID) {
		int productsNumber=getAllProductsNumber();
		double purchaseCost=getPurchaseCost();
		int purchaseID=-1;
		
		DataSql sql = new DataSql();
		
		purchaseID=sql.fillPurchaseTable(userID, productsNumber, purchaseCost);
		
		for(BasketProduct product: basketProducts) {
			sql.fillPurchasesDetails(purchaseID, product);
		}
	}
	
	public ArrayList<String> cmprPurchaseWStorage(){
		ArrayList<String> mismatches = new ArrayList<>();
		int numberInStorage=0;
		
		for(BasketProduct product: basketProducts) {
			numberInStorage=product.getProduct().getNumbInStorage();
			if(numberInStorage<product.getProductsNumber()) {
				mismatches.add(product.getProduct().getName()+" "+product.getProduct().getTypeName());
			}
		}
		
		
		return mismatches;
	}
}
