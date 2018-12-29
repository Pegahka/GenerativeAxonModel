package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.ss4;

import gcode2.NeuriteMachine;
import gcode2.SomaMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.BasalDendriteOutgrowth;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.PyramidalAxonMain;

public class DifferentiationSS4 extends SomaMachine {



	@Override
	public void run() {
		writeMorphMass(val(2000));
		instantiate(new BasalDendriteOutgrowth());
//
		fork(val(0.01,-1,0),new SS4StartAxon());

		kill();

	}


}

class SS4StartAxon extends NeuriteMachine
{

	@Override
	public void run() {
		instantiate(new PyramidalAxonMain());
		instantiate(new SS4Side1Outgrowth());
		writeMorphDiameter(val(1));
		writeMorphAxon();
		kill();
	}
}