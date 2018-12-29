package floretgenerator;

import static ini.cx3d.utilities.Matrix.randomNoise;
import ini.cx3d.Param;
import ini.cx3d.cells.Cell;
import ini.cx3d.cells.CellFactory;
import ini.cx3d.localBiology.NeuriteElement;
import ini.cx3d.physics.Substance;
import ini.cx3d.simulations.ECM;
import ini.cx3d.simulations.Scheduler;

import java.awt.Color;

import segmentexporter.Segment;
import segmentexporter.SegmentsHandler;

public class Main {
	public static void main(String[] args) {
		ECM ecm = ECM.getInstance();
		
		String substanceId = "test";
		
		double maxSubstance = 10000.0;
		double minSubstance = 0.0;
		
		int numberOfFlorets = 5;
		SegmentsHandler segments = new SegmentsHandler();
		
		for (int i=0; i < numberOfFlorets; i++) {
			
			Segment root = new Segment();
		
			for (int ii = 0; ii < 18; ii++) {	
				ecm.getPhysicalNodeInstance(randomNoise(1000,3));			
			} 
			ECM.setRandomSeed(7L);
			
			Substance substance = new Substance(substanceId,Color.red);
			
			ecm.addArtificialLinearConcentrationZ(substance, MathCommons.bias * (maxSubstance - minSubstance), maxSubstance, minSubstance);
						
			Cell c = CellFactory.getCellInstance(new double[] {0,0,0});
			c.setColorForAllPhysicalObjects(Param.GRAY);
			NeuriteElement neurite = c.getSomaElement().extendNewNeurite(new double[] {0,0,0});
			neurite.getPhysicalCylinder().setDiameter(2);
			
			double resource = MathCommons.resourceGamma.sample();
			
			neurite.addLocalBiologyModule(new Floret(resource, root, substanceId));		
		
			Boolean simulate = true;
			
			while (simulate) {
				
				simulate = false;
				
				for (NeuriteElement ne : c.getNeuriteElements()) {
					if (!ne.getLocalBiologyModulesList().isEmpty())
						simulate = true;
				}
								
				Scheduler.simulateOneStep();
			}
			
			if ( i < numberOfFlorets - 1) 	
				ecm.clearAll();
			else 
				System.out.println("Finished");
			
			segments.addSegment(root);
		}
		segments.generateOutput();
	}
}
