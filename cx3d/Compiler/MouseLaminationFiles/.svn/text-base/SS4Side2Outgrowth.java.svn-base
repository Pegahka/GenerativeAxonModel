package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.ss4;

import gcode2.GValue;
import gcode2.GVector;
import gcode2.NeuriteMachine;

public class SS4Side2Outgrowth extends NeuriteMachine {

	GValue maxNbOfSide = MAdd(val(2),Mrand(val(2)));
	GValue nbOfSide = val(0);

	@Override
	public void run() {
		if(LAnd(LSmaler(nbOfSide,maxNbOfSide),

				Mthrowdice(val(0.015))).eval()
		){
			GVector gradient = val(0,1,0);
			fork(gradient, new SS4Side2(),val(0.9));
			nbOfSide = Minc(nbOfSide);
		}

	}



}
