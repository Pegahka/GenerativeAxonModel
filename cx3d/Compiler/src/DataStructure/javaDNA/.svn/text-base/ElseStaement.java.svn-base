package DataStructure.javaDNA;

import java.util.Vector;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class ElseStaement extends Statement {

	public Vector<Statement> statements = new Vector<Statement>();

	@Override
	public void createFromString(String s) {
		s = s.trim();
		
		int [] index = p.extractFirstBlock(s);
		String block = s.substring(index[0],index[1]);	
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
	public Statement getCopy() {
		ElseStaement n = new ElseStaement();
		n.p = p;
		for(Statement s:statements)
		{
			n.statements.add(s.getCopy());
		}
		return n;
	}
	
	public String toString()
	{
		return  "else";
	}
	
	
	@Override
	public int similarity(Statement o) {
		if((o instanceof ElseIfStaement))
		{
		
			ElseIfStaement a = (ElseIfStaement) o;
			int i = NeedlemanWunsch.sametype/4;
			
			i+= NeedlemanWunsch.similarityValue(this.statements, a.statements)/2;  
			
			return i;
		}
		else if((o instanceof IfStaement))
		{
			IfStaement a = (IfStaement) o;
			int i = NeedlemanWunsch.sametype/4;
			
			i+= NeedlemanWunsch.similarityValue(this.statements, a.statements)/2;  
			
			return i;
		}
		else if((o instanceof ElseStaement))
		{
			ElseStaement a = (ElseStaement) o;
			int i = NeedlemanWunsch.sametype;
			
			i+= NeedlemanWunsch.similarityValue(this.statements, a.statements)/2;  
			
			return i;
		}
		else
		{
			return NeedlemanWunsch.unequal;
		}
	}

}
