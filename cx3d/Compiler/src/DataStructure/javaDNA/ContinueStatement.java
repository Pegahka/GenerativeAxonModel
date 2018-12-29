package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class ContinueStatement extends Statement {

	
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
		ContinueStatement n = new ContinueStatement();
		n.p = p;
	
		return n;
	}
	
	public String toString()
	{
		return  "continue";
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof ContinueStatement)) return NeedlemanWunsch.unequal;
		return 0;
	}

}
