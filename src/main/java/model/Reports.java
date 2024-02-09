package model;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;

public class Reports {
	public static void printReport() {
		  File reportFile1;
			String jasperFile;
			String nameFile = null;
			
		    jasperFile = "D:\\JavaWorkSpace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\KursovoiWebAppWithDB\\downloads\\List1VP.jasper";
		    reportFile1 = new File(jasperFile);

		    if (!reportFile1.exists()){
		        System.out.println("File .jasper not found !");
		        throw new JRRuntimeException("File .jasper not found. The report design must be compiled first.");
		    }
		    
		    Map<String, Object> parameters = new HashMap<String, Object>();
		    List<Map<String,String>> data = new ArrayList<Map<String, String>>();
	        
			JasperPrint jasperPrint1 = null;
			
			ProductsDataSource source = new ProductsDataSource();
			source.calcProductsToBuy();
			for(ProductDataSource singleSource: source.getProductsDataSource()) {
				
				Map<String, String> map1 = new HashMap<String, String>();
				
				map1.put("productName", singleSource.getName());
				map1.put("productInfo", singleSource.getTypeName()+", "+singleSource.getProductInfo());
				map1.put("productCost", String.valueOf(singleSource.getProductCost()));
				map1.put("providerCost", String.valueOf(singleSource.getProviderCost()));
				map1.put("left", String.valueOf(singleSource.getLeft()));
				map1.put("sold", String.valueOf(singleSource.getSold()));
				map1.put("numberToBuy", String.valueOf(singleSource.getNumberToBuy()));
				
				data.add(map1);
			}

		    nameFile = "D:\\JavaWorkSpace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp2\\wtpwebapps\\KursovoiWebAppWithDB\\downloads\\List1VP.pdf";
		        
		    JasperReport jasperReport1;
			try {
				jasperReport1 = (JasperReport)JRLoader.loadObject(reportFile1);
			 		
				
				jasperPrint1 = JasperFillManager.fillReport( jasperReport1,parameters, new testDS(data));
				
		    	if (jasperPrint1 != null) {
		    		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		        	jasperPrintList.add( jasperPrint1);
		
		        	FileOutputStream tout = new FileOutputStream(nameFile);
		            
		        	JRPdfExporter exporter = new JRPdfExporter();
		        	exporter.setParameter(JRExporterParameter.JASPER_PRINT_LIST, jasperPrintList);
		        	exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, tout);
		
		        	try {
		        		exporter.exportReport();
		        	}
		        	finally {
		        		try {
							tout.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
		        	}
		    	}
		    	else {
			        System.out.println("Object jasperPrint hasn't created !");
			    }	
			}
		    catch (JRException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		    
	}
}
