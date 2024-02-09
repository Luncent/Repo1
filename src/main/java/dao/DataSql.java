package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.microsoft.sqlserver.jdbc.SQLServerDriver;

import model.BasketProduct;
import model.Catalog;
import model.Order;
import model.Product;
import model.ProductDataSource;
import model.Provider;
import model.ProviderInfo;


//String connectionUrl = "jdbc:sqlserver://DESKTOP-OMBNSHK\\MSSQLSERVER2022;encrypt=true;trustServerCertificate=true;database=kursovoi;integratedSecurity=true;user=sas;password=11111";

public class DataSql {
	private Connection conn;
	
	public DataSql() {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String connectionUrl = "jdbc:sqlserver://DESKTOP-OMBNSHK\\MSSQLSERVER2022:5022;encrypt=true;trustServerCertificate=true;databaseName=kursovoi;user=sa;password=123";
			conn=DriverManager.getConnection(connectionUrl);
		}
		catch(SQLException e) {
			e.getStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public boolean checkIfUserExists(String login, String password){
        Statement statement;
        boolean check = false;
		try {
			statement = conn.createStatement();
			String SQL = "SELECT * FROM dbo.Users WHERE Login='"+login+"' AND Password='"+password+"'";
			ResultSet rs = statement.executeQuery(SQL);
			check = rs.next()?true:false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Error in Datasql: method checkIfUserExists");
		}
		return check;
    }
	
	public int getUserID(String login, String password) {
		 Statement statement;
	        int id = -1;
			try {
				statement = conn.createStatement();
				String SQL = "SELECT UserID FROM dbo.Users WHERE Login='"+login+"' AND Password='"+password+"'";
				ResultSet rs = statement.executeQuery(SQL);
				rs.next();
				id = rs.getInt("UserID");
			} catch (SQLException e) {
				System.out.println("Error in Datasql: method getUserBalance");
			}
			return id;
	}
	
	
	public void incUserBalance(String name) {
		Statement stmt = null;
		String SQL="UPDATE dbo.Users SET Balance=Balance+50 WHERE Login='"+name+"'";
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public ArrayList<Product> getAllProducts(){
		Statement stmt = null;
		String SQL="SELECT * FROM dbo.Products";
		ResultSet rs=null;
		ArrayList<Product> products =new ArrayList<>();
		
		String name, typeName;
		String parameters;
		double cost;
		int number, id, prodTypeID;
		
		try {
			stmt=conn.createStatement();
		
			rs=stmt.executeQuery(SQL);
			while(rs.next()) {
				name=rs.getString("Name");
				typeName=rs.getString("TypeName");
				parameters=rs.getString("Properties");
				cost = rs.getDouble("Cost");
				number = rs.getInt("LeftInStorage");
				id = rs.getInt("ProductID");
				prodTypeID = rs.getInt("ProductTypeID");
				Product product=new Product(name, typeName, parameters, cost,number,id,prodTypeID);
				products.add(product);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return products;
	}
	
	public void fillPurchasesDetails(int purchID, BasketProduct basketProduct) {
		Statement stmt=null;
		int productID=basketProduct.getProduct().getID();
		int productTypeID=basketProduct.getProduct().getProductTypeID();
		int number=basketProduct.getProductsNumber();
		double cost=basketProduct.getProduct().getCost()*number;
		String SQL="INSERT INTO dbo.PurchaseDetails(PurchaseID,ProductID,ProductTypeID,Products_number,Cost) VALUES ("+purchID+","+productID+","+productTypeID+","+number+","+cost+")";
		try {
			stmt = conn.createStatement();
			int rows=stmt.executeUpdate(SQL);
			if(rows!=1) {
				System.out.println("вставилась не 1 строчка!");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int fillPurchaseTable(int userId, int productsNumber, double cost) {
		Statement stmt=null;
		String SQL="INSERT INTO dbo.Purchases(UserID,Products_number,Cost) VALUES ("+userId+","+productsNumber+","+cost+")";
		String SQL2="SELECT MAX(PurchaseID) AS ID FROM dbo.Purchases";
		ResultSet rs=null;
		int id=-1;
		try {
			stmt = conn.createStatement();
			int rows=stmt.executeUpdate(SQL);
			if(rows!=1) {
				System.out.println("вставилась не 1 строчка!");
			}
			
			rs=stmt.executeQuery(SQL2);
			rs.next();
			id=rs.getInt("ID");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return id;
	}
	
	public int getLeftProductsNumber(int productID, int productTypeID) {
		Statement stmt = null;
		String SQL=null;
		int number=0;
		
		if(productTypeID==1) {
			SQL="SELECT LeftInStorage AS number FROM dbo.Cardboard WHERE ProductID="+productID;
		}
		else if(productTypeID==2) {
			SQL="SELECT LeftInStock AS number FROM dbo.Glue WHERE ProductID="+productID;
		}
		else {
			System.out.println("неправильный ид типа товара");
			number=-1;
			return number;
		}
		
		ResultSet rs=null;
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(SQL);
			if(rs.next()) {
			number=rs.getInt("number");
			}
			else {
				System.out.println("неправильный ид товара");
				number = -2;
				return number;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return number;
	}
	
	public void createNewUser(String login, String password) {
		Statement stmt = null;
		String SQL ="INSERT INTO dbo.Users(Login,Password,UserRole) VALUES ('"+login+"', '"+password+"', 'user')";
		
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int checkLogin(String login) {
		Statement stmt = null;
		String SQL ="SELECT COUNT(*) AS numb FROM dbo.Users WHERE Login='"+login+"'";
		ResultSet rs=null;
		int rows=0;
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(SQL);
			rs.next();
			rows=rs.getInt("numb");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rows;
	}
	
	public String getUserRole(String login) {
		Statement stmt = null;
		String SQL ="SELECT UserRole FROM dbo.Users WHERE Login='"+login+"'";
		ResultSet rs=null;
		String role="";
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(SQL);
			rs.next();
			role=rs.getString("UserRole");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return role;
	}
	
	public void deleteCardboardProduct(int productID) {
		Statement stmt = null;
		String SQL ="DELETE FROM dbo.Cardboard WHERE ProductID="+productID;
		
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void editProduct(String typeName, String properties, double cost, int leftInStorage, int id, int productType) {
		Statement stmt=null;
		String SQL="UPDATE dbo.Products SET TypeName = '"+typeName+"', Properties='"+properties+"', Cost="+cost+", LeftInStorage="+leftInStorage+" WHERE ProductID="+id+" AND ProductTypeID="+productType;
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
			System.out.println("изменение товара в бд успешно!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void insertProduct(String name,String typeName, String properties, double cost, int leftInStorage, double providerCost, String providerName) {
		String sql = "EXEC NewProduct ?, ?, ?, ?, ?, ?, ?,?";
		// Установка значений входных параметров
		try {
			CallableStatement stmt = conn.prepareCall(sql);
			stmt.setString(1, name);
			stmt.setString(2, typeName);
			stmt.setString(3, properties);
			stmt.setDouble(4, cost);
			stmt.setInt(5, leftInStorage);
			stmt.setDouble(6, providerCost);
			stmt.setString(7, providerName);

			// Регистрация выходного параметра
			stmt.registerOutParameter(8, Types.VARCHAR);

			// Выполнение процедуры
			stmt.execute();

			// Получение значения выходного параметра
			String returnValue = stmt.getString(8);
			System.out.println("Вставка: " + returnValue);

			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public List<String> getAllProviders(){
		Statement stmt = null;
		String SQL="SELECT Name FROM dbo.Providers";
		ResultSet rs=null;
		List<String> names =new ArrayList<>();
		
		try {
			stmt=conn.createStatement();
		
			rs=stmt.executeQuery(SQL);
			while(rs.next()) {
				names.add(rs.getString("Name"));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return names;
	}
	
	public List<ProviderInfo> getAllProvidersInfo(){
		Statement stmt = null;
		String SQL="SELECT ProviderID,Name FROM dbo.Providers";
		ResultSet rs=null;
		List<ProviderInfo> providers =new ArrayList<>();
		
		try {
			stmt=conn.createStatement();
		
			rs=stmt.executeQuery(SQL);
			while(rs.next()) {
				int id = rs.getInt("ProviderID");
				String name = rs.getString("Name");
				ProviderInfo provider= new ProviderInfo(id, name);
				providers.add(provider);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return providers;
	}
	
	public ArrayList<ProductDataSource> getProductsDataSource(){
		Statement stmt = null;
		String SQL="SELECT ISNULL(Supplies.ProviderID, 0) AS ProviderID, Products.Name, Products.TypeName,\r\n"
				+ "       Products.Properties, Products.LeftInStorage,\r\n"
				+ "       ISNULL(PurchasesStatistics.ProductsNumber, 0) AS Sold,\r\n"
				+ "       CASE WHEN Supplies.ProviderID IS NULL THEN 0\r\n"
				+ "            WHEN (Products.LeftInStorage - ISNULL(PurchasesStatistics.ProductsNumber, 0)) < 0\r\n"
				+ "            THEN ISNULL(PurchasesStatistics.ProductsNumber, 0) - Products.LeftInStorage\r\n"
				+ "            ELSE 0\r\n"
				+ "       END AS NumberToBuy,\r\n"
				+ "       ISNULL(Supplies.Cost, 9999) AS ProviderCost,\r\n"
				+ "       Products.Cost AS ProductCost\r\n"
				+ "FROM dbo.Products\r\n"
				+ "LEFT JOIN dbo.PurchasesStatistics ON Products.ProductID = PurchasesStatistics.ProductID\r\n"
				+ "                                    AND Products.ProductTypeID = PurchasesStatistics.ProductTypeID\r\n"
				+ "LEFT JOIN dbo.Supplies ON Supplies.ProductID = Products.ProductID\r\n"
				+ "                          AND Supplies.ProductTypeID = Products.ProductTypeID\r\n"
				+ "WHERE DATEPART(MONTH, Date) = DATEPART(MONTH, GETDATE())\r\n"
				+ "   OR PurchasesStatistics.ProductID IS NULL\r\n"
				+ "   OR Supplies.ProductID IS NULL";
		
		
		ResultSet rs=null;
		ArrayList<ProductDataSource> productsDataSource =new ArrayList<>();
		
		String name;
		String typeName;
		String productInfo;
		int left,sold, minNumberToBuy=0;
		double providerCost, productCost;
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(SQL);
			
			while(rs.next()) {
				name=rs.getString("Name");
				typeName=rs.getString("TypeName");
				productInfo = rs.getString("Properties");
				left = rs.getInt("LeftInStorage");
				sold = rs.getInt("Sold");
				minNumberToBuy = rs.getInt("NumberToBuy");
				providerCost = rs.getDouble("ProviderCost");
				productCost = rs.getDouble("ProductCost");
				ProductDataSource productDataSource=new ProductDataSource(name,typeName,productInfo,
						left,sold,minNumberToBuy,providerCost,productCost);
				productsDataSource.add(productDataSource);
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return productsDataSource;
	}
	
	public double getProfitForMonth(int typeID){
		Statement stmt = null;
		String SQL="SELECT SUM(Earnings) AS Profit FROM dbo.PurchasesStatistics WHERE ProductTypeID="+typeID;
		ResultSet rs=null;
		double profit=0;
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(SQL);
			
			rs.next();
			profit=rs.getDouble("Profit");
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return profit;
	}
	
	public List<Provider> getProvidersInfo() {
		Statement stmt = null;
		String SQL ="SELECT Products.ProductID, Products.ProductTypeID,Supplies.ProviderID, Providers.Name, CONCAT(Products.Name,' ',Products.TypeName,' ',Products.Properties) AS Product, Supplies.Cost FROM dbo.Providers\r\n"
				+ "JOIN dbo.Supplies ON Providers.ProviderID=Supplies.ProviderID\r\n"
				+ "JOIN dbo.Products ON Products.ProductID=Supplies.ProductID AND Products.ProductTypeID=Supplies.ProductTypeID";
		ResultSet rs=null;
		List<Provider> providers = new ArrayList<>();
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(SQL);
			while(rs.next()) {
				int provId=rs.getInt("ProviderID");
				int id=rs.getInt("ProductID");
				int typeId=rs.getInt("ProductTypeID");
				String name=rs.getString("Name");
				String product=rs.getString("Product");
				double cost = rs.getDouble("Cost");
				Provider provider = new Provider(name,product,cost,id,typeId,provId);
				providers.add(provider);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return providers;
	}
	
	public void editProviderCost(int provId, int prodId, int prodTypeId, double cost) {
		Statement stmt=null;
		String SQL="UPDATE dbo.Supplies\r\n"
				+ "SET Cost="+cost+"\r\n"
				+ "WHERE ProviderID="+provId+" AND ProductID="+prodId+" AND ProductTypeID="+prodTypeId;
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
			System.out.println("изменение поставочной цены!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void editProviderName(String name, int provId) {
		Statement stmt=null;
		String SQL="UPDATE dbo.Providers\r\n"
				+ "SET Name='"+name+"'\r\n"
				+ "WHERE ProviderID="+provId;
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
			System.out.println("изменение названия поставщика!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void createProvider(String name) {
		Statement stmt = null;
		String SQL ="INSERT INTO dbo.Providers(Name) VALUES ('"+name+"')";
		
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
			System.out.println("Втавка поставщика");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<Order> getOrders() {
		Statement stmt = null;
		String SQL ="SELECT Login, PurchaseID, ProdcutsNumber, CostForPurchase, Date, \r\n"
				+ "    STUFF((SELECT '; ' + SingleProduct\r\n"
				+ "           FROM\r\n"
				+ "           (\r\n"
				+ "               SELECT Purchases.PurchaseID, Purchases.Products_number AS ProdcutsNumber, \r\n"
				+ "                   Purchases.Cost AS CostForPurchase, \r\n"
				+ "                   CONCAT(Products.Name, '/ ', Products.TypeName, '/ ', Products.Properties, '/ цена товара:', Products.Cost, '/ шт', PurchaseDetails.Products_number, '/ =', PurchaseDetails.Cost) AS SingleProduct\r\n"
				+ "               FROM dbo.Users \r\n"
				+ "               JOIN dbo.Purchases ON Users.UserID = Purchases.UserID\r\n"
				+ "               JOIN dbo.PurchaseDetails ON PurchaseDetails.PurchaseID = Purchases.PurchaseID\r\n"
				+ "               JOIN dbo.Products ON Products.ProductID = PurchaseDetails.ProductID AND Products.ProductTypeID = PurchaseDetails.ProductTypeID\r\n"
				+ "               WHERE Products.Name IS NOT NULL\r\n"
				+ "                 AND Products.TypeName IS NOT NULL\r\n"
				+ "                 AND Products.Properties IS NOT NULL\r\n"
				+ "                 AND Purchases.Date IS NOT NULL\r\n"
				+ "           ) AS T2\r\n"
				+ "           WHERE T2.PurchaseID = T1.PurchaseID\r\n"
				+ "           FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS SingleProducts\r\n"
				+ "FROM\r\n"
				+ "(\r\n"
				+ "    SELECT Login, Purchases.PurchaseID, Purchases.Products_number AS ProdcutsNumber, Purchases.Cost AS CostForPurchase, Purchases.Date\r\n"
				+ "    FROM dbo.Users \r\n"
				+ "    JOIN dbo.Purchases ON Users.UserID = Purchases.UserID\r\n"
				+ ") AS T1\r\n"
				+ "GROUP BY Login, PurchaseID, ProdcutsNumber, CostForPurchase, Date;";
		ResultSet rs=null;
		List<Order> orders = new ArrayList<>();
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(SQL);
			while(rs.next()) {
				String login=rs.getString("Login");
				String date=rs.getString("Date");
				int purchaseID=rs.getInt("PurchaseID");
				int productsNumber=rs.getInt("ProdcutsNumber");
				String productsInfo=rs.getString("SingleProducts");
				double orderCost = rs.getDouble("CostForPurchase");
				
				List<Product> products= new ArrayList<>();
				String[] difProductsInfo = productsInfo.split(";");
				for(String singleProduct:difProductsInfo) {
					String[] productInfo = singleProduct.split("/");
					double productCost=Double.parseDouble(productInfo[3].replaceAll("[^\\d.]", ""));
					int number=Integer.parseInt(productInfo[4].replaceAll("[^\\d.]", ""));
					double summaryCost=Double.parseDouble(productInfo[5].replaceAll("[^\\d.]", ""));
					Product product = new Product(productInfo[0], productInfo[1],productInfo[2],productCost,number,summaryCost);
					products.add(product);
				}
				Order order=new Order(login,date,productsNumber,orderCost,products,purchaseID);
				orders.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orders;
	}
	
	public List<Order> getOrderByID(int id) {
		Statement stmt = null;
		String SQL ="SELECT Login, PurchaseID, ProdcutsNumber, CostForPurchase, Date, \r\n"
				+ "    STUFF((SELECT '; ' + SingleProduct\r\n"
				+ "           FROM\r\n"
				+ "           (\r\n"
				+ "               SELECT Purchases.PurchaseID, Purchases.Products_number AS ProdcutsNumber, \r\n"
				+ "                   Purchases.Cost AS CostForPurchase, \r\n"
				+ "                   CONCAT(Products.Name, '/ ', Products.TypeName, '/ ', Products.Properties, '/ цена товара:', Products.Cost, '/ шт', PurchaseDetails.Products_number, '/ =', PurchaseDetails.Cost) AS SingleProduct\r\n"
				+ "               FROM dbo.Users \r\n"
				+ "               JOIN dbo.Purchases ON Users.UserID = Purchases.UserID\r\n"
				+ "               JOIN dbo.PurchaseDetails ON PurchaseDetails.PurchaseID = Purchases.PurchaseID\r\n"
				+ "               JOIN dbo.Products ON Products.ProductID = PurchaseDetails.ProductID AND Products.ProductTypeID = PurchaseDetails.ProductTypeID\r\n"
				+ "               WHERE Products.Name IS NOT NULL\r\n"
				+ "                 AND Products.TypeName IS NOT NULL\r\n"
				+ "                 AND Products.Properties IS NOT NULL\r\n"
				+ "                 AND Purchases.Date IS NOT NULL\r\n"
				+ "           ) AS T2\r\n"
				+ "           WHERE T2.PurchaseID = T1.PurchaseID\r\n"
				+ "           FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS SingleProducts\r\n"
				+ "FROM\r\n"
				+ "(\r\n"
				+ "    SELECT Login, Purchases.PurchaseID, Purchases.Products_number AS ProdcutsNumber, Purchases.Cost AS CostForPurchase, Purchases.Date\r\n"
				+ "    FROM dbo.Users \r\n"
				+ "    JOIN dbo.Purchases ON Users.UserID = Purchases.UserID\r\n"
				+ "	WHERE Purchases.PurchaseID="+id+"\r\n"
				+ ") AS T1\r\n"
				+ "GROUP BY Login, PurchaseID, ProdcutsNumber, CostForPurchase, Date;";
		ResultSet rs=null;
		List<Order> orders = new ArrayList<>();
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(SQL);
			while(rs.next()) {
				String login=rs.getString("Login");
				String date=rs.getString("Date");
				int purchaseID=rs.getInt("PurchaseID");
				int productsNumber=rs.getInt("ProdcutsNumber");
				String productsInfo=rs.getString("SingleProducts");
				double orderCost = rs.getDouble("CostForPurchase");
				
				List<Product> products= new ArrayList<>();
				String[] difProductsInfo = productsInfo.split(";");
				for(String singleProduct:difProductsInfo) {
					String[] productInfo = singleProduct.split("/");
					double productCost=Double.parseDouble(productInfo[3].replaceAll("[^\\d.]", ""));
					int number=Integer.parseInt(productInfo[4].replaceAll("[^\\d.]", ""));
					double summaryCost=Double.parseDouble(productInfo[5].replaceAll("[^\\d.]", ""));
					Product product = new Product(productInfo[0], productInfo[1],productInfo[2],productCost,number,summaryCost);
					products.add(product);
				}
				Order order=new Order(login,date,productsNumber,orderCost,products,purchaseID);
				orders.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orders;
	}
	
	public void deletePurchaseInfo(int purchaseID) {
		Statement stmt = null;
		String SQL ="DELETE FROM dbo.Purchases\r\n"
				+ "WHERE PurchaseID="+purchaseID;
		
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
			System.out.println("Удаление информации о заказе");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void deleteProvider(int id) {
		Statement stmt = null;
		String SQL ="DELETE FROM dbo.Providers\r\n"
				+ "WHERE ProviderID="+id;
		
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
			System.out.println("Удаление поставщика");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void deleteProduct(int id) {
		Statement stmt = null;
		String SQL ="DELETE FROM dbo.Products\r\n"
				+ "WHERE ProductID="+id;
		
		try {
			stmt=conn.createStatement();
			stmt.executeUpdate(SQL);
			System.out.println("Удаление продукта");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	                                  
	
}