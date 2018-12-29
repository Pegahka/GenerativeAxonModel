package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class StringValue extends Value{

	public String v;
	
	@Override
	public void createFromString(String s) {
		if(s.startsWith("\"") && s.endsWith("\""))
		{
			v = s.substring(1, s.length()-1);
		}
		else
		{
			throw new RuntimeException("no StringValue");
		}
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public Statement getCopy() {
		StringValue n = new StringValue();
		n.p = p;
		n.v = v;
		return n;
	}
	
	public String toString()
	{
		return  v+"";
	}
	

	@Override
	public int similarity(Statement o) {
		if(!(o instanceof StringValue)) return NeedlemanWunsch.unequal;
		StringValue a = (StringValue) o;
		int i = 0;
		if(this.v.equals(a.v))
		{
			i = 1;
		}
		
		return i;
	}
	
	
}
