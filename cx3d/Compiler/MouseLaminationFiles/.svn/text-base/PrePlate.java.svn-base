package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.GBoolean;
import gcode2.GValue;
import gcode2.SomaMachine;
import ini.cx3d.Param;
import ini.cx3d.biology.AbstractLocalBiologyModule;
import ini.cx3d.biology.Cell;
import ini.cx3d.biology.NeuriteElement;
import ini.cx3d.biology.SomaElement;
import ini.cx3d.cells.geneModules2.GRNArea3;
import ini.cx3d.cells.geneModules2.GRNArea6;
import ini.cx3d.cells.geneModules2.SmoothProgenitorVZ;
import ini.cx3d.cells.geneNetwork.gui.CellTrackerNode;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;
import ini.cx3d.fcode.highLevelMachines.helper.GradientX;
import ini.cx3d.physics.PhysicalObject;
import ini.cx3d.simulation.ECM;
import ini.cx3d.utilities.TimeToken;
import ini.cx3d.utilities.Timer;

import java.awt.Color;

public class PrePlate extends SomaMachine {
	
	private GValue generation = val(0);
	
	
	//Marion: growth of rgfs is earlier and they attach to the pia not layer1 cells. but they keep growing with the 
	//Taverna and Huttner Neuron 2010
	
	//Marion; Noctor 2004: How it actually is with the gray cells beein progenitors and such. and astrocites afterwards
	//Marion:  Malatesta 2000 : ON the function of radial glia cells and Progenitors
	
	//Marion: Meyer et al 2000 
	
	//Marion: Cells can count how many times they have divided: centrosome counter.
	
	


	public void run() {
		
		GValue nbOfL1Division = val(7);	 // 5
		GValue nbOfSubplateDivision = val(7); 	// 10
		
		if (LSmaler(readMorphDiameter(),val(10)).eval()){
			writeMorphDiameter(MAdd(readMorphDiameter(),val(0.2)));
			return;
		}
		
		if(LSmaler(generation,nbOfL1Division).eval()){
			generation =Minc(generation);
			replicate(val(0,1,0),new MarginalZoneStarter() , val(0.5));

			return;
		}
		else if(LSmaler(generation,MAdd(nbOfL1Division ,val(1))).eval()){
			generation =Minc(generation);
			writeCellType(CtxConstants.RGC);
			fork(val(0,1,0),new ExtensionRGF2() , val(3));
			return;
		}
		else if(LSmaler(generation,MAdd(nbOfL1Division ,nbOfSubplateDivision,val(1))).eval()){
			generation =Minc(generation);
			replicate(val(0,1,0),new SubplateStarter(), val(0.5));
			return;
		}
		
		
		writeCellType("adultpercursors");
		instantiate(new GetProperSize());
		
		replicate(val(0,1,0), new GRNStarter(), val(0.5));
		kill();
	}
	
	public String toString()
	{
		return "PrePlate";
	}
	

}


class MarginalZoneStarter extends SomaMachine {
	
	@Override
	public void run() {
		writeMorphColor(CtxConstants.L1_Color);
		writeCellType(CtxConstants.L1);
		writeMorphInterObjectForceCoefficient(val(1));
		writeMorphMass(val(0.001));
		instantiate(new lateralInhibited(val(100)));
		instantiate(new CellAdhesion2());
		instantiate(new GetProperSize());
		kill();
	}
}

class SubplateStarter extends SomaMachine {
	
	@Override
	public void run() {
		writeMorphColor(CtxConstants.L1_Color);
		writeCellType(CtxConstants.Subplate);
//		writeMorphInterObjectForceCoefficient(val(1.4));
		writeMorphMass(val(1.0));
		instantiate(new GetProperSize());
		instantiate(new GetProperInterObjectForceCoef());
		kill();
	}
}

class GRNStarter extends SomaMachine {
	
	@Override
	public void run() {
		writeMorphColor(new Color(.73f, 0f, 0.97f, .03f));
		writeCellType("pre");
		
		GValue ge = readDetectExtracellularConcentration("GE");
		GValue th = readDetectExtracellularConcentration("Thalamus");
	
		GBoolean b =  LBigger(ge, th);
		
		if(Mthrowdice(val(0)).eval()) //smoothcells in VZ...
		{
			instantiate(new SmoothProgenitorVZ());
			writeMorphColor(new Color(148,0,211));
		}	
		else if(b.eval())
		{
			instantiate(new GRNArea3());
			writeMorphColor(new Color(129,59,9));
		}
		else
		{
			instantiate(new GRNArea6());
			writeMorphColor(new Color(139,69,19));
		}
		kill();
	}
}
