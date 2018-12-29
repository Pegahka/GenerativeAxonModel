package FlattenMachines;

import Compiler.AbstractVisiter;
import DataStructure.javaDNA.Variable;
import DataStructure.javaDNA.VariableAsValue;

public class VariableChange extends AbstractVisiter {

	private String postfix;

	public VariableChange(String postfix)
	{
		this.postfix = postfix;
	}
	
	@Override
	public void visit(Variable s) {
		s.name+=postfix;
		visit(s.type);
	}
	
	@Override
	public void visit(VariableAsValue s) {
		s.v += postfix;
	}
}
