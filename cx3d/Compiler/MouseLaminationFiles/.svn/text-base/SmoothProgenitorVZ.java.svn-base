package ini.cx3d.cells.geneModules2;

import gcode2.GValue;
import ini.cx3d.cells.geneNetwork2.GeneNetworkMachine;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.ChangeColorAndMigrate;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23.MoveRadially;
import ini.cx3d.fcode.highLevelMachines.ctx.celltype2.B23.MoveTangentially;
import ini.cx3d.fcode.highLevelMachines.helper.CtxConstants;

import java.awt.Color;

public class SmoothProgenitorVZ extends GeneNetworkMachine
{

	public void run() {

		writeStainGolgi();
		writeMorphIgnoreboundaries(val(true));
		startGene("start");
		bistableSwitch("g0_GE_1","g0_GE_2","start", val(1));
		bistableSwitch("g1_GE_1","g1_GE_2","g0_GE_1", val(-0.8));
		bistableSwitch("g2_GE_1","g2_GE_2","g0_GE_2",val(-1));
		bistableSwitch("g3_GE_1","g3_GE_2","g2_GE_1",val(1));
		bistableSwitch("g4_GE_1","g4_GE_2","g3_GE_1",val(-1));
		bistableSwitch("g5_GE_1","g5_GE_2","g3_GE_2",val(-1));
		bistableSwitch("g6_GE_1","g6_GE_2","g5_GE_1",val(-0.7));
		bistableSwitch("g7a_GE_1","g7a_GE_2","g6_GE_2",val(-0.8));
		bistableSwitch("g7_GE_1","g7_GE_2","g6_GE_1",val(-0.9));
		bistableSwitch("g8_GE_1","g8_GE_2","g7_GE_1",val(-0.9));
		bistableSwitch("g9_GE_1","g9_GE_2","g7a_GE_1",val(-0.9));
		timer("timer_GE_4", val(9));
		timer("timer_GE_3",val(13));
		
		//promoters
		//6
		GValue th = val(0.99);
		
		if( LOr(
				LBigger(readDetectIntracellularConcentration("g1_GE_1"),th),
				LBigger(readDetectIntracellularConcentration("g1_GE_2"),th),
				LBigger(readDetectIntracellularConcentration("g2_GE_2"),th)
		).eval())
		{
			instantiate(new MoveRadially(CtxConstants.L6,new Color(255,128,128)));
			writeMorphProperty("count", "GE_6");
			kill();
		}
		//5
		if( LOr(
				LBigger(readDetectIntracellularConcentration("g4_GE_1"),th),
				LBigger(readDetectIntracellularConcentration("g4_GE_2"),th),
				LBigger(readDetectIntracellularConcentration("g5_GE_2"),th)
				).eval())
		{
			instantiate(new MoveRadially(CtxConstants.L5,new Color(128,255,128)));
			writeMorphProperty("count", "GE_5");
			kill();
		}
		
		//4
		if( LOr(
				LBigger(readDetectIntracellularConcentration("g7a_GE_2"),th),
				LBigger(readDetectIntracellularConcentration("g9_GE_1"),th),
				LBigger(readDetectIntracellularConcentration("g9_GE_2"),th)
				).eval())
		{
			runcycle = val(false);
			writeMorphProperty("count", "GE_4");
			if(LBigger(readDetectIntracellularConcentration("timer_GE_4"),th).eval())
			{
				writeMorphProperty("count", "GE_4");
				instantiate(new MoveRadially(CtxConstants.L4,new Color(128,128,255)));
				kill();
			}

		}
		//2-3
		if( LOr(
				LBigger(readDetectIntracellularConcentration("g7_GE_2"),th),
				LBigger(readDetectIntracellularConcentration("g8_GE_1"),th),
				LBigger(readDetectIntracellularConcentration("g8_GE_2"),th)
				).eval())
		{
			
			runcycle = val(false);
			writeMorphProperty("count", "GE_23");
			if(LBigger(readDetectIntracellularConcentration("timer_GE_3"),th).eval())
			{
				instantiate(new MoveRadially(CtxConstants.L23,new Color(128,255,255)));
				kill();
			}
		}		
		
		cellCycle();

	}

	@Override
	protected GeneNetworkMachine getGeneNetwork() {
		// TODO Auto-generated method stub
		return new SmoothProgenitorVZ();
	}


}