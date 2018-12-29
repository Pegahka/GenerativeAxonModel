package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23;

import gcode2.GVector;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;

public class B23Medium extends AbstractGrowthCone {

	@Override
	public void run() {
		
		stopIfNonePermissive();
		if(LSmaler(readMorphDiameter(),val(0.5)).eval()){
			kill();
		}
		//double [] gradient = cyl.getExtracellularGradient("Semaphorin");
		GVector gradient = val(0,1,0);
		
		move(gradient,val(100),val(1),val(0.6),val(2));
	
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.003))));
		if(LBigger(readMorphDiameter(),val(0.7)).eval()){
			if(Mthrowdice(val(0.04)).eval()){
				fork(new B23Medium(),new B23Medium(),val(0.9));
				kill();
			}
		}
	}
	

}
