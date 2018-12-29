package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23;

import gcode2.GValue;
import gcode2.NeuriteMachine;

public class B23MediumOutgrowth extends NeuriteMachine {
	
	final GValue maxNbOfSide = MAdd(val(2),MMult(val(2), Mrand()));
	GValue nbOfSide = val(0);

	@Override
	public void run() {
		if(LSmaler(nbOfSide,maxNbOfSide).eval())
		{
			if(Mthrowdice(val(0.3)).eval())
			{
				fork(new StartMediumOutgrowth());
				nbOfSide = Minc(nbOfSide);
			}
		}
	}



}

class StartMediumOutgrowth extends  NeuriteMachine{

	@Override
	public void run() {
		instantiate(new B23Medium());
		kill();
	}
	
}