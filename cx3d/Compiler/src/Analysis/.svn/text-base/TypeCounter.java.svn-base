package Analysis;

import java.io.PrintStream;
import java.util.HashMap;

import ini.cx3d.utilities.HashT;
import Compiler.AbstractVisiter;
import DataStructure.javaDNA.ElseIfStaement;
import DataStructure.javaDNA.ElseStaement;
import DataStructure.javaDNA.FunctionCall;
import DataStructure.javaDNA.IfStaement;
import DataStructure.javaDNA.JavaCodeStatement;
import DataStructure.javaDNA.MemoryElement;
import DataStructure.javaDNA.Value;

public class TypeCounter  extends  AbstractVisiter{

	PrintStream out = System.out;

	

	
	public TypeCounter(PrintStream out)
	{ 
		this.out = out;
	}
	
	
	HashMap<String, Integer> count = new HashMap<String, Integer>();
	void count(String s)
	{
		if(!count.containsKey(s))
		{
			count.put(s, new Integer(0));
		}
		int c = count.get(s) +1;
		count.put(s, c);
	}
	
	@Override
	public void visit(FunctionCall s) {
		if(s.callType !=null && s.callType!="")
		{
			count(s.callType);
		}
		super.visit(s);
	}
	
	@Override
	public void visit(MemoryElement s) {
		count("memoryElement");
		super.visit(s);
	}
	
	@Override
	public void visit(IfStaement s) {
		//count("conditional");
		count("math");
		super.visit(s);
	}
	
	@Override
	public void visit(ElseStaement s) {
		//count("conditional");
		count("math");

		super.visit(s);
	}
	
	@Override
	public void visit(ElseIfStaement s) {
		//count("conditional");
		count("math");

		super.visit(s);
	}
	
	
	@Override
	public void visit(JavaCodeStatement s){
		count("javacode");
		super.visit(s);
	}
	
	public void print()
	{
		for (String  s : count.keySet()) {
			out.print(s+";");
		}
		out.println("");
		for (String  s : count.keySet()) {
			out.print(count.get(s)+";");
		}
		out.println("");
		
	}
	
}
