package Test;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;

import Analysis.ComplexityByCount;
import Analysis.NeedlemanWunsch;
import Analysis.TypeCounter;
import ConherenceChecker.GCodeCompilanceChecker;
import ConherenceChecker.MachineDefinition;
import DataStructure.javaDNA.Parser;
import DataStructure.printer.TreeToXML;
import Draw.MonitoringGui;
import Draw.Drawers.ViewTreeDisplay;
import Inheritance.InheritanceTree;
import Inheritance.InheritanceTreeToXML;
import MachineCallTree.Tree;

public class TestMachineLoading {

	/**
	 * @param args
	 * @throws FileNotFoundException 
	 */
	public static void main(String[] args) throws FileNotFoundException {
		MachineDefinition g = new MachineDefinition();
		g.readGCodeType("MachineDefinition/gcode2/GBoolean.java");
		g.readGCodeType("MachineDefinition/gcode2/GValue.java");
		g.readGCodeType("MachineDefinition/gcode2/GVector.java");
		g.readGCodeType("MachineDefinition/gcode2/GToken.java");
		g.readGCodeType("MachineDefinition/gcode2/GTokenCollection.java");
		
		g.readMachineDefiniton("MachineDefinition/gcode2/Machine.java");
		g.readMachineDefiniton("MachineDefinition/gcode2/SomaMachine.java");
		g.readMachineDefiniton("MachineDefinition/gcode2/NeuriteMachine.java");
		g.addManualType("String");
		g.addManualType("Color");
	//	g.printAll();
		GCodeCompilanceChecker tmp =  new GCodeCompilanceChecker(g);
		Parser p = new Parser();
		p.ParseDir("MouseLaminationFiles");
		p.visit(tmp);
		
		
		
		TypeCounter c = new TypeCounter(new PrintStream(new FileOutputStream("primcat.csv")));
		ComplexityByCount cc = new ComplexityByCount(g,new PrintStream(new FileOutputStream("complexity.csv")));
		TreeToXML xmlT = new TreeToXML(new PrintStream(new FileOutputStream("hirarchy.xml")));
		InheritanceTreeToXML inheritxml = new InheritanceTreeToXML(new PrintStream(new FileOutputStream("inheritance.xml")));
		InheritanceTree ht = new InheritanceTree();
		p.visit(ht);
		
		
		p.visit(c);
		p.visit(cc);
		
		Tree tree = new Tree();
		p.visit(tree);
		c.print();
		cc.print();
//		tree.Print();
		xmlT.visit(tree);
		inheritxml.visit(ht);
		
		NeedlemanWunsch.generateSimilarityMatrixOfMachines(p.dna,new PrintStream(new FileOutputStream("similarity.csv")));
		NeedlemanWunsch.makeClusters(p.dna, 0.5);
		
		MonitoringGui gui =  MonitoringGui.getStandardGUI();
		ViewTreeDisplay tr = new ViewTreeDisplay();
		tr.t = tree;
		gui.addDrawer(tr, true);
		gui.setBounds(0, 0, 500, 500);
		
		
		
		
		
//		p.visit(new WriteJava());
//		p.visit(tmp);
//		p.visit(new Flatten(g));
//		p.visit(new FunctionToSataements());
//		//p.visit(new HirarchicalDraw());
//		p.visit(new WriteJava());
		
		

	}

}
