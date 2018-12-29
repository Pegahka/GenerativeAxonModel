package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.GValue;
import gcode2.SomaMachine;

/**
 * Used for finishing the cell cycle for cells that don't divide.
 * @author fredericzubler
 *
 */
public class GetProperSize extends SomaMachine {

	//reivew on cell cycle maybe: Stein, Own 2002 Enceclopedia of Cell Cycle (NOT FOUND YET)
	@Override
	public void run() {
		
		if (LSmaler(readMorphDiameter(),val(10)).eval()){
			writeMorphDiameter(MAdd(readMorphDiameter(),val(0.2)));
		}else{
			GValue tmp = readMorphDiameter();
			kill();
		}
	}
	
}
