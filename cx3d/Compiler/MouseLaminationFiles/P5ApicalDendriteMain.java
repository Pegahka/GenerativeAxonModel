     package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p5;

import gcode2.GValue;
import gcode2.GVector;
import gcode2.NeuriteMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6.P6ApicalDendriteSide;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class P5ApicalDendriteMain extends AbstractGrowthCone {

	
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
		
		GVector gradient = val(0,1,0);
		move(gradient,val(50),val(1),val(0.7),val(3));
		
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.001))));

		if(LSmaler(readMorphDiameter(),val(0.5)).eval()){
			kill();
		}
		
		if(LAnd(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L23)),val(0)),Mthrowdice(val(0.01))).eval()){
			fork(new P5ApicalDendriteMain(),new P5ApicalDendriteMain(),val(0.9));
		}

		
		
	}

}
