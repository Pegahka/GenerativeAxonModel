package ConherenceChecker;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import Compiler.AbstractVisiter;
import DataStructure.javaDNA.AbstractFunctionDefinition;
import DataStructure.javaDNA.DNA;
import DataStructure.javaDNA.FunctionCall;
import DataStructure.javaDNA.FunctionDefinition;
import DataStructure.javaDNA.Machine;
import DataStructure.javaDNA.NewOperator;
import DataStructure.javaDNA.Type;
import DataStructure.javaDNA.VariableAsValue;

public class GCodeCompilanceChecker extends AbstractVisiter{

	private MachineDefinition g;
	private ArrayList<Machine> machines;
	private Machine currentmachine;
	
	public GCodeCompilanceChecker(MachineDefinition g)
	{
		this.g = g;
	}

	@Override
	public void visit(DNA s) {
		this.machines = s.machines;
		for (Machine m : machines) {
			if(m==null) continue;
			if(!isDecendentOfMachine(m))
			{
				System.out.println("the class is no machine: "+m.name);
				isDecendentOfMachine(m);
			}
		}
		
		super.visit(s);
	}
	
	
	@Override
	public void visit(NewOperator s) {
		
	}
	
	private boolean isDecendentOfMachine(Machine m) {
		for(String l:g.machineTypes)
		{
			if(l.contains(m.basemachine))
			{
				return true;
			}
		}
		for(Machine l:machines)
		{
			if(l==null) continue;
			if(m.basemachine.toLowerCase().equals(l.name.toLowerCase()))
			{
				return isDecendentOfMachine(l);
			}
		}
		return false;
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
		for(String k: g.machineTypes)
		{
			if(k.contains(s.name))
			{
				return;
			}
		}
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
		s.callType = k;
		if(k.equals("OTHER"))
		{
			if(!functionContainedInSubtype(currentmachine,s.name))
			{
				System.out.println("Function call is no primitive: "+s.name);
			}
			else
			{
				s.callType = "local";
			}
		}
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
}
