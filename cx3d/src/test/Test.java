package test;

import ini.cx3d.Param;
import ini.cx3d.cells.Cell;
import ini.cx3d.cells.CellFactory;
import ini.cx3d.localBiology.SomaElement;
import ini.cx3d.physics.PhysicalSphere;
import ini.cx3d.simulations.Scheduler;

public class Test {
	public static void main(String[] args) {

		double[] cellOrigin = {0.0, 3.0, 5.0};			
		Cell cell = CellFactory.getCellInstance(cellOrigin);		
		cell.setColorForAllPhysicalObjects(Param.RED);
		SomaElement soma = cell.getSomaElement();
		PhysicalSphere sphere = soma.getPhysicalSphere();

		for (int i = 0; i < 50000; i++) {
			Scheduler.simulateOneStep();		// run the simulation
			if(sphere.getDiameter()<20){		// if small..
				sphere.changeVolume(350);		// .. increase volume
			}else{
				Cell c3 = cell.divide();		// otherwise divide
				c3.setColorForAllPhysicalObjects(Param.BLUE);
				Cell c4 = cell.divide();		// otherwise divide
				c4.setColorForAllPhysicalObjects(Param.BLUE);
			}
		}

	}
}
