package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p23;

import gcode2.GValue;
import gcode2.NeuriteMachine;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class P23Side23Outgrowth extends NeuriteMachine {

	GValue maxNbOfSide = MAdd(val(2),Mrand(val(3)));
	GValue nbOfSide = val(0);

	@Override
	public void run() {
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L23)),val(2)).eval())
		{
			if(LAnd(LSmaler(nbOfSide,maxNbOfSide),
					Mthrowdice(val(0.1))).eval()
			){
	
				fork(new P23Side23());
				nbOfSide = Minc(nbOfSide);
			}
		}

	}

}
