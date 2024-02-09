package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRField;

public class testDS  implements JRDataSource {
    private int index = -1;
    private List<Map<String, String>> dataSpec;

    public testDS(List<Map<String,String>> data) {
    	dataSpec=data;
    }

    public boolean next() throws JRException {
        index++;
        return (index < dataSpec.size());
    }

    /**
     * @param field
     * @return
     * @throws JRException
     */
    public Object getFieldValue(JRField field) throws JRException {
        Map<String, String> map = dataSpec.get(index);        
        Object value = null;

        String fieldName = field.getName();
        
        value = map.get( fieldName);        

        return value;
    }

    public static void main(String[] args) {
    }

}
