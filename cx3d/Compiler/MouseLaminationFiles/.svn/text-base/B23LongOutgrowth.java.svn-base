package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23;

import gcode2.GValue;
import gcode2.NeuriteMachine;

public class B23LongOutgrowth extends NeuriteMachine {

	final GValue maxNbOfSide = MAdd(val(1),MMult(val(1), Mrand()));
	GValue nbOfSide = val(0);

	@Override
	public void run() {
		if(	LSmaler(nbOfSide,maxNbOfSide).eval())
		{
			if(Mthrowdice(val(0.15)).eval())
			{
				fork(new StartLongOutgrowth());
				nbOfSide = Minc(nbOfSide);
			}
			return;
		}
		kill();
	}


}

class StartLongOutgrowth extends NeuriteMachine{

	@Override
	public void run() {
		instantiate(new B23Long());
		instantiate(new B23MediumOutgrowth());
		kill();
	}
	
	}
