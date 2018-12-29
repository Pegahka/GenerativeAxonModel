package ini.cx3d.fcode.highLevelMachines.ctx.celltype2;

import gcode2.GBoolean;
import gcode2.GToken;
import gcode2.GValue;
import gcode2.Machine;
import gcode2.SomaMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23.DifferentiationB23;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p23.DifferentiationP23;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p5.DifferentiationP5;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6.DifferentiationP6;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.ss4.DifferentiationSS4;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

public class RadialMigration extends SomaMachine  {

	// Racik: Mode of CEll migration to the supperficial layers

	// attaching detaching and suff





	public RadialMigration(GToken o)
	{
		migerateOn =o;
		
	}


	/* gadial glial fiber we are attached to*/
	public GToken migerateOn;

	public void run() {

		writeMorphProperty("migrating", "t");

		if(LisSet(migerateOn).eval()){
			writeMorphInterObjectForceCoefficient(val(0));
			moveAlongGuidingCylinder();
			evalueStoppingCondition();
		}else{
			writeMorphInterObjectForceCoefficient(val(0));
			moveRandomly();
			tryToClimbOntoRadialGlialProcess();
		}
	}

	/* move randomly*/
	private void moveRandomly(){
		move(val(40),val(0),val(1));
	}

	private void tryToClimbOntoRadialGlialProcess(){
		for (GToken neighbor : readTasteSuroundingNeurites("type","rgf")) {	
			migerateOn = neighbor;
		}
	}

	private void moveAlongGuidingCylinder(){
		migerateOn = moveAlong(val(100),migerateOn,val(0));
	}



	private void evalueStoppingCondition(){

		GBoolean containsL1Cells =  LBigger(getCellcounttouchingL1(),val(0));
		GBoolean suroundedBySameType = LBigger(getCountofCellswithSameTypeButFix(),val(3));

		if(LOr(containsL1Cells, suroundedBySameType).eval())
		{

			kill(); 
			//			System.out.println("no");
			//writeMorphColor(tempcol);
			//sphere.setInterObjectForceCoefficient(2);
			writeMorphMass(val(1));
			writeMorphProperty("migrating", "f");
			instantiate(new GetProperSize());
			instantiate(new GetProperInterObjectForceCoef());
			instantiate(new lateralInhibited(val(100)));
			checkifOutgrowth();

		}
	}




	private void checkifOutgrowth() {
		
		//GValue prob = val(0.01);
		GValue prob = val(1);
		if(LEquals(readCellType(),CtxConstants.L6).eval())
		{
			if(Mthrowdice(prob).eval())
			{
			//	writeStainGolgi();
				instantiate(new DifferentiationP6());
			}
		}
		else if(LEquals(readCellType(),CtxConstants.L5).eval())
		{
			if(Mthrowdice(prob).eval())
			{
			//	writeStainGolgi();
				instantiate(new DifferentiationP5());
			}
		}
		else if(LEquals(readCellType(),CtxConstants.L4).eval())
		{
			if(Mthrowdice(prob).eval())
			{
				
			//	writeStainGolgi();
				instantiate(new DifferentiationSS4());
			}
		}
		else if(LEquals(readCellType(),CtxConstants.L23).eval())
		{
			if(Mthrowdice(prob).eval())
			{
			//	writeStainGolgi();
				instantiate(new DifferentiationP23());
			}
		}

	}


	private GValue getCountofCellswithSameTypeButFix() {
		GValue neighbourtypesamecount = val(0);
		for(GToken n:  readTasteSuroundingSomasCellType(readCellType()))
		{

			if(readTastePropertyEquals(n,"migrating","f").eval())
			{

				neighbourtypesamecount= MAdd(neighbourtypesamecount,val(1));
			}
		}
		return neighbourtypesamecount;
	}

	private GValue getCellcounttouchingL1() {

		return readCount(readTasteSuroundingSomasCellType(CtxConstants.L1));

	}




}
