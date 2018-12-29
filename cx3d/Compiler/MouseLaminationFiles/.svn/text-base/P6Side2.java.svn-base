package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6;

import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;
import gcode2.GVector;
import gcode2.NeuriteMachine;

public class P6Side2 extends AbstractGrowthCone {

	

	

	public void run() {
		if(isNonePermissive().eval())
		{
			return;
		}

		// compute direction
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L1)),val(1)).eval())
		{
			incLongWating();
			StopIfLongWating();
			return;
		}
		resetLongWating();
		
		GVector desiredDirection = val(0,1,0);
		move(desiredDirection,val(100),val(1),val(1),val(2));
		
		
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.002))));
		
		if(LAnd(LSmaler(readMorphDiameter(),val(0.9)),Mthrowdice(val(0.05))).eval()){	
			fork(new P6Side2(),new P6Side2(),val(0.9));
			kill();
		}
		
		if(LSmaler(readMorphDiameter(),val(0.6)).eval()){
			kill();
		}
		
		stopOnDetection(CtxConstants.L23);
		stopOnDetection(CtxConstants.L5);
		
	}


}
