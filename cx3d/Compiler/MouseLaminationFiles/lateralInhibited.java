package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.GValue;
import gcode2.SomaMachine;

import java.awt.Color;

public class lateralInhibited extends SomaMachine {

	
	//Marion: review 2009 Rakic (inhibit aboptosis and this generates a bigger coretx but worngly placed cells) Haydar 1999
	
	//Marion : review 2005 Rakic
	//potential to propose an experiment of transplanation and chekcing weather cells will die in the layer
	
	GValue notrightthreashhold;
	
	GValue notrightcounter =val(0);
	GValue rightcounter =val(0);
	
	
	public lateralInhibited(GValue theshold)
	{
		this.notrightthreashhold = theshold;
	}
	
	@Override
	public void run(){
		GValue counter = MSub(readCount(readTasteSuroundingSomasCellType(readCellType())),readCount(readTasteSuroundingSomas()));
		GValue spheres = readCount(readTasteSuroundingSomas());
		GValue ncount =MAdd(val(1),spheres);
		if(LBigger(MDiv(val(100.0),MMult(ncount,counter)),val(50)).eval())
		{
			notrightcounter= Minc(notrightcounter);
			rightcounter = val(0);
		}
		else
		{
			rightcounter= Minc(rightcounter);
			notrightcounter = val(0);
		}
		if(LBigger(notrightcounter,notrightthreashhold).eval())
		{
			//die();
			writeMorphColor(Color.pink);
			writeCellType("inhibited");
			kill();
		} 
		
		if(LBigger(rightcounter,notrightthreashhold).eval())
		{
			kill();
		} 
		
		
	}
	
}
