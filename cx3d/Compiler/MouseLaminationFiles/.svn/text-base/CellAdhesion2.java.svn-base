package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.GToken;
import gcode2.GTokenCollection;
import gcode2.GValue;
import gcode2.GVector;
import gcode2.SomaMachine;

import ini.cx3d.utilities.TimeToken;
import ini.cx3d.utilities.Timer;

import java.util.ArrayList;

public class CellAdhesion2 extends SomaMachine {

	

	@Override
	public void run(){
		
		if (LSmaler(readMorphDiameter(),val(10)).eval()){
			return;
		}
		
		writeMorphProperty("grown", "fully");
		GToken tobindwith = null;
		GValue dist = val(Double.MAX_VALUE);
		GValue localcount=val(0);
		GTokenCollection ps = this.readTasteSuroundingSomasCellType(readCellType());
		
		for (GToken neighbor : ps) {

			GVector f = readTasteForceFrom(neighbor);
			GValue distance = readTasteDistanceFrom(neighbor);
			GValue maxdist =  readTasteMaxInteractionDistance(neighbor);
			if(LNot(readTastePropertyEquals(neighbor, "grown", "fully")).eval()) continue;
			if(LBigger(MNorm(f),val(0)).eval()) continue;				
			if(LBigger(distance,maxdist).eval()) continue;
			
			if(LNot(readAttachHasPhysicalBondWith(neighbor)).eval())
			{
				GValue dist_c = distance;
				if(LBigger(dist,dist_c).eval())
				{
					dist = dist_c;
					tobindwith = neighbor;
				}
			
			}
			else
			{
				localcount=Minc(localcount);

			}
		}
		if(LisSet(tobindwith).eval())
		{
			
			writeAttachPhysicalBond(tobindwith,val(500), val(0), val(10));
		}
		if(LBigger(localcount,val(1)).eval())
		{
			kill();
		}

	}
}
