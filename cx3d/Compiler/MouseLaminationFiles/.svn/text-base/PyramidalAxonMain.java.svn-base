package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.GBoolean;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;


public class PyramidalAxonMain extends AbstractGrowthCone {

	
	@Override
	public void run() {
		
		move(val(0,-1,0) ,val(100),val(1),val(0.3),val(0.5));		
		
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.Subplate)),val(2)).eval())
		{
			kill();
		}
		
		
	}

}
