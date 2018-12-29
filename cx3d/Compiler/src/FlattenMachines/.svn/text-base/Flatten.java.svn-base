package FlattenMachines;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import Compiler.AbstractVisiter;
import ConherenceChecker.MachineDefinition;
import DataStructure.javaDNA.AbstractFunctionDefinition;
import DataStructure.javaDNA.DNA;
import DataStructure.javaDNA.DotOperator;
import DataStructure.javaDNA.FunctionCall;
import DataStructure.javaDNA.FunctionDefinition;
import DataStructure.javaDNA.Machine;
import DataStructure.javaDNA.MemoryElement;
import DataStructure.javaDNA.NewOperator;
import DataStructure.javaDNA.Type;
import DataStructure.javaDNA.VariableAsValue;

public class Flatten extends AbstractVisiter{

	private MachineDefinition g;
	private ArrayList<Machine> machines;
	private Machine currentmachine;
	
	public Flatten(MachineDefinition g)
	{
		this.g = g;
	}

	@Override
	public void visit(DNA s) {
		this.machines = s.machines;
		for (Machine m : machines) {
			if(m==null) continue;
			flattenMachine(m);
		}
		
		ArrayList<Machine> mach =  (ArrayList<Machine>) machines.clone();
		for (Machine m : mach) {
			if(m==null) continue;
			if(m.isabstract)
			{
				s.machines.remove(m);
			}
		}
		
		super.visit(s);
	}
	
	
	@Override
	public void visit(NewOperator s) {
		
	}
	
	private void flattenMachine(Machine m) {
		for(String l:g.machineTypes)
		{
			if(l.contains(m.basemachine))
			{
				return;
			}
		}
		for(Machine l:machines)
		{
			if(l==null) continue;
			if(m.basemachine.toLowerCase().equals(l.name.toLowerCase()))
			{
				m.basemachine = l.basemachine;
				for (FunctionDefinition f1 : l.functions) {
					if(!m.functions.contains(f1));
					{
						m.functions.add(f1);
					}
				}
				for (MemoryElement f1 : l.memoryElements) {
					if(!m.memoryElements.contains(f1));
					{
						m.memoryElements.add(f1);
					}
				}
				
				
				flattenMachine(m);
				return;
			}
		}
	}
	
	private boolean functionContainedInSubtype(Machine m,String function) {
		for(FunctionDefinition d: m.functions)
		{
			if(d.name.equals(function))
			{
				return true;
			}
		}
		for(AbstractFunctionDefinition d: m.abstractfunctions)
		{
			if(d.name.equals(function))
			{
				return true;
			}
		}
		
		for(Machine l:machines)
		{
			if(l==null) continue;
			if( m.basemachine.toLowerCase().equals(l.name.toLowerCase()))
			{
				return functionContainedInSubtype(l,function);
			}
		}
		return false;
	}

	@Override
	public void visit(Type s) {
		if(s ==null) return;
		for(String k: g.types)
		{
			if(k.contains(s.name))
			{
				return;
			}
		}
		System.out.println("type does not exisit :"+s.name);
	}
	
	@Override
	public void visit(FunctionCall s) {
		String k =  g.getPrimitiveType(s.name);
		super.visit(s);
	}
	
	
	

	@Override
	public void visit(Machine s) {
		this.currentmachine = s;
		super.visit(s);
	}



	@Override
	public void visit(VariableAsValue s) {
		Pattern regex;
		Matcher matcher;
		regex = Pattern.compile("^[a-zA-Z_0-9]+$");
		matcher = regex.matcher(s.v);
		if(!matcher.find())
		{
			System.out.println("variable name does not comply :"+s.v);
		}
	}
	
	@Override
	public void visit(DotOperator s) {
		
		visit(s.base);
		visit(s.call);
	}
	
}
