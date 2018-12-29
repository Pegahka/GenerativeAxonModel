package DataStructure.javaDNA;

import java.util.Vector;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class ElseIfStaement extends Statement {

	public Vector<Statement> statements = new Vector<Statement>();
	public Value val;

	@Override
	public void createFromString(String s) {
		s = s.trim();
		String value = s.substring(0,s.indexOf('{'));
		value = value.trim();
		value = value.substring(value.indexOf('(')+1, value.lastIndexOf(')'));
		if(!value.endsWith(".eval()")) throw new RuntimeException("all ifstatements must be evaluated with a Machine Boolean! comming from bool(...)");
		value = value.replace(".eval()", "");
		value = value.trim();
		if(value.length()!=0)
		{	
			val = p.readValueTree(value);
		}
		
		
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
		ElseIfStaement n = new ElseIfStaement();
		n.p = p;
		n.val = (Value) val.getCopy();
		for(Statement s:statements)
		{
			n.statements.add(s.getCopy());
		}
		return n;
	}


	public String toString()
	{
		return  "else if"+val.toString();
	}
	
	@Override
	public int similarity(Statement o) {
		if((o instanceof ElseIfStaement))
		{
		
			ElseIfStaement a = (ElseIfStaement) o;
			int i = NeedlemanWunsch.sametype;
			
			i+= this.val.similarity(a.val)/2;
			i+= NeedlemanWunsch.similarityValue(this.statements, a.statements)/2;  
			
			return i;
		}
		else if((o instanceof IfStaement))
		{
			IfStaement a = (IfStaement) o;
			int i = NeedlemanWunsch.sametype/2;
			
			i+= this.val.similarity(a.val)/2;
			i+= NeedlemanWunsch.similarityValue(this.statements, a.statements)/2;  
			
			return i;
		}
		else if((o instanceof ElseStaement))
		{
			ElseStaement a = (ElseStaement) o;
			int i = NeedlemanWunsch.sametype/4;
			
			i+= NeedlemanWunsch.similarityValue(this.statements, a.statements)/2;  
			
			return i;
		}
		else
		{
			return NeedlemanWunsch.unequal;
		}
	}
}
