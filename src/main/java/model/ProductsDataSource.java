package model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import dao.DataSql;

public class ProductsDataSource {
	List<ProductDataSource> dataSource = new ArrayList<>();
	
	public ProductsDataSource() {
		DataSql sql = new DataSql();
		dataSource=sql.getProductsDataSource();
	}
	
	public List<ProductDataSource> calcSimplex(String type, int typeID) {
		List<ProductDataSource> productsDataSource = new ArrayList<>();
		for(ProductDataSource src: dataSource) {
			if(src.getName().equals(type)) {
				ProductDataSource prod= new ProductDataSource(src);
				productsDataSource.add(prod);
			}
		}
		
		DataSql sql = new DataSql();
		int size=productsDataSource.size();
		
		double[] funcCoef = new double[size];
		double[][]constraints = new double[size+1][size];
		double[] b=new double[size+1];
		
		Iterator<ProductDataSource> iter = productsDataSource.iterator();
		int i =0;
		while(iter.hasNext()&&i<size) {
			ProductDataSource singleSource = iter.next();
			funcCoef[i]=singleSource.getProductCost();
			b[i]=singleSource.getMinNumberToBuy();
			constraints[size][i]=singleSource.getProviderCost();
			i++;
		}
		
		b[size]=sql.getProfitForMonth(typeID);
		
		for(int index = 0; index<constraints.length-1; index++) {
			constraints[index][index]=1;
			for (int j =0; j<constraints[0].length; j++) {
				if(j!=index) {
					constraints[index][j]=0;
				}
			}
		}
		
		//получаем решение 
		int[] solution=Simplex.calculate(funcCoef, constraints, b);
		//записываем решение в поля
		iter=productsDataSource.iterator();
		i =0;
		while(iter.hasNext()&&i<size) {
			ProductDataSource singleSource = iter.next();
			singleSource.setNumberToBuy(solution[i]);
			i++;
		}
		
		System.out.println("Size "+size);
		for(int y=0;y<funcCoef.length;y++) {
			System.out.println("y "+(y+1)+"="+funcCoef[y]);
		}
		for(int y=0;y<b.length;y++) {
			System.out.println("b "+(y+1)+"="+b[y]);
		}
		for(int index = 0; index<constraints.length; index++) {
			for (int j =0; j<constraints[0].length; j++) {
				System.out.print(constraints[index][j]+" ");
			}
			System.out.println();
		}
		
		return productsDataSource;
	}

	
	public void calcProductsToBuy() {
		//решаем с-задачу для картона
		List<ProductDataSource> CardboardDataSource = calcSimplex("картон", 1);
		
		Iterator<ProductDataSource> iter = dataSource.iterator();
		while(iter.hasNext()) {
			if(iter.next().getName().equals("картон")) {
				iter.remove();
			}
		}
		
		dataSource.addAll(CardboardDataSource);
		
		
		List<ProductDataSource> GlueDataSource = calcSimplex("клей", 2);
		
		iter = dataSource.iterator();
		while(iter.hasNext()) {
			if(iter.next().getName().equals("клей")) {
				iter.remove();
			}
		}
		
		dataSource.addAll(GlueDataSource);
		
		
		List<ProductDataSource> TapeDataSource = calcSimplex("лента", 5);
		
		iter = dataSource.iterator();
		while(iter.hasNext()) {
			if(iter.next().getName().equals("лента")) {
				iter.remove();
			}
		}
		
		dataSource.addAll(TapeDataSource);
		
		List<ProductDataSource> MembranaDataSource = calcSimplex("пленка", 3);
		
		iter = dataSource.iterator();
		while(iter.hasNext()) {
			if(iter.next().getName().equals("пленка")) {
				iter.remove();
			}
		}
		
		dataSource.addAll(MembranaDataSource);
		
		List<ProductDataSource> DrywallDataSource = calcSimplex("гипсокартон", 4);
		
		iter = dataSource.iterator();
		while(iter.hasNext()) {
			if(iter.next().getName().equals("гипсокартон")) {
				iter.remove();
			}
		}
		
		dataSource.addAll(DrywallDataSource);
	}
	public List<ProductDataSource> getProductsDataSource(){
		return dataSource;
	}
}
