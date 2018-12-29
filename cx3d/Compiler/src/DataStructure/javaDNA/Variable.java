package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class Variable extends Statement{
	
	public String name;
	public Type type;
	
	public void createFromString(String s) {
		s =s.replace("final ", "");
		s = s.trim();
		if(s.contains(" "))
		{
			type = new Type();
			type.setParser(p);
			type.createFromString(s.substring(0, s.indexOf(' ')).trim());
			name = s.substring(s.indexOf(' '), s.length()).trim();
		}
		else
		{
			name = s.trim();
		}
		
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean equals(Object o)
	{
		if(!(o instanceof Variable)) return false;
		Variable f = (Variable) o;
		if(!this.name.equals(f.name)) return false;
		if(!type.equals(f.type)) return false;
		
		return true;
	}
	

	@Override
	public Statement getCopy() {
		Variable n = new Variable();
		n.p = p;
		n.name = name;
		n.type = new Type();
		n.type.p = type.p;
		n.type.name = type.name;
		return n;
	}
	
	public String toString()
	{
		return  "var "+this.name;
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof Variable)) return NeedlemanWunsch.unequal;
		Variable a = (Variable) o;
		int i = 0;
		if(this.type==null)
		{
			if(a.type==null)
			{
				i+= 1;
			}
		}
		else if( this.type.equals(a.type))
		{
			i += NeedlemanWunsch.sametype;
		}
		
		return i;
	}
	
}
