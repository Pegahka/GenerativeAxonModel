package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class BooleanConstant extends Constant{

	public boolean i;
	
	@Override
	public void createFromString(String s) {
		s = s.trim().toLowerCase();
		if(s.equals("false") || s.equals("true"))
		{
			i =  Boolean.parseBoolean(s);
		}
		throw new RuntimeException("not a boolean");
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Statement getCopy() {
		BooleanConstant n = new BooleanConstant();
		n.p = p;
		n.i = i;
		return n;
	}
	
	public String toString()
	{
		return  i+"";
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof BooleanConstant)) return NeedlemanWunsch.unequal;
		BooleanConstant a = (BooleanConstant) o;
		int i = NeedlemanWunsch.sametype;
		if(this.i ==a.i) i+=4;
		return i;
	}
	
}
