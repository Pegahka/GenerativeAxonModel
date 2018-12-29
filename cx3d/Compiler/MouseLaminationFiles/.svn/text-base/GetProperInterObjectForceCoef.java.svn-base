package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.SomaMachine;

/**
 * Used for finishing the cell cycle for cells that don't divide.
 * @author fredericzubler
 *
 */
public class GetProperInterObjectForceCoef extends SomaMachine {

	
	@Override
	public void run() {
		if (LSmaler(readMorphInterObjectForceCoefficient(), val(1.1)).eval()){
			writeMorphInterObjectForceCoefficient(MAdd(readMorphInterObjectForceCoefficient(),val(0.2)));
		}else{
			kill();
		}
	}

}
