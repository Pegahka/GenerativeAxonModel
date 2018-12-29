package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6;

import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.AbstractGrowthCone;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;
import gcode2.GBoolean;
import gcode2.GToken;
import gcode2.GValue;
import gcode2.GVector;
import gcode2.NeuriteMachine;

public class PyramidalAxonMainL6 extends AbstractGrowthCone {


	public GToken fiber= null; 
	
	@Override
	public void run() {
		
		if(LisSet(fiber).eval()){
			
			 this.followToThalamus();
		}
		else
		{
			
			
			
			if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L6)),val(2)).eval())
			{
				if(Mthrowdice(val(0.01)).eval())
				{
					instantiate(new P6Side1Outgrowth());
				}
			}
			findThalamicfiber();
			
			writeMorphInterObjectForceCoefficient(val(0));
			if(checkHitBottom().eval())
			{
				return;
			}
			
			if(isNonePermissive().eval())
			{
				return;
			}
			GVector desiredDirection = val(0,1,0);
			move(desiredDirection,val(100),val(1),val(0.3),val(0));	
		}
		
	}

	
	private GBoolean checkHitBottom()
	{
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L6)),val(0)).eval())
		{
			return val(false);
		}
		return val(true);
	}
	
	
	private void findThalamicfiber() {
		
		for (GToken n: readTasteSuroundingNeurites("thalamus","t")) {
			fiber = n;
			
			break;
		}
	}
	
	private void followToThalamus()
	{
		
		writeMorphIgnoreboundaries(val(true));
		GValue dist= val(-4); 
		fiber = moveBackOn(val(400),fiber,dist);
	}
	
	

}
