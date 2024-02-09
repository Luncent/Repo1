package model;

import java.util.ArrayList;

import org.apache.commons.math3.optim.OptimizationData;
import org.apache.commons.math3.optim.PointValuePair;
import org.apache.commons.math3.optim.linear.LinearConstraint;
import org.apache.commons.math3.optim.linear.LinearConstraintSet;
import org.apache.commons.math3.optim.linear.LinearObjectiveFunction;
import org.apache.commons.math3.optim.linear.Relationship;
import org.apache.commons.math3.optim.linear.SimplexSolver;
import org.apache.commons.math3.optim.nonlinear.scalar.GoalType;

public class Simplex {
	public static int[] calculate(double [] mainfuncCoef, double[][] constr, double[] b) {
		   double[] coefficients = mainfuncCoef;

	       ArrayList<LinearConstraint> constraints = new ArrayList<LinearConstraint>(); 
	       int maxIndex = constr.length;
	       for(int i=0; i<maxIndex-1; i++) {
	    	   constraints.add( new LinearConstraint(constr[i], Relationship.GEQ, b[i]));
	    	   System.out.println("ограничение "+(i+1)+" "+constr[i]+">="+b[i]);
	       }
	       
	        constraints.add(new LinearConstraint(constr[maxIndex-1], Relationship.LEQ, b[maxIndex-1]));
	        
	        // Создание целевой функции и линейных ограничений
	        LinearObjectiveFunction objectiveFunction = new LinearObjectiveFunction(coefficients, 0);
	        LinearConstraintSet constraintSet = new LinearConstraintSet(constraints);

	        // Создание задачи линейного программирования
	        OptimizationData[] data = {constraintSet, objectiveFunction, GoalType.MAXIMIZE};
	        SimplexSolver solver = new SimplexSolver();
	        PointValuePair solution = solver.optimize(data);

	        // Получение значений решения
	        double[] solv = solution.getPoint();
	        int index = solv.length;
	        int[] point = new int[index+1]; 
	        
	        for(int i=0; i<solv.length; i++) {
	        	point[i]=(int)Math.round(solv[i]);
	        }
	        		
	        point[index] = (int)Math.round(solution.getValue());
	        return point;
	}	
}
