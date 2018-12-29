package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class DotOperator extends Value{
	
	public Value base;
	public Value call;


	@Override
	public void createFromString(String s) {
		base = p.readValueTree(s.substring(0, p.findIgnoreRoundBrackets(s, '.')));
		s = s.substring(s.indexOf(".")+1,s.length());
		call = p.readValueTree(s);
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public Statement getCopy() {
		DotOperator n = new DotOperator();
		n.p = p;
		n.base = (Value) base.getCopy();
		n.call = (Value) call.getCopy();
		return n;
	}

	public String toString()
	{
		return  base.toString()+"."+call.toString();
	}

	@Override
	public int similarity(Statement o) {
		if(!(o instanceof DotOperator)) return NeedlemanWunsch.unequal;
		DotOperator a = (DotOperator) o;
		int i = NeedlemanWunsch.sametype;
		
		i+= this.base.similarity(a.base)/2;
		i+= this.call.similarity(a.call)/2;
		
		return i;
	}
	
}
