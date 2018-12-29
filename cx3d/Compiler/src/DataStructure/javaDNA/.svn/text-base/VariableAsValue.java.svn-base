package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class VariableAsValue extends Value{

	public String v;
	
	@Override
	public void createFromString(String s) {
		v = s;
	}

	@Override
	public String identifier() {
	
		return null;
	}

	@Override
	public Statement getCopy() {
		VariableAsValue n = new VariableAsValue();
		n.p = p;
		n.v = v;
		return n;
	}
	
	public String toString()
	{
		return  this.v;
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof VariableAsValue)) return NeedlemanWunsch.unequal;
		VariableAsValue a = (VariableAsValue) o;
		int i = 0;
		if(this.v.equals(a.v))
		{
			i = NeedlemanWunsch.sametype;
		}
		
		return i;
	}
	
}
