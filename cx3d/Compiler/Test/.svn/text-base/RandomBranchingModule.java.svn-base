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
		GValue tmp;
		GValue k = findsomething(v);
			
		stopIfNonePermissive(CtxConstants.L6);

		GValue probabilityToBifurcate = val(0.01); // o.oo5
		move(val(100), val(1),val(3));
		if(LBigger(probdie,val(1)).eval()){
			GValue k2 = findsomething(v);
			kill();
		}
		readPositionNotAllowed().XNotAllowed();
		if(Mthrowdice(probabilityToBifurcate).eval()){
			if(bool(true).eval())
			{
				GValue k = findsomething(v);
			}
			probdie= MAdd(probdie, val(0.30));
			fork(new RandomBranchingModule(probdie),new RandomBranchingModule(probdie));
			kill();
		}
	}
	
	public GValue findsomething(GValue v)
	{
		return v;
	}
}