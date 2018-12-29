package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class NullValue extends Value {

	@Override
	public void createFromString(String s) {
		
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Statement getCopy() {
		NullValue n = new NullValue();
		n.p = p;
		return n;
	}

	
	public String toString()
	{
		return  "null";
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof NullValue)) return NeedlemanWunsch.unequal;
		NullValue a = (NullValue) o;
		int i = NeedlemanWunsch.sametype/2;
		
		return i;
	}
}
