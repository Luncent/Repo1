package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.math3.optim.*;
import org.apache.commons.math3.optim.linear.*;
import org.apache.commons.math3.optim.nonlinear.scalar.GoalType;
import org.apache.commons.math3.optim.nonlinear.scalar.ObjectiveFunction;

import model.ProductDataSource;
import model.ProductsDataSource;
import model.Simplex;

public class test2 {

	public static void main(String[] args) {
		ProductsDataSource source = new ProductsDataSource();
		source.calcProductsToBuy();
		for(ProductDataSource singleSource: source.getProductsDataSource()) {
			System.out.println(singleSource.getName()+" "+singleSource.getTypeName()+" "+singleSource.getProductInfo()+
			"цена продукта: "+singleSource.getProductCost()+" цена поставки:"+singleSource.getProviderCost()+
					" осталось:"+singleSource.getLeft()+" продано:"+singleSource.getSold()+" купить минимум:"+singleSource.getMinNumberToBuy()+
			" покупаем:"+singleSource.getNumberToBuy());
		}
		
//		DataSql sql = new DataSql();
//		List<ProductDataSource>productsDataSource=sql.getProductsDataSource();
//		
//		for(ProductDataSource singleSource: productsDataSource) {
//			System.out.println(""+singleSource.getName()+" "+singleSource.getProductInfo());
//		}
//		
//		double profit = sql.getProfitForMonth();
//		System.out.println("Прибыль "+ profit);
//		
//		double[] funcCoef= {40,41,21,30};
//		double[][] constraints= {{1,0,0,0}, {0,1,0,0}, {0,0,1,0},{0,0,0,1}, {25,12.99,9.99,20}};
//		double[] b= {4,4,4,5,1000};
//		
//		int[]point=Simplex.calculate(funcCoef, constraints, b);
//		
//		for(int i=0; i<point.length-1; i++) {
//			System.out.println("Решение: x"+(i+1)+" = " + point[i]);
//		}
//	    System.out.println("Максимальное значение: " + point[point.length-1]);
	}

}
