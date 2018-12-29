package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class NewOperator extends Value{
	

	public Value val;


	@Override
	public void createFromString(String s) {
		s = s.trim();
		s = s.substring(4,s.length());
		s = s.trim();
		s = s.trim();
		if(s.length()!=0)
		{	
			val = p.readValueTree(s);
		}
		
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Statement getCopy() {
		NewOperator n = new NewOperator();
		n.p = p;
		n.val = (Value) val.getCopy();
		return n;
	}
	
	public String toString()
	{
		return  "new "+this.val.toString();
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof NewOperator)) return NeedlemanWunsch.unequal;
		NewOperator a = (NewOperator) o;
		int i = NeedlemanWunsch.sametype;
		i+= this.val.similarity(a.val)/2;
		
		return i;
	}

}
