package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class DoubleConstant extends Constant{

	public double i;
	
	@Override
	public void createFromString(String s) {
		i = Double.parseDouble(s);
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Statement getCopy() {
		DoubleConstant n = new DoubleConstant();
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
		if(!(o instanceof DoubleConstant)) return NeedlemanWunsch.unequal;
		DoubleConstant a = (DoubleConstant) o;
		int i = NeedlemanWunsch.sametype;
		
		if(this.i == a.i) return  i+=1;
		
		return i;
	}
	
}
