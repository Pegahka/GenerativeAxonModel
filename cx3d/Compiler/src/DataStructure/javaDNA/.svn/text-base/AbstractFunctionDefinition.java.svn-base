package DataStructure.javaDNA;

import java.util.StringTokenizer;
import java.util.Vector;

import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class AbstractFunctionDefinition implements Visitable {

	public String name;
	public Type type;
	public Vector<Variable> parameters = new Vector<Variable>();
	
	private Parser p;
	
	
	@Override
	public void createFromString(String s) {
		s = s.replace("public", "");
		s = s.replace("private", "");
		s = s.replace("protected", "");
		s = s.replace("abstract", "");
		s = s.trim();
		String potentialname = s.substring(0, s.indexOf('('));
		
		if(potentialname.contains(" "))
		{
			type = new Type();
			type.setParser(p);
			type.createFromString(potentialname.substring(0, potentialname.indexOf(' ')));
			potentialname = potentialname.substring(potentialname.indexOf(' ')+1, potentialname.length());
		}
		name = potentialname; 
		
		String tmp= s.substring(s.indexOf('('), s.indexOf(')')+1);
		tmp = tmp.substring(tmp.indexOf('(')+1, tmp.indexOf(')'));
		StringTokenizer tokens = new StringTokenizer(tmp,",");
		while(tokens.hasMoreTokens())
		{
			String tok = ((String)tokens.nextToken()).trim();
			if(tok.length()!=0)
			{
				Variable v = new Variable();
				v.setParser(p);
				v.createFromString(tok);
				parameters.add(v);
			}
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

	public String toString()
	{
		return "Abstract function" +this.name;
	}
	
}
