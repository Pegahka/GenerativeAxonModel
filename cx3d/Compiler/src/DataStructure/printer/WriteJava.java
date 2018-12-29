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

public class WriteJava implements Visiter {


	PrintStream out = System.out;

	public WriteJava()
	{ 
	}

	
	public WriteJava(PrintStream out)
	{ 
		this.out = out;
	}

	int i = 0;
	@Override
	public void visit(AssignOperator s) {
		visit(s.var);
		out.print(" = ");
		visit(s.val);
	}

	@Override
	public void visit(BooleanConstant s) {
		out.print(" "+s.i);
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
		out.print(s.i);
	}

	@Override
	public void visit(FunctionDefinition s) {
		i+=3;
		out.print(indent()+"public ");
		if(s.type==null)
		{
			out.print("void "+s.name+"(");
		}
		else
		{
			out.print(s.type.name+" "+s.name+"(");
		}
		for(int k = 0;k<s.parameters.size();k++)
		{
			Variable v =  s.parameters.get(k);
			visit(v);
			if(k!=s.parameters.size()-1)
			{
				out.print(",");
			}
		}
		out.println(")");
		out.println(indent()+"{");
		i+=3;
		for(Statement v:  s.statements)
		{
			out.print(indent());
			visit(v);
		}
		i-=3;
		out.println(indent()+"}\n");
		i-=3;

	}

	@Override
	public void visit(FunctionCall s) {
		
		out.print(s.name+"(");
		for(int i = 0;i<s.vals.size();i++)
		{
			Value v =   s.vals.get(i);
			visit(v);
			if(i!=s.vals.size()-1)
			{
				out.print(",");
			}
		}
		
		out.print(")");
		

	}

	@Override
	public void visit(IfStaement s) {
		
		out.print("if(");
		visit(s.val);
		out.println(".eval())");
		out.println(indent()+"{");
		i+=3;
		for(Statement v:  s.statements)
		{
			out.print(indent());
			visit(v);
		}
		i-=3;
		out.println(indent()+"}");
		

	}

	@Override
	public void visit(IntegerConstant s) {
		out.print(s.i);
	}

	@Override
	public void visit(Machine s) {
		i+=3;
		if(s.isabstract)
		{
			out.print(indent()+"abstract ");
		}
		else
		{
			out.print(indent());
		}
		out.print("class "+s.name);

		if(s.basemachine !="")
		{
			out.println(" extends "+s.basemachine);
		}
		else
		{
			out.println(" extends Machine ");
		}
		
		out.println(indent()+"{");

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
		
		out.println(indent()+"}");
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
		out.print(indent()+"public ");
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
		out.print("new ");
		visit(s.val);
		i-=3;

	}

	@Override
	public void visit(NullValue s) {
		i+=3;
		out.print(" NULL");
		i-=3;

	}
	
	@Override
	public void visit(DotOperator s) {
		visit(s.base);
		out.print(".");
		visit(s.call);
	}

	@Override
	public void visit(StringValue s) {
		out.print("\""+s.v+"\"");
	}

	@Override
	public void visit(Type s) {
		out.print(s.name);
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
		
		out.print("return ");
		if(s.v!=null)
		{
			visit(s.v);
		}
	}

	@Override
	public void visit(ElseStaement s)
	{
		
		out.println("else");
		out.println(indent()+"{");
		i+=3;
		for(Statement v:  s.statements)
		{
			out.print(indent());
			visit(v);
		}
		i-=3;
		out.println(indent()+"}");
	
	}

	@Override
	public void visit(ElseIfStaement s){
		
		out.print("else if(");
		visit(s.val);
		out.print(".eval())");
		out.println(indent()+ "{");
		i+=3;
		for(Statement v:  s.statements)
		{
			out.print(indent());
			visit(v);
		}
		i-=3;
		out.println(indent()+"}");
	}

	@Override
	public void visit(ForEachStaement s)
	{
		
		out.println("for(");
		visit(s.iterating);
		out.print(" : ");
		visit(s.collection);
		out.println(")");
		out.println(indent()+"{");
		for(Statement v:  s.statements)
		{
			out.print(indent());
			visit(v);
		}
		i-=3;
		out.println(indent()+"}");
	}


	@Override
	public void visit(ContinueStatement s){
		out.print("continue");
	}

	@Override
	public void visit(JavaCodeStatement s){
		
		out.println("//++Java "+s.comment);
		out.println(s.javacode);
		out.println(indent()+"//--Java ");
		
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
			out.println(";");
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
			out.println(";");
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
			out.println(";");
		}
		else if(s instanceof AssignOperator)
		{
			visit((AssignOperator)s);
			out.println(";");
		}
		else if(s instanceof Variable)
		{
			visit((Variable)s);
			out.println(";");
		}
		else
		{
			throw new RuntimeException("type not found");
		}

	}

	@Override
	public void visit(Variable s) {
		if(s.type!=null)
		{
			
			out.print(s.type.name+" "+s.name);
		}
		else
		{
			out.print(s.name);
		}
	}

	@Override
	public void visit(VariableAsValue s) {
		out.print(s.v);
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