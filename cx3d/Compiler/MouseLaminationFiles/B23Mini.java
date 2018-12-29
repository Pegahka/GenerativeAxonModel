package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23;

import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;

public class B23Mini extends AbstractGrowthCone {

	
	@Override
	public void run() {
		stopIfNonePermissive();
		if(LSmaler(readMorphDiameter(),val(0.6)).eval()){
			kill();
		}
		move(val(100),val(1),val(3));
		
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.001))));
		
	}

}
