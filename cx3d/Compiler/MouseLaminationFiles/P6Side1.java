package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6;

import gcode2.GVector;
import gcode2.NeuriteMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class P6Side1 extends AbstractGrowthCone {

	
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
		GVector gradient= val(0,1,0);
		move(gradient,val(100),val(1),val(0.7),val(0.5));

		
		stopOnDetection(CtxConstants.L23);

	}


}
