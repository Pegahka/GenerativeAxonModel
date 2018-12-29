package Compiler;

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

public class AbstractVisiter implements Visiter{
	
	@Override
	public void visit(AssignOperator s) {
		visit(s.var);
		visit(s.val);
	}

	@Override
	public void visit(BooleanConstant s) {
	}

	@Override
	public void visit(DNA s) {
//		String str = "";
		for (Machine m : s.machines) {
//			str = m.name;
//			System.out.println(str);
			visit(m);
		}
	}

	@Override
	public void visit(DoubleConstant s) {
		

	}

	@Override
	public void visit(FunctionDefinition s) {		
		for(Variable v:  s.parameters)
		{
			visit(v);
		}
		for(Statement v:  s.statements)
		{
//			System.out.println("state: "+v);
			visit(v);
		}
	}

	@Override
	public void visit(FunctionCall s) {
		for(Value v:  s.vals)
		{
			visit(v);
		}
	}

	@Override
	public void visit(IfStaement s) {
		
		visit(s.val);
	
		for(Statement v:  s.statements)
		{
//			System.out.println(":"+v);
			visit(v);
		}
	}

	@Override
	public void visit(IntegerConstant s) {
		

	}

	@Override
	public void visit(Machine s) {
		for (MemoryElement m : s.memoryElements) {
			visit(m);
		}
		
		for (FunctionDefinition m : s.functions) {
			visit(m);
		}
	
		for (AbstractFunctionDefinition m : s.abstractfunctions) {
			visit(m);
		}
	}

	public void visit(AbstractFunctionDefinition s) {
	
		for(Variable v:  s.parameters)
		{
			visit(v);
		}
	}

	@Override
	public void visit(MemoryElement s) {
		
		if(s.assignment!=null)
		{
			visit(s.assignment);
		}
		else
		{
			visit(s.v);
		}
	}

	@Override
	public void visit(NewOperator s) {
		visit(s.val);
	}

	@Override
	public void visit(NullValue s) {
	}
	
	@Override
	public void visit(DotOperator s) {
		
		visit(s.base);
		visit(s.call);
	}

	@Override
	public void visit(StringValue s) {
		
	}

	@Override
	public void visit(Type s) {
		

	}

	@Override
	public void visit(Value s) {
		if(s instanceof StringValue)
		{
			visit((StringValue)s);
		}
		else if(s instanceof IntegerConstant)
		{
			visit((IntegerConstant)s);
		}
		else if(s instanceof DoubleConstant)
		{
			visit((DoubleConstant)s);
		}
		else if(s instanceof BooleanConstant)
		{
			visit((BooleanConstant)s);
		}
		else if(s instanceof VariableAsValue)
		{
			visit((VariableAsValue)s);
		}
		else if(s instanceof FunctionCall)
		{
			visit((FunctionCall)s);
		}
		else if(s instanceof NewOperator)
		{
			visit((NewOperator)s);
		}
		else if(s instanceof DotOperator)
		{
			visit((DotOperator)s);
		}
		else if(s instanceof NullValue)
		{
			visit((NullValue)s);
		}
		else
		{
			System.out.println("Why odes it not exist!!"+s.getClass().getName());
		}
	}

	@Override
	public void visit(ReturnStatement s)
	{
		if(s.v!=null)
		{
			visit(s.v);
		}
	}

	@Override
	public void visit(ElseStaement s)
	{
		for(Statement v:  s.statements)
		{
			visit(v);
		}
	}

	@Override
	public void visit(ElseIfStaement s){
		visit(s.val);	
		for(Statement v:  s.statements)
		{
			visit(v);
		}
	}

	@Override
	public void visit(ForEachStaement s)
	{
	
		for(Statement v:  s.statements)
		{
			visit(v);
		}
		
	}


	@Override
	public void visit(ContinueStatement s){
		
	}

	@Override
	public void visit(JavaCodeStatement s){
		
	}


	@Override
	public void visit(Statement s) {
		if(s instanceof IfStaement)
		{
			visit((IfStaement)s);
		}
		else if(s instanceof ReturnStatement)
		{
			visit((ReturnStatement)s);
		}
		else if(s instanceof ElseStaement)
		{
			visit((ElseStaement)s);
		}
		else if(s instanceof ElseIfStaement)
		{
			visit((ElseIfStaement)s);
		}
		else if(s instanceof ContinueStatement)
		{
			visit((ContinueStatement)s);
		}
		else if(s instanceof JavaCodeStatement)
		{
			visit((JavaCodeStatement)s);
		}
		else if(s instanceof ForEachStaement)
		{
			visit((ForEachStaement)s);
		}
		else if(s instanceof Value)
		{
			visit((Value)s);
		}
		else if(s instanceof AssignOperator)
		{
			visit((AssignOperator)s);
		}
		else if(s instanceof Variable)
		{
			visit((Variable)s);
		}
		else
		{
			throw new RuntimeException("type not found");
		}

	}

	@Override
	public void visit(Variable s) {
		visit(s.type);
		
	}

	@Override
	public void visit(VariableAsValue s) {
		
	}

	

}
