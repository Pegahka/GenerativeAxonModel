package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23;



import gcode2.GBoolean;
import gcode2.GToken;
import gcode2.GValue;
import gcode2.GVector;
import gcode2.SomaMachine;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;
import ini.cx3d.simulations.fred.ctx.Launch;

import java.awt.Color;

public class MoveRadially extends SomaMachine  {

	
	String targetLayer;
	Color c;
	
	public MoveRadially(String name,Color c)
	{
		this.c= c;
		this.targetLayer = name;
	}

	public void run() {
		
		writeMorphInterObjectForceCoefficient(val(0));	
		writeMorphColor(c);
		writeCellType("Inihibitory");
		
		growfully();
		writeMorphIgnoreboundaries(val(false));
		moveUp(); 
		outgrowth();


	}


	private void growfully() {
		if (LSmaler(readMorphDiameter(),val(10)).eval()){
			writeMorphDiameter(MAdd(readMorphDiameter(),val(0.1)));
		}
	}

	

	private void moveUp(){

		move(val(0,1,0),val(200),val(0),val(3),val(5));
	}

	 
	private void outgrowth() {
		
		
		if(LBigger(getCountofCellswithSameTypeButFix(),val(2)).eval())
		{
			if(Mthrowdice(val(0.1)).eval()){
				writeMorphInterObjectForceCoefficient(val(1));	
				kill();
				if(LEquals(targetLayer,CtxConstants.L23).eval())
				{
					if(Mthrowdice(val(1)).eval())
					{
						instantiate(new DifferentiationB23());
					}
				}
			}
		}
		
		if(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L1)),val(1)).eval())
		{
			writeMorphInterObjectForceCoefficient(val(1));	
			kill();
		}
		
		
		if(LEquals(readCount(readTasteSuroundingSomas()),val(0)).eval())
		{
			kill();
			writeMorphColor(new Color(255,255,255));
		}
				
		

	}

	private GValue getCountofCellswithSameTypeButFix() {
		GValue neighbourtypesamecount = val(0);
		for(GToken n:  readTasteSuroundingSomasCellType(targetLayer))
		{
			if(readTastePropertyEquals(n,"migrating","f").eval())
			{
				neighbourtypesamecount= MAdd(neighbourtypesamecount,val(1));
			}
		}
		return neighbourtypesamecount;
	}

	
}
