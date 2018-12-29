
package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p23;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class P23Side5 extends AbstractGrowthCone {

	
	@Override
	public void run() {
		if(isNonePermissive().eval())
		{
			return;
		}
		
		move(val(100), val(1), val(2));
		
	
		if(LSmaler(readCount(readTasteSuroundingSomasCellType(CtxConstants.L5)),val(1)).eval()){
			if(Mthrowdice(val(0.07)).eval())
			{
				kill();
				
			}
			return;
		}
		
		
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.0015))));
		
		// bifurcation if distant enough
		if(LAnd(LSmaler(readMorphDiameter(),val(0.9)), Mthrowdice(val(0.05))).eval()){
			// putting a machine in the daughters
			fork(new P23Side5(),new P23Side5(),val(0.9));
		}
		if(LSmaler(readMorphDiameter(),val(0.5)).eval()){
			kill();
		}

		
	}

	
}
