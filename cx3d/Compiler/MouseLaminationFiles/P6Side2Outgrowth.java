package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6;

import gcode2.GValue;
import gcode2.NeuriteMachine;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class P6Side2Outgrowth extends NeuriteMachine {

	GValue maxNbOfSide = MAdd(val(2),Mrand(val(3)));
	GValue nbOfSide = val(0);

	@Override
	public void run() {
		if(LAnd(LSmaler(nbOfSide,maxNbOfSide),
				LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L4)),val(0)),
				Mthrowdice(val(0.1))).eval()
		){
			fork(new P6Side2());
			nbOfSide=Minc(nbOfSide);
		}

	}

}
