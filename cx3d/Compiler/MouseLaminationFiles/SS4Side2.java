package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.ss4;

import gcode2.GVector;
import gcode2.NeuriteMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class SS4Side2 extends AbstractGrowthCone {

	
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
		move(desiredDirection,val(100),val(1),val(1),val(3));
		
		// updateDiameter if 
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.0015))));
		// if too small:
		if(LSmaler(readMorphDiameter(),val(0.7)).eval()){
			kill();
		}
				
		// branching if in Layer 2/3
		if(LAnd(
			LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L23)),val(0)),
			Mthrowdice(val(0.01))).eval()
			){
			
			fork(new SS4Side2(),new SS4Side2(),val(0.9));

			kill();
		}
		

	}

}
