package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;


import java.lang.reflect.WildcardType;
import java.util.concurrent.CountDownLatch;

import gcode2.GToken;
import gcode2.GValue;
import gcode2.GVector;
import gcode2.NeuriteMachine;
import gcode2.SomaMachine;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;
import ini.cx3d.simulations.fred.ctx.Launch;
import ini.cx3d.spacialOrganisation.SpatialOrganizationNode;
import ini.cx3d.utilities.TimeToken;
import ini.cx3d.utilities.Timer;

public class ExtensionRGF2 extends NeuriteMachine{

	
	GValue count = val(0);
	public void run() {	

		count = Minc(count);
		if(LSmaler(count,val(10)).eval()) return;
		writeMorphProperty("type", "rgf");
		writeMorphInterObjectForceCoefficient(val(0));
		
		
		GValue min = val(30);
		for(GToken t:readTasteSuroundingSomasCellType(CtxConstants.L1))
		{
			GValue dist =  this.readTasteDistanceFrom(t);
			if(LSmaler(dist, min).eval())
			{
				min = dist;
			}
		}
		
		if(LSmaler(min,val(5)).eval())
		{
				count = val(0);
				return;
		}
		
		if(LSmaler(readCount(readTasteSuroundingSomas()),val(1)).eval())
		{
			return;
		}
		
	
		move(val(0,1,0) ,val(100), val(0.1),val(1),val(0.3));
		
	}


}
