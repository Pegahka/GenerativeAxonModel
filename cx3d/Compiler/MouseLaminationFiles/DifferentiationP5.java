package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p5;

import gcode2.NeuriteMachine;
import gcode2.SomaMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.BasalDendriteOutgrowth;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.PyramidalAxonMain;

public class DifferentiationP5 extends SomaMachine {


	@Override
	public void run() {
		
		writeMorphMass(val(2000));
		
		instantiate(new BasalDendriteOutgrowth());
		fork(val(0.01,-1,0),new P5InitAxon());
		fork(val(0,1,0),new P5InitDendrite());

		kill();

	}

}

class P5InitAxon extends NeuriteMachine
{
	@Override
	public void run() {
		instantiate(new PyramidalAxonMain());
		instantiate(new P5SideOutgrowth());
		writeMorphDiameter(val(1));
		writeMorphAxon();
		kill();
	}
}

class P5InitDendrite extends NeuriteMachine
{

	@Override
	public void run() {
		instantiate(new P5ApicalDendriteMain());
		writeMorphDiameter(val(2));
		writeMorphDendrite();
		kill();
	}	
}