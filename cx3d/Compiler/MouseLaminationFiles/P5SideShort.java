package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p5;

import gcode2.GVector;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class P5SideShort extends AbstractGrowthCone {

	
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
		move(gradient,val(100),val(1),val(1),val(3));
		
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.005))));
		
		if(LSmaler(readMorphDiameter(),val(0.6)).eval()){
			kill();
			return;
		}
		
		
		if(Mthrowdice(val(0.02)).eval()){	
			fork(new P5SideShort(),new P5SideShort(),val(0.9));
			kill();
		}
		
	}
	
}
