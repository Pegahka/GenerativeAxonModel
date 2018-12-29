package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23;

import gcode2.GVector;
import gcode2.NeuriteMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class B23Long extends AbstractGrowthCone {

		
	@Override
	public void run() {
		
		stopIfNonePermissive();
		GVector gradient = val(0,-1,0);
		move(gradient,val(100),val(1),val(1),val(1));
		
		// Some minis...
		if(Mthrowdice(val(0.02)).eval()){
			fork(new B23Mini(),val(0.7));
		}
		
		// stop if we enter L5
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L5)),val(0)).eval()){
			kill();
		}
	}
	

}
