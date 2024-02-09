package model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import dao.DataSql;

public class Catalog implements CatalogInterf {
	public ArrayList<Product> products=new ArrayList<>(); // current products
	public ArrayList<Product> allProducts=new ArrayList<>();
	
	public Catalog(){
		DataSql datacls = new DataSql();
		products.addAll(datacls.getAllProducts());
		allProducts.addAll(products);
	}
	
	public void refreshCatalog() {

		if(products!=null || allProducts!=null) {
			products.clear();
			allProducts.clear();
			DataSql datacls = new DataSql();
			products.addAll(datacls.getAllProducts());
			allProducts.addAll(products);
		}
	}
	public ArrayList<String> getProductsTypes(){
		ArrayList<String> types = new ArrayList<>();
		for(Product product:allProducts) {
			if(!types.contains(product.getName())) {
				types.add(product.getName());
			}
		}
		return types;
	}
	
	public ArrayList<String> getCurrentProductsTypes(){
		ArrayList<String> types = new ArrayList<>();
		for(Product product:products) {
			if(!types.contains(product.getName())) {
				types.add(product.getName());
			}
		}
		return types;
	}
	
	public void filterProductsByTypeAndCost(String type, double left, double right){
		cancelFilters();
		Iterator<Product> iter = products.iterator();
		if(!type.equals("all")) {
			while(iter.hasNext()) {
				Product product=iter.next();
				String productType=product.getName();
				if(!type.equals(productType)) {
					System.out.println("удаляю прод с типом: "+productType+" потому что не лежит в: "+type);
					iter.remove();
				}
			}
		}
		
		iter = products.iterator();
		
		while(iter.hasNext()) {
			Product product=iter.next();
			Double cost=product.getCost();
			System.out.println("cost: "+cost);
			if(left>cost || cost>right) {
				System.out.println("удаляю прод с ценой: "+cost+" потому что не лежит в: "+left+"-"+right);
				iter.remove();
			}
		}
	}
	
	public void ascendingSort() {
		Comparator<Product> ascendingComparator = new Comparator<Product>() {
		    @Override
		    public int compare(Product p1, Product p2) {
		        return Double.compare(p1.getCost(), p2.getCost());
		    }
		};
		products.sort(ascendingComparator);
	}
	
	public void decreasingSort() {
		Comparator<Product> decreasing= new Comparator<Product>(){
		  @Override
		    public int compare(Product p1, Product p2) {
		        return Double.compare(p2.getCost(), p1.getCost());
		    }
		};
		products.sort(decreasing);
	}
	
	public void cancelFilters() {
		products.clear();
		products.addAll(allProducts);
	}
	
	
	public ArrayList<Product> getGlueProducts(){
		ArrayList<Product> glueProducts = new ArrayList<>();
		for(Product product: allProducts) {
			if(product.getProductTypeID()==2) {
				glueProducts.add(product);
			}
		}
		return glueProducts;
	}
	
	public ArrayList<Product> getMembranaProducts(){
		ArrayList<Product> glueProducts = new ArrayList<>();
		for(Product product: allProducts) {
			if(product.getProductTypeID()==3) {
				glueProducts.add(product);
			}
		}
		return glueProducts;
	}
	
	public ArrayList<Product> getTapeProducts(){
		ArrayList<Product> glueProducts = new ArrayList<>();
		for(Product product: allProducts) {
			if(product.getProductTypeID()==5) {
				glueProducts.add(product);
			}
		}
		return glueProducts;
	}
	
	public ArrayList<Product> getDrywallProducts(){
		ArrayList<Product> glueProducts = new ArrayList<>();
		for(Product product: allProducts) {
			if(product.getProductTypeID()==4) {
				glueProducts.add(product);
			}
		}
		return glueProducts;
	}
	
	public ArrayList<Product> getCardboardProducts(){
		ArrayList<Product> cardboardProducts = new ArrayList<>();
		for(Product product: allProducts) {
			if(product.getProductTypeID()==1) {
				cardboardProducts.add(product);
			}
		}
		return cardboardProducts;
	}
	
	public void searchProoducts(String[] properties) {
		cancelFilters();
		for(String property: properties) {
			Iterator<Product> iter = products.iterator();
			String property1 = Character.toUpperCase(property.charAt(0)) + property.substring(1);
			String property2 = Character.toLowerCase(property.charAt(0)) + property.substring(1);
			String property3 = property.toLowerCase();
			while(iter.hasNext()) {
				Product product = iter.next();
				String productProperties = product.getName()+product.getCost()+product.getTypeName()+product.getProductParameters()+product.getNumbInStorage();
				if (!productProperties.contains(property) && !productProperties.contains(property1) && !productProperties.contains(property2) && !productProperties.contains(property3)) {
					iter.remove();
				}
			}
		}
	}
}
