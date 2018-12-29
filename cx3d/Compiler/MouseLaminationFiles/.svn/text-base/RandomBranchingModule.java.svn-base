package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.lgn;

import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;
import gcode2.GValue;
import gcode2.NeuriteMachine;

public class RandomBranchingModule extends AbstractGrowthCone {

	
	private GValue probdie = val(0);
	public RandomBranchingModule()
	{
		probdie = val(0);
	}
	public RandomBranchingModule(GValue probdie)
	{
		this.probdie = probdie;
	}
	
	public void run() {
		if(isNonePermissive().eval())
		{
			return;
		}
		
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L1)),val(1)).eval())
		{
			incLongWating();
			StopIfLongWating();
			return;
		}
		resetLongWating();
		
		GValue probabilityToBifurcate = val(0.005); // o.oo5
		move(val(100), val(1),val(3));
		if(LBigger(probdie,val(1)).eval()){
			kill();
		}
		if(Mthrowdice(probabilityToBifurcate).eval()){
			probdie= MAdd(probdie, val(0.35));
			fork(new RandomBranchingModule(probdie),new RandomBranchingModule(probdie));
			kill();
		}
	}

}