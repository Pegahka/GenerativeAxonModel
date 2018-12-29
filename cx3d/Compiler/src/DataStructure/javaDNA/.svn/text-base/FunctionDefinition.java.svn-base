package DataStructure.javaDNA;

import java.util.StringTokenizer;
import java.util.Vector;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class FunctionDefinition implements Visitable {

	public String name;
	public Type type;
	public Vector<Variable> parameters = new Vector<Variable>();
	public Vector<Statement> statements = new Vector<Statement>();
	
	private Parser p;
	
	
	@Override
	public void createFromString(String s) {
		s = s.replace("public", "");
		s = s.replace("private", "");
		s = s.replace("protected", "");
		s = s.trim();
		String potentialname = s.substring(0, s.indexOf('('));
		
		if(potentialname.contains(" "))
		{
			type = new Type();
			type.setParser(p);
			type.createFromString(potentialname.substring(0, potentialname.indexOf(' ')));
			potentialname = potentialname.substring(potentialname.indexOf(' ')+1, potentialname.length());
		}
		name = potentialname.trim(); 
		
		String tmp= s.substring(s.indexOf('('), s.indexOf('{'));
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
		
		int [] index = p.extractFirstBlock(s);
		String block = s.substring(index[0],index[1]);
		block.trim();
		while(block.length()>0)
		{
			block = p.readStatement(block,statements);
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
		if(!(o instanceof FunctionDefinition)) return false;
		FunctionDefinition f = (FunctionDefinition) o;
		if(!f.name.equals(name)) return false;
		if(f.parameters.size()!=parameters.size()) return false;
		for (Variable v : f.parameters) {
			if(!this.parameters.contains(v)) return false;
		}
		return true;
	}

	public String toString()
	{
		return  "functiiondef" +name;
	}
	
	
	public int similarity(FunctionDefinition o) { 
		if(o.parameters.size()!=o.parameters.size()) return 0;
		return NeedlemanWunsch.similarityValue(this.statements, o.statements);
	}
	
}
