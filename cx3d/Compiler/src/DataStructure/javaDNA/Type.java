package DataStructure.javaDNA;

import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class Type implements Visitable {
	public Parser p;
	public String name;
	
	@Override
	public void createFromString(String s) {
		// TODO Auto-generated method stub
		
		name = s.trim();
		if(name.equals("final"))
		{
			System.out.println("why final??");
		}

	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void setParser(IParser p) {
		this.p = (Parser)p;		
	}
	
	@Override
	public boolean equals(Object o)
	{
		if(!(o instanceof Type)) return false;
		Type f = (Type) o;
		if(!this.name.equals(f.name)) return false;
		
		return true;
	}

	public String toString()
	{
		return  " "+this.name;
	}
	
}
