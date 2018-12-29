package DataStructure.printer;

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

public class TreeToXML {


	PrintStream out = System.out;

	public TreeToXML()
	{ 
	}

	
	public TreeToXML(PrintStream out)
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
	
	public void visit(Tree t) {
		if(t ==null) return;
		out.print("<beginn name=\"O\" type=\"OO\" complexity=\"1\" color=\""+1+"\" created=\"2008-06-24 15:15:03\">\n");
		for(Link l:t.n.links)
		{
			drawTree(l.n,l.type,3);
		}
		out.print("</beginn>\n");
	}
	
    

    private void drawTree(Node root,String type,int i){
    	
    	if(root.hasvited) return;
    	root.hasvited = true;
    	this.i = i;
    	String color = 1+"";
    	if(type.equals("fork"))
    		color = 2+"";
		else if(type.equals("instantiate"))
			color = 3+"";
		else if(type.equals("replicate"))
			color = 4+"";
    	out.print(indent()+"<machine name=\""+root.name+"\" type=\""+type+"\"  complexity=\""+root.m.complexity+"\" color=\""+color+"\" created=\"2008-06-24 15:15:03\">\n");
    	if(root.links.size()!=0)
    	{
    		for(Link l:root.links)
    		{
    			drawTree(l.n,l.type,i+3);	
    		}
    	}
    	this.i = i;
    	out.print(indent()+"</machine >\n");
    	root.hasvited = false;
    	
    }

}