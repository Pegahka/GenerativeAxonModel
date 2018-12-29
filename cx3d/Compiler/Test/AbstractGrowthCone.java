package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.NeuriteMachine;

public abstract class AbstractGrowthCone extends NeuriteMachine {

	protected void stopIfNonePermissive(String s)
	{
		if(LSmaler(readCount(readTasteSuroundingSomasCellType(s)),val(2)).eval())
		{
			kill();
		}
	}
	
	protected void stopOnDetection(String s)
	{
		if(LBigger(readCount(readTasteSuroundingSomasCellType(s)),val(0)).eval())
		{
			kill();
		}
	}
	
	protected void stopIfNonePermissive()
	{
		if(LSmaler(readCount(readTasteSuroundingSomas()),val(1)).eval())
		{
			kill();
		}
	}
	
	
}
