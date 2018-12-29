package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;

public class AssignOperator extends Statement{
	
	public Variable var;
	public Value val;


	@Override
	public void createFromString(String s) {
		var = new Variable();
		var.setParser(p);
		var.createFromString(s.substring(0, s.indexOf("=")));
		s = s.substring(s.indexOf("=")+1,s.length());
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
		AssignOperator n = new AssignOperator();
		n.p = p;
		if(val!=null) n.val = (Value) val.getCopy();
		if(var!=null) n.var = (Variable) var.getCopy();
		return n;
	}

	public String toString()
	{
		return  var.name+"=" +this.val.toString();
	}

	@Override
	public int similarity(Statement o) {
		if(!(o instanceof AssignOperator)) return NeedlemanWunsch.unequal;
		AssignOperator a = (AssignOperator) o;
		int i = NeedlemanWunsch.sametype;
		
		i+= this.val.similarity(a.val)/2;
		i+= this.var.similarity(a.var)/2;
		
		return i;
	}
	
}
