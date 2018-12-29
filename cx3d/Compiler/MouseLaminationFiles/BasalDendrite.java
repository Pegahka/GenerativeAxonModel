package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.GBoolean;
import gcode2.NeuriteMachine;

import java.awt.Color;

public class BasalDendrite extends AbstractGrowthCone {

	Color c;
	public BasalDendrite(Color c)
	{
		this.c  = c;
	}

	@Override
	public void run() {
		stopIfNonePermissive();
		writeMorphColor(c);
		
		if(LSmaler(readMorphDiameter(),val(0.5)).eval()){
			kill();
		}
		
		move(val(100), val(1), val(3));
		// updateDiameter
		writeMorphDiameter(MMult(readMorphDiameter(),MSub(val(1),val(0.01))));
		writeMorphDendrite();
		
		GBoolean a1 = LBigger(readMorphDiameter(),val(1.0));
		GBoolean a2 = Mthrowdice(val(0.01));
		if(LAnd(a1,a2).eval()){
			fork(new BasalDendrite(c), new BasalDendrite(c));
			kill();
		}
		
	}
	
}
