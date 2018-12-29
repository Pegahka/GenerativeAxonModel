package Analysis;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;

import Compiler.AbstractVisiter;
import ConherenceChecker.MachineDefinition;
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
import DataStructure.javaDNA.Variable;
import DataStructure.javaDNA.VariableAsValue;

public class ComplexityByCount extends AbstractVisiter{

	HashMap<String, Integer> counter = new HashMap<String, Integer>();
	int k =0;
	private MachineDefinition g;
	private ArrayList<Machine> machines;
	private Machine currentm;

	
	PrintStream out = System.out;

	
	
	public ComplexityByCount(MachineDefinition g,PrintStream out)
	{
		this.out = out;
		this.g = g;
	}

	public ComplexityByCount(MachineDefinition g)
	{
		this.g = g;
	}

	@Override
	public void visit(AssignOperator s) {

		super.visit(s);
	}

	@Override
	public void visit(BooleanConstant s) {
		super.visit(s);
	}

	@Override
	public void visit(DNA s) {
		this.machines =  s.machines;

//		String str = "";
		for (Machine m : s.machines) {
//			str = m.name;
//			System.out.println(str);
//			if(str.equals("P23ApicalDendrite"))
//			{
//				System.out.println("stop");
//			}
			visit(m);
		}
	}

	@Override
	public void visit(DoubleConstant s) {

		super.visit(s);
	}

	@Override
	public void visit(FunctionDefinition s) {		
		if(s.name.equals("run"))
		{
			for(Variable v:  s.parameters)
			{
				visit(v);
			}
			for(Statement v:  s.statements)
			{
//				System.out.println("state: "+v);
				visit(v);
			}

		}
	}

	@Override
	public void visit(FunctionCall s) {
		if(s.callType.equals("local"))
		{
			functionContainedInSubtype(currentm, s);
		}
		else
		{
			k+=countFunction(s.callType);
		}
	}

	@Override
	public void visit(IfStaement s) {
		k+=1;
		super.visit(s);
	}

	@Override
	public void visit(IntegerConstant s) {
		super.visit(s);

	}

	@Override
	public void visit(Machine s) {
		if(!s.isabstract)
		{
			this.currentm = s;
			k = 0;
			super.visit(s);
			s.complexity = k;
			counter.put(s.name, k);
		}
	}

	public void visit(AbstractFunctionDefinition s) {
		super.visit(s);
	}

	@Override
	public void visit(MemoryElement s) {
		super.visit(s);
	}

	@Override
	public void visit(NewOperator s) {
		super.visit(s);
	}

	@Override
	public void visit(NullValue s) {
		super.visit(s);
	}

	@Override
	public void visit(DotOperator s) {
		super.visit(s);
	}

	@Override
	public void visit(StringValue s) {
		super.visit(s);
	}

	@Override
	public void visit(Type s) {
		super.visit(s);

	}




	@Override
	public void visit(ReturnStatement s)
	{
		super.visit(s);
	}

	@Override
	public void visit(ElseStaement s)
	{
		k+=1;
		super.visit(s);
	}

	@Override
	public void visit(ElseIfStaement s){
		k+=1;
		super.visit(s);
	}

	@Override
	public void visit(ForEachStaement s)
	{
		k+=1;
		super.visit(s);	
	}


	@Override
	public void visit(ContinueStatement s){
		super.visit(s);
	}

	@Override
	public void visit(JavaCodeStatement s){
		super.visit(s);
	}

	@Override
	public void visit(Variable s) {
		super.visit(s);

	}

	@Override
	public void visit(VariableAsValue s) {
		super.visit(s);
	}


	private void functionContainedInSubtype(Machine m,FunctionCall s) {
		for(FunctionDefinition d: m.functions)
		{
			if(d.name.equals(s.name) && d.parameters.size() == s.vals.size())
			{
				super.visit(d);
			}
		}

		for(Machine l:machines)
		{
			if(l==null) continue;
			if( m.basemachine.toLowerCase().equals(l.name.toLowerCase()))
			{
				Machine tmp = this.currentm;
				this.currentm = l;
				functionContainedInSubtype(l,s);
				this.currentm = tmp;
			}
		}

	}

	public int countFunction(String name)
	{
		if(name.contains("constructor"))
		{
			return 0;
		}
		if(name.contains("logic"))
		{
			return 1;
		}
		if(name.contains("math"))
		{
			return 1;
		}
		if(name.contains("replication"))
		{
			return 1;
		}
		if(name.contains("movement"))
		{
			return 1;
		}
		if(name.contains("termination"))
		{
			return 1;
		}
		if(name.contains("eradication"))
		{
			return 1;
		}
		if(name.contains("instantiation"))
		{
			return 1;
		}
		if(name.contains("primitive"))
		{
			return 1;
		}
		if(name.contains("reader"))
		{
			return 1;
		}

		if(name.contains("writers"))
		{
			return 1;
		}

		if(name.contains("valcreater"))
		{
			return 0;
		}
		if(name.contains("OTHER"))
		{
			return 1;
		}
		return 0;
		
		
	}


	public void print()
	{
		for (String  s : counter.keySet()) {
			out.print(s+";");
		}
		out.println();
		for (String  s : counter.keySet()) {
			out.print(counter.get(s)+";");
		}
		out.println();

	}




}
