package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.GToken;
import gcode2.GValue;
import gcode2.Machine;
import gcode2.SomaMachine;

import java.awt.Color;

public class ChangeColorAndMigrate extends SomaMachine {

	
	private Color color = Color.black;
	private String ctype="";
	
	
	public ChangeColorAndMigrate(Color c ,String type)
	{
		color = c;
		ctype = type;
	}

	public void run() {

		GToken pc = null;
	
		writeMorphColor(color);
		writeCellType(ctype);
		GValue dist = val(Double.MAX_VALUE);	
		for (GToken n : readTasteSuroundingNeurites("type","rgf")) {
			GValue tempd = readTasteDistanceFrom(n);
			if(LSmaler(tempd,dist).eval())
			{
				dist = tempd;
				pc = n;
			}
		}
		if(LNot(LisSet(pc)).eval())
		{
			writeMorphColor(Color.pink);
			move(val(0, 1, 0),val(50),val(0),val(1),val(3));
			return;
		}
		
		kill();
		instantiate(new RadialMigration(pc));
		instantiate(new GetProperSize());
			
	}

	
}
