package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class IntegerConstant extends Constant{

	public int i;
	
	@Override
	public void createFromString(String s) {
		i = Integer.parseInt(s);
		
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public Statement getCopy() {
		IntegerConstant n = new IntegerConstant();
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
		if(!(o instanceof IntegerConstant)) return NeedlemanWunsch.unequal;
		IntegerConstant a = (IntegerConstant) o;
		int i = NeedlemanWunsch.sametype;
		
		if(this.i == a.i) return  i+=1;
		
		return i;
	}
	
}
