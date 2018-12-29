package ini.cx3d.cells.geneNetwork2;

import gcode2.GBoolean;
import gcode2.GValue;
import gcode2.SomaMachine;
import ini.cx3d.Param;
import ini.cx3d.simulation.ECM;

/**
 * @author sabina High level machine that contains the genetic network
 */
public abstract class GeneNetworkMachine extends SomaMachine {

    //Marion suggestions:
	
	// Qin Shen, Sally Temple 2006 The timing of cortical neurogenisis within linages of individual progrenitor cells   

	//Jennifre Slater Sally Temple. Cell lingage ree models of neurogenisis
	
	// Torii M, Rakic Integration of neuroal clones in radial cortical columns by EphA and ephrin-A signaling
	
	// Reeler Mouse read up again
	
	//Protomal Araeas: Rakic:  Independent parcellation of the embryonic visual cortex and thalamus reveled by combinatorial Eph/Ephrin gene exepression

	
	protected GValue asymetryProb = val(1);
	

	public abstract void run();


	protected void startGene(String gene1)
	{
		GValue timeConstant = val(10);
		GValue cnc = readDetectIntracellularConcentration(gene1);
		GValue g = MHill(MAdd(val(1),cnc));

		//gene interaction
		GValue degTerm_g1 = readDetectIntracellularConcentration(gene1);
		GValue quantity_g1 = MMult(timeConstant,(MSub(g,degTerm_g1)));
		writeSecreteIntracellularQuantity(gene1, quantity_g1);
	}
	
	protected void bistableSwitch(String gene1,String gene2,String ext,GValue asymetryProb)
	{
//		if(LEquals(ext,"g1_A6_2").eval())
//		{
//			if(LBigger(readDetectIntracellularConcentration(ext),val(0.99)).eval())
//			{
//				
//				System.out.println("here"+readDetectIntracellularConcentration(ext)+""+this);
//				
//			}
//		}
		GValue timeConstant = val(10);	
		GValue ext_gene_c= readDetectIntracellularConcentration(ext);
		GValue tr = val(0);
		
		if(LBigger(ext_gene_c ,val(0.99)).eval())
		{
			tr = val(1);
		}
		
		GValue g1= MHill(readDetectIntracellularConcentration(gene1));
		GValue g2= MHill(readDetectIntracellularConcentration(gene2));

		
		GValue not_g1 = GeneNot(g2);
		GValue or2_g1 = GeneOr(tr, g1);
		GValue and_g1 = GeneAnd(or2_g1, not_g1);
		GValue or1_g1 = GeneOr(and_g1, g1);
		
		//gene interaction
		GValue degTerm_g1 = readDetectIntracellularConcentration(gene1);
		GValue quantity_g1 = MMult(timeConstant,(MSub(or1_g1,degTerm_g1)));
		writeSecreteIntracellularQuantity(gene1, quantity_g1);
		
		
		
		GValue not_g2 = GeneNot(g1);
		GValue or2_g2 = GeneOr(tr, g2);
		GValue and_g2 = GeneAnd(or2_g2, not_g2);
		GValue or1_g2 = GeneOr(and_g2, g2);
			
			//gene interaction
		GValue degTerm_g2 = readDetectIntracellularConcentration(gene2);
		GValue quantity_g2 = MMult(timeConstant,(MSub(or1_g2,degTerm_g2)));
		writeSecreteIntracellularQuantity(gene2, quantity_g2);
			
		if(isInRange(gene1, gene2).eval())
		{
			this.asymetryProb = asymetryProb;
		}
		if(LOr(LBigger(readDetectIntracellularConcentration(gene1),val(0.99)),LBigger(readDetectIntracellularConcentration(gene2),val(0.99))).eval())
		{
			writeMorphAssymetryConstant(gene1,val(0));
			writeMorphAssymetryConstant(gene2, val(0));
		}
	}
	
	

	private GBoolean isInRange(String gene1,String gene2)
	{
		GValue g1 = readDetectIntracellularConcentration(gene1);
		GValue g2= readDetectIntracellularConcentration(gene2);
		
		GValue thl = val(0.9);
		GValue thh = val(0.99);
		
		return LAnd(LAnd(LBigger(g1, thl),LSmaler(g1, thh)),LAnd(LBigger(g2, thl),LSmaler(g2, thh)));
	}
	

	private GValue GeneOr(GValue a,GValue b)
	{
		return MSub(MAdd(a,b),MMult(a,b));
	}
	
	private GValue GeneAnd(GValue a,GValue b)
	{
		return MMult(a,b);
	}
	
	private GValue GeneNot(GValue a)
	{
		return MSub(val(1),a);
	}

	protected void timer(String sub, GValue hittime) {
		readDetectIntracellularConcentration(sub);
		writeSecreteIntracellularQuantity(sub,MDiv(val(1), hittime));
	}
	
	protected void growfully(GValue maxDiamiter, GValue dVdt)
	{
		if (LSmaler(readMorphDiameter(),maxDiamiter).eval()){
			writeMorphDiameter(MAdd(readMorphDiameter(),dVdt));
		}
		
	}
	
	
	protected GBoolean runcycle = val(true);
	private GValue time = val(0);
	private GValue tmax = val(LocalParam.CELL_CYCLE_TMAX);
	private GValue timestep = val(Param.SIMULATION_TIME_STEP);
	private GValue recurrentprobadd = val(0);
	
	
	public  void cellCycle() {
		
		if(runcycle.eval())
		{
			
			
			time = MAdd(time,timestep);

			growfully(val(10), val(0.2));
//			printConc();
			if (LBigger(time,tmax).eval()) {
//				System.out.println("---------");
//				printConc();
				GValue rand = Mrand();
				if(Mthrowdice(MAdd(Mabs(this.asymetryProb),recurrentprobadd)).eval())
				{
					recurrentprobadd=val(0);
					//asymetric
					
					this.replicate(val(0,1,0), getGeneNetwork(), val(1),val(false));
				}
				else
				{
					//symetric
					recurrentprobadd = MAdd(recurrentprobadd,val(0.07));
					this.replicate(val(0,1,0), getGeneNetwork(), val(1),val(true));
				}
				this.time = val(0);
//				printConc();
			}
			
		}
	}
	
	protected abstract GeneNetworkMachine getGeneNetwork();


//	private void printConc()
//	{
//		System.out.println("cellcycle "+recurrentprobadd);
//	}

//	private void  printSwitch(String s)
//	{
//		
//		System.out.println("conc of "+s+" " +readDetectIntracellularConcentration(s+"_1") +" "+readDetectIntracellularConcentration(s+"_2"));
//		
//		
//	}
	
}

