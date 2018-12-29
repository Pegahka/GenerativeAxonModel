package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p5;

import gcode2.GValue;
import gcode2.NeuriteMachine;

public class P5SideOutgrowth extends NeuriteMachine {
	
	// Long side branches -> L23
	GValue maxNbOfLongSide = MAdd(val(2),Mrand(val(3)));
	GValue nbOfLongSide = val(0);
	
	// Short Side branches (staying here
	GValue maxNbOfShortSide = MAdd(val(2),Mrand(val(3)));
	GValue nbOfShortSide = val(0);

	@Override
	public void run() {
		if(LAnd(LSmaler(nbOfLongSide,maxNbOfLongSide),Mthrowdice(val(0.1))).eval()){
			fork(new P5SideLong());
			nbOfLongSide = Minc(nbOfLongSide);
			
		}else if(LAnd(LSmaler(nbOfShortSide,maxNbOfShortSide),Mthrowdice(val(0.1))).eval()){
			fork(new P5SideShort());
			nbOfShortSide = Minc(nbOfShortSide);
			
		} 

	}


}
