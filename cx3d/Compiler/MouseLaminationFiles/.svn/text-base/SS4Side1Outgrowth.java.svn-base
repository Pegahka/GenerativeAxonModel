package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.ss4;

import gcode2.GValue;
import gcode2.NeuriteMachine;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class SS4Side1Outgrowth extends NeuriteMachine {


	GValue maxNbOfSide = MAdd(val(2),Mrand(val(3)));
	GValue nbOfSide = val(0);

	@Override
	public void run() {
		
		if(LAnd(LSmaler(nbOfSide,maxNbOfSide),
				LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L5)),val(0)),
				Mthrowdice(val(0.1))).eval()
		){

			fork(new SS4StartSideAxon());
			nbOfSide = Minc(nbOfSide);
		}

	}


}

class SS4StartSideAxon extends  NeuriteMachine
{

	@Override
	public void run() {
		instantiate(new SS4Side1());
		instantiate(new SS4Side2Outgrowth());
		kill();

	}
}