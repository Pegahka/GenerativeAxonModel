package ini.cx3d.cells.geneModules2;

import gcode2.GValue;
import ini.cx3d.cells.geneNetwork2.GeneNetworkMachine;
import ini.cx3d.cells.geneNetwork2.MoveSVZ;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.ChangeColorAndMigrate;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p23.DifferentiationP23;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p5.DifferentiationP5;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.p6.DifferentiationP6;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.ss4.DifferentiationSS4;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

import java.awt.Color;

public class GRNArea6 extends GeneNetworkMachine
{


	@Override
	public void run() {
	
		
		startGene("start");
		bistableSwitch("g0_A6_1","g0_A6_2","start",val(1));
		bistableSwitch("g1_A6_1","g1_A6_2","g0_A6_1",val(-0.8));
		bistableSwitch("g2_A6_1","g2_A6_2","g0_A6_2",val(-0.9));
		bistableSwitch("g2b_A6_1","g2b_A6_2","g2_A6_2",val(-1));
		bistableSwitch("g3_A6_1","g3_A6_2","g2_A6_1",val(1));
		bistableSwitch("g4_A6_1","g4_A6_2","g3_A6_1",val(-0.7));
		bistableSwitch("g5_A6_1","g5_A6_2","g3_A6_2",val(-0.7));
		bistableSwitch("g6_A6_1","g6_A6_2","g5_A6_1",val(-0.8));
		bistableSwitch("g7a_A6_1","g7a_A6_2","g6_A6_2",val(-0.9));
		bistableSwitch("g7_A6_1","g7_A6_2","g6_A6_1",val(-0.9));
		bistableSwitch("g8_A6_1","g8_A6_2","g7_A6_1",val(-0.8));
		timer("timer_A6_4", val(9));
		timer("timer_A6_3",val(13));


		
		//promoters
		//6
		GValue th = val(0.99);
		if( LOr(
				LBigger(readDetectIntracellularConcentration("g1_A6_1"),th),
				LBigger(readDetectIntracellularConcentration("g1_A6_2"),th),
				LBigger(readDetectIntracellularConcentration("g2b_A6_1"),th),
				LBigger(readDetectIntracellularConcentration("g2b_A6_2"),th)
		).eval())
		{
			instantiate(new ChangeColorAndMigrate(Color.RED, CtxConstants.L6));
			writeMorphProperty("count", "A6_6");
			kill();
		}
		//5
		if( LOr(
				LBigger(readDetectIntracellularConcentration("g4_A6_1"),th),
				LBigger(readDetectIntracellularConcentration("g4_A6_2"),th),
				LBigger(readDetectIntracellularConcentration("g5_A6_2"),th)
				).eval())
		{
			instantiate(new ChangeColorAndMigrate(Color.GREEN, CtxConstants.L5));
			writeMorphProperty("count", "A6_5");
			kill();
		}
		//SVZ
		if( LOr(
				LBigger(readDetectIntracellularConcentration("g5_A6_1"),th)
				).eval())
		{
			instantiate(new MoveSVZ());
		}
		//4
		if( LOr(
				LBigger(readDetectIntracellularConcentration("g7a_A6_2"),th),
				LBigger(readDetectIntracellularConcentration("g7a_A6_1"),th)
				).eval())
		{
			runcycle = val(false);
			writeMorphProperty("count", "A6_4");
			if(LBigger(readDetectIntracellularConcentration("timer_A6_4"),th).eval())
			{
				instantiate(new ChangeColorAndMigrate(Color.BLUE, CtxConstants.L4));
				kill();
			}
		}
		//2-3
		if( LOr(
				LBigger(readDetectIntracellularConcentration("g7_A6_2"),th),
				LBigger(readDetectIntracellularConcentration("g8_A6_1"),th),
				LBigger(readDetectIntracellularConcentration("g8_A6_2"),th)
				).eval())
		{
			runcycle = val(false);
			writeMorphProperty("count", "A6_23");
			if(LBigger(readDetectIntracellularConcentration("timer_A6_3"),th).eval())
			{
				instantiate(new ChangeColorAndMigrate(Color.CYAN, CtxConstants.L23));
				kill();
			}
		}
		
		cellCycle();
	}

	@Override
	protected GeneNetworkMachine getGeneNetwork() {
		// TODO Auto-generated method stub
		return new GRNArea6();
	}
}