package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23;
import gcode2.SomaMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.BasalDendrite;

public class B23DendriteOutgrowth extends SomaMachine {

	
	@Override
	public void run() {
		
		
		this.fork(new BasalDendrite(readMrophColor().brighter().brighter()));
		this.fork(new BasalDendrite(readMrophColor().brighter().brighter()));
		this.fork(new BasalDendrite(readMrophColor().brighter().brighter()));
		
		
		
		
		kill();
	}


}
