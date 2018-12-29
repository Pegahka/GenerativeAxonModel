package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class ReturnStatement extends Statement {

	public Value v;
	@Override
	public void createFromString(String s) {
		s = s.substring(s.indexOf("return ")+7);
		if(s.trim().length()>0)
		{
			 v  = p.readValueTree(s);
		}
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Statement getCopy() {
		ReturnStatement n = new ReturnStatement();
		n.p = p;
		n.v = (Value) v.getCopy();
		return n;
	}
	
	public String toString()
	{
		if(this.v == null) return "return ";
		return  "return "+this.v.toString();
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof ReturnStatement)) return NeedlemanWunsch.unequal;
		ReturnStatement a = (ReturnStatement) o;
		int i = 0;
		
		return i;
	}
}
