package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p23;

import gcode2.NeuriteMachine;
import gcode2.SomaMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.BasalDendriteOutgrowth;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.PyramidalAxonMain;

public class DifferentiationP23 extends SomaMachine {

	
	
	@Override
	public void run() {
	    instantiate(new BasalDendriteOutgrowth());
		fork(val(0.01,1,0),new P23InitDendrite(),val(2));
		fork(val(0.01,-1,0),new P23InitAxon());
		writeMorphMass(val(2000));
		kill();
	}

}


class P23InitAxon extends NeuriteMachine
{
	@Override
	public void run() {
		
		instantiate(new PyramidalAxonMain());
		instantiate(new P23Side23Outgrowth());
		instantiate(new P23Side5Outgrowth());
		writeMorphDiameter(val(1));
		writeMorphAxon();
		kill();
	}
}

class P23InitDendrite extends NeuriteMachine {
	@Override
	public void run() {
		instantiate(new P23ApicalDendrite());
		writeMorphDiameter(val(2));
		writeMorphDendrite();
		kill();
	}
}