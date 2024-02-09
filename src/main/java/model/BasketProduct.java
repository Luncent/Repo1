package model;

public class BasketProduct {
	Product product;
	int number=0;
	
	public BasketProduct(Product product, int numb) {
		this.product=product;
		number+=numb;
	}
	public Product getProduct() {
		return product;
	}
	
	public int getProductsNumber() {
		return number;
	}
	public void incNumber(int numb) {
		number+=numb;
	}
	public void decNumber() {
		number-=1;
	}
	
}
