package DataStructure.printer;

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

public class HirarchicalDraw implements Visiter {


	PrintStream out = System.out;

	public HirarchicalDraw()
	{ 
	}

	
	public HirarchicalDraw(PrintStream out)
	{ 
		this.out = out;
	}

	int i = 0;
	@Override
	public void visit(AssignOperator s) {
		i+=3;

		out.println(indent()+"assignment:");

		visit(s.var);
		visit(s.val);
		i-=3;

	}

	@Override
	public void visit(BooleanConstant s) {
		i+=3;
		out.println(indent()+"BooleanConst:"+s.i);
		i-=3;

	}

	@Override
	public void visit(DNA s) {
		out.println(indent()+"DNA:");
		for (Machine m : s.machines) {
			visit(m);
		}

	}

	@Override
	public void visit(DoubleConstant s) {
		i+=3;
		out.println(indent()+"DoubleConstant:"+s.i);
		i-=3;

	}

	@Override
	public void visit(FunctionDefinition s) {
		i+=3;
		if(s.type==null)
		{
			out.println(indent()+"constructor def: "+s.name);
		}
		else
		{
			out.println(indent()+"Function def: "+s.name+" return type "+s.type.name);
		}
		i+=3;
		out.println(indent()+"parameters {");
		for(Variable v:  s.parameters)
		{
			visit(v);
		}
		out.println(indent()+"}\n");
		out.println(indent()+"statements {");
		for(Statement v:  s.statements)
		{
			visit(v);
		}
		out.println(indent()+"}\n\n");
		i-=3;
		i-=3;

	}

	@Override
	public void visit(FunctionCall s) {
		i+=3;
		out.println(indent()+"FunctionCall: "+s.name);
		for(Value v:  s.vals)
		{
			visit(v);
		}
		i-=3;

	}

	@Override
	public void visit(IfStaement s) {
		i+=3;
		out.println(indent()+"If: ");
		visit(s.val);
		out.println(indent()+"{");
		for(Statement v:  s.statements)
		{
			visit(v);
		}
		out.println(indent()+"}");
		i-=3;

	}

	@Override
	public void visit(IntegerConstant s) {
		i+=3;
		out.println(indent()+"IntegerConstant:"+s.i);
		i-=3;

	}

	@Override
	public void visit(Machine s) {
		i+=3;
		out.print(indent()+"Machine:"+s.name);

		if(s.isabstract)
		{
			out.print(" Abstract ");
		}

		if(s.basemachine !="")
		{
			out.println(" baseed on "+s.basemachine);
		}
		else
		{
			out.println();
		}

		for (MemoryElement m : s.memoryElements) {
			visit(m);
		}
		out.println();
		for (FunctionDefinition m : s.functions) {
			visit(m);
		}
		out.println();
		for (AbstractFunctionDefinition m : s.abstractfunctions) {
			visit(m);
		}
		i-=3;

	}

	public void visit(AbstractFunctionDefinition s) {
		i+=3;
		out.println(indent()+"AbstractFunction:"+s.name);
		{
			out.println(indent()+"Function def: "+s.name+" return type "+s.type.name);
		}
		i+=3;
		out.println(indent()+"parameters {");
		for(Variable v:  s.parameters)
		{
			visit(v);
		}
		out.println(indent()+"}");
		i-=3;
		i-=3;

	}

	@Override
	public void visit(MemoryElement s) {
		i+=3;
		out.println(indent()+"MemoryElement:");
		if(s.assignment!=null)
		{
			visit(s.assignment);
		}
		else
		{
			visit(s.v);
		}
		i-=3;

	}

	@Override
	public void visit(NewOperator s) {
		i+=3;
		out.println(indent()+"new :");
		visit(s.val);
		i-=3;

	}

	@Override
	public void visit(NullValue s) {
		i+=3;
		out.println(indent()+"NULL");
		i-=3;

	}
	
	@Override
	public void visit(DotOperator s) {
		
		
		visit(s.base);
		i+=3;
		out.println(indent()+":Dot:");
		visit(s.call);
		i-=3;

	}

	@Override
	public void visit(StringValue s) {
		i+=3;
		out.println(indent()+"StringValue :"+s.v);
		i-=3;

	}

	@Override
	public void visit(Type s) {
		i+=3;
		out.println(indent()+"Type :"+s.name);
		i-=3;

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
			out.println("Why odes it not exist!!"+s.getClass().getName());
		}
	}

	@Override
	public void visit(ReturnStatement s)
	{
		i+=3;
		out.println(indent()+"return ");
		if(s.v!=null)
		{
			visit(s.v);
		}
		i-=3;
	}

	@Override
	public void visit(ElseStaement s)
	{
		i+=3;
		out.println(indent()+"Else: ");
		out.println(indent()+"{");
		for(Statement v:  s.statements)
		{
			visit(v);
		}
		out.println(indent()+"}");
		i-=3;
	}

	@Override
	public void visit(ElseIfStaement s){
		i+=3;
		out.println(indent()+"Elseif: ");
		visit(s.val);
		out.println(indent()+ "{");
		for(Statement v:  s.statements)
		{
			visit(v);
		}
		out.println(indent()+"}");
		i-=3;
	}

	@Override
	public void visit(ForEachStaement s)
	{
		i+=3;
		out.println(indent()+"For: ");
		visit(s.iterating);
		out.println(indent()+" in ");
		visit(s.collection);

		out.println("\n");
		for(Statement v:  s.statements)
		{
			visit(v);
		}
		i-=3;
	}


	@Override
	public void visit(ContinueStatement s){
		i+=3;
		out.println(indent()+"continue: ");
		i-=3;
	}

	@Override
	public void visit(JavaCodeStatement s){
		i+=3;
		out.println(indent()+"JAVA code: ");
		out.println(indent()+s.comment);
		out.println(s.javacode);
		i-=3;
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
		i+=3;
		out.print(indent()+"StringValue :"+s.name);
		if(s.type!=null)
		{
			out.println(" type "+s.type.name);
		}
		else
		{
			out.println();
		}
		i-=3;

	}

	@Override
	public void visit(VariableAsValue s) {
		i+=3;
		out.println(indent()+"VariableAsValue :"+s.v);
		i-=3;

	}

	private String indent()
	{
		StringBuilder b = new StringBuilder();
		for(int k =0;k<i;k++)
		{
			b.append(" ");
		}
		return b.toString();
	}

}