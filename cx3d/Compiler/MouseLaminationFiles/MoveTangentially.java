package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23;



import gcode2.GBoolean;
import gcode2.GToken;
import gcode2.GValue;
import gcode2.GVector;
import gcode2.SomaMachine;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;
import ini.cx3d.simulations.fred.ctx.Launch;

import java.awt.Color;

public class MoveTangentially extends SomaMachine  {


	//Marion: metin et all 2006 
	//Marion: Marin & Rubenstein 2003 2streams of migration (CEll Migration in Forebrain)
	//Marion: Nadarajah Parnavelas 2002 Modes of migration in the developing cerebral cortex
	GBoolean moveup = val(false);
	GValue threshhold=val(-10);
	
	String targetLayer;
	Color c;
	
	public MoveTangentially(String name,Color c)
	{
		this.c= c;
		this.targetLayer = name;
	}

	public void run() {
		
		writeMorphIgnoreboundaries(val(true));
		writeMorphInterObjectForceCoefficient(val(0));	
		writeMorphColor(c);
		writeCellType("Inihibitory");
		
		if(LEquals(threshhold,val(-10)).eval()){
			threshhold = readInBetween(readDetectExtracellularConcentration("GE")); //to be justified
		}
		
		GValue currentval = readDetectExtracellularConcentration("Thalamus");
		
		if(MinRange(threshhold, val(0.01),currentval).eval())
		{
			writeMorphIgnoreboundaries(val(false));
			moveup = val(true);
		}
		

		if(moveup.eval())
		{
			writeMorphIgnoreboundaries(val(false));
			moveUp(); 
			outgrowth();

		}
		else
		{
			growfully();
			moveRandomly();
			
		
		}

	}

	private GValue readInBetween(GValue g) {
		GValue min= val(8.55940594059406);
		GValue max= val(9.5);
		
		GValue normedval = MDiv(MSub(g, min),MSub(max,min));
		
		GValue pos = MMult( normedval,val(9.5));
		
		return  pos;
	}

	private void growfully() {
		if (LSmaler(readMorphDiameter(),val(10)).eval()){
			writeMorphDiameter(MAdd(readMorphDiameter(),val(0.1)));
		}
	}

	private void moveRandomly(){
		GVector graddir  = readDetectExtracellularGradient("Thalamus");
		
		if(LSmaler(readPositionNotAllowed().YNotAllowed(),val(30)).eval())
		{
			graddir = MAdd(graddir,val(0,5,0));//0,5,0 sitœa la sim en un lugar distinto
		}
	
		move(graddir,val(400),val(1),val(1),val(0.3)); //400,1,1,0.3
	}

	private void moveUp(){

		move(val(0,1,0),val(200),val(0),val(3),val(5));//0,1,0,200,0,3,5
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

	private GValue recalc(GValue internal)
	{
		//return internal;
		GValue o1 = MSub(internal,val(0.943110886));
		GValue norm = MDiv(o1,val( 0.5806074));
		GValue o2 = MSub(val(9.5),val(0.047));
		GValue o3 = MMult(norm, o2);
		return MAdd(o3,val(0.047));
	}
	
}
