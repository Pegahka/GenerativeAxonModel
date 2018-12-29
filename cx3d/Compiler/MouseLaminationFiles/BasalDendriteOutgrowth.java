package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.SomaMachine;

import java.awt.Color;

public class BasalDendriteOutgrowth extends SomaMachine {


	@Override
	public void run() {
		//1
		final Color c = this.readMrophColor();
		fork(MrandomDir(),new BasalDendrite(c),val(1.9));
		fork(MrandomDir(),new BasalDendrite(c),val(1.9));
		fork(MrandomDir(),new BasalDendrite(c),val(1.9));
		
		kill();
	}

}
