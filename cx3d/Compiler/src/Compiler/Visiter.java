package Compiler;

import DataStructure.javaDNA.AssignOperator;
import DataStructure.javaDNA.BooleanConstant;
import DataStructure.javaDNA.ContinueStatement;
import DataStructure.javaDNA.DNA;
import DataStructure.javaDNA.DotOperator;
import DataStructure.javaDNA.DoubleConstant;
import DataStructure.javaDNA.ElseIfStaement;
import DataStructure.javaDNA.ElseStaement;
import DataStructure.javaDNA.ForEachStaement;
import DataStructure.javaDNA.FunctionDefinition;
import DataStructure.javaDNA.FunctionCall;
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

public interface  Visiter {

	public void visit(AssignOperator s);
	
	public void visit(BooleanConstant s);
	
	public void visit(DNA s);
	
	public void visit(DoubleConstant s);
	
	public void visit(FunctionDefinition s);
	
	public void visit(FunctionCall s);

	public void visit(IfStaement s);
	
	public void visit(IntegerConstant s);
	
	public void visit(Machine s);
	
	public void visit(MemoryElement s);

	public void visit(NewOperator s);
	
	public void visit(StringValue s);
	
	public void visit(Type s);
	
	public void visit(Variable s);
	
	public void visit(VariableAsValue s);

	public void visit(Value s);

	void visit(Statement s);

	void visit(ReturnStatement s);

	void visit(ElseStaement s);

	void visit(ElseIfStaement s);

	void visit(ContinueStatement s);

	void visit(ForEachStaement s);

	void visit(JavaCodeStatement s);

	void visit(NullValue s);

	void visit(DotOperator s);

}
