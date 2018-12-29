package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6;

import gcode2.SomaMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.BasalDendriteOutgrowth;

public class DifferentiationP6 extends SomaMachine{
	
//	private GValue waitrounds = val(200);
	
	@Override
	public void run() {
		
		writeMorphMass(val(2000));
//		
//		if(LBigger(waitrounds,val(0)).eval())
//		{
//			waitrounds = Mdec(waitrounds);
//		}
		
		instantiate(new BasalDendriteOutgrowth());
		fork(val(0,1,0), new P6ApicalDendriteMain(), val(2));
		fork(val(0,-1,0), new PyramidalAxonMainL6(), val(1));
		
		kill();
		
	}

}
