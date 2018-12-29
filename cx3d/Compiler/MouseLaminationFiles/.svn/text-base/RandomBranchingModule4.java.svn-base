package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.lgn;

import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;
import gcode2.GValue;
import gcode2.NeuriteMachine;

public class RandomBranchingModule4 extends AbstractGrowthCone {

	private GValue probdie = val(0);
	public RandomBranchingModule4()
	{
		probdie = val(0);
	}
	public RandomBranchingModule4(GValue probdie)
	{
		this.probdie = probdie;
	}
	
	public void run() {
		if(isNonePermissive().eval())
		{
			return;
		}
//		stopIfNonePermissive(CtxConstants.L4);
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L1)),val(1)).eval())
		{
			incLongWating();
			StopIfLongWating();
			return;
		}
		resetLongWating();
		
		GValue probabilityToBifurcate = val(0.01); // o.oo5
		move(val(100), val(1),val(4));
		
		if(LBigger(probdie,val(1)).eval()){
			kill();
		}
		if(Mthrowdice(probabilityToBifurcate).eval()){
			probdie= MAdd(probdie, val(0.15));
			fork(new RandomBranchingModule4(probdie),new RandomBranchingModule4(probdie));
			kill();
		}
	}



}