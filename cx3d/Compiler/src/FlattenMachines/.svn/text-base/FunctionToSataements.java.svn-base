package FlattenMachines;

import java.util.Vector;

import Compiler.AbstractVisiter;
import DataStructure.javaDNA.AssignOperator;
import DataStructure.javaDNA.ElseIfStaement;
import DataStructure.javaDNA.ElseStaement;
import DataStructure.javaDNA.FunctionCall;
import DataStructure.javaDNA.FunctionDefinition;
import DataStructure.javaDNA.IfStaement;
import DataStructure.javaDNA.Machine;
import DataStructure.javaDNA.ReturnStatement;
import DataStructure.javaDNA.Statement;
import DataStructure.javaDNA.Value;
import DataStructure.javaDNA.Variable;

public class FunctionToSataements extends AbstractVisiter {

	int i = 0;
	Machine m ; 
	@Override
	public void visit(FunctionDefinition d) {
		boolean contains_calls = true;
		while(contains_calls)
		{
			contains_calls =containsCalls(d);
		}
		super.visit(d);
	}
	
	public void visit(IfStaement d) {
		boolean contains_calls = true;
		while(contains_calls)
		{
			contains_calls =containsCalls(d);
		}
		super.visit(d);
	}
	
	public void visit(ElseIfStaement d) {
		boolean contains_calls = true;
		while(contains_calls)
		{
			contains_calls =containsCalls(d);
		}
		super.visit(d);
	}
	
	public void visit(ElseStaement d) {
		boolean contains_calls = true;
		while(contains_calls)
		{
			contains_calls =containsCalls(d);
		}
		super.visit(d);
	}
	
	
	public void visit(Machine m) {
		this.m = m;
		Vector<FunctionDefinition> funcdef = new Vector<FunctionDefinition>();
		for(FunctionDefinition f: m.functions)
		{
			if(f.name.equals("run"))
			{
				visit(f);
			}
			else if(f.name.equals(m.name))
			{
				
			}
			else
			{
				funcdef.add(f);
			}
		}
		
		for(FunctionDefinition f: funcdef)
		{
			m.functions.remove(f);
		}
		
	}

	private boolean containsCalls(FunctionDefinition d) {
		Vector<Statement> newstatements = new Vector<Statement>();
		boolean found = false;
		for(int i = 0; i< d.statements.size();i++)
		{
			Statement s = d.statements.get(i);
			if(null!=replaceFunctionCall(newstatements,s))
			{	
				found = true;
			}
			else if(null!=replaceAssignment(newstatements,s))
			{
				found = true;
			}
			else
			{
				newstatements.add(s);
			}
			
		}
		d.statements = newstatements;
		return found;
	}
	
	private boolean containsCalls(IfStaement d) {
		Vector<Statement> newstatements = new Vector<Statement>();
		boolean found = false;
		for(int i = 0; i< d.statements.size();i++)
		{
			Statement s = d.statements.get(i);
			if(null!=replaceFunctionCall(newstatements,s))
			{	
				found = true;
			}
			else if(null!=replaceAssignment(newstatements,s))
			{
				found = true;
			}
			else
			{
				newstatements.add(s);
			}
			
		}
		d.statements = newstatements;
		return found;
	}
	
	private boolean containsCalls(ElseStaement d) {
		Vector<Statement> newstatements = new Vector<Statement>();
		boolean found = false;
		for(int i = 0; i< d.statements.size();i++)
		{
			Statement s = d.statements.get(i);
			if(null!=replaceFunctionCall(newstatements,s))
			{	
				found = true;
			}
			else if(null!=replaceAssignment(newstatements,s))
			{
				found = true;
			}
			else
			{
				newstatements.add(s);
			}
			
		}
		d.statements = newstatements;
		return found;
	}
	
	private boolean containsCalls(ElseIfStaement d) {
		Vector<Statement> newstatements = new Vector<Statement>();
		boolean found = false;
		for(int i = 0; i< d.statements.size();i++)
		{
			Statement s = d.statements.get(i);
			if(null!=replaceFunctionCall(newstatements,s))
			{	
				found = true;
			}
			else if(null!=replaceAssignment(newstatements,s))
			{
				found = true;
			}
			else
			{
				newstatements.add(s);
			}
			
		}
		d.statements = newstatements;
		return found;
	}
	

	public AssignOperator replaceAssignment(Vector<Statement> newstatements,Statement s)
	{
		if(s instanceof AssignOperator)
		{
			AssignOperator a = (AssignOperator)s;
			if(a.val instanceof FunctionCall && ((FunctionCall)a.val).callType.equals("local"))
			{
				FunctionCall f =  (FunctionCall)a.val;
				VariableChange v = new VariableChange("_"+this.i++);
				for(Statement st : getAllStaementsOfFunctionDefintion(f.name,f.vals,v))
				{
					newstatements.add(st);
				}
				Statement tmp =  newstatements.get(newstatements.size()-1);
				a.val = ((ReturnStatement) tmp).v;
				newstatements.remove(newstatements.size()-1);
				newstatements.add(a);
				return a;
			}
		}
		return null;
	}
	
	
	public FunctionCall replaceFunctionCall(Vector<Statement> newstatements,Statement s)
	{
		if(s instanceof FunctionCall && ((FunctionCall)s).callType.equals("local"))
		{
			FunctionCall f =  (FunctionCall)s;
			VariableChange v = new VariableChange("_"+this.i++);
			
			for(Statement st : getAllStaementsOfFunctionDefintion(f.name,f.vals,v))
			{
				newstatements.add(st);
			}
			return f;
		}
		return null;
	}
	

	private Vector<Statement> getAllStaementsOfFunctionDefintion(String name, Vector<Value> vals, VariableChange variablechange) {
		Vector<Statement> newstatements = new Vector<Statement>();
		
		for(FunctionDefinition f: m.functions)
		{
			if(!f.name.equals(name)) continue;
			if(f.parameters.size()!=vals.size()) continue;
			//I could check for valuetype here but overkill I guess
			for(int i = 0;i<f.parameters.size();i++)
			{
				Variable var = (Variable)f.parameters.get(i).getCopy();
				variablechange.visit(var);
				Value v = (Value) vals.get(i).getCopy();
				AssignOperator as = new AssignOperator();
				as.val = v;
				as.var = var;
				newstatements.add(as);
			}
			for(Statement s:f.statements)
			{
				Statement scopy = s.getCopy();
				variablechange.visit(scopy);
				newstatements.add(scopy);
			}
			return newstatements;
		}
		
		return null;
	}
}
