package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6;

import gcode2.GVector;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

import java.awt.Color;

public class P6ApicalDendriteMain extends AbstractGrowthCone {


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

		// 2) Evaluate stopping conditions
		// We kill the movement when we enter a region with large concentration of "23"
		
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L23)),val(0)).eval()){
			kill();
		}
		
		// 3a) inferior side branch 
//		if(LAnd(LBigger(getCountofCellswithSameTypeButFix(CtxConstants.L6),val(0)),Mthrowdice(val(0.02))).eval()){	
//			fork(new P6ApicalDendriteSide(),new P6ApicalDendriteSide());
//		}
		
		if(LAnd(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L4)),val(0)),Mthrowdice(val(0.02))).eval()){	
			fork(new P6ApicalDendriteSide());
		}
//		// 3a) superior side branch 

	}

}
