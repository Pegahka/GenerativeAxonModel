

package ini.cx3d.simulations.tutorial;

import java.awt.Color;

import ini.cx3d.Param;
import ini.cx3d.cells.Cell;
import ini.cx3d.cells.CellFactory;
import ini.cx3d.localBiology.CellElement;
import ini.cx3d.localBiology.LocalBiologyModule;
import ini.cx3d.localBiology.NeuriteElement;
import ini.cx3d.simulations.ECM;
import ini.cx3d.simulations.Scheduler;

import static ini.cx3d.utilities.Matrix.add;
import static ini.cx3d.utilities.Matrix.normalize;
import static ini.cx3d.utilities.Matrix.randomNoise;


public class Test2 implements LocalBiologyModule {

	NeuriteElement neuriteElement;
	
	private double[] direction;
	
	public CellElement getCellElement() {
		return neuriteElement;
	}

	public void setCellElement(CellElement cellElement) {
		if(cellElement.isANeuriteElement()){
			neuriteElement = (NeuriteElement)cellElement;
			direction = neuriteElement.getPhysicalCylinder().getAxis();
		}else{
			cellElement.removeLocalBiologyModule(this);
			System.out.println("Sorry, I only work with neurite elements");
		}
	}
	
	public LocalBiologyModule getCopy() {
		Test2 m = new Test2();
		return m;
	}

	public boolean isCopiedWhenNeuriteBranches() {
		return true;
	}

	public boolean isCopiedWhenNeuriteElongates() {
		return false;	// only in growth cones
	}

	public boolean isCopiedWhenNeuriteExtendsFromSoma() {
		return false;	// this method should never be called
	}

	public boolean isCopiedWhenSomaDivides() {
		return false;  	// this method should never be called
	}
	
	public boolean isDeletedAfterNeuriteHasBifurcated() {
		return true;	// Important because of bifurcations!
	}

	public void run() {
		double speed = 100;
		double probabilityToBifurcate = 0.005; // o.oo5		
		//double[] deltaDirection = randomNoise(0.1, 3);
		double[] deltaDirection = {0,0,0};
		direction = add(direction, deltaDirection);		
		direction = normalize(direction);
		neuriteElement.getPhysical().movePointMass(speed, direction);
		
		if(ECM.getRandomDouble()<probabilityToBifurcate){
			NeuriteElement[] nn = neuriteElement.bifurcate();
			nn[0].getPhysical().setColor(Param.RED);
			nn[1].getPhysical().setColor(Param.BLUE);
			return;
		}		
	}

	public static void main(String[] args) {
		ECM ecm = ECM.getInstance();
		for (int i = 0; i < 18; i++) {	
			ecm.getPhysicalNodeInstance(randomNoise(1000,3));
		} 
		ECM.setRandomSeed(7L);
		
		Cell c = CellFactory.getCellInstance(randomNoise(40, 3));
		c.setColorForAllPhysicalObjects(Param.GRAY);
		NeuriteElement neurite = c.getSomaElement().extendNewNeurite(new double[] {0,0,1});
		neurite.getPhysicalCylinder().setDiameter(2);
		neurite.addLocalBiologyModule(new Test2());
	
		Scheduler.simulate();
	}

}

