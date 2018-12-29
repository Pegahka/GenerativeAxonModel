package ini.cx3d.fcode.highLevelMachines.ctx.celltype2.lgn;



import gcode2.GBoolean;
import gcode2.GValue;
import gcode2.GVector;
import gcode2.NeuriteMachine;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;
import ini.cx3d.fcode.highLevelMachines.helper.GradientX;
import ini.cx3d.simulation.ECM;

public class TangInGrowth extends NeuriteMachine  {

	
	//MArion: has sent me some papers about thalamic ingrowth  this is Molnar. (Handshake and such)
	//Marion: read S. Garel/Rubenstein 2004 (coridor neurons)
	//MArion: bielle neuron 20011  slit2 activity in the migration of guidepost neurons shapes thalamic projections during development and evolution
	//Lopez Bendito Garel 2006 Tangential neuronal migration controls axonal guidance: a role for neurogulin1...
	
	GValue threshhold=val(-10);

	GBoolean foundWaintingSpot = val(false);
	GValue noN = val(0);
	GBoolean foundL23Cell = val(false);
	GValue waitrounds = val(200);

	public TangInGrowth() {
	}

	public void run() {
	
		//++Java wait until its nine past
		if(LSmaler(val(ECM.getInstance().getECMtime()),val(10.5)).eval()) return; //trick no bio relation
		//--Java
		writeMorphProperty("thalamus", "t");
		writeMorphIgnoreboundaries(val(true));
		writeMorphInterObjectForceCoefficient(val(0));
		
		if(LEquals(threshhold,val(-10)).eval()){
			threshhold = readInBetween(readDetectExtracellularConcentration("GE")); //to be justified
		}
		
		GValue currentval = readDetectExtracellularConcentration("Thalamus");
	

		if(MinRange(threshhold, val(0.01),currentval).eval())
		{
			writeMorphIgnoreboundaries(val(false));
			foundWaintingSpot = val(true);
		}

			if(foundWaintingSpot.eval())
		{
			if(LNot(foundL23Cell).eval())
			{
				L23Cellaround();
				return;
			}
			if(LBigger(waitrounds,val(0)).eval())
			{
				waitrounds = Mdec(waitrounds);
				return;
			}
			//			cellElement.removeLocalBiologyModule(this);
			
		
			moveUp();
			outgrowth();
			growfully();
		}
		else
		{
			moveRandomly();
		}
		
	}

		if(LOr(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L23)),val(0)),
			   LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L4)),val(0))).eval())
		{
			waitrounds = MAdd(waitrounds,Mrand(val(30)));
			foundL23Cell = val(true);
		}
	}

	GValue maxNbOfSide = val(1);
	GValue nbOfSide6 = val(0);
	GValue icounter = val(0);
	private void outgrowth() {
		if(LAnd(LSmaler(nbOfSide6,maxNbOfSide)
				, LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L6)),val(0))).eval())
		{

			fork(new RandomBranchingModule());
			nbOfSide6=Minc(nbOfSide6);

		}

		if(	LAnd(LBigger(readCount(readTasteSuroundingSomasCellType(CtxConstants.L4)),val(0))).eval()){

			kill();
			instantiate(new RandomBranchingModule4());
		}

	}

	private GValue threshold = MAdd(val(50),Mrand(val(15)));
	private void moveRandomly(){

		
		GVector graddir  = readDetectExtracellularGradient("Thalamus");

		if(LSmaler(readPositionNotAllowed().YNotAllowed(),threshold).eval())
		{
			graddir = MAdd(graddir,val(0,5,0));
			move(graddir,val(100),val(0.01),val(1),val(0.3));
		}
		else
		{
			move(graddir,val(400),val(0.01),val(1),val(0.3));
		}

	}


	
	private GValue readInBetween(GValue g) {
		GValue min= val(8.55940594059406);
		GValue max= val(9.5);
		
		GValue normedval = MDiv(MSub(g, min),MSub(max,min));
		
		GValue pos = MMult( normedval,val(9.5));
		
		return  pos;
	}


}
