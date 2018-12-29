package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6;

import gcode2.GVector;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class P6ApicalDendriteSide extends AbstractGrowthCone {

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
		
		
		if(LSmaler(readMorphDiameter(),val(1.0)).eval()){
			kill();
		}
		
		if(LBigger(getCountofCellswithSameTypeButFix(CtxConstants.L23),val(1)).eval()){
			kill();
		}
		
		//double [] gradient = cyl.getExtracellularGradient("Semaphorin");
		GVector gradient = val(0,1,0);
		move(gradient,val(100),val(1),val(0.7),val(2));

		// updateDiameter
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.001))));
		
		// 2) Evaluate bifurcation
		if(Mthrowdice(val(0.004)).eval()){
			fork(new P6ApicalDendriteSide(),new P6ApicalDendriteSide());
		}
		
		
	}
	

}
