package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p5;

import gcode2.GVector;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class P5SideLong extends AbstractGrowthCone {


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
		//double [] gradient = cyl.getExtracellularGradient("Semaphorin");
		GVector gradient = val(0,1,0);
		move(gradient,val(100),val(1),val(1),val(3));
		
		
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.001))));
		// if too small:
		if(LSmaler(readMorphDiameter(),val(0.5)).eval()){
			kill();
		}
		// bifurcation if in L23
		
		if(LAnd(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L23)),val(0)),Mthrowdice(val(0.05))).eval()){
			fork(new P5SideLong(),new P5SideLong(),val(0.9));
			kill();
		}

		

	}
	

}
