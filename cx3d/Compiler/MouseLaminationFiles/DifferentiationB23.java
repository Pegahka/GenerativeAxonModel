package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23;

import gcode2.NeuriteMachine;
import gcode2.SomaMachine;

public class DifferentiationB23 extends SomaMachine {

	
	@Override
	public void run() {
		
		instantiate(new B23DendriteOutgrowth());
		
		fork(new B23StartAxonnew());
		kill();
	}



}

class B23StartAxonnew extends NeuriteMachine
{
	@Override
	public void run() {
		
		instantiate(new B23Long());
		instantiate(new B23LongOutgrowth());
		instantiate(new B23MediumOutgrowth());
		writeMorphDiameter(val(1));
		writeMorphAxon();
		kill();
	}
}