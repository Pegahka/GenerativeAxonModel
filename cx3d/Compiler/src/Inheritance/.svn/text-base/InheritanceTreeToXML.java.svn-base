package Inheritance;

import java.awt.Color;
import java.awt.Graphics;
import java.io.PrintStream;

import Compiler.Visiter;
import DataStructure.javaDNA.AbstractFunctionDefinition;
import DataStructure.javaDNA.AssignOperator;
import DataStructure.javaDNA.BooleanConstant;
import DataStructure.javaDNA.ContinueStatement;
import DataStructure.javaDNA.DNA;
import DataStructure.javaDNA.DotOperator;
import DataStructure.javaDNA.DoubleConstant;
import DataStructure.javaDNA.ElseIfStaement;
import DataStructure.javaDNA.ElseStaement;
import DataStructure.javaDNA.ForEachStaement;
import DataStructure.javaDNA.FunctionCall;
import DataStructure.javaDNA.FunctionDefinition;
import DataStructure.javaDNA.IfStaement;
import DataStructure.javaDNA.IntegerConstant;
import DataStructure.javaDNA.JavaCodeStatement;
import DataStructure.javaDNA.Machine;
import DataStructure.javaDNA.MemoryElement;
import DataStructure.javaDNA.NewOperator;
import DataStructure.javaDNA.NullValue;
import DataStructure.javaDNA.ReturnStatement;
import DataStructure.javaDNA.Statement;
import DataStructure.javaDNA.StringValue;
import DataStructure.javaDNA.Type;
import DataStructure.javaDNA.Value;
import DataStructure.javaDNA.Variable;
import DataStructure.javaDNA.VariableAsValue;
import Draw.Vector2d;
import MachineCallTree.Link;
import MachineCallTree.Node;
import MachineCallTree.Tree;

public class InheritanceTreeToXML {


	PrintStream out = System.out;

	public InheritanceTreeToXML()
	{ 
	}
	
	public InheritanceTreeToXML(PrintStream out)
	{ 
		this.out = out;
	}

	int i = 0;

	private String indent()
	{
		StringBuilder b = new StringBuilder();
		for(int k =0;k<i;k++)
		{
			b.append(" ");
		}
		return b.toString();
	}
	
	public void visit(InheritanceTree t) {
		if(t ==null) return;
		out.print("<machine name=\"machine\" type=\"OO\" complexity=\"1\" color=\""+1+"\" created=\"2008-06-24 15:15:03\">\n");
		for(InheritanceNode l:t.nodes.values())
		{
			drawTree(l,3);
		}
		out.print("</machine>\n");
	}
	
    

    private void drawTree(InheritanceNode root,int i){
    	this.i = i;
    	String color = 1+"";
    	out.print(indent()+"<machine name=\""+root.name+"\" type=\"1\"  complexity=\"1\" color=\"1\" created=\"2008-06-24 15:15:03\">\n");
		for(InheritanceNode n:root.nodes.values())
		{
			drawTree(n,i+3);
		}
    	this.i = i;
    	out.print(indent()+"</machine >\n");
    	
    }

}