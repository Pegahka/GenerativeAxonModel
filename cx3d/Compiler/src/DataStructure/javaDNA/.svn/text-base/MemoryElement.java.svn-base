package DataStructure.javaDNA;

import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class MemoryElement implements Visitable {
	
	public Parser p;
	public AssignOperator assignment;
	public Variable v;
	
	@Override
	public void createFromString(String s) {
		s = s.replace("final ","");
		s = s.replace("public ","");
		s = s.replace("private ","");
		s = s.replace("protected ", "");
		if(s.contains("="))
		{
			assignment = new AssignOperator();
			assignment.setParser(p);
			assignment.createFromString(s);
		}
		else
		{
			v = new Variable();
			v.setParser(p);
			v.createFromString(s);
		}
		
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	

	@Override
	public void setParser(IParser p) {
		this.p = (Parser) p;
	}

	@Override
	public boolean equals(Object o)
	{
		if(!(o instanceof MemoryElement)) return false;
		MemoryElement f = (MemoryElement) o;
		if(v!=null)
		{
			if(!f.v.equals(v)) return false;
		}
		else
		{
			if(!f.assignment.var.equals(assignment.var)) return false;
		}
		return true;
	}
	
	public String toString()
	{
		return  "memelement "+this.v.name;
	}
	
}
