package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.ss4;

import gcode2.GValue;
import gcode2.GVector;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class SS4Side1 extends AbstractGrowthCone {


	@Override
	public void run() {
		if(isNonePermissive().eval())
		{
			return;
		}
		
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L1)),val(1)).eval())
		{
			incLongWating();
			StopIfLongWating();
			return;
		}
		resetLongWating();
		
		// compute direction
		GVector desiredDirection = val(0,1,0);
		move(desiredDirection,val(100),val(1),val(0.4),val(2));
		// updateDiameter if 

		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.001))));
		// if too small:
		if(LSmaler(readMorphDiameter(),val(0.7)).eval()){
			kill();
		}

	}

}
